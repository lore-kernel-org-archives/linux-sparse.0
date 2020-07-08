Return-Path: <SRS0=1LG9=AT=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE550C433E0
	for <linux-sparse@archiver.kernel.org>; Wed,  8 Jul 2020 19:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D288E2065D
	for <linux-sparse@archiver.kernel.org>; Wed,  8 Jul 2020 19:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4k/Ax5h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbgGHT1D (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 8 Jul 2020 15:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbgGHT1D (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 8 Jul 2020 15:27:03 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088DFC061A0B
        for <linux-sparse@vger.kernel.org>; Wed,  8 Jul 2020 12:27:03 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id p20so51665581ejd.13
        for <linux-sparse@vger.kernel.org>; Wed, 08 Jul 2020 12:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eeiO1F8qEsdRRG5FzT+6yY5fGx/l21cg8XRqGYiUY/4=;
        b=b4k/Ax5hhzT88yZumOnROWZT/a0krB8VvLtQX65NVSJM605JRlde92Aab40/1b9ILy
         SA6/AIY0TX938IzA+n5G9q/E7e2y5EFSjLOX1xQs0H72xzTjTeBzEPCoPWhHT+M2FeT7
         qHXZMMA6rDhoL3cwNtrufXklc1Acn8NNBXqiv/jKLXh+HTndwioWpjGBMi/aGjZzvzUV
         L7N/9X2+j28Xhorc5HUk6yjeAL55jx2m6qavsXm10/ecXR1K8YzaHKzseMOrbslYOuvj
         ctPD3kONSMPGntAmd1JEUOhrKu4QgaaX70ZZkXdW60RZeFSeDe1DfNWv1y6mE3Nq46se
         Xnbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eeiO1F8qEsdRRG5FzT+6yY5fGx/l21cg8XRqGYiUY/4=;
        b=JwVvrIJlw+MDfxngMAydP/cR6znTmd5rQWuhinn66CFrI8SRk1K39AHOkdTsUMzrsX
         kTxJvOX/Zw6myCcmdDGoZwJK6+lH+ccEktZdI8MuSZhs9LmOtLtD949Qo5Bm9DL168aM
         iEGlrli27hg6I6o5UnOxOI6UnHEjxOBB0XwYLIDajPzAg/XKUjNrceuIoqxywMKCfRXQ
         ahcm7gq73OAd+Ir1+dp8+z0rEmzwgkCKFQKILJ/JsQ5kDf61oPtlfnmONg/uMBCM6f0Q
         foLGWuIptSCEgmTBVwFgY99tk5gEhKvigasz19AL92wUR7tJhm2RgkNY7cqWtvNvUKdM
         nLaw==
X-Gm-Message-State: AOAM532Z55ozjoeXQUOOW0JiutVByudUBWZWe1fVOVBljfox2MXx7sL0
        /UPWsCiYs+NUYgx1BUBJz04Bwq1i
X-Google-Smtp-Source: ABdhPJwRLXu770a5E9xP02Q6P9g7549KMYXo5xgCDnu7K3A382nm2Q0o0NKkrsO4ECySdyu5JNEQJA==
X-Received: by 2002:a17:906:dbed:: with SMTP id yd13mr51933818ejb.419.1594236421330;
        Wed, 08 Jul 2020 12:27:01 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:b1eb:f280:ff97:eab2])
        by smtp.gmail.com with ESMTPSA id cc9sm372970edb.14.2020.07.08.12.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 12:27:00 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/3] keyword: use some macros to avoid duplication
Date:   Wed,  8 Jul 2020 21:26:54 +0200
Message-Id: <20200708192654.28097-4-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200708192654.28097-1-luc.vanoostenryck@gmail.com>
References: <20200708192654.28097-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Most keywords have a variant with the leading nd trailing
double-underscore. Some have also a variant with only the
leading underscores. But only the identifier change, the
remaining of the information is duplicated for them.

So, use some macros to define the corresponding entries
without duplication.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 parse.c | 223 +++++++++++++++++++++++++-------------------------------
 1 file changed, 98 insertions(+), 125 deletions(-)

