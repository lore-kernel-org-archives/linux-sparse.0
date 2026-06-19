Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FDD30BF66
	for <linux-sparse@vger.kernel.org>; Fri, 19 Jun 2026 07:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.40.148.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781852744; cv=none; b=aOfTpl6twGmx9xqddjupN2KVFGLlHlZSRactF9DSzQ+kOaO26BuThrXM7vfNuCg4pPKfN3CWpNnm/CqUT0tO8yU4Ei3q8XEeajBS0OrTsxxAe7mmOv2eiqBnFv4mULghhX5eya9GG3FO65ia6efHMUUFpRKd19Za1XY6wYnldN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781852744; c=relaxed/simple;
	bh=y2hH2RRcntSWp4QkvTsdbJKpqK1eY91EfPFQ47Z5OA0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j1VQR57M3YYja8aO6z/1NzOX+uzpYUBZCv1EUB47QB/gAhZhWi9pkmVHDi3hkv2uN8PX9SOcVnWl8dHGmSizI4fOT9uf+wmKvUbaac5wuydlCpWMTqSISDLjMQAZtUnnfIwmgBBXIxA0aGtM50YbX+kVUBvnU/G3ajtf6Ji8SNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.com; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=xuItCAvH; arc=none smtp.client-ip=78.40.148.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="xuItCAvH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To; bh=OZs+q0qnX87T76+zjw7RTEKOgnQM194h7/HxLLRuJrY=; b=xuItCAvHFV9Sl00x
	HR0WsiHbCxU87N7T2Csv77jqltjIIpN3lH7OmIlhfbkYyk8DHruO8S7Jmh/wUlJWBU3m05no6/Z9D
	CZWNdTollQgdaWzuzvKgiZ5RtcwDFyRVcQvAwSPfHf9MC5nBM852u2Lynu0EHaMMKQQGTrEvqgzfZ
	sywXQPS+Knkrkl1xBHAx+Tog2wUiZuH1FiwqPEF++FbHt/2XCSqYKi24MpOqMZELVy9Nqm0cw5qjr
	nvm7MalfdEf6tk26bD1FA9x2efRYS6H3SW/OoZ1S1j+dazAMFYkowH7lL3Kkdq+Pql7OL1TNr/+6c
	STSim/h/3rPjixRT0A==;
Received: from [63.135.74.212] (helo=rainbowdash)
	by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1waTID-00HCaJ-VO; Fri, 19 Jun 2026 08:05:33 +0100
Received: from ben by rainbowdash with local (Exim 4.99.4)
	(envelope-from <ben@rainbowdash>)
	id 1waTID-0000000033h-2J0y;
	Fri, 19 Jun 2026 08:05:33 +0100
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: linux-sparse@vger.kernel.org
Cc: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [RFC v4 1/4] parse: initial parsing of __attribute__((format))
Date: Fri, 19 Jun 2026 08:05:29 +0100
Message-Id: <20260619070532.11664-2-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
In-Reply-To: <20260619070532.11664-1-ben.dooks@codethink.co.uk>
References: <20260619070532.11664-1-ben.dooks@codethink.co.uk>
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
v3:
  - merged the scanf bits back in here as scanf is now inclided
---
 parse.c  | 72 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 symbol.h | 17 +++++++++++--
 2 files changed, 86 insertions(+), 3 deletions(-)

diff --git a/parse.c b/parse.c
index 9389079e..06818bd1 100644
--- a/parse.c
+++ b/parse.c
@@ -86,7 +86,7 @@ static attr_t
 	attribute_cleanup,
 	attribute_designated_init,
 	attribute_transparent_union, ignore_attribute,
-	attribute_mode, attribute_force;
+	attribute_mode, attribute_force, attribute_format;
 
 typedef struct symbol *to_mode_t(struct symbol *);
 
@@ -389,6 +389,10 @@ static struct symbol_op attr_force_op = {
 	.attribute = attribute_force,
 };
 
+static struct symbol_op attr_format_op = {
+	.attribute = attribute_format,
+};
+
 static struct symbol_op address_space_op = {
 	.attribute = attribute_address_space,
 };
@@ -448,6 +452,16 @@ static struct symbol_op mode_word_op = {
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
@@ -565,6 +579,9 @@ static struct init_keyword {
 	D("pure",		&attr_fun_op,		.mods = MOD_PURE),
 	A("const",		&attr_fun_op,		.mods = MOD_PURE),
 	D("gnu_inline",		&attr_fun_op,		.mods = MOD_GNU_INLINE),
+	D("format",		&attr_format_op),
+	D("printf",		&attr_printf_op),
+	D("scanf",		&attr_scanf_op),
 
 	/* Modes */
 	D("mode",		&mode_op),
@@ -1235,6 +1252,57 @@ static struct token *attribute_address_space(struct token *token, struct symbol
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
+		ctx->ctype.format.type = fmt_sym->op->class;
+	}
+
+	return token;
+}
+
 static struct symbol *to_QI_mode(struct symbol *ctype)
 {
 	if (ctype->ctype.base_type != &int_type)
@@ -3025,6 +3093,8 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
 
 		if (!(decl->ctype.modifiers & MOD_STATIC))
 			decl->ctype.modifiers |= MOD_EXTERN;
+
+		base_type->ctype.format = decl->ctype.format;
 	} else if (base_type == &void_ctype && !(decl->ctype.modifiers & MOD_EXTERN)) {
 		sparse_error(token->pos, "void declaration");
 	}
diff --git a/symbol.h b/symbol.h
index 3552d439..296861b4 100644
--- a/symbol.h
+++ b/symbol.h
@@ -83,8 +83,8 @@ enum keyword {
 	KW_ASM		= 1 << 5,
 	KW_MODE		= 1 << 6,
 	KW_STATIC	= 1 << 7,
-     // KW UNUSED	= 1 << 8,
-	KW_EXACT	= 1 << 9,
+	KW_EXACT	= 1 << 8,
+	KW_FORMAT	= 1 << 9,
 };
 
 struct context {
@@ -96,12 +96,25 @@ extern struct context *alloc_context(void);
 
 DECLARE_PTR_LIST(context_list, struct context);
 
+/* the types of formatting from __attribute__((format)) */
+enum {
+	FMT_PRINTF	= 1,
+	FMT_SCANF	= 2,
+};
+
+struct attr_format {
+	unsigned short type;
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

