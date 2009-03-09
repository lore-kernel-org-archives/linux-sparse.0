From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH 11/18] Take the rest of specifiers to parse.c
Date: Mon, 09 Mar 2009 07:11:58 +0000
Message-ID: <E1LgZeY-0000w5-1k@ZenIV.linux.org.uk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:43759 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752418AbZCIHMA (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 9 Mar 2009 03:12:00 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.69 #1 (Red Hat Linux))
	id 1LgZeY-0000w5-1k
	for linux-sparse@vger.kernel.org; Mon, 09 Mar 2009 07:11:58 +0000
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


... and yes, right now it's ucking fugly.  Will get sanitized shortly.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 parse.c  |   28 ++++++++++++++++++++++++++--
 symbol.c |   48 ++++++------------------------------------------
 symbol.h |    1 +
 3 files changed, 33 insertions(+), 44 deletions(-)

diff --git a/parse.c b/parse.c
index ba1a52d..a9156c9 100644
--- a/parse.c
+++ b/parse.c
@@ -101,7 +101,9 @@ static struct symbol_op enum_op = {
 	.declarator = enum_specifier,
 };
 
-
+static struct symbol_op spec_op = {
+	.type = KW_SPEC,
+};
 
 static struct symbol_op if_op = {
 	.statement = parse_if_statement,
@@ -199,6 +201,7 @@ static struct init_keyword {
 	enum namespace ns;
 	unsigned long modifiers;
 	struct symbol_op *op;
+	struct symbol *type;
 } keyword_table[] = {
 	/* Type qualifiers */
 	{ "const",	NS_TYPEDEF, MOD_CONST, .op = &qualifier_op },
@@ -211,6 +214,26 @@ static struct init_keyword {
 	/* Typedef.. */
 	{ "typedef",	NS_TYPEDEF, MOD_TYPEDEF, .op = &modifier_op },
 
+	/* Type specifiers */
+	{ "void",	NS_TYPEDEF, .type = &void_ctype, .op = &spec_op},
+	{ "char",	NS_TYPEDEF, MOD_CHAR, .op = &spec_op },
+	{ "short",	NS_TYPEDEF, MOD_SHORT, .op = &spec_op },
+	{ "int",	NS_TYPEDEF, .type = &int_type, .op = &spec_op },
+	{ "long",	NS_TYPEDEF, MOD_LONG, .op = &spec_op },
+	{ "float",	NS_TYPEDEF, .type = &fp_type, .op = &spec_op },
+	{ "double",	NS_TYPEDEF, MOD_LONG, .type = &fp_type, .op = &spec_op },
+	{ "signed",	NS_TYPEDEF, MOD_SIGNED | MOD_EXPLICITLY_SIGNED, .op = &spec_op },
+	{ "__signed",	NS_TYPEDEF, MOD_SIGNED | MOD_EXPLICITLY_SIGNED, .op = &spec_op },
+	{ "__signed__",	NS_TYPEDEF, MOD_SIGNED | MOD_EXPLICITLY_SIGNED, .op = &spec_op },
+	{ "unsigned",	NS_TYPEDEF, MOD_UNSIGNED, .op = &spec_op },
+	{ "__label__",	NS_TYPEDEF, MOD_LABEL | MOD_UNSIGNED,
+		.type =&label_ctype, .op = &spec_op },
+	{ "_Bool",	NS_TYPEDEF, MOD_UNSIGNED, .type = &bool_ctype,
+		.op = &spec_op },
+
+	/* Predeclared types */
+	{ "__builtin_va_list", NS_TYPEDEF, .type = &int_type, .op = &spec_op },
+
 	/* Extended types */
 	{ "typeof", 	NS_TYPEDEF, .op = &typeof_op },
 	{ "__typeof", 	NS_TYPEDEF, .op = &typeof_op },
@@ -363,6 +386,7 @@ void init_parser(int stream)
 		if (ptr->ns == NS_TYPEDEF)
 			sym->ident->reserved = 1;
 		sym->ctype.modifiers = ptr->modifiers;
+		sym->ctype.base_type = ptr->type;
 		sym->op = ptr->op;
 	}
 }
@@ -1067,7 +1091,7 @@ static void check_modifiers(struct position *pos, struct symbol *s, unsigned lon
 	const unsigned long BANNED_SIZE = MOD_LONG | MOD_LONGLONG | MOD_SHORT;
 	const unsigned long BANNED_SIGN = MOD_SIGNED | MOD_UNSIGNED;
 
-	if (s->type == SYM_KEYWORD)
+	if (!(s->op->type & KW_SPEC))
 		banned = s->op->type == KW_SPECIFIER ? (BANNED_SIZE | BANNED_SIGN) : 0;
 	else if (s->ctype.base_type == &fp_type)
 		banned = BANNED_SIGN;
diff --git a/symbol.c b/symbol.c
index 8a323b5..b7bb5af 100644
--- a/symbol.c
+++ b/symbol.c
@@ -687,40 +687,6 @@ out:
 	return 0;
 }
 
-/*
- * Type and storage class keywords need to have the symbols
- * created for them, so that the parser can have enough semantic
- * information to do parsing.
- *
- * "double" == "long float", "long double" == "long long float"
- */
-static struct sym_init {
-	const char *name;
-	struct symbol *base_type;
-	unsigned int modifiers;
-	struct symbol_op *op;
-} symbol_init_table[] = {
-	/* Type specifiers */
-	{ "void",	&void_ctype,	0 },
-	{ "char",	NULL,		MOD_CHAR },
-	{ "short",	NULL,		MOD_SHORT },
-	{ "int",	&int_type,	0 },
-	{ "long",	NULL,		MOD_LONG },
-	{ "float",	&fp_type,	0 },
-	{ "double",	&fp_type,	MOD_LONG },
-	{ "signed",	NULL,		MOD_SIGNED | MOD_EXPLICITLY_SIGNED },
-	{ "__signed",	NULL,		MOD_SIGNED | MOD_EXPLICITLY_SIGNED },
-	{ "__signed__",	NULL,		MOD_SIGNED | MOD_EXPLICITLY_SIGNED },
-	{ "unsigned",	NULL,		MOD_UNSIGNED },
-	{ "__label__",	&label_ctype,	MOD_LABEL | MOD_UNSIGNED },
-	{ "_Bool",	&bool_ctype,	MOD_UNSIGNED },
-
-	/* Predeclared types */
-	{ "__builtin_va_list", &int_type, 0 },
-
-	{ NULL,		NULL,		0 }
-};
-
 static struct symbol_op constant_p_op = {
 	.evaluate = evaluate_to_integer,
 	.expand = expand_constant_p
@@ -750,7 +716,12 @@ static struct symbol_op choose_op = {
  * Builtin functions
  */
 static struct symbol builtin_fn_type = { .type = SYM_FN /* , .variadic =1 */ };
-static struct sym_init eval_init_table[] = {
+static struct sym_init {
+	const char *name;
+	struct symbol *base_type;
+	unsigned int modifiers;
+	struct symbol_op *op;
+} eval_init_table[] = {
 	{ "__builtin_constant_p", &builtin_fn_type, MOD_TOPLEVEL, &constant_p_op },
 	{ "__builtin_safe_p", &builtin_fn_type, MOD_TOPLEVEL, &safe_p_op },
 	{ "__builtin_warning", &builtin_fn_type, MOD_TOPLEVEL, &warning_op },
@@ -799,13 +770,6 @@ void init_symbols(void)
 #include "ident-list.h"
 
 	init_parser(stream);
-	for (ptr = symbol_init_table; ptr->name; ptr++) {
-		struct symbol *sym;
-		sym = create_symbol(stream, ptr->name, SYM_NODE, NS_TYPEDEF);
-		sym->ident->reserved = 1;
-		sym->ctype.base_type = ptr->base_type;
-		sym->ctype.modifiers = ptr->modifiers;
-	}
 
 	builtin_fn_type.variadic = 1;
 	for (ptr = eval_init_table; ptr->name; ptr++) {
diff --git a/symbol.h b/symbol.h
index 1f66d55..229057c 100644
--- a/symbol.h
+++ b/symbol.h
@@ -68,6 +68,7 @@ enum keyword {
 	KW_STATEMENT	= 1 << 5,
 	KW_ASM		= 1 << 6,
 	KW_MODE		= 1 << 7,
+	KW_SPEC		= 1 << 8,
 };
 
 struct context {
-- 
1.5.6.5