diff --git a/parse.c b/parse.c
index c18a9e66e0a8..188b7485c61b 100644
--- a/parse.c
+++ b/parse.c
@@ -460,6 +460,12 @@ static struct symbol_op mode_word_op = {
  * The entries in the 'typedef' and put in NS_TYPEDEF and
  * are automatically set as reserved keyword while the ones
  * in the 'keyword' table are just put in NS_KEYWORD.
+ *
+ * The entries are added via the 3 macros:
+ *   N() for entries with "name" only,
+ *   D() for entries with "name" & "__name__",
+ *   A() for entries with "name", "__name" & "__name__",
+ *   U() for entries with "__name" & "__name__".
  */
 static struct init_keyword {
 	const char *name;
@@ -467,147 +473,114 @@ static struct init_keyword {
 	struct symbol *type;
 	unsigned long mods;
 } typedefs[] = {
+#define N(I, O,...)	{ I, O,##__VA_ARGS__ }
+#define D(I, O,...)	N(I,O,##__VA_ARGS__ ),		\
+			N("__" I "__",O,##__VA_ARGS__)
+#define A(I, O,...)	N(I,O,##__VA_ARGS__ ),		\
+			N("__" I,O,##__VA_ARGS__),	\
+			N("__" I "__",O,##__VA_ARGS__)
+#define U(I, O,...)	N("__" I,O,##__VA_ARGS__),	\
+			N("__" I "__",O,##__VA_ARGS__)
 	/* Storage classes */
-	{ "auto",		&auto_op },
-	{ "register",		&register_op },
-	{ "static",		&static_op },
-	{ "extern",		&extern_op },
-	{ "__thread",		&thread_op },
-	{ "_Thread_local",	&thread_op },
+	N("auto",		&auto_op),
+	N("register",		&register_op),
+	N("static",		&static_op),
+	N("extern",		&extern_op),
+	N("__thread",		&thread_op),
+	N("_Thread_local",	&thread_op),
 
-	{ "inline",		&inline_op },
-	{ "__inline__",		&inline_op },
-	{ "__inline",		&inline_op },
+	A("inline",		&inline_op),
 
 	/* Typedef ... */
-	{ "typedef",		&typedef_op },
-	{ "typeof",		&typeof_op },
-	{ "__typeof__",		&typeof_op },
-	{ "__typeof",		&typeof_op },
-	{ "__auto_type",	&autotype_op },
+	N("typedef",		&typedef_op),
+	A("typeof",		&typeof_op),
+	N("__auto_type",	&autotype_op),
 
 	/* Type qualifiers */
-	{ "const",		&const_op },
-	{ "__const__",		&const_op },
-	{ "__const",		&const_op },
-	{ "volatile",		&volatile_op },
-	{ "__volatile__",	&volatile_op },
-	{ "__volatile",		&volatile_op },
-	{ "restrict",		&restrict_op },
-	{ "__restrict__",	&restrict_op },
-	{ "__restrict",		&restrict_op },
-
-	{ "_Atomic",		&atomic_op },
-	{ "_Noreturn",		&noreturn_op },
-	{ "_Alignas",		&alignas_op },
-
-	{ "__attribute__",	&attribute_op },
-	{ "__attribute",	&attribute_op },
+	A("const",		&const_op),
+	A("volatile",		&volatile_op),
+	A("restrict",		&restrict_op),
+
+	N("_Atomic",		&atomic_op),
+	N("_Noreturn",		&noreturn_op),
+	N("_Alignas",		&alignas_op),
+
+	U("attribute",		&attribute_op),
 
 	/* Type specifiers */
-	{ "struct",		&struct_op },
-	{ "union",		&union_op },
-	{ "enum",		&enum_op },
-
-	{ "void",		&spec_op,	.type = &void_ctype },
-	{ "char",		&char_op },
-	{ "short",		&short_op },
-	{ "int",		&int_op },
-	{ "long",		&long_op },
-	{ "float",		&float_op },
-	{ "double",		&double_op },
-	{ "signed",		&signed_op },
-	{ "__signed__",		&signed_op },
-	{ "__signed",		&signed_op },
-	{ "unsigned",		&unsigned_op },
-	{ "__int128",		&int128_op },
-	{ "_Bool",		&spec_op,	.type = &bool_ctype },
+	N("struct",		&struct_op),
+	N("union",		&union_op),
+	N("enum",		&enum_op),
+
+	N("void",		&spec_op,	.type = &void_ctype),
+	N("char",		&char_op),
+	N("short",		&short_op),
+	N("int",		&int_op),
+	N("long",		&long_op),
+	N("float",		&float_op),
+	N("double",		&double_op),
+	A("signed",		&signed_op),
+	N("unsigned",		&unsigned_op),
+	N("__int128",		&int128_op),
+	N("_Bool",		&spec_op,	.type = &bool_ctype),
 
 	/* Predeclared types */
-	{ "__builtin_va_list",	&spec_op,	.type = &ptr_ctype },
-	{ "__builtin_ms_va_list",&spec_op,	.type = &ptr_ctype },
-	{ "__int128_t",		&spec_op,	.type = &sint128_ctype },
-	{ "__uint128_t",	&spec_op,	.type = &uint128_ctype },
-	{ "_Float32",		&spec_op,	.type = &float32_ctype },
-	{ "_Float32x",		&spec_op,	.type = &float32x_ctype },
-	{ "_Float64",		&spec_op,	.type = &float64_ctype },
-	{ "_Float64x",		&spec_op,	.type = &float64x_ctype },
-	{ "_Float128",		&spec_op,	.type = &float128_ctype },
+	N("__builtin_va_list",	&spec_op,	.type = &ptr_ctype),
+	N("__builtin_ms_va_list",&spec_op,	.type = &ptr_ctype),
+	N("__int128_t",		&spec_op,	.type = &sint128_ctype),
+	N("__uint128_t",	&spec_op,	.type = &uint128_ctype),
+	N("_Float32",		&spec_op,	.type = &float32_ctype),
+	N("_Float32x",		&spec_op,	.type = &float32x_ctype),
+	N("_Float64",		&spec_op,	.type = &float64_ctype),
+	N("_Float64x",		&spec_op,	.type = &float64x_ctype),
+	N("_Float128",		&spec_op,	.type = &float128_ctype),
 }, keywords[] = {
 	/* Statements */
-	{ "if",			&if_op },
-	{ "return",		&return_op },
-	{ "break",		&loop_iter_op },
-	{ "continue",		&loop_iter_op },
-	{ "default",		&default_op },
-	{ "case",		&case_op },
-	{ "switch",		&switch_op },
-	{ "for",		&for_op },
-	{ "while",		&while_op },
-	{ "do",			&do_op },
-	{ "goto",		&goto_op },
-	{ "asm",		&asm_op },
-	{ "__asm__",		&asm_op },
-	{ "__asm",		&asm_op },
-	{ "context",		&context_op },
-	{ "__context__",	&__context___op },
-	{ "__range__",		&range_op },
-	{ "_Static_assert",	&static_assert_op },
+	N("if",			&if_op),
+	N("return",		&return_op),
+	N("break",		&loop_iter_op),
+	N("continue",		&loop_iter_op),
+	N("default",		&default_op),
+	N("case",		&case_op),
+	N("switch",		&switch_op),
+	N("for",		&for_op),
+	N("while",		&while_op),
+	N("do",			&do_op),
+	N("goto",		&goto_op),
+	A("asm",		&asm_op),
+	N("context",		&context_op),
+	N("__context__",	&__context___op),
+	N("__range__",		&range_op),
+	N("_Static_assert",	&static_assert_op),
 
 	/* Attributes */
-	{ "packed",		&packed_op },
-	{ "__packed__",		&packed_op },
-	{ "aligned",		&aligned_op },
-	{ "__aligned__",	&aligned_op },
-	{ "nocast",		&attr_mod_op,		.mods = MOD_NOCAST },
-	{ "__nocast__",		&attr_mod_op,		.mods = MOD_NOCAST },
-	{ "noderef",		&attr_mod_op,		.mods = MOD_NODEREF },
-	{ "__noderef__",	&attr_mod_op,		.mods = MOD_NODEREF },
-	{ "safe",		&attr_mod_op,		.mods = MOD_SAFE },
-	{ "__safe__",		&attr_mod_op,		.mods = MOD_SAFE },
-	{ "unused",		&attr_mod_op,		.mods = MOD_UNUSED },
-	{ "__unused__",		&attr_mod_op,		.mods = MOD_UNUSED },
-	{ "externally_visible",&attr_mod_op,		.mods = MOD_EXT_VISIBLE },
-	{ "__externally_visible__",&attr_mod_op,	.mods = MOD_EXT_VISIBLE },
-	{ "force",		&attr_force_op },
-	{ "__force__",		&attr_force_op },
-	{ "bitwise",		&attr_bitwise_op,	.mods = MOD_BITWISE },
-	{ "__bitwise__",	&attr_bitwise_op,	.mods = MOD_BITWISE },
-	{ "address_space",	&address_space_op },
-	{ "__address_space__",	&address_space_op },
-	{ "designated_init",	&designated_init_op },
-	{ "__designated_init__",&designated_init_op },
-	{ "transparent_union",	&transparent_union_op },
-	{ "__transparent_union__",&transparent_union_op },
-	{ "noreturn",		&attr_fun_op,		.mods = MOD_NORETURN },
-	{ "__noreturn__",	&attr_fun_op,		.mods = MOD_NORETURN },
-	{ "pure",		&attr_fun_op,		.mods = MOD_PURE },
-	{ "__pure__",		&attr_fun_op,		.mods = MOD_PURE },
-	{ "const",		&attr_fun_op,		.mods = MOD_PURE },
-	{ "__const__",		&attr_fun_op,		.mods = MOD_PURE },
-	{ "__const",		&attr_fun_op,		.mods = MOD_PURE },
-	{ "gnu_inline",		&attr_fun_op,		.mods = MOD_GNU_INLINE },
-	{ "__gnu_inline__",	&attr_fun_op,		.mods = MOD_GNU_INLINE },
+	D("packed",		&packed_op),
+	D("aligned",		&aligned_op),
+	D("nocast",		&attr_mod_op,		.mods = MOD_NOCAST),
+	D("noderef",		&attr_mod_op,		.mods = MOD_NODEREF),
+	D("safe",		&attr_mod_op,		.mods = MOD_SAFE),
+	D("unused",		&attr_mod_op,		.mods = MOD_UNUSED),
+	D("externally_visible",	&attr_mod_op,		.mods = MOD_EXT_VISIBLE),
+	D("force",		&attr_force_op),
+	D("bitwise",		&attr_bitwise_op,	.mods = MOD_BITWISE),
+	D("address_space",	&address_space_op),
+	D("designated_init",	&designated_init_op),
+	D("transparent_union",	&transparent_union_op),
+	D("noreturn",		&attr_fun_op,		.mods = MOD_NORETURN),
+	D("pure",		&attr_fun_op,		.mods = MOD_PURE),
+	A("const",		&attr_fun_op,		.mods = MOD_PURE),
+	D("gnu_inline",		&attr_fun_op,		.mods = MOD_GNU_INLINE),
 
 	/* Modes */
-	{ "mode",		&mode_op },
-	{ "__mode__",		&mode_op },
-	{ "QI",			&mode_QI_op },
-	{ "__QI__",		&mode_QI_op },
-	{ "HI",			&mode_HI_op },
-	{ "__HI__",		&mode_HI_op },
-	{ "SI",			&mode_SI_op },
-	{ "__SI__",		&mode_SI_op },
-	{ "DI",			&mode_DI_op },
-	{ "__DI__",		&mode_DI_op },
-	{ "TI",			&mode_TI_op },
-	{ "__TI__",		&mode_TI_op },
-	{ "byte",		&mode_QI_op },
-	{ "__byte__",		&mode_QI_op },
-	{ "pointer",		&mode_pointer_op },
-	{ "__pointer__",	&mode_pointer_op },
-	{ "word",		&mode_word_op },
-	{ "__word__",		&mode_word_op },
+	D("mode",		&mode_op),
+	D("QI",			&mode_QI_op),
+	D("HI",			&mode_HI_op),
+	D("SI",			&mode_SI_op),
+	D("DI",			&mode_DI_op),
+	D("TI",			&mode_TI_op),
+	D("byte",		&mode_QI_op),
+	D("pointer",		&mode_pointer_op),
+	D("word",		&mode_word_op),
 };
 
 
-- 
2.27.0

