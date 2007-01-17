From: Christopher Li <sparse@chrisli.org>
Subject: [PATCH 9] Another attempt to fix the attribute parsing.
Date: Tue, 16 Jan 2007 18:43:57 -0800
Message-ID: <20070117024357.GJ962@chrisli.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rwcrmhc15.comcast.net ([216.148.227.155]:49689 "EHLO
	rwcrmhc15.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751984AbXAQDGy (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 16 Jan 2007 22:06:54 -0500
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Josh Triplett <josh@freedesktop.org>

This patch delay the finalized of the abstract int type so it
can take the __attribute__ in the end of declaration. 

It complicate the bit field parsing because abstract type can
show up in the base type of bit field.

Signed-off-by: Christopher Li <sparse@chrisli.org>

Index: sparse/parse.c
===================================================================
--- sparse.orig/parse.c	2006-12-14 20:26:32.000000000 -0800
+++ sparse/parse.c	2006-12-14 20:27:44.000000000 -0800
@@ -70,6 +70,50 @@ struct statement *alloc_statement(struct
 
 static struct token *struct_declaration_list(struct token *token, struct symbol_list **list);
 
+static int apply_modifiers(struct position pos, struct ctype *ctype)
+{
+	struct symbol *base;
+
+	while ((base = ctype->base_type)) {
+		switch (base->type) {
+		case SYM_FN:
+		case SYM_ENUM:
+		case SYM_ARRAY:
+		case SYM_BITFIELD:
+		case SYM_PTR:
+			ctype = &base->ctype;
+			continue;
+		}
+		break;
+	}
+
+	/* Turn the "virtual types" into real types with real sizes etc */
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
@@ -724,7 +768,6 @@ static void check_modifiers(struct posit
 		     modifier_string (wrong));
 }
 
-
 static struct token *declaration_specifiers(struct token *next, struct ctype *ctype, int qual)
 {
 	struct token *token;
@@ -778,7 +821,6 @@ static struct token *declaration_specifi
 		apply_ctype(token->pos, &thistype, ctype);
 	}
 
-	/* Turn the "virtual types" into real types with real sizes etc */
 	if (!ctype->base_type) {
 		struct symbol *base = &incomplete_ctype;
 
@@ -791,28 +833,6 @@ static struct token *declaration_specifi
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
 
@@ -947,7 +967,7 @@ static struct token *handle_bitfield(str
 	struct symbol *bitfield;
 	long long width;
 
-	if (!is_int_type(ctype->base_type)) {
+	if (ctype->base_type != &int_type && !is_int_type(ctype->base_type)) {
 		sparse_error(token->pos, "invalid bitfield specifier for type %s.",
 			show_typename(ctype->base_type));
 		// Parse this to recover gracefully.
@@ -968,15 +988,16 @@ static struct token *handle_bitfield(str
 		width = -1;
 	} else if (decl->ident) {
 		struct symbol *base_type = bitfield->ctype.base_type;
-		int is_signed = !(base_type->ctype.modifiers & MOD_UNSIGNED);
+		struct symbol *bitfield_type = base_type == &int_type ? bitfield : base_type;
+		int is_signed = !(bitfield_type->ctype.modifiers & MOD_UNSIGNED);
 		if (Wone_bit_signed_bitfield && width == 1 && is_signed) {
 			// Valid values are either {-1;0} or {0}, depending on integer
 			// representation.  The latter makes for very efficient code...
 			sparse_error(token->pos, "dubious one-bit signed bitfield");
 		}
 		if (Wdefault_bitfield_sign &&
-		    base_type->type != SYM_ENUM &&
-		    !(base_type->ctype.modifiers & MOD_EXPLICITLY_SIGNED) &&
+		    bitfield_type->type != SYM_ENUM &&
+		    !(bitfield_type->ctype.modifiers & MOD_EXPLICITLY_SIGNED) &&
 		    is_signed) {
 			// The sign of bitfields is unspecified by default.
 			sparse_error(token->pos, "dubious bitfield without explicit `signed' or `unsigned'");
@@ -1001,6 +1022,7 @@ static struct token *declaration_list(st
 			token = handle_bitfield(token, decl);
 			token = handle_attributes(token, &decl->ctype);
 		}
+		apply_modifiers(token->pos, &decl->ctype);
 		add_symbol(list, decl);
 		if (!match_op(token, ','))
 			break;
@@ -1034,6 +1056,7 @@ static struct token *parameter_declarati
 	*tree = sym;
 	token = declarator(token, sym, &ident);
 	sym->ident = ident;
+	apply_modifiers(token->pos, &sym->ctype);
 	return token;
 }
 
@@ -1042,7 +1065,9 @@ struct token *typename(struct token *tok
 	struct symbol *sym = alloc_symbol(token->pos, SYM_NODE);
 	*p = sym;
 	token = declaration_specifiers(token, &sym->ctype, 0);
-	return declarator(token, sym, NULL);
+	token = declarator(token, sym, NULL);
+	apply_modifiers(token->pos, &sym->ctype);
+	return token;
 }
 
 static struct token *expression_statement(struct token *token, struct expression **tree)
@@ -1770,6 +1795,7 @@ struct token *external_declaration(struc
 	decl = alloc_symbol(token->pos, SYM_NODE);
 	decl->ctype = ctype;
 	token = declarator(token, decl, &ident);
+	apply_modifiers(token->pos, &decl->ctype);
 
 	/* Just a type declaration? */
 	if (!ident)
@@ -1830,6 +1856,7 @@ struct token *external_declaration(struc
 		decl->ctype = ctype;
 		token = declaration_specifiers(token, &decl->ctype, 1);
 		token = declarator(token, decl, &ident);
+		apply_modifiers(token->pos, &decl->ctype);
 		if (!ident) {
 			sparse_error(token->pos, "expected identifier name in type definition");
 			return token;
