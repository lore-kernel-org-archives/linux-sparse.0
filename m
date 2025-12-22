Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6B510E3
	for <linux-sparse@vger.kernel.org>; Mon, 22 Dec 2025 16:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.40.148.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766421582; cv=none; b=mjJdyH7zyOzvbohicjB96sykQTXtMTGqXUHCVteq4Kpo9hwAIOzoKYFSdfQ6IbhRx2pHDXTLFFPfWeMxiyfYaFdcb+IwsajBjgwPHE/JXTE5CQ2ogoiRynAAvwGnbGPDpRpauQfkc+NhRMGQnJhSOtRZQIWVG4pB41LfNGiY+wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766421582; c=relaxed/simple;
	bh=X80RebAIrDzbNlF/MduhF715h+CTWC9Z7ZHie2FlZN0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TQCkKU6lMy94+gJ5oVon5X+EX+GoBufBoVl+ZzsKkvVnl18ZS7qInGCPXGm/fUFWnz0JhQG/ALwKzXyiSwKbvtd6YvF1zLUhDBNGibHPMlh2KLE6zfju24qi96xF/i7X7AWFzb7ZVw5D3NWRAo75mi07211XUO4WnEVvqx/lqJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.com; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=NyUWMu+V; arc=none smtp.client-ip=78.40.148.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="NyUWMu+V"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To; bh=+Z4T9hFzpw2vew5F5Y5XHcgo27J+dWTLyeKYu7E4FZk=; b=NyUWMu+VZ8LfHYQ+
	W8tStM6zajBgPsixvmk20tY8aTcWtAxw4+VYzdWaLdQfKzXBWCDlvtUKtc5QSi4/12xEbMDip3V+D
	8j4bgabGZko6zUfyNk9KXkC5cCABgWecxs2alRCaAj1QQOX+Eum9RmXHuz698SV5Ez7UBup7h56y6
	LxOEgNGrAncmJ1jUXY4Ks3PHg8IAnFi6svmC6ilmpiNhDG8uUHYHp13WixN1BIikGvr/zU0l7LWYh
	FuIr3koMXCqbKvXJGDF796tJ3lyvJ2M52ePw/JXAHWC5jOQUMnXajyL524POvNuOlM6hqCyTiVfrk
	5fWfeoBcSVWze0PM5g==;
Received: from [167.98.27.226] (helo=rainbowdash)
	by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1vXiKp-004DSp-Hr; Mon, 22 Dec 2025 16:00:35 +0000
Received: from ben by rainbowdash with local (Exim 4.99)
	(envelope-from <ben@rainbowdash>)
	id 1vXiKp-00000000P2X-0okv;
	Mon, 22 Dec 2025 16:00:35 +0000
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: linux-sparse@vger.kernel.org,
	sparse@chrisli.org
Cc: luc.vanoostenryck@gmail.com,
	Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH v2 1/4] parse: initial parsing of __attribute__((format))
Date: Mon, 22 Dec 2025 16:00:31 +0000
Message-Id: <20251222160034.96188-2-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
In-Reply-To: <20251222160034.96188-1-ben.dooks@codethink.co.uk>
References: <20251222160034.96188-1-ben.dooks@codethink.co.uk>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: srv_ts003@codethink.com

Add code to parse the __attribute__((format)) used to indicate that
a variadic function takes a printf-style format string and where
those are. Save the data in ctype ready for checking when such an
function is encoutered.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
--
v2:
  - apply comments about arg names and early-exit from function
  - remove the KW_UNUSED
---
 parse.c  | 83 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 symbol.h | 10 +++++--
 2 files changed, 90 insertions(+), 3 deletions(-)

diff --git a/parse.c b/parse.c
index 3f67451e..8d587c07 100644
--- a/parse.c
+++ b/parse.c
@@ -86,7 +86,7 @@ static attr_t
 	attribute_cleanup,
 	attribute_designated_init,
 	attribute_transparent_union, ignore_attribute,
-	attribute_mode, attribute_force;
+	attribute_mode, attribute_force, attribute_format;
 
 typedef struct symbol *to_mode_t(struct symbol *);
 
@@ -121,6 +121,12 @@ static void asm_modifier(struct token *token, unsigned long *mods, unsigned long
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
@@ -382,6 +388,10 @@ static struct symbol_op attr_force_op = {
 	.attribute = attribute_force,
 };
 
+static struct symbol_op attr_format_op = {
+	.attribute = attribute_format,
+};
+
 static struct symbol_op address_space_op = {
 	.attribute = attribute_address_space,
 };
@@ -441,6 +451,16 @@ static struct symbol_op mode_word_op = {
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
@@ -557,6 +577,9 @@ static struct init_keyword {
 	D("pure",		&attr_fun_op,		.mods = MOD_PURE),
 	A("const",		&attr_fun_op,		.mods = MOD_PURE),
 	D("gnu_inline",		&attr_fun_op,		.mods = MOD_GNU_INLINE),
+	D("format",		&attr_format_op),
+	D("printf",		&attr_printf_op),
+	D("scanf",		&attr_scanf_op),
 
 	/* Modes */
 	D("mode",		&mode_op),
@@ -1217,6 +1240,62 @@ static struct token *attribute_address_space(struct token *token, struct symbol
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
+	struct expression *arg_type, *arg_fmt, *arg_argpos;
+	struct symbol *fmt_sym = NULL;
+	long long start, at;
+
+	/* expecting format ( type, fmt, va_args at) */
+
+	token = expect(token, '(', "after format attribute");
+	if (token_type(token) == TOKEN_IDENT)
+		fmt_sym = lookup_keyword(token->ident, NS_KEYWORD);
+	if (fmt_sym && (!fmt_sym->op || fmt_sym->op->type != KW_FORMAT))
+		fmt_sym = NULL;
+
+	token = conditional_expression(token, &arg_type);
+	token = expect(token, ',', "format attribute type");
+	token = conditional_expression(token, &arg_fmt);
+	token = expect(token, ',', "format attribute type position");
+	token = conditional_expression(token, &arg_argpos);
+	token = expect(token, ')', "format attribute arg position");
+
+	if (!fmt_sym || !arg_type || !arg_fmt || !arg_argpos) {
+		warning(token->pos, "missing format attribute argument(s)");
+		return token;
+	}
+
+	if (fmt_sym->op->class != FMT_PRINTF) {
+		/* skip anything that isn't printf for the moment */
+		warning(token->pos, "only printf format attribute supported");
+		return token;
+	}
+
+	start = get_expression_value(arg_argpos);
+	at = get_expression_value(arg_fmt);
+
+	if (invalid_format_args(start, at)) {
+		warning(token->pos, "bad format positions");
+	} else if (start == 0) {
+		/* nothing to do here, is va_list function */
+	} else if (start < at) {
+		warning(token->pos, "format cannot be after va_args");
+	} else {
+		ctx->ctype.format.index = at;
+		ctx->ctype.format.first = start;
+	}
+
+	return token;
+}
+
 static struct symbol *to_QI_mode(struct symbol *ctype)
 {
 	if (ctype->ctype.base_type != &int_type)
@@ -3007,6 +3086,8 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
 
 		if (!(decl->ctype.modifiers & MOD_STATIC))
 			decl->ctype.modifiers |= MOD_EXTERN;
+
+		base_type->ctype.format = decl->ctype.format;
 	} else if (base_type == &void_ctype && !(decl->ctype.modifiers & MOD_EXTERN)) {
 		sparse_error(token->pos, "void declaration");
 	}
diff --git a/symbol.h b/symbol.h
index 88130c15..8cc61cdb 100644
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
2.37.2.352.g3c44437643

