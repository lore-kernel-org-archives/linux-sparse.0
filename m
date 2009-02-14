From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH 5/7] more direct_declarator() sanitizing
Date: Sat, 14 Feb 2009 12:25:45 +0000
Message-ID: <E1LYJab-0001p6-L5@ZenIV.linux.org.uk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:60901 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751546AbZBNMZr (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 14 Feb 2009 07:25:47 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.69 #1 (Red Hat Linux))
	id 1LYJab-0001p6-L5
	for linux-sparse@vger.kernel.org; Sat, 14 Feb 2009 12:25:45 +0000
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


* new helper function - which_kind().  Finds how to parse what
follows ( in declarator.
* parameter-type-list and identifier-list handling separated
and cleaned up.
* saner recovery from errors
* int f(__attribute__((....)) x) is prohibited by gcc syntax;
attributes are not allowed in K&R identifier list, obviously,
and gcc refused to treat that as "int is implicit if missing"
kind of case.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 parse.c                         |  138 ++++++++++++++++++++++++--------------
 validation/nested-declarator2.c |   40 +++++++++++
 2 files changed, 127 insertions(+), 51 deletions(-)
 create mode 100644 validation/nested-declarator2.c

diff --git a/parse.c b/parse.c
index 62a005c..70cf2fb 100644
--- a/parse.c
+++ b/parse.c
@@ -1226,7 +1226,8 @@ static struct token *abstract_array_declarator(struct token *token, struct symbo
 	return token;
 }
 
-static struct token *parameter_type_list(struct token *, struct symbol *, struct ident **p);
+static struct token *parameter_type_list(struct token *, struct symbol *);
+static struct token *identifier_list(struct token *, struct symbol *);
 static struct token *declarator(struct token *token, struct symbol *sym, struct ident **p, int);
 
 static struct token *handle_attributes(struct token *token, struct ctype *ctype, unsigned int keywords)
@@ -1248,6 +1249,55 @@ static struct token *handle_attributes(struct token *token, struct ctype *ctype,
 	return token;
 }
 
+enum kind {
+	Nested, Empty, K_R, Proto, Bad_Func, Bad_Nested
+};
+
+static enum kind which_kind(struct token *token, struct token **p,
+			    struct ident **n, struct ctype *ctype,
+			    int dont_nest, int prefer_abstract)
+{
+	/*
+	 * This can be either a parameter list or a grouping.
+	 * For the direct (non-abstract) case, we know if must be
+	 * a parameter list if we already saw the identifier.
+	 * For the abstract case, we know if must be a parameter
+	 * list if it is empty or starts with a type.
+	 */
+	struct token *next = token->next;
+
+	*p = next = handle_attributes(next, ctype, KW_ATTRIBUTE);
+
+	if (token_type(next) == TOKEN_IDENT) {
+		if (lookup_type(next))
+			return (dont_nest || prefer_abstract) ? Proto : Nested;
+		if (dont_nest)
+			return (next == token->next) ? K_R : Bad_Func;
+		return Nested;
+	}
+
+	if (token_type(next) != TOKEN_SPECIAL)
+		return dont_nest ? Bad_Nested : Bad_Func;
+
+	if (next->special == ')') {
+		/* don't complain about those */
+		if (!n || match_op(next->next, ';'))
+			return Empty;
+		warning(next->pos,
+			"non-ANSI function declaration of function '%s'",
+			show_ident(*n));
+		return Empty;
+	}
+
+	if (next->special == SPECIAL_ELLIPSIS) {
+		warning(next->pos,
+			"variadic functions must have one named argument");
+		return Proto;
+	}
+
+	return dont_nest ? Bad_Func : Nested;
+}
+
 static struct token *direct_declarator(struct token *token, struct symbol *decl, struct ident **p, int prefer_abstract)
 {
 	struct ctype *ctype = &decl->ctype;
@@ -1263,40 +1313,42 @@ static struct token *direct_declarator(struct token *token, struct symbol *decl,
 		if (token_type(token) != TOKEN_SPECIAL)
 			return token;
 
-		/*
-		 * This can be either a parameter list or a grouping.
-		 * For the direct (non-abstract) case, we know if must be
-		 * a parameter list if we already saw the identifier.
-		 * For the abstract case, we know if must be a parameter
-		 * list if it is empty or starts with a type.
-		 */
 		if (token->special == '(') {
 			struct symbol *sym;
-			struct token *next = token->next;
-			int fn;
+			struct token *next;
+			enum kind kind = which_kind(token, &next, p, ctype,
+						dont_nest, prefer_abstract);
 
-			next = handle_attributes(next, ctype, KW_ATTRIBUTE);
-			fn = dont_nest || match_op(next, ')') ||
-				(prefer_abstract && lookup_type(next));
+			dont_nest = 1;
 
-			if (!fn) {
+			if (kind == Nested) {
 				struct symbol *base_type = ctype->base_type;
 				token = declarator(next, decl, p, prefer_abstract);
 				token = expect(token, ')', "in nested declarator");
 				while (ctype->base_type != base_type)
 					ctype = &ctype->base_type->ctype;
-				dont_nest = 1;
 				p = NULL;
 				continue;
 			}
 
+			if (kind == Bad_Nested) {
+				token = expect(token, ')', "in nested declarator");
+				p = NULL;
+				continue;
+			}
+
+			/* otherwise we have a function */
 			sym = alloc_indirect_symbol(token->pos, ctype, SYM_FN);
-			token = parameter_type_list(next, sym, p);
-			token = expect(token, ')', "in function declarator");
+			if (kind == K_R) {
+				next = identifier_list(next, sym);
+			} else if (kind == Proto) {
+				next = parameter_type_list(next, sym);
+			}
+			token = expect(next, ')', "in function declarator");
 			sym->endpos = token->pos;
-			dont_nest = 1;
 			continue;
 		}
+
 		if (token->special == '[') {
 			struct symbol *array = alloc_indirect_symbol(token->pos, ctype, SYM_ARRAY);
 			token = abstract_array_declarator(token->next, array);
@@ -1939,43 +1991,27 @@ static struct token * statement_list(struct token *token, struct statement_list
 	return token;
 }
 
-static struct token *parameter_type_list(struct token *token, struct symbol *fn, struct ident **p)
+static struct token *identifier_list(struct token *token, struct symbol *fn)
 {
 	struct symbol_list **list = &fn->arguments;
-
-	if (match_op(token, ')')) {
-		// No warning for "void oink ();"
-		// Bug or feature: warns for "void oink () __attribute__ ((noreturn));"
-		if (p && !match_op(token->next, ';'))
-			warning(token->pos, "non-ANSI function declaration of function '%s'", show_ident(*p));
-		return token;
-	}
-
-	if (match_op(token, SPECIAL_ELLIPSIS)) {
-		warning(token->pos, "variadic functions must have one named argument");
-		fn->variadic = 1;
-		return token->next;
+	for (;;) {
+		struct symbol *sym = alloc_symbol(token->pos, SYM_NODE);
+		sym->ident = token->ident;
+		token = token->next;
+		sym->endpos = token->pos;
+		add_symbol(list, sym);
+		if (!match_op(token, ',') ||
+		    token_type(token->next) != TOKEN_IDENT ||
+		    lookup_type(token->next))
+			break;
+		token = token->next;
 	}
+	return token;
+}
 
-	if (token_type(token) != TOKEN_IDENT)
-		return token;
-
-	if (!lookup_type(token)) {
-		/* K&R */
-		for (;;) {
-			struct symbol *sym = alloc_symbol(token->pos, SYM_NODE);
-			sym->ident = token->ident;
-			token = token->next;
-			sym->endpos = token->pos;
-			add_symbol(list, sym);
-			if (!match_op(token, ',') ||
-			    token_type(token->next) != TOKEN_IDENT ||
-			    lookup_type(token->next))
-				break;
-			token = token->next;
-		}
-		return token;
-	}
+static struct token *parameter_type_list(struct token *token, struct symbol *fn)
+{
+	struct symbol_list **list = &fn->arguments;
 
 	for (;;) {
 		struct symbol *sym;
diff --git a/validation/nested-declarator2.c b/validation/nested-declarator2.c
new file mode 100644
index 0000000..700c802
--- /dev/null
+++ b/validation/nested-declarator2.c
@@ -0,0 +1,40 @@
+typedef int T;
+extern void f1(int);
+extern void f2(T);
+static void (*f3)(int) = f2;
+static void (*f4)(T) = f1;
+extern void f5(void (int));
+extern void f6(void (T));
+static void z(int x)
+{
+	int (T) = x;
+	f5(f2);
+	f6(f3);
+}
+static void f8();
+static int (x) = 1;
+static void w1(y)
+int y;
+{
+	x = y;
+}
+static void w2(int ());
+static void w3(...);
+static void f9(__attribute__((mode(DI))) T);
+static void bad1(__attribute__((mode(DI))) x);
+static int (-bad2);
+static void [2](*bad3);
+/*
+ * check-name: more on handling of ( in direct-declarator
+ * check-error-start:
+nested-declarator2.c:17:1: warning: non-ANSI definition of function 'w1'
+nested-declarator2.c:21:21: warning: non-ANSI function declaration of function '<noident>'
+nested-declarator2.c:22:16: warning: variadic functions must have one named argument
+nested-declarator2.c:24:44: error: Expected ) in function declarator
+nested-declarator2.c:24:44: error: got x
+nested-declarator2.c:25:13: error: Expected ) in nested declarator
+nested-declarator2.c:25:13: error: got -
+nested-declarator2.c:26:17: error: Expected ) in function declarator
+nested-declarator2.c:26:17: error: got *
+ * check-error-end:
+ */
-- 
1.5.6.6


