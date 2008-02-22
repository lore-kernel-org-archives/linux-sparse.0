From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH 2/3] fix show_typename()
Date: Fri, 22 Feb 2008 23:05:25 +0000
Message-ID: <E1JSgxJ-0003m5-1z@ZenIV.linux.org.uk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:54753 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755714AbYBVXF0 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 22 Feb 2008 18:05:26 -0500
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: josh@freedesktop.org
Cc: linux-sparse@vger.kernel.org


* postfix stuff had been applied in wrong order (e.g. int a[2][3] generated
int [addressable][toplevel] a[3][2])
* after fixing that, we've no need for recursion anymore, a bunch of arguments
go away and turn into local variables and we get an easy way to get rid of
bogus space in the show_typename() result.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 evaluate.c   |    4 +-
 show-parse.c |  100 +++++++++++++++++++++++++++++----------------------------
 2 files changed, 53 insertions(+), 51 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index 777f603..2901c1b 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -502,7 +502,7 @@ static inline void unrestrict(struct expression *expr,
 	if (class & TYPE_RESTRICT) {
 		if (class & TYPE_FOULED)
 			*ctype = unfoul(*ctype);
-		warning(expr->pos, "%sdegrades to integer",
+		warning(expr->pos, "%s degrades to integer",
 			show_typename(*ctype));
 		*ctype = (*ctype)->ctype.base_type; /* get to arithmetic type */
 	}
@@ -1802,7 +1802,7 @@ static struct symbol *evaluate_preop(struct expression *expr)
 			expr->right->ctype = ctype;
 			expr->right->fvalue = 0;
 		} else if (is_fouled_type(ctype)) {
-			warning(expr->pos, "%sdegrades to integer",
+			warning(expr->pos, "%s degrades to integer",
 				show_typename(ctype->ctype.base_type));
 		}
 		ctype = &bool_ctype;
diff --git a/show-parse.c b/show-parse.c
index b9a2828..064af32 100644
--- a/show-parse.c
+++ b/show-parse.c
@@ -226,12 +226,16 @@ const char *builtin_ctypename(struct ctype *ctype)
 	return NULL;
 }
 
-static void do_show_type(struct symbol *sym, struct type_name *name,
-			 unsigned long mod, int as, int was_ptr)
+static void do_show_type(struct symbol *sym, struct type_name *name)
 {
 	const char *typename;
-	int is_ptr = was_ptr;
+	unsigned long mod = 0;
+	int as = 0;
+	int was_ptr = 0;
+	int restr = 0;
+	int fouled = 0;
 
+deeper:
 	if (!sym || (sym->type != SYM_NODE && sym->type != SYM_ARRAY &&
 		     sym->type != SYM_BITFIELD)) {
 		const char *s;
@@ -249,14 +253,15 @@ static void do_show_type(struct symbol *sym, struct type_name *name,
 	}
 
 	if (!sym)
-		return;
+		goto out;
 
 	if ((typename = builtin_typename(sym))) {
 		int len = strlen(typename);
-		*--name->start = ' ';
+		if (name->start != name->end)
+			*--name->start = ' ';
 		name->start -= len;
 		memcpy(name->start, typename, len);
-		return;
+		goto out;
 	}
 
 	/* Prepend */
@@ -265,20 +270,29 @@ static void do_show_type(struct symbol *sym, struct type_name *name,
 		prepend(name, "*");
 		mod = sym->ctype.modifiers;
 		as = sym->ctype.as;
-		is_ptr = 1;
+		was_ptr = 1;
 		break;
+
 	case SYM_FN:
-		if (was_ptr)
+		if (was_ptr) {
 			prepend(name, "( ");
-		is_ptr = 0;
+			append(name, " )");
+			was_ptr = 0;
+		}
+		append(name, "( ... )");
 		break;
+
 	case SYM_STRUCT:
-		prepend(name, "struct %s ", show_ident(sym->ident));
-		return;
+		if (name->start != name->end)
+			*--name->start = ' ';
+		prepend(name, "struct %s", show_ident(sym->ident));
+		goto out;
 
 	case SYM_UNION:
-		prepend(name, "union %s ", show_ident(sym->ident));
-		return;
+		if (name->start != name->end)
+			*--name->start = ' ';
+		prepend(name, "union %s", show_ident(sym->ident));
+		goto out;
 
 	case SYM_ENUM:
 		prepend(name, "enum %s ", show_ident(sym->ident));
@@ -298,60 +312,48 @@ static void do_show_type(struct symbol *sym, struct type_name *name,
 
 	case SYM_LABEL:
 		append(name, "label(%s:%p)", show_ident(sym->ident), sym);
-		break;
+		return;
 
 	case SYM_ARRAY:
 		mod |= sym->ctype.modifiers;
 		as |= sym->ctype.as;
-		if (was_ptr)
+		if (was_ptr) {
 			prepend(name, "( ");
-		is_ptr = 0;
+			append(name, " )");
+			was_ptr = 0;
+		}
+		append(name, "[%lld]", get_expression_value(sym->array_size));
 		break;
 
 	case SYM_RESTRICT:
-		if (sym->ident) {
-			prepend(name, "restricted %s ", show_ident(sym->ident));
-			return;
+		if (!sym->ident) {
+			restr = 1;
+			break;
 		}
-		break;
+		if (name->start != name->end)
+			*--name->start = ' ';
+		prepend(name, "restricted %s", show_ident(sym->ident));
+		goto out;
 
 	case SYM_FOULED:
+		fouled = 1;
 		break;
 
 	default:
+		if (name->start != name->end)
+			*--name->start = ' ';
 		prepend(name, "unknown type %d", sym->type);
-		return;
+		goto out;
 	}
 
-	do_show_type(sym->ctype.base_type, name, mod, as, is_ptr);
-
-	switch (sym->type) {
-	case SYM_PTR:
-		return;
-
-	case SYM_FN:
-		if (was_ptr)
-			append(name, " )");
-		append(name, "( ... )");
-		return;
-
-	case SYM_ARRAY:
-		if (was_ptr)
-			append(name, " )");
-		append(name, "[%lld]", get_expression_value(sym->array_size));
-		return;
+	sym = sym->ctype.base_type;
+	goto deeper;
 
-	case SYM_RESTRICT:
+out:
+	if (restr)
 		prepend(name, "restricted ");
-		return;
-
-	case SYM_FOULED:
+	if (fouled)
 		prepend(name, "fouled ");
-		return;
-
-	default:
-		break;
-	}
 }
 
 void show_type(struct symbol *sym)
@@ -360,7 +362,7 @@ void show_type(struct symbol *sym)
 	struct type_name name;
 
 	name.start = name.end = array+100;
-	do_show_type(sym, &name, 0, 0, 0);
+	do_show_type(sym, &name);
 	*name.end = 0;
 	printf("%s", name.start);
 }
@@ -371,7 +373,7 @@ const char *show_typename(struct symbol *sym)
 	struct type_name name;
 
 	name.start = name.end = array+100;
-	do_show_type(sym, &name, 0, 0, 0);
+	do_show_type(sym, &name);
 	*name.end = 0;
 	return name.start;
 }
-- 
1.5.3.GIT
