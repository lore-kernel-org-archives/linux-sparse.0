Return-Path: <SRS0=XUoR=DI=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C3F3C4727F
	for <linux-sparse@archiver.kernel.org>; Thu,  1 Oct 2020 09:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D171A2087D
	for <linux-sparse@archiver.kernel.org>; Thu,  1 Oct 2020 09:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731067AbgJAJso (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 1 Oct 2020 05:48:44 -0400
Received: from imap2.colo.codethink.co.uk ([78.40.148.184]:36340 "EHLO
        imap2.colo.codethink.co.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731243AbgJAJso (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 1 Oct 2020 05:48:44 -0400
Received: from cpc98990-stkp12-2-0-cust216.10-2.cable.virginm.net ([86.26.12.217] helo=rainbowdash.codethink.co.uk)
        by imap2.colo.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1kNukJ-0002oo-6u; Thu, 01 Oct 2020 10:19:27 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.94)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1kNukI-001YtU-Er; Thu, 01 Oct 2020 10:19:26 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-sparse@vger.kernel.org
Cc:     thomas.preston@codethink.co.uk, christopher.phang@codethink.co.uk,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH 2/4] parse: initial parsing of __attribute__((format))
Date:   Thu,  1 Oct 2020 10:19:21 +0100
Message-Id: <20201001091923.372349-3-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201001091923.372349-1-ben.dooks@codethink.co.uk>
References: <20201001091923.372349-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Add code to parse the __attribute__((format)) used to indicate that
a variadic function takes a printf-style format string and where
those are. Save the data in ctype ready for checking when such an
function is encoutered.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
---
 parse.c  | 81 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 symbol.h | 10 +++++--
 2 files changed, 88 insertions(+), 3 deletions(-)

diff --git a/parse.c b/parse.c
index 31ecef0f..1b021b87 100644
--- a/parse.c
+++ b/parse.c
@@ -85,7 +85,7 @@ static attr_t
 	attribute_address_space, attribute_context,
 	attribute_designated_init,
 	attribute_transparent_union, ignore_attribute,
-	attribute_mode, attribute_force;
+	attribute_mode, attribute_force, attribute_format;
 
 typedef struct symbol *to_mode_t(struct symbol *);
 
@@ -120,6 +120,12 @@ static void asm_modifier(struct token *token, unsigned long *mods, unsigned long
 	*mods |= mod;
 }
 
+/* the types of formatting from __attribute__((format)) */
+enum {
+	FMT_PRINTF = 0,
+	FMT_SCANF,
+};
+
 static struct symbol_op typedef_op = {
 	.type = KW_MODIFIER,
 	.declarator = storage_specifier,
@@ -377,6 +383,10 @@ static struct symbol_op attr_force_op = {
 	.attribute = attribute_force,
 };
 
+static struct symbol_op attr_format_op = {
+	.attribute = attribute_format,
+};
+
 static struct symbol_op address_space_op = {
 	.attribute = attribute_address_space,
 };
@@ -436,6 +446,16 @@ static struct symbol_op mode_word_op = {
 	.to_mode = to_word_mode
 };
 
+static struct symbol_op attr_printf_op = {
+	.type	= KW_FORMAT,
+	.class	= FMT_PRINTF,
+};
+
+static struct symbol_op attr_scanf_op = {
+	.type	= KW_FORMAT,
+	.class	= FMT_SCANF,
+};
+
 /*
  * Define the keyword and their effects.
  * The entries in the 'typedef' and put in NS_TYPEDEF and
@@ -551,6 +571,9 @@ static struct init_keyword {
 	D("pure",		&attr_fun_op,		.mods = MOD_PURE),
 	A("const",		&attr_fun_op,		.mods = MOD_PURE),
 	D("gnu_inline",		&attr_fun_op,		.mods = MOD_GNU_INLINE),
+	D("format",		&attr_format_op),
+	D("printf",		&attr_printf_op),
+	D("scanf",		&attr_scanf_op),
 
 	/* Modes */
 	D("mode",		&mode_op),
@@ -1188,6 +1211,60 @@ static struct token *attribute_address_space(struct token *token, struct symbol
 	return token;
 }
 
+static int invalid_format_args(long long start, long long at)
+{
+	return start < 0 || at < 0 || start > USHRT_MAX || at > USHRT_MAX ||
+		(start == at && start > 0) ||
+		(start == 0 && at == 0);
+}
+
+static struct token *attribute_format(struct token *token, struct symbol *attr, struct decl_state *ctx)
+{
+	struct expression *args[3];
+	struct symbol *fmt_sym = NULL;
+
+	/* expecting format ( type, start, va_args at) */
+
+	token = expect(token, '(', "after format attribute");
+	if (token_type(token) == TOKEN_IDENT)
+		fmt_sym = lookup_keyword(token->ident, NS_KEYWORD);
+	if (fmt_sym)
+		if (!fmt_sym->op || fmt_sym->op->type != KW_FORMAT)
+			fmt_sym = NULL;
+
+	token = conditional_expression(token, &args[0]);
+	token = expect(token, ',', "format attribute type");
+	token = conditional_expression(token, &args[1]);
+	token = expect(token, ',', "format attribute type position");
+	token = conditional_expression(token, &args[2]);
+	token = expect(token, ')', "format attribute arg position");
+
+	if (!fmt_sym || !args[0] || !args[1] || !args[2]) {
+		warning(token->pos, "incorrect format attribute");
+	} else if (fmt_sym->op->class != FMT_PRINTF) {
+		/* skip anything that isn't printf for the moment */
+		warning(token->pos, "only printf format attribute supported");
+	} else {
+		long long start, at;
+
+		start = get_expression_value(args[2]);
+		at = get_expression_value(args[1]);
+
+		if (invalid_format_args(start, at)) {
+			warning(token->pos, "bad format positions");
+		} else if (start == 0) {
+			/* nothing to do here, is va_list function */
+		} else if (start < at) {
+			warning(token->pos, "format cannot be after va_args");
+		} else {
+			ctx->ctype.format.index = at;
+			ctx->ctype.format.first = start;
+		}
+	}
+
+	return token;
+}
+
 static struct symbol *to_QI_mode(struct symbol *ctype)
 {
 	if (ctype->ctype.base_type != &int_type)
@@ -2957,6 +3034,8 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
 
 		if (!(decl->ctype.modifiers & MOD_STATIC))
 			decl->ctype.modifiers |= MOD_EXTERN;
+
+		base_type->ctype.format = decl->ctype.format;
 	} else if (base_type == &void_ctype && !(decl->ctype.modifiers & MOD_EXTERN)) {
 		sparse_error(token->pos, "void declaration");
 	}
diff --git a/symbol.h b/symbol.h
index a3ed9567..e8ebbb71 100644
--- a/symbol.h
+++ b/symbol.h
@@ -82,8 +82,8 @@ enum keyword {
 	KW_ASM		= 1 << 5,
 	KW_MODE		= 1 << 6,
 	KW_STATIC	= 1 << 7,
-     // KW UNUSED	= 1 << 8,
-	KW_EXACT	= 1 << 9,
+	KW_EXACT	= 1 << 8,
+	KW_FORMAT	= 1 << 9,
 };
 
 struct context {
@@ -95,12 +95,18 @@ extern struct context *alloc_context(void);
 
 DECLARE_PTR_LIST(context_list, struct context);
 
+struct attr_format {
+	unsigned short index;	/* index in argument list for format string */
+	unsigned short first;	/* where first variadic argument is */
+};
+
 struct ctype {
 	struct symbol *base_type;
 	unsigned long modifiers;
 	unsigned long alignment;
 	struct context_list *contexts;
 	struct ident *as;
+	struct attr_format format;
 };
 
 struct decl_state {
-- 
2.28.0

