From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 0/5] keyword driven parsing
Date: Thu, 8 Mar 2007 00:59:25 -0800
Message-ID: <20070308085925.GA19829@chrisli.org>
References: <20070307100109.GA10577@chrisli.org> <45EFB34B.6030101@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from sccrmhc14.comcast.net ([63.240.77.84]:58566 "EHLO
	sccrmhc14.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030432AbXCHJeR (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 8 Mar 2007 04:34:17 -0500
Content-Disposition: inline
In-Reply-To: <45EFB34B.6030101@freedesktop.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>

On Wed, Mar 07, 2007 at 10:55:07PM -0800, Josh Triplett wrote:
> Christopher Li wrote:
> 
> Beautiful!  Looks far more elegant and maintainable; thanks.
> 
> I've applied the first four patches in this series.  The fifth causes a
> regression in validation/context.c; see the attached diff of the output from
> the fourth to the fifth patches.

Hah. I misunderstand the syntax of context with only two arguments.
This syntax sucks. The meaning of the each argument depends on the total
number of arguments.

The patch is updated.

Chris

Introduce keyword driven attribute parsing

Now we are really parsing the attribute rather than building the
expression tree first.

Signed-Off-By: Christopher Li <sparse@chrisli.org>

Index: sparse/parse.c
===================================================================
--- sparse.orig/parse.c	2007-03-08 01:06:25.000000000 -0800
+++ sparse/parse.c	2007-03-08 01:08:32.000000000 -0800
@@ -55,8 +55,19 @@ static struct token *parse_do_statement(
 static struct token *parse_goto_statement(struct token *token, struct statement *stmt);
 static struct token *parse_context_statement(struct token *token, struct statement *stmt);
 static struct token *parse_range_statement(struct token *token, struct statement *stmt);
-static struct token *parse_asm(struct token *token, struct statement *stmt);
+static struct token *parse_asm_statement(struct token *token, struct statement *stmt);
 static struct token *toplevel_asm_declaration(struct token *token, struct symbol_list **list);
+static struct token *parse_asm_declarator(struct token *token, struct ctype *ctype);
+
+
+static struct token *attribute_packed(struct token *token, struct symbol *attr, struct ctype *ctype);
+static struct token *attribute_modifier(struct token *token, struct symbol *attr, struct ctype *ctype);
+static struct token *attribute_address_space(struct token *token, struct symbol *attr, struct ctype *ctype);
+static struct token *attribute_aligned(struct token *token, struct symbol *attr, struct ctype *ctype);
+static struct token *attribute_mode(struct token *token, struct symbol *attr, struct ctype *ctype);
+static struct token *attribute_context(struct token *token, struct symbol *attr, struct ctype *ctype);
+static struct token *attribute_transparent_union(struct token *token, struct symbol *attr, struct ctype *ctype);
+static struct token *ignore_attribute(struct token *token, struct symbol *attr, struct ctype *ctype);
 
 
 static struct symbol_op modifier_op = {
@@ -134,7 +145,7 @@ static struct symbol_op goto_op = {
 	.statement = parse_goto_statement,
 };
 
-static struct symbol_op context_op = {
+static struct symbol_op __context___op = {
 	.statement = parse_context_statement,
 };
 
@@ -143,10 +154,48 @@ static struct symbol_op range_op = {
 };
 
 static struct symbol_op asm_op = {
-	.statement = parse_asm,
+	.type = KW_ASM,
+	.declarator = parse_asm_declarator,
+	.statement = parse_asm_statement,
 	.toplevel = toplevel_asm_declaration,
 };
 
+static struct symbol_op packed_op = {
+	.attribute = attribute_packed,
+};
+
+static struct symbol_op aligned_op = {
+	.attribute = attribute_aligned,
+};
+
+static struct symbol_op attr_mod_op = {
+	.attribute = attribute_modifier,
+};
+
+static struct symbol_op address_space_op = {
+	.attribute = attribute_address_space,
+};
+
+static struct symbol_op mode_op = {
+	.attribute = attribute_mode,
+};
+
+static struct symbol_op context_op = {
+	.attribute = attribute_context,
+};
+
+static struct symbol_op transparent_union_op = {
+	.attribute = attribute_transparent_union,
+};
+
+static struct symbol_op ignore_attr_op = {
+	.attribute = ignore_attribute,
+};
+
+static struct symbol_op mode_spec_op = {
+	.type = KW_MODE,
+};
+
 static struct init_keyword {
 	const char *name;
 	enum namespace ns;
@@ -196,12 +245,83 @@ static struct init_keyword {
 	{ "while",	NS_KEYWORD, .op = &while_op },
 	{ "do",		NS_KEYWORD, .op = &do_op },
 	{ "goto",	NS_KEYWORD, .op = &goto_op },
-	{ "__context__",NS_KEYWORD, .op = &context_op },
+	{ "__context__",NS_KEYWORD, .op = &__context___op },
 	{ "__range__",	NS_KEYWORD, .op = &range_op },
 	{ "asm",	NS_KEYWORD, .op = &asm_op },
 	{ "__asm",	NS_KEYWORD, .op = &asm_op },
 	{ "__asm__",	NS_KEYWORD, .op = &asm_op },
 
+	/* Attribute */
+	{ "packed",	NS_KEYWORD, .op = &packed_op },
+	{ "__packed__",	NS_KEYWORD, .op = &packed_op },
+	{ "aligned",	NS_KEYWORD, .op = &aligned_op },
+	{ "__aligned__",NS_KEYWORD, .op = &aligned_op },
+	{ "nocast",	NS_KEYWORD,	MOD_NOCAST,	.op = &attr_mod_op },
+	{ "noderef",	NS_KEYWORD,	MOD_NODEREF,	.op = &attr_mod_op },
+	{ "safe",	NS_KEYWORD,	MOD_SAFE, 	.op = &attr_mod_op },
+	{ "force",	NS_KEYWORD,	MOD_FORCE,	.op = &attr_mod_op },
+	{ "bitwise",	NS_KEYWORD,	MOD_BITWISE,	.op = &attr_mod_op },
+	{ "__bitwise__",NS_KEYWORD,	MOD_BITWISE,	.op = &attr_mod_op },
+	{ "address_space",NS_KEYWORD,	.op = &address_space_op },
+	{ "mode",	NS_KEYWORD,	.op = &mode_op },
+	{ "context",	NS_KEYWORD,	.op = &context_op },
+	{ "__transparent_union__",	NS_KEYWORD,	.op = &transparent_union_op },
+
+	{ "__mode__",	NS_KEYWORD,	.op = &mode_op },
+	{ "QI",		NS_KEYWORD,	MOD_CHAR,	.op = &mode_spec_op },
+	{ "__QI__",	NS_KEYWORD,	MOD_CHAR,	.op = &mode_spec_op },
+	{ "HI",		NS_KEYWORD,	MOD_SHORT,	.op = &mode_spec_op },
+	{ "__HI__",	NS_KEYWORD,	MOD_SHORT,	.op = &mode_spec_op },
+	{ "SI",		NS_KEYWORD,			.op = &mode_spec_op },
+	{ "__SI__",	NS_KEYWORD,			.op = &mode_spec_op },
+	{ "DI",		NS_KEYWORD,	MOD_LONGLONG,	.op = &mode_spec_op },
+	{ "__DI__",	NS_KEYWORD,	MOD_LONGLONG,	.op = &mode_spec_op },
+	{ "word",	NS_KEYWORD,	MOD_LONG,	.op = &mode_spec_op },
+	{ "__word__",	NS_KEYWORD,	MOD_LONG,	.op = &mode_spec_op },
+
+	/* Ignored attributes */
+	{ "nothrow",	NS_KEYWORD,	.op = &ignore_attr_op },
+	{ "__nothrow",	NS_KEYWORD,	.op = &ignore_attr_op },
+	{ "__nothrow__",	NS_KEYWORD,	.op = &ignore_attr_op },
+	{ "__malloc__",	NS_KEYWORD,	.op = &ignore_attr_op },
+	{ "nonnull",	NS_KEYWORD,	.op = &ignore_attr_op },
+	{ "__nonnull",	NS_KEYWORD,	.op = &ignore_attr_op },
+	{ "__nonnull__",	NS_KEYWORD,	.op = &ignore_attr_op },
+	{ "format",	NS_KEYWORD,	.op = &ignore_attr_op },
+	{ "__format__",	NS_KEYWORD,	.op = &ignore_attr_op },
+	{ "__format_arg__",	NS_KEYWORD,	.op = &ignore_attr_op },
+	{ "section",	NS_KEYWORD,	.op = &ignore_attr_op },
+	{ "__section__",NS_KEYWORD,	.op = &ignore_attr_op },
+	{ "unused",	NS_KEYWORD,	.op = &ignore_attr_op },
+	{ "__unused__",	NS_KEYWORD,	.op = &ignore_attr_op },
+	{ "const",	NS_KEYWORD,	.op = &ignore_attr_op },
+	{ "__const",	NS_KEYWORD,	.op = &ignore_attr_op },
+	{ "__const__",	NS_KEYWORD,	.op = &ignore_attr_op },
+	{ "noreturn",	NS_KEYWORD,	.op = &ignore_attr_op },
+	{ "__noreturn__",	NS_KEYWORD,	.op = &ignore_attr_op },
+	{ "no_instrument_function",	NS_KEYWORD,	.op = &ignore_attr_op },
+	{ "__no_instrument_function__",	NS_KEYWORD,	.op = &ignore_attr_op },
+	{ "sentinel",	NS_KEYWORD,	.op = &ignore_attr_op },
+	{ "__sentinel__",	NS_KEYWORD,	.op = &ignore_attr_op },
+	{ "regparm",	NS_KEYWORD,	.op = &ignore_attr_op },
+	{ "weak",	NS_KEYWORD,	.op = &ignore_attr_op },
+	{ "__weak__",	NS_KEYWORD,	.op = &ignore_attr_op },
+	{ "alias",	NS_KEYWORD,	.op = &ignore_attr_op },
+	{ "__alias__",	NS_KEYWORD,	.op = &ignore_attr_op },
+	{ "pure",	NS_KEYWORD,	.op = &ignore_attr_op },
+	{ "__pure__",	NS_KEYWORD,	.op = &ignore_attr_op },
+	{ "always_inline",	NS_KEYWORD,	.op = &ignore_attr_op },
+	{ "syscall_linkage",	NS_KEYWORD,	.op = &ignore_attr_op },
+	{ "visibility",	NS_KEYWORD,	.op = &ignore_attr_op },
+	{ "__visibility__",	NS_KEYWORD,	.op = &ignore_attr_op },
+	{ "deprecated",	NS_KEYWORD,	.op = &ignore_attr_op },
+	{ "__deprecated__",	NS_KEYWORD,	.op = &ignore_attr_op },
+	{ "noinline",	NS_KEYWORD,	.op = &ignore_attr_op },
+	{ "__used__",	NS_KEYWORD,	.op = &ignore_attr_op },
+	{ "warn_unused_result",	NS_KEYWORD,	.op = &ignore_attr_op },
+	{ "__warn_unused_result__",	NS_KEYWORD,	.op = &ignore_attr_op },
+	{ "model",	NS_KEYWORD,	.op = &ignore_attr_op },
+	{ "__model__",	NS_KEYWORD,	.op = &ignore_attr_op },
 };
 
 void init_parser(int stream)
@@ -621,180 +741,127 @@ static struct token *typeof_specifier(st
 	return expect(token, ')', "after typeof");
 }
 
-static const char * handle_attribute(struct ctype *ctype, struct ident *attribute, struct expression *expr)
+static struct token *ignore_attribute(struct token *token, struct symbol *attr, struct ctype *ctype)
 {
-	if (attribute == &packed_ident ||
-	    attribute == &__packed___ident) {
-		ctype->alignment = 1;
-		return NULL;
-	}
-	if (attribute == &aligned_ident ||
-	    attribute == &__aligned___ident) {
-		int alignment = max_alignment;
+	struct expression *expr = NULL;
+	if (match_op(token, '('))
+		token = parens_expression(token, &expr, "in attribute");
+	return token;
+}
+
+static struct token *attribute_packed(struct token *token, struct symbol *attr, struct ctype *ctype)
+{
+	ctype->alignment = 1;
+	return token;
+}
+
+static struct token *attribute_aligned(struct token *token, struct symbol *attr, struct ctype *ctype)
+{
+	int alignment = max_alignment;
+	struct expression *expr = NULL;
+
+	if (match_op(token, '(')) {
+		token = parens_expression(token, &expr, "in attribute");
 		if (expr)
 			alignment = get_expression_value(expr);
-		ctype->alignment = alignment;
-		return NULL;
 	}
-	if (attribute == &nocast_ident) {
-		ctype->modifiers |= MOD_NOCAST;
-		return NULL;
-	}
-	if (attribute == &noderef_ident) {
-		ctype->modifiers |= MOD_NODEREF;
-		return NULL;
-	}
-	if (attribute == &safe_ident) {
-		ctype->modifiers |= MOD_SAFE;
-		return NULL;
-	}
-	if (attribute == &force_ident) {
-		ctype->modifiers |= MOD_FORCE;
-		return NULL;
-	}
-	if (attribute == &bitwise_ident ||
-            attribute == &__bitwise___ident) {
-		if (Wbitwise)
-			ctype->modifiers |= MOD_BITWISE;
-		return NULL;
-	}
-	if (attribute == &address_space_ident) {
-		if (!expr)
-			return "expected address space number";
+	ctype->alignment = alignment;
+	return token;
+}
+
+static struct token *attribute_modifier(struct token *token, struct symbol *attr, struct ctype *ctype)
+{
+	ctype->modifiers |= attr->ctype.modifiers;
+	return token;
+}
+
+static struct token *attribute_address_space(struct token *token, struct symbol *attr, struct ctype *ctype)
+{
+	struct expression *expr = NULL;
+	token = expect(token, '(', "after address_space attribute");
+	token = conditional_expression(token, &expr);
+	if (expr)
 		ctype->as = get_expression_value(expr);
-		return NULL;
-	}
-	if (attribute == &context_ident) {
-		if (expr && expr->type == EXPR_COMMA) {
-			struct context *context = alloc_context();
-			if(expr->left->type == EXPR_COMMA) {
-				context->context = expr->left->left;
-				context->in = get_expression_value(
-					expr->left->right);
-			} else {
-				context->context = NULL;
-				context->in = get_expression_value(expr->left);
-			}
-			context->out = get_expression_value(expr->right);
-			add_ptr_list(&ctype->contexts, context);
-			return NULL;
-		}
-		return "expected context input/output values";
-	}
-	if (attribute == &mode_ident ||
-	    attribute == &__mode___ident) {
-		if (expr && expr->type == EXPR_SYMBOL) {
-			struct ident *ident = expr->symbol_name;
+	token = expect(token, ')', "after address_space attribute");
+	return token;
+}
 
-			/*
-			 * Match against __QI__/__HI__/__SI__/__DI__
-			 *
-			 * FIXME! This is broken - we don't actually get
-			 * the type information updated properly at this
-			 * stage for some reason.
-			 */
-			if (ident == &__QI___ident ||
-			    ident == &QI_ident) {
-				ctype->modifiers |= MOD_CHAR;
-				return NULL;
-			}
-			if (ident == &__HI___ident ||
-			    ident == &HI_ident) {
-				ctype->modifiers |= MOD_SHORT;
-				return NULL;
-			}
-			if (ident == &__SI___ident ||
-			    ident == &SI_ident) {
-				/* Nothing? */
-				return NULL;
-			}
-			if (ident == &__DI___ident ||
-			    ident == &DI_ident) {
-				ctype->modifiers |= MOD_LONGLONG;
-				return NULL;
-			}
-			if (ident == &__word___ident ||
-			    ident == &word_ident) {
-				ctype->modifiers |= MOD_LONG;
-				return NULL;
-			}
-			return "unknown mode attribute";
-		}
-		return "expected attribute mode symbol";
+static struct token *attribute_mode(struct token *token, struct symbol *attr, struct ctype *ctype)
+{
+	token = expect(token, '(', "after mode attribute");
+	if (token_type(token) == TOKEN_IDENT) {
+		struct symbol *mode = lookup_keyword(token->ident, NS_KEYWORD);
+		if (mode && mode->op->type == KW_MODE)
+			ctype->modifiers |= mode->ctype.modifiers;
+		else
+			sparse_error(token->pos, "unknown mode attribute %s\n", show_ident(token->ident));
+		token = token->next;
+	} else 
+		sparse_error(token->pos, "expect attribute mode symbol\n");
+	token = expect(token, ')', "after mode attribute");
+	return token;
+}
+
+static struct token *attribute_context(struct token *token, struct symbol *attr, struct ctype *ctype)
+{
+	struct context *context = alloc_context();
+	struct expression *args[3];
+	int argc = 0;
+
+	token = expect(token, '(', "after context attribute");
+	while (!match_op(token, ')')) {
+		struct expression *expr = NULL;
+		token = conditional_expression(token, &expr);
+		if (!expr)
+			break;
+		if (argc < 3)
+			args[argc++] = expr;
+		if (!match_op(token, ','))
+			break;
+		token = token->next;
 	}
 
-	/* Throw away for now.. */
-	if (attribute == &__transparent_union___ident) {
-		if (Wtransparent_union)
-		    return "ignoring attribute __transparent_union__";
-		return NULL;
+	switch(argc) {
+	case 0:
+		sparse_error(token->pos, "expected context input/output values");
+		break;
+	case 1:
+		context->in = get_expression_value(args[0]);
+		break;
+	case 2:
+		context->in = get_expression_value(args[0]);
+		context->out = get_expression_value(args[1]);
+		break;
+	case 3:
+		context->context = args[0];
+		context->in = get_expression_value(args[1]);
+		context->out = get_expression_value(args[2]);
+		break;
 	}
-	if (attribute == &nothrow_ident ||
-	    attribute == &__nothrow_ident ||
-	    attribute == &__nothrow___ident)
-		return NULL;
-	if (attribute == &__malloc___ident)
-		return NULL;
-	if (attribute == &nonnull_ident ||
-	    attribute == &__nonnull_ident ||
-	    attribute == &__nonnull___ident)
-		return NULL;
-	if (attribute == &format_ident ||
-	    attribute == &__format___ident ||
-	    attribute == &__format_arg___ident)
-		return NULL;
-	if (attribute == &section_ident ||
-	    attribute == &__section___ident)
-		return NULL;
-	if (attribute == &unused_ident ||
-	    attribute == &__unused___ident)
-		return NULL;
-	if (attribute == &const_ident ||
-	    attribute == &__const_ident ||
-	    attribute == &__const___ident)
-		return NULL;
-	if (attribute == &noreturn_ident ||
-	    attribute == &__noreturn___ident)
-		return NULL;
-	if (attribute == &no_instrument_function_ident ||
-	    attribute == &__no_instrument_function___ident)
-		return NULL;
-	if (attribute == &sentinel_ident ||
-	    attribute == &__sentinel___ident)
-		return NULL;
-	if (attribute == &regparm_ident)
-		return NULL;
-	if (attribute == &weak_ident ||
-	    attribute == &__weak___ident)
-		return NULL;
-	if (attribute == &alias_ident ||
-	    attribute == &__alias___ident)
-		return NULL;
-	if (attribute == &pure_ident ||
-	    attribute == &__pure___ident)
-		return NULL;
-	if (attribute == &always_inline_ident)
-		return NULL;
-	if (attribute == &syscall_linkage_ident)
-		return NULL;
-	if (attribute == &visibility_ident ||
-	    attribute == &__visibility___ident)
-		return NULL;
-	if (attribute == &deprecated_ident ||
-	    attribute == &__deprecated___ident)
-		return NULL;
-	if (attribute == &noinline_ident)
-		return NULL;
-	if (attribute == &__used___ident)
-		return NULL;
-	if (attribute == &warn_unused_result_ident ||
-	    attribute == &__warn_unused_result___ident)
-		return NULL;
-	if (attribute == &model_ident ||
-	    attribute == &__model___ident)
-		return NULL;
 
-	return "unknown attribute";
+	if (argc)
+		add_ptr_list(&ctype->contexts, context);
+
+	token = expect(token, ')', "after context attribute");
+	return token;
+}
+
+static struct token *attribute_transparent_union(struct token *token, struct symbol *attr, struct ctype *ctype)
+{
+	if (Wtransparent_union)
+		sparse_error(token->pos, "ignoring attribute __transparent_union__");
+	return token;
+}
+
+static struct token *recover_unknown_attribute(struct token *token)
+{
+	struct expression *expr = NULL;
+
+	sparse_error(token->pos, "attribute '%s': unknown attribute", show_ident(token->ident));
+	token = token->next;
+	if (match_op(token, '('))
+		token = parens_expression(token, &expr, "in attribute");
+	return token;
 }
 
 static struct token *attribute_specifier(struct token *token, struct ctype *ctype)
@@ -804,9 +871,8 @@ static struct token *attribute_specifier
 	token = expect(token, '(', "after attribute");
 
 	for (;;) {
-		const char *error_str;
 		struct ident *attribute_name;
-		struct expression *attribute_expr;
+		struct symbol *attr;
 
 		if (eof_token(token))
 			break;
@@ -815,13 +881,12 @@ static struct token *attribute_specifier
 		if (token_type(token) != TOKEN_IDENT)
 			break;
 		attribute_name = token->ident;
-		token = token->next;
-		attribute_expr = NULL;
-		if (match_op(token, '('))
-			token = parens_expression(token, &attribute_expr, "in attribute");
-		error_str = handle_attribute(ctype, attribute_name, attribute_expr);
-		if (error_str)
-			sparse_error(token->pos, "attribute '%s': %s", show_ident(attribute_name), error_str);
+		attr = lookup_keyword(attribute_name, NS_KEYWORD);
+		if (attr && attr->op->attribute)
+			token = attr->op->attribute(token->next, attr, ctype);
+		else
+			token = recover_unknown_attribute(token);
+	
 		if (!match_op(token, ','))
 			break;
 		token = token->next;
@@ -1030,23 +1095,18 @@ static struct token *declarator(struct t
 
 static struct token *handle_attributes(struct token *token, struct ctype *ctype)
 {
+	struct symbol *keyword;
 	for (;;) {
+		struct ctype thistype = { 0, };
 		if (token_type(token) != TOKEN_IDENT)
 			break;
-		if (match_idents(token, &__attribute___ident, &__attribute_ident, NULL)) {
-			struct ctype thistype = { 0, };
-			token = attribute_specifier(token->next, &thistype);
-			apply_ctype(token->pos, &thistype, ctype);
-			continue;
-		}
-		if (match_idents(token, &asm_ident, &__asm_ident, &__asm___ident, NULL)) {
-			struct expression *expr;
-			token = expect(token->next, '(', "after asm");
-			token = parse_expression(token->next, &expr);
-			token = expect(token, ')', "after asm");
-			continue;
-		}
-		break;
+		keyword = lookup_keyword(token->ident, NS_KEYWORD | NS_TYPEDEF);
+		if (!keyword || keyword->type != SYM_KEYWORD)
+			break;
+		if (!(keyword->op->type & (KW_ATTRIBUTE | KW_ASM)))
+			break;
+		token = keyword->op->declarator(token->next, &thistype);
+		apply_ctype(token->pos, &thistype, ctype);
 	}
 	return token;
 }
@@ -1294,7 +1354,7 @@ static struct token *parse_asm_clobbers(
 	return token;
 }
 
-static struct token *parse_asm(struct token *token, struct statement *stmt)
+static struct token *parse_asm_statement(struct token *token, struct statement *stmt)
 {
 	token = token->next;
 	stmt->type = STMT_ASM;
@@ -1313,6 +1373,15 @@ static struct token *parse_asm(struct to
 	return expect(token, ';', "at end of asm-statement");
 }
 
+static struct token *parse_asm_declarator(struct token *token, struct ctype *ctype)
+{
+	struct expression *expr;
+	token = expect(token, '(', "after asm");
+	token = parse_expression(token->next, &expr);
+	token = expect(token, ')', "after asm");
+	return token;
+}
+
 /* Make a statement out of an expression */
 static struct statement *make_statement(struct expression *expr)
 {
@@ -1964,7 +2033,7 @@ static struct token *toplevel_asm_declar
 	stmt = alloc_statement(token->pos, STMT_NONE);
 	fn->stmt = stmt;
 
-	token = parse_asm(token, stmt);
+	token = parse_asm_statement(token, stmt);
 
 	add_symbol(list, anon);
 	return token;
Index: sparse/symbol.h
===================================================================
--- sparse.orig/symbol.h	2007-03-08 01:06:25.000000000 -0800
+++ sparse/symbol.h	2007-03-08 01:08:32.000000000 -0800
@@ -65,6 +65,8 @@ enum keyword {
 	KW_ATTRIBUTE	= 1 << 3,
 	KW_TYPEOF	= 1 << 4,
 	KW_STATEMENT	= 1 << 5,
+	KW_ASM		= 1 << 6,
+	KW_MODE		= 1 << 7,
 };
 
 struct context {
@@ -94,6 +96,7 @@ struct symbol_op {
 	struct token *(*declarator)(struct token *token, struct ctype *ctype);
 	struct token *(*statement)(struct token *token, struct statement *stmt);
 	struct token *(*toplevel)(struct token *token, struct symbol_list **list);
+	struct token *(*attribute)(struct token *token, struct symbol *attr, struct ctype *ctype);
 };
 
 extern int expand_safe_p(struct expression *expr, int cost);
