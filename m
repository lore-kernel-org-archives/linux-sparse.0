From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH 7/7] Apply attributes after ( to the right place
Date: Sat, 14 Feb 2009 12:26:05 +0000
Message-ID: <E1LYJav-0001pq-LQ@ZenIV.linux.org.uk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:60903 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751507AbZBNM0G (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 14 Feb 2009 07:26:06 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.69 #1 (Red Hat Linux))
	id 1LYJav-0001pq-LQ
	for linux-sparse@vger.kernel.org; Sat, 14 Feb 2009 12:26:05 +0000
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


In int f(__user int *p) __user applies to p, not to f...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 parse.c                        |   23 +++++++++++++++--------
 validation/attr_in_parameter.c |   12 ++++++++++++
 2 files changed, 27 insertions(+), 8 deletions(-)
 create mode 100644 validation/attr_in_parameter.c

diff --git a/parse.c b/parse.c
index 9fe87e6..3922ce3 100644
--- a/parse.c
+++ b/parse.c
@@ -1226,7 +1226,7 @@ static struct token *abstract_array_declarator(struct token *token, struct symbo
 	return token;
 }
 
-static struct token *parameter_type_list(struct token *, struct symbol *);
+static struct token *parameter_type_list(struct token *, struct symbol *, struct ctype *);
 static struct token *identifier_list(struct token *, struct symbol *);
 static struct token *declarator(struct token *token, struct symbol *sym, struct ident **p, int);
 
@@ -1324,13 +1324,16 @@ static struct token *direct_declarator(struct token *token, struct symbol *decl,
 		if (token->special == '(') {
 			struct symbol *sym;
 			struct token *next;
-			enum kind kind = which_kind(token, &next, p, ctype,
+			struct ctype thistype = {0, };
+			enum kind kind = which_kind(token, &next, p, &thistype,
 						dont_nest, prefer_abstract);
 
 			dont_nest = 1;
 
 			if (kind == Nested) {
 				struct symbol *base_type = ctype->base_type;
+				if (token->next != next)
+					apply_ctype(token->pos, &thistype, ctype);
 				token = declarator(next, decl, p, prefer_abstract);
 				token = expect(token, ')', "in nested declarator");
 				while (ctype->base_type != base_type)
@@ -1350,7 +1353,9 @@ static struct token *direct_declarator(struct token *token, struct symbol *decl,
 			if (kind == K_R) {
 				next = identifier_list(next, sym);
 			} else if (kind == Proto) {
-				next = parameter_type_list(next, sym);
+				struct ctype *t;
+				t = (token->next == next ? NULL : &thistype);
+				next = parameter_type_list(next, sym, t);
 			}
 			token = expect(next, ')', "in function declarator");
 			sym->endpos = token->pos;
@@ -1495,12 +1500,14 @@ static struct token *struct_declaration_list(struct token *token, struct symbol_
 	return token;
 }
 
-static struct token *parameter_declaration(struct token *token, struct symbol **tree)
+static struct token *parameter_declaration(struct token *token, struct symbol **tree, struct ctype *pending)
 {
 	struct ident *ident = NULL;
 	struct symbol *sym;
-	struct ctype ctype = { 0, };
+	struct ctype ctype = {0, };
 
+	if (pending)
+		apply_ctype(token->pos, pending, &ctype);
 	token = declaration_specifiers(token, &ctype, 0);
 	sym = alloc_symbol(token->pos, SYM_NODE);
 	sym->ctype = ctype;
@@ -2017,7 +2024,7 @@ static struct token *identifier_list(struct token *token, struct symbol *fn)
 	return token;
 }
 
-static struct token *parameter_type_list(struct token *token, struct symbol *fn)
+static struct token *parameter_type_list(struct token *token, struct symbol *fn, struct ctype *pending)
 {
 	struct symbol_list **list = &fn->arguments;
 
@@ -2031,7 +2038,7 @@ static struct token *parameter_type_list(struct token *token, struct symbol *fn)
 		}
 
 		sym = alloc_symbol(token->pos, SYM_NODE);
-		token = parameter_declaration(token, &sym);
+		token = parameter_declaration(token, &sym, pending);
 		if (sym->ctype.base_type == &void_ctype) {
 			/* Special case: (void) */
 			if (!*list && !sym->ident)
@@ -2043,7 +2050,7 @@ static struct token *parameter_type_list(struct token *token, struct symbol *fn)
 		if (!match_op(token, ','))
 			break;
 		token = token->next;
-
+		pending = NULL;
 	}
 	return token;
 }
diff --git a/validation/attr_in_parameter.c b/validation/attr_in_parameter.c
new file mode 100644
index 0000000..1b104ea
--- /dev/null
+++ b/validation/attr_in_parameter.c
@@ -0,0 +1,12 @@
+#define A __attribute__((address_space(1)))
+static int (A *p);
+static int A *q;
+static void (*f)(A int *x, A int *y) = (void *)0;
+static void g(int A *x)
+{
+	f(x, x);
+	p = q;
+}
+/*
+ * check-name: attribute after ( in direct-declarator
+ */
-- 
1.5.6.6

