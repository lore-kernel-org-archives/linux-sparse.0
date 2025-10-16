Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C8725B1DA
	for <linux-sparse@vger.kernel.org>; Thu, 16 Oct 2025 11:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.40.148.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760612666; cv=none; b=LgC/WpRkPPgKX7AVurDhCeGrL9tkygYZJjz+f4hkbOjlIYoAlCs+retQdDqN2KOcEDZu/QYBGYmTyxJ85BCCsC/HlsFsREUWZR7r14lFi+laYKssrsxhpo7jdqBdv9rJx+Z6ZyyQu64yJtKpFzLpp9dMNlheMWJA8LywHLhfbmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760612666; c=relaxed/simple;
	bh=XKJ9vEZ2nnlRtzKNvAAQxDHjCyhfVB9FIPzddEGjDvw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PKSb+JS2HkBY3dWyIS1Jev99myerMIsYG9eZh0redZEwiEmotK+fmTpC+O3478MYph4MRgcjv+uVteWwyCLrxB4GcT9qAKZq9slmOrYqH2NBHE+saSM4tHs845sGknnGwuVc7U6P3LP2sQN0f6qpMyeX2e+i8TRS49WdvBhdHVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.com; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=ldHu6Yy7; arc=none smtp.client-ip=78.40.148.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="ldHu6Yy7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=LrCSIF8gvQlTGLf2AH0s2aiiOHigSC3rQCGLAOzjZ/s=; b=ldHu6Yy7pIkFzlOaCL+patp4qm
	o6HztwS8WoSCghg7R8NXHZFCowpVcBjH2FhKC1ayKVQBUlxARavvYo3XQWykhdcCBuaYLBgMv5i6d
	e/B5LkCSqrT1Oth5o+Ii8AnsjAD8h5AjbZdpcE2r1tm6ZHfIexuetqAcvK498vjRe52V1hmlKJX5M
	1tirYtIQ1/nbB0/lCmY5LxGB4In+PO+M6VtnDoMDh0tCWH3MRyHpE5rJgG9MJkPuP72+4MzLJzYHP
	8nRzJI7rf90nABm79rcmD3JI3wDSV7DU9Os51GaVSwex0dVfaKmGeL0tLtZlssJ2kwTcAM9WpAh7i
	LvmrNIWw==;
Received: from [167.98.27.226] (helo=rainbowdash)
	by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1v9LmK-004bE4-RB; Thu, 16 Oct 2025 12:04:16 +0100
Received: from ben by rainbowdash with local (Exim 4.98.2)
	(envelope-from <ben@rainbowdash>)
	id 1v9LmK-00000002e2Z-2HnJ;
	Thu, 16 Oct 2025 12:04:16 +0100
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: linux-sparse@vger.kernel.org,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	Chris Li <sparse@chrisli.org>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH RESEND 1/4] parse: initial parsing of __attribute__((format))
Date: Thu, 16 Oct 2025 12:04:12 +0100
Message-Id: <20251016110415.630506-2-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
In-Reply-To: <20251016110415.630506-1-ben.dooks@codethink.co.uk>
References: <20251016110415.630506-1-ben.dooks@codethink.co.uk>
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
---
 parse.c  | 81 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 symbol.h |  9 ++++++-
 2 files changed, 88 insertions(+), 2 deletions(-)

diff --git a/parse.c b/parse.c
index 3f67451e..af4e5b50 100644
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
@@ -1217,6 +1240,60 @@ static struct token *attribute_address_space(struct token *token, struct symbol
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
@@ -3007,6 +3084,8 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
 
 		if (!(decl->ctype.modifiers & MOD_STATIC))
 			decl->ctype.modifiers |= MOD_EXTERN;
+
+		base_type->ctype.format = decl->ctype.format;
 	} else if (base_type == &void_ctype && !(decl->ctype.modifiers & MOD_EXTERN)) {
 		sparse_error(token->pos, "void declaration");
 	}
diff --git a/symbol.h b/symbol.h
index 88130c15..0ea46da8 100644
--- a/symbol.h
+++ b/symbol.h
@@ -82,8 +82,9 @@ enum keyword {
 	KW_ASM		= 1 << 5,
 	KW_MODE		= 1 << 6,
 	KW_STATIC	= 1 << 7,
-     // KW UNUSED	= 1 << 8,
+	// KW_UNUSED	= 1 << 8.
 	KW_EXACT	= 1 << 9,
+	KW_FORMAT	= 1 << 10,
 };
 
 struct context {
@@ -95,12 +96,18 @@ extern struct context *alloc_context(void);
 
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

