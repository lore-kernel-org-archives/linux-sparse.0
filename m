From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 2/2] Support GCC's transparent unions
Date: Sat,  1 Mar 2014 11:41:39 +0000
Message-ID: <303d3e76a8db47a65f2015289cfd5259611723bf.1393674078.git.john@keeping.me.uk>
References: <afd69e2697f3d3da96b74c06501fd2fb1fc5cba2.1393674078.git.john@keeping.me.uk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from jackal.aluminati.org ([72.9.247.210]:49858 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750869AbaCALlw (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 1 Mar 2014 06:41:52 -0500
In-Reply-To: <afd69e2697f3d3da96b74c06501fd2fb1fc5cba2.1393674078.git.john@keeping.me.uk>
In-Reply-To: <afd69e2697f3d3da96b74c06501fd2fb1fc5cba2.1393674078.git.john@keeping.me.uk>
References: <afd69e2697f3d3da96b74c06501fd2fb1fc5cba2.1393674078.git.john@keeping.me.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: John Keeping <john@keeping.me.uk>

This stops warnings in code using socket operations with a modern glibc,
which otherwise result in warnings of the form:

	warning: incorrect type in argument 2 (invalid types)
	   expected union __CONST_SOCKADDR_ARG [usertype] __addr
	   got struct sockaddr *<noident>

Since transparent unions are only applicable to function arguments, we
create a new function to check that the types are compatible
specifically in this context.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 evaluate.c                     | 28 +++++++++++++++++++++++++++-
 lib.c                          |  2 --
 lib.h                          |  1 -
 parse.c                        |  6 ++++--
 sparse.1                       |  8 --------
 symbol.h                       |  3 ++-
 validation/transparent-union.c | 25 +++++++++++++++++++++++++
 7 files changed, 58 insertions(+), 15 deletions(-)
 create mode 100644 validation/transparent-union.c

diff --git a/evaluate.c b/evaluate.c
index 2e6511b..f36c6c1 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -1406,6 +1406,32 @@ static int compatible_assignment_types(struct expression *expr, struct symbol *t
 	return 1;
 }
 
+static int compatible_argument_type(struct expression *expr, struct symbol *target,
+	struct expression **rp, const char *where)
+{
+	const char *typediff;
+	struct symbol *source = degenerate(*rp);
+	struct symbol *t;
+	classify_type(target, &t);
+
+	if (t->type == SYM_UNION && t->transparent_union) {
+		struct symbol *member;
+		FOR_EACH_PTR(t->symbol_list, member) {
+			if (check_assignment_types(member, rp, &typediff))
+				return 1;
+		} END_FOR_EACH_PTR(member);
+	}
+
+	if (check_assignment_types(target, rp, &typediff))
+		return 1;
+
+	warning(expr->pos, "incorrect type in %s (%s)", where, typediff);
+	info(expr->pos, "   expected %s", show_typename(target));
+	info(expr->pos, "   got %s", show_typename(source));
+	*rp = cast_to(*rp, target);
+	return 0;
+}
+
 static void mark_assigned(struct expression *expr)
 {
 	struct symbol *sym;
@@ -2172,7 +2198,7 @@ static int evaluate_arguments(struct symbol *f, struct symbol *fn, struct expres
 			static char where[30];
 			examine_symbol_type(target);
 			sprintf(where, "argument %d", i);
-			compatible_assignment_types(expr, target, p, where);
+			compatible_argument_type(expr, target, p, where);
 		}
 
 		i++;
diff --git a/lib.c b/lib.c
index bf3e91c..a52b88e 100644
--- a/lib.c
+++ b/lib.c
@@ -226,7 +226,6 @@ int Wparen_string = 0;
 int Wptr_subtraction_blows = 0;
 int Wreturn_void = 0;
 int Wshadow = 0;
-int Wtransparent_union = 0;
 int Wtypesign = 0;
 int Wundef = 0;
 int Wuninitialized = 1;
@@ -438,7 +437,6 @@ static const struct warning {
 	{ "ptr-subtraction-blows", &Wptr_subtraction_blows },
 	{ "return-void", &Wreturn_void },
 	{ "shadow", &Wshadow },
-	{ "transparent-union", &Wtransparent_union },
 	{ "typesign", &Wtypesign },
 	{ "undef", &Wundef },
 	{ "uninitialized", &Wuninitialized },
diff --git a/lib.h b/lib.h
index f09b338..197b549 100644
--- a/lib.h
+++ b/lib.h
@@ -120,7 +120,6 @@ extern int Wparen_string;
 extern int Wptr_subtraction_blows;
 extern int Wreturn_void;
 extern int Wshadow;
-extern int Wtransparent_union;
 extern int Wtypesign;
 extern int Wundef;
 extern int Wuninitialized;
diff --git a/parse.c b/parse.c
index 9cc5f65..bf62bdd 100644
--- a/parse.c
+++ b/parse.c
@@ -1207,8 +1207,10 @@ static struct token *attribute_designated_init(struct token *token, struct symbo
 
 static struct token *attribute_transparent_union(struct token *token, struct symbol *attr, struct decl_state *ctx)
 {
-	if (Wtransparent_union)
-		warning(token->pos, "ignoring attribute __transparent_union__");
+	if (ctx->ctype.base_type && ctx->ctype.base_type->type == SYM_UNION)
+		ctx->ctype.base_type->transparent_union = 1;
+	else
+		warning(token->pos, "attribute __transparent_union__ applied to non-union type");
 	return token;
 }
 
diff --git a/sparse.1 b/sparse.1
index cd6be26..6e79202 100644
--- a/sparse.1
+++ b/sparse.1
@@ -297,14 +297,6 @@ Such declarations can lead to error-prone code.
 Sparse does not issue these warnings by default.
 .
 .TP
-.B \-Wtransparent\-union
-Warn about any declaration using the GCC extension
-\fB__attribute__((transparent_union))\fR.
-
-Sparse issues these warnings by default.  To turn them off, use
-\fB\-Wno\-transparent\-union\fR.
-.
-.TP
 .B \-Wtypesign
 Warn when converting a pointer to an integer type into a pointer to an integer
 type with different signedness.
diff --git a/symbol.h b/symbol.h
index 43c165b..ccb5dcb 100644
--- a/symbol.h
+++ b/symbol.h
@@ -174,7 +174,8 @@ struct symbol {
 					evaluated:1,
 					string:1,
 					designated_init:1,
-					forced_arg:1;
+					forced_arg:1,
+					transparent_union:1;
 			struct expression *array_size;
 			struct ctype ctype;
 			struct symbol_list *arguments;
diff --git a/validation/transparent-union.c b/validation/transparent-union.c
new file mode 100644
index 0000000..149c7d9
--- /dev/null
+++ b/validation/transparent-union.c
@@ -0,0 +1,25 @@
+struct a {
+	int field;
+};
+struct b {
+	int field;
+};
+
+typedef union {
+	struct a *a;
+	struct b *b;
+} transparent_arg __attribute__((__transparent_union__));
+
+static void foo(transparent_arg arg)
+{
+}
+
+static void bar(void)
+{
+	struct b arg = { 0 };
+	foo((struct a *) &arg);
+}
+
+/*
+ * check-name: Transparent union attribute.
+ */
-- 
1.9.0.6.g037df60.dirty

