From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH][RFC] Re: sparse handles int64_t type wrong
Date: Wed, 13 Dec 2006 16:13:55 -0800
Message-ID: <20061214001355.GA20494@chrisli.org>
References: <1165952070.17896.7.camel@chaos.malinovka7.net> <Pine.LNX.4.64.0612121143280.3535@woody.osdl.org> <Pine.LNX.4.64.0612121155450.3535@woody.osdl.org> <20061213051827.GA13748@chrisli.org> <Pine.LNX.4.64.0612130733190.3418@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from sccrmhc15.comcast.net ([63.240.77.85]:34159 "EHLO
	sccrmhc15.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751854AbWLNA2u (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 13 Dec 2006 19:28:50 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612130733190.3418@woody.osdl.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Yura Pakhuchiy <pakhuchiy@gmail.com>, Josh Triplett <josh@freedesktop.org>, linux-sparse@vger.kernel.org

On Wed, Dec 13, 2006 at 07:36:20AM -0800, Linus Torvalds wrote:
> 
> It looks correct to me, although not wonderfully pretty. But it's simpler 
> than the "don't do the int/fp type finalization until later" that I 
> couldn't even get to work (not that I spent a lot of time on it, but 
> still)

Do you mean some thing like this?  I might leave some abstract ctype
in the tree, it is hard to find all all the user of ctype before
it get finalized.  It seems work with the test case in my hand.

Chris

Index: sparse/parse.c
===================================================================
--- sparse.orig/parse.c	2006-12-13 16:10:32.000000000 -0800
+++ sparse/parse.c	2006-12-13 16:15:42.000000000 -0800
@@ -70,12 +70,43 @@ struct statement *alloc_statement(struct
 
 static struct token *struct_declaration_list(struct token *token, struct symbol_list **list);
 
+static int apply_modifiers(struct position pos, struct ctype *ctype)
+{
+	/* Turn the "virtual types" into real types with real sizes etc */
+
+	if (ctype->base_type == &int_type) {
+		ctype->base_type = ctype_integer(ctype->modifiers);
+		ctype->modifiers &= ~MOD_SPECIFIER;
+	} else if (ctype->base_type == &fp_type) {
+		ctype->base_type = ctype_fp(ctype->modifiers);
+		ctype->modifiers &= ~MOD_SPECIFIER;
+	}
+
+	if (ctype->modifiers & MOD_BITWISE) {
+		struct symbol *type;
+		ctype->modifiers &= ~(MOD_BITWISE | MOD_SPECIFIER);
+		if (!is_int_type(ctype->base_type)) {
+			sparse_error(pos, "invalid modifier");
+			return 1;
+		}
+		type = alloc_symbol(pos, SYM_BASETYPE);
+		*type = *ctype->base_type;
+		type->ctype.base_type = ctype->base_type;
+		type->type = SYM_RESTRICT;
+		type->ctype.modifiers &= ~MOD_SPECIFIER;
+		ctype->base_type = type;
+		create_fouled(type);
+	}
+	return 0;
+}
+
 static struct symbol * indirect(struct position pos, struct ctype *ctype, int type)
 {
 	struct symbol *sym = alloc_symbol(pos, type);
 
 	sym->ctype.base_type = ctype->base_type;
 	sym->ctype.modifiers = ctype->modifiers & ~MOD_STORAGE;
+	apply_modifiers(pos, &sym->ctype);
 
 	ctype->base_type = sym;
 	ctype->modifiers &= MOD_STORAGE;
@@ -724,7 +755,6 @@ static void check_modifiers(struct posit
 		     modifier_string (wrong));
 }
 
-
 static struct token *declaration_specifiers(struct token *next, struct ctype *ctype, int qual)
 {
 	struct token *token;
@@ -778,7 +808,6 @@ static struct token *declaration_specifi
 		apply_ctype(token->pos, &thistype, ctype);
 	}
 
-	/* Turn the "virtual types" into real types with real sizes etc */
 	if (!ctype->base_type) {
 		struct symbol *base = &incomplete_ctype;
 
@@ -791,28 +820,6 @@ static struct token *declaration_specifi
 			base = &int_type;
 		ctype->base_type = base;
 	}
-	if (ctype->base_type == &int_type) {
-		ctype->base_type = ctype_integer(ctype->modifiers);
-		ctype->modifiers &= ~MOD_SPECIFIER;
-	} else if (ctype->base_type == &fp_type) {
-		ctype->base_type = ctype_fp(ctype->modifiers);
-		ctype->modifiers &= ~MOD_SPECIFIER;
-	}
-	if (ctype->modifiers & MOD_BITWISE) {
-		struct symbol *type;
-		ctype->modifiers &= ~(MOD_BITWISE | MOD_SPECIFIER);
-		if (!is_int_type(ctype->base_type)) {
-			sparse_error(token->pos, "invalid modifier");
-			return token;
-		}
-		type = alloc_symbol(token->pos, SYM_BASETYPE);
-		*type = *ctype->base_type;
-		type->ctype.base_type = ctype->base_type;
-		type->type = SYM_RESTRICT;
-		type->ctype.modifiers &= ~MOD_SPECIFIER;
-		ctype->base_type = type;
-		create_fouled(type);
-	}
 	return token;
 }
 
@@ -1001,6 +1008,7 @@ static struct token *declaration_list(st
 			token = handle_bitfield(token, decl);
 			token = handle_attributes(token, &decl->ctype);
 		}
+		apply_modifiers(token->pos, &decl->ctype);
 		add_symbol(list, decl);
 		if (!match_op(token, ','))
 			break;
@@ -1034,6 +1042,7 @@ static struct token *parameter_declarati
 	*tree = sym;
 	token = declarator(token, sym, &ident);
 	sym->ident = ident;
+	apply_modifiers(token->pos, &sym->ctype);
 	return token;
 }
 
