From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v2 2/2] Support GCC's transparent unions
Date: Sun,  9 Mar 2014 11:32:51 +0000
Message-ID: <7ef88cd469ed05f83f40631f496869c558640c65.1394364717.git.john@keeping.me.uk>
References: <afd69e2697f3d3da96b74c06501fd2fb1fc5cba2.1394364717.git.john@keeping.me.uk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from hyena.aluminati.org ([64.22.123.221]:37391 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751741AbaCILdH (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 9 Mar 2014 07:33:07 -0400
In-Reply-To: <afd69e2697f3d3da96b74c06501fd2fb1fc5cba2.1394364717.git.john@keeping.me.uk>
In-Reply-To: <afd69e2697f3d3da96b74c06501fd2fb1fc5cba2.1394364717.git.john@keeping.me.uk>
References: <afd69e2697f3d3da96b74c06501fd2fb1fc5cba2.1394364717.git.john@keeping.me.uk>
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

Also change the wording of the existing warning slightly since sparse
does now support them.  The warning is left in case people want to avoid
using transparent unions.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 evaluate.c                     | 28 +++++++++++++++++++++++++++-
 parse.c                        |  7 ++++++-
 symbol.h                       |  3 ++-
 validation/transparent-union.c | 25 +++++++++++++++++++++++++
 4 files changed, 60 insertions(+), 3 deletions(-)
 create mode 100644 validation/transparent-union.c

diff --git a/evaluate.c b/evaluate.c
index 2e6511b..1def2af 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -1406,6 +1406,32 @@ static int compatible_assignment_types(struct expression *expr, struct symbol *t
 	return 1;
 }
 
+static int compatible_transparent_union(struct symbol *target,
+	struct expression **rp)
+{
+	struct symbol *t, *member;
+	classify_type(target, &t);
+	if (t->type != SYM_UNION || !t->transparent_union)
+		return 0;
+
+	FOR_EACH_PTR(t->symbol_list, member) {
+		const char *typediff;
+		if (check_assignment_types(member, rp, &typediff))
+			return 1;
+	} END_FOR_EACH_PTR(member);
+
+	return 0;
+}
+
+static int compatible_argument_type(struct expression *expr, struct symbol *target,
+	struct expression **rp, const char *where)
+{
+	if (compatible_transparent_union(target, rp))
+		return 1;
+
+	return compatible_assignment_types(expr, target, rp, where);
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
diff --git a/parse.c b/parse.c
index 9cc5f65..785630a 100644
--- a/parse.c
+++ b/parse.c
@@ -1208,7 +1208,12 @@ static struct token *attribute_designated_init(struct token *token, struct symbo
 static struct token *attribute_transparent_union(struct token *token, struct symbol *attr, struct decl_state *ctx)
 {
 	if (Wtransparent_union)
-		warning(token->pos, "ignoring attribute __transparent_union__");
+		warning(token->pos, "attribute __transparent_union__");
+
+	if (ctx->ctype.base_type && ctx->ctype.base_type->type == SYM_UNION)
+		ctx->ctype.base_type->transparent_union = 1;
+	else
+		warning(token->pos, "attribute __transparent_union__ applied to non-union type");
 	return token;
 }
 
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

