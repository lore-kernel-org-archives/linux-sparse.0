From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH 4/18] Sanitize direct_declarator logics
Date: Mon, 09 Mar 2009 07:10:48 +0000
Message-ID: <E1LgZdQ-0000sV-0X@ZenIV.linux.org.uk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:43729 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752549AbZCIHKu (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 9 Mar 2009 03:10:50 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.69 #1 (Red Hat Linux))
	id 1LgZdQ-0000sV-0X
	for linux-sparse@vger.kernel.org; Mon, 09 Mar 2009 07:10:48 +0000
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


a) handling of nested declarator does not belong in the loop, for fsck sake
b) functions and arrays don't mix (and functions don't mix with functions)

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 parse.c                         |  140 ++++++++++++++++++---------------------
 validation/nested-declarator.c  |   16 +++--
 validation/nested-declarator2.c |    6 +-
 3 files changed, 76 insertions(+), 86 deletions(-)

diff --git a/parse.c b/parse.c
index 08de424..4c31bbe 100644
--- a/parse.c
+++ b/parse.c
@@ -1224,13 +1224,8 @@ static struct token *handle_attributes(struct token *token, struct ctype *ctype,
 	return token;
 }
 
-enum kind {
-	Nested, Empty, K_R, Proto, Bad_Func, Bad_Nested
-};
-
-static enum kind which_kind(struct token *token, struct token **p,
-			    struct ident **n,
-			    int dont_nest, int prefer_abstract)
+static int is_nested(struct token *token, struct token **p,
+		    int prefer_abstract)
 {
 	/*
 	 * This can be either a parameter list or a grouping.
@@ -1245,22 +1240,38 @@ static enum kind which_kind(struct token *token, struct token **p,
 
 	if (token_type(next) == TOKEN_IDENT) {
 		if (lookup_type(next))
-			return (dont_nest || prefer_abstract) ? Proto : Nested;
-		if (dont_nest) {
-			/* attributes in the K&R identifier list */
-			if (next != token->next)
-				return Bad_Func;
-			/* identifier list not in definition; complain */
-			if (prefer_abstract)
-				warning(token->pos,
-					"identifier list not in definition");
-			return K_R;
-		}
-		return Nested;
+			return !prefer_abstract;
+		return 1;
+	}
+
+	if (match_op(next, ')') || match_op(next, SPECIAL_ELLIPSIS))
+		return 0;
+
+	return 1;
+}
+
+enum kind {
+	Empty, K_R, Proto, Bad_Func,
+};
+
+static enum kind which_func(struct token *token,
+			    struct ident **n,
+			    int prefer_abstract)
+{
+	struct token *next = token->next;
+
+	if (token_type(next) == TOKEN_IDENT) {
+		if (lookup_type(next))
+			return Proto;
+		/* identifier list not in definition; complain */
+		if (prefer_abstract)
+			warning(token->pos,
+				"identifier list not in definition");
+		return K_R;
 	}
 
 	if (token_type(next) != TOKEN_SPECIAL)
-		return !dont_nest ? Bad_Nested : Bad_Func;
+		return Bad_Func;
 
 	if (next->special == ')') {
 		/* don't complain about those */
@@ -1278,72 +1289,51 @@ static enum kind which_kind(struct token *token, struct token **p,
 		return Proto;
 	}
 
-	return dont_nest ? Bad_Func : Nested;
+	return Bad_Func;
 }
 
 static struct token *direct_declarator(struct token *token, struct ctype *ctx, struct ident **p, int prefer_abstract)
 {
 	struct ctype *ctype = ctx;
-	int dont_nest = 0;
+	struct token *next;
 
 	if (p && token_type(token) == TOKEN_IDENT) {
 		*p = token->ident;
 		token = token->next;
-		dont_nest = 1;
+	} else if (match_op(token, '(') &&
+	    is_nested(token, &next, prefer_abstract)) {
+		struct symbol *base_type = ctype->base_type;
+		if (token->next != next)
+			next = handle_attributes(token->next, ctype,
+						  KW_ATTRIBUTE);
+		token = declarator(next, ctx, p, prefer_abstract);
+		token = expect(token, ')', "in nested declarator");
+		while (ctype->base_type != base_type)
+			ctype = &ctype->base_type->ctype;
+		p = NULL;
 	}
 
-	for (;;) {
-		if (token_type(token) != TOKEN_SPECIAL)
-			return token;
-
-		if (token->special == '(') {
-			struct symbol *sym;
-			struct token *next;
-			enum kind kind = which_kind(token, &next, p,
-						dont_nest, prefer_abstract);
-
-			dont_nest = 1;
-
-			if (kind == Nested) {
-				struct symbol *base_type = ctype->base_type;
-				if (token->next != next)
-					next = handle_attributes(token->next, ctype,
-								  KW_ATTRIBUTE);
-				token = declarator(next, ctx, p, prefer_abstract);
-				token = expect(token, ')', "in nested declarator");
-				while (ctype->base_type != base_type)
-					ctype = &ctype->base_type->ctype;
-				p = NULL;
-				continue;
-			}
-
-			if (kind == Bad_Nested) {
-				token = expect(token, ')', "in nested declarator");
-				p = NULL;
-				continue;
-			}
-
-			/* otherwise we have a function */
-			sym = alloc_indirect_symbol(token->pos, ctype, SYM_FN);
-			if (kind == K_R)
-				next = identifier_list(token->next, sym);
-			else if (kind == Proto)
-				next = parameter_type_list(token->next, sym);
-			token = expect(next, ')', "in function declarator");
-			sym->endpos = token->pos;
-			continue;
-		}
+	if (match_op(token, '(')) {
+		enum kind kind = which_func(token, p, prefer_abstract);
+		struct symbol *fn;
+		fn = alloc_indirect_symbol(token->pos, ctype, SYM_FN);
+		token = token->next;
+		if (kind == K_R)
+			token = identifier_list(token, fn);
+		else if (kind == Proto)
+			token = parameter_type_list(token, fn);
+		token = expect(token, ')', "in function declarator");
+		fn->endpos = token->pos;
+		return token;
+	}
 
-		if (token->special == '[') {
-			struct symbol *array = alloc_indirect_symbol(token->pos, ctype, SYM_ARRAY);
-			token = abstract_array_declarator(token->next, array);
-			token = expect(token, ']', "in abstract_array_declarator");
-			array->endpos = token->pos;
-			ctype = &array->ctype;
-			dont_nest = 1;
-			continue;
-		}
-		break;
+	while (match_op(token, '[')) {
+		struct symbol *array;
+		array = alloc_indirect_symbol(token->pos, ctype, SYM_ARRAY);
+		token = abstract_array_declarator(token->next, array);
+		token = expect(token, ']', "in abstract_array_declarator");
+		array->endpos = token->pos;
+		ctype = &array->ctype;
 	}
 	return token;
 }
@@ -2282,7 +2272,7 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
 	/* Just a type declaration? */
 	if (!ident) {
 		warning(token->pos, "missing identifier in declaration");
-		return expect(token, ';', "end of type declaration");
+		return expect(token, ';', "at the end of type declaration");
 	}
 
 	/* type define declaration? */
diff --git a/validation/nested-declarator.c b/validation/nested-declarator.c
index 62c4940..1efe20c 100644
--- a/validation/nested-declarator.c
+++ b/validation/nested-declarator.c
@@ -16,12 +16,14 @@ int j(int [2](*));
 /*
  * check-name: nested declarator vs. parameters
  * check-error-start:
-nested-declarator.c:11:29: warning: missing identifier in declaration
-nested-declarator.c:13:16: error: Expected ) in function declarator
-nested-declarator.c:13:16: error: got *
-nested-declarator.c:14:19: error: Expected ) in function declarator
-nested-declarator.c:14:19: error: got *
-nested-declarator.c:15:15: error: Expected ) in function declarator
-nested-declarator.c:15:15: error: got *
+nested-declarator.c:11:23: warning: missing identifier in declaration
+nested-declarator.c:11:23: error: Expected ; at the end of type declaration
+nested-declarator.c:11:23: error: got (
+nested-declarator.c:13:15: error: Expected ; at the end of type declaration
+nested-declarator.c:13:15: error: got (
+nested-declarator.c:14:18: error: Expected ) in function declarator
+nested-declarator.c:14:18: error: got (
+nested-declarator.c:15:14: error: Expected ) in function declarator
+nested-declarator.c:15:14: error: got (
  * check-error-end:
  */
diff --git a/validation/nested-declarator2.c b/validation/nested-declarator2.c
index 795d01f..cd22853 100644
--- a/validation/nested-declarator2.c
+++ b/validation/nested-declarator2.c
@@ -32,11 +32,9 @@ nested-declarator2.c:17:1: warning: non-ANSI definition of function 'w1'
 nested-declarator2.c:21:21: warning: non-ANSI function declaration of function '<noident>'
 nested-declarator2.c:22:16: warning: variadic functions must have one named argument
 nested-declarator2.c:24:21: warning: identifier list not in definition
-nested-declarator2.c:25:44: error: Expected ) in function declarator
-nested-declarator2.c:25:44: error: got x
 nested-declarator2.c:26:13: error: Expected ) in nested declarator
 nested-declarator2.c:26:13: error: got -
-nested-declarator2.c:27:17: error: Expected ) in function declarator
-nested-declarator2.c:27:17: error: got *
+nested-declarator2.c:27:16: error: Expected ; at the end of type declaration
+nested-declarator2.c:27:16: error: got (
  * check-error-end:
  */
-- 
1.5.6.5