@@ -1042,7 +1051,9 @@ struct token *typename(struct token *tok
 	struct symbol *sym = alloc_symbol(token->pos, SYM_NODE);
 	*p = sym;
 	token = declaration_specifiers(token, &sym->ctype, 0);
-	return declarator(token, sym, NULL);
+	token = declarator(token, sym, NULL);
+	apply_modifiers(token->pos, &sym->ctype);
+	return token;
 }
 
 static struct token *expression_statement(struct token *token, struct expression **tree)
@@ -1770,6 +1781,8 @@ struct token *external_declaration(struc
 	decl = alloc_symbol(token->pos, SYM_NODE);
 	decl->ctype = ctype;
 	token = declarator(token, decl, &ident);
+	apply_modifiers(token->pos, &decl->ctype);
+	apply_modifiers(token->pos, &ctype);
 
 	/* Just a type declaration? */
 	if (!ident)
@@ -1830,6 +1843,7 @@ struct token *external_declaration(struc
 		decl->ctype = ctype;
 		token = declaration_specifiers(token, &decl->ctype, 1);
 		token = declarator(token, decl, &ident);
+		apply_modifiers(token->pos, &decl->ctype);
 		if (!ident) {
 			sparse_error(token->pos, "expected identifier name in type definition");
 			return token;
Index: sparse/show-parse.c
===================================================================
--- sparse.orig/show-parse.c	2006-12-13 16:10:32.000000000 -0800
+++ sparse/show-parse.c	2006-12-13 16:10:36.000000000 -0800
@@ -98,7 +98,7 @@ const char *modifier_string(unsigned lon
 	const char *res,**ptr, *names[] = {
 		"auto", "register", "static", "extern",
 		"const", "volatile", "[signed]", "[unsigned]",
-		"[char]", "[short]", "[long]", "[long]",
+		"[char]", "[short]", "[long]", "[long long]",
 		"[typdef]", "[structof]", "[unionof]", "[enum]",
 		"[typeof]", "[attribute]", "inline", "[addressable]",
 		"[nocast]", "[noderef]", "[accessed]", "[toplevel]",
Index: sparse/test-parsing.c
===================================================================
