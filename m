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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA1AC433DF
	for <linux-sparse@archiver.kernel.org>; Wed,  8 Jul 2020 19:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C06820720
	for <linux-sparse@archiver.kernel.org>; Wed,  8 Jul 2020 19:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EOHKw1ib"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbgGHT1B (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 8 Jul 2020 15:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbgGHT1B (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 8 Jul 2020 15:27:01 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08ABC061A0B
        for <linux-sparse@vger.kernel.org>; Wed,  8 Jul 2020 12:27:00 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id h28so42796026edz.0
        for <linux-sparse@vger.kernel.org>; Wed, 08 Jul 2020 12:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BQCM45N8UL/zaDFFFkblI95tDvbRsuOSTDCv2MYA4e8=;
        b=EOHKw1ibGUPYfZ1JRAl7nQjhNBh/IMq6o0fEmbKIJ+pMXzdf8m2cNaXYqFdoaZZX6E
         krqDF7ukNU4yr21u7pMaE5f7H8o2pSmDfSCU1z265dwL019aCKGd9LsFz6yYjy9sjqQM
         A+mQnOMYKfOtXYTPE91xfFTRrDi+y6XL3d18V/9DkkBYbK/OOCMO/hfWPkcwXUXQDC0u
         UgRMu0DaYoWDQ+O6QZrQPUr1++sKqVf3WkkaZ1IIFz4lVqy7XwVnRWakwJay9pAaove8
         3ZqTNWOM1TOMHuaMy15rCEh3P/wPYTZNM0TqAJMQGcShqCIvXLDeuEMcZrcISCCpw2iY
         tM7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BQCM45N8UL/zaDFFFkblI95tDvbRsuOSTDCv2MYA4e8=;
        b=UohIAP2ZbhtJ4C7JI4umWHv0a8TKj0XOV9+I2bGZBgbiriygN/STTe4jx8t1OVIg91
         Yy/9a+/2lZuAvzxUYpdnu4yt7rFHGkJV7fOSItYwwMSA53uL/kqaVfhn89r3A/uYyiWA
         Dk7VDn8NBj21VIYoHEFP6lf9DRfAk9lZ1RT9sDD4wAJGNNhFdiOB96WsbdQIy+ar8Nma
         S/LNgbk9mZNKcsT8UA5QCBFTlDETt8VzTTHPmIC69IF/3P28sC9OaqCcrigNvEGeSyHx
         gObfRyes1UvKVLyVNtvwbCd/BrTYl9/dHIPrukIU/4HrgWtYeEOY3P0y07WquyI3Ew3c
         F6lQ==
X-Gm-Message-State: AOAM532CroxstWxYrWQA2yq+ghsDj1M7pgITioEPnEfud6hBLzWQVSsU
        qcFwDivApD0sO3yZOUF643FSkjMt
X-Google-Smtp-Source: ABdhPJyyfj1xXSvSb/TecKSBp5yTHlXjL5ToNuW+vcDWZ2vfUZNcUw4MPr0fMK/d8gJp1JWvUsDp2g==
X-Received: by 2002:a50:f9c9:: with SMTP id a9mr71658554edq.89.1594236419203;
        Wed, 08 Jul 2020 12:26:59 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:b1eb:f280:ff97:eab2])
        by smtp.gmail.com with ESMTPSA id cc9sm372970edb.14.2020.07.08.12.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 12:26:58 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/3] keyword: reorganize the keyword table
Date:   Wed,  8 Jul 2020 21:26:52 +0200
Message-Id: <20200708192654.28097-2-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200708192654.28097-1-luc.vanoostenryck@gmail.com>
References: <20200708192654.28097-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

With time, the keyword table has become quite hard to read.

So, split the table in 2: one for NS_TYPEDEF and one for NS_KEYWORD.
This allows to remove one argument, making more place for those
that really matter.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 parse.c | 287 +++++++++++++++++++++++++++++---------------------------
 1 file changed, 148 insertions(+), 139 deletions(-)

diff --git a/parse.c b/parse.c
index a9222e7cbf08..4a2b62974612 100644
--- a/parse.c
+++ b/parse.c
@@ -455,159 +455,163 @@ static struct symbol_op mode_word_op = {
 	.to_mode = to_word_mode
 };
 
-/* Using NS_TYPEDEF will also make the keyword a reserved one */
+/*
+ * Define the keyword and their effects.
+ * The entries in the 'typedef' and put in NS_TYPEDEF and
+ * are automatically set as reserved keyword while the ones
+ * in the 'keyword' table are just put in NS_KEYWORD.
+ */
 static struct init_keyword {
 	const char *name;
-	enum namespace ns;
-	unsigned long modifiers;
 	struct symbol_op *op;
 	struct symbol *type;
-} keyword_table[] = {
+	unsigned long mods;
+} typedefs[] = {
 	/* Type qualifiers */
-	{ "const",	NS_TYPEDEF, .op = &const_op },
-	{ "__const",	NS_TYPEDEF, .op = &const_op },
-	{ "__const__",	NS_TYPEDEF, .op = &const_op },
-	{ "volatile",	NS_TYPEDEF, .op = &volatile_op },
-	{ "__volatile",		NS_TYPEDEF, .op = &volatile_op },
-	{ "__volatile__", 	NS_TYPEDEF, .op = &volatile_op },
-	{ "restrict",	NS_TYPEDEF, .op = &restrict_op},
-	{ "__restrict",	NS_TYPEDEF, .op = &restrict_op},
-	{ "__restrict__",	NS_TYPEDEF, .op = &restrict_op},
-	{ "_Atomic",	NS_TYPEDEF, .op = &atomic_op},
+	{ "const",		&const_op },
+	{ "__const__",		&const_op },
+	{ "__const",		&const_op },
+	{ "volatile",		&volatile_op },
+	{ "__volatile__",	&volatile_op },
+	{ "__volatile",		&volatile_op },
+	{ "restrict",		&restrict_op },
+	{ "__restrict__",	&restrict_op },
+	{ "__restrict",		&restrict_op },
+	{ "_Atomic",		&atomic_op },
 
 	/* Typedef.. */
-	{ "typedef",	NS_TYPEDEF, .op = &typedef_op },
+	{ "typedef",		&typedef_op },
 
 	/* Type specifiers */
-	{ "void",	NS_TYPEDEF, .type = &void_ctype, .op = &spec_op},
-	{ "char",	NS_TYPEDEF, .op = &char_op },
-	{ "short",	NS_TYPEDEF, .op = &short_op },
-	{ "int",	NS_TYPEDEF, .op = &int_op },
-	{ "long",	NS_TYPEDEF, .op = &long_op },
-	{ "float",	NS_TYPEDEF, .op = &float_op },
-	{ "double",	NS_TYPEDEF, .op = &double_op },
-	{ "signed",	NS_TYPEDEF, .op = &signed_op },
-	{ "__signed",	NS_TYPEDEF, .op = &signed_op },
-	{ "__signed__",	NS_TYPEDEF, .op = &signed_op },
-	{ "unsigned",	NS_TYPEDEF, .op = &unsigned_op },
-	{ "__int128",	NS_TYPEDEF, .op = &int128_op },
-	{ "_Bool",	NS_TYPEDEF, .type = &bool_ctype, .op = &spec_op },
+	{ "void",		&spec_op,	.type = &void_ctype },
+	{ "char",		&char_op },
+	{ "short",		&short_op },
+	{ "int",		&int_op },
+	{ "long",		&long_op },
+	{ "float",		&float_op },
+	{ "double",		&double_op },
+	{ "signed",		&signed_op },
+	{ "__signed__",		&signed_op },
+	{ "__signed",		&signed_op },
+	{ "unsigned",		&unsigned_op },
+	{ "__int128",		&int128_op },
+	{ "_Bool",		&spec_op,	.type = &bool_ctype },
 
 	/* Predeclared types */
-	{ "__builtin_va_list", NS_TYPEDEF, .type = &ptr_ctype, .op = &spec_op },
-	{ "__builtin_ms_va_list", NS_TYPEDEF, .type = &ptr_ctype, .op = &spec_op },
-	{ "__int128_t",	NS_TYPEDEF, .type = &sint128_ctype, .op = &spec_op },
-	{ "__uint128_t",NS_TYPEDEF, .type = &uint128_ctype, .op = &spec_op },
-	{ "_Float32",	NS_TYPEDEF, .type = &float32_ctype, .op = &spec_op },
-	{ "_Float32x",	NS_TYPEDEF, .type = &float32x_ctype, .op = &spec_op },
-	{ "_Float64",	NS_TYPEDEF, .type = &float64_ctype, .op = &spec_op },
-	{ "_Float64x",	NS_TYPEDEF, .type = &float64x_ctype, .op = &spec_op },
-	{ "_Float128",	NS_TYPEDEF, .type = &float128_ctype, .op = &spec_op },
+	{ "__builtin_va_list",	&spec_op,	.type = &ptr_ctype },
+	{ "__builtin_ms_va_list",&spec_op,	.type = &ptr_ctype },
+	{ "__int128_t",		&spec_op,	.type = &sint128_ctype },
+	{ "__uint128_t",	&spec_op,	.type = &uint128_ctype },
+	{ "_Float32",		&spec_op,	.type = &float32_ctype },
+	{ "_Float32x",		&spec_op,	.type = &float32x_ctype },
+	{ "_Float64",		&spec_op,	.type = &float64_ctype },
+	{ "_Float64x",		&spec_op,	.type = &float64x_ctype },
+	{ "_Float128",		&spec_op,	.type = &float128_ctype },
 
 	/* Extended types */
-	{ "typeof", 	NS_TYPEDEF, .op = &typeof_op },
-	{ "__typeof", 	NS_TYPEDEF, .op = &typeof_op },
-	{ "__typeof__",	NS_TYPEDEF, .op = &typeof_op },
-	{ "__auto_type",NS_TYPEDEF, .op = &autotype_op },
+	{ "typeof",		&typeof_op },
+	{ "__typeof__",		&typeof_op },
+	{ "__typeof",		&typeof_op },
+	{ "__auto_type",	&autotype_op },
 
-	{ "__attribute",   NS_TYPEDEF, .op = &attribute_op },
-	{ "__attribute__", NS_TYPEDEF, .op = &attribute_op },
+	{ "__attribute",	&attribute_op },
+	{ "__attribute__",	&attribute_op },
 
-	{ "struct",	NS_TYPEDEF, .op = &struct_op },
-	{ "union", 	NS_TYPEDEF, .op = &union_op },
-	{ "enum", 	NS_TYPEDEF, .op = &enum_op },
+	{ "struct",		&struct_op },
+	{ "union",		&union_op },
+	{ "enum",		&enum_op },
 
-	{ "inline",	NS_TYPEDEF, .op = &inline_op },
-	{ "__inline",	NS_TYPEDEF, .op = &inline_op },
-	{ "__inline__",	NS_TYPEDEF, .op = &inline_op },
+	{ "inline",		&inline_op },
+	{ "__inline__",		&inline_op },
+	{ "__inline",		&inline_op },
 
-	{ "_Noreturn",	NS_TYPEDEF, .op = &noreturn_op },
+	{ "_Noreturn",		&noreturn_op },
 
-	{ "_Alignas",	NS_TYPEDEF, .op = &alignas_op },
+	{ "_Alignas",		&alignas_op },
 
-	/* Static assertion */
-	{ "_Static_assert", NS_KEYWORD, .op = &static_assert_op },
 
 	/* Storage class */
-	{ "auto",	NS_TYPEDEF, .op = &auto_op },
-	{ "register",	NS_TYPEDEF, .op = &register_op },
-	{ "static",	NS_TYPEDEF, .op = &static_op },
-	{ "extern",	NS_TYPEDEF, .op = &extern_op },
-	{ "__thread",	NS_TYPEDEF, .op = &thread_op },
-	{ "_Thread_local",	NS_TYPEDEF, .op = &thread_op },
-
+	{ "auto",		&auto_op },
+	{ "register",		&register_op },
+	{ "static",		&static_op },
+	{ "extern",		&extern_op },
+	{ "__thread",		&thread_op },
+	{ "_Thread_local",	&thread_op },
+
+}, keywords[] = {
 	/* Statement */
-	{ "if",		NS_KEYWORD, .op = &if_op },
-	{ "return",	NS_KEYWORD, .op = &return_op },
-	{ "break",	NS_KEYWORD, .op = &loop_iter_op },
-	{ "continue",	NS_KEYWORD, .op = &loop_iter_op },
-	{ "default",	NS_KEYWORD, .op = &default_op },
-	{ "case",	NS_KEYWORD, .op = &case_op },
-	{ "switch",	NS_KEYWORD, .op = &switch_op },
-	{ "for",	NS_KEYWORD, .op = &for_op },
-	{ "while",	NS_KEYWORD, .op = &while_op },
-	{ "do",		NS_KEYWORD, .op = &do_op },
-	{ "goto",	NS_KEYWORD, .op = &goto_op },
-	{ "context",	NS_KEYWORD, .op = &context_op },
-	{ "__context__",NS_KEYWORD, .op = &__context___op },
-	{ "__range__",	NS_KEYWORD, .op = &range_op },
-	{ "asm",	NS_KEYWORD, .op = &asm_op },
-	{ "__asm",	NS_KEYWORD, .op = &asm_op },
-	{ "__asm__",	NS_KEYWORD, .op = &asm_op },
+	{ "if",			&if_op },
+	{ "return",		&return_op },
+	{ "break",		&loop_iter_op },
+	{ "continue",		&loop_iter_op },
+	{ "default",		&default_op },
+	{ "case",		&case_op },
+	{ "switch",		&switch_op },
+	{ "for",		&for_op },
+	{ "while",		&while_op },
+	{ "do",			&do_op },
+	{ "goto",		&goto_op },
+	{ "context",		&context_op },
+	{ "__context__",	&__context___op },
+	{ "__range__",		&range_op },
+	{ "asm",		&asm_op },
+	{ "__asm__",		&asm_op },
+	{ "__asm",		&asm_op },
+	{ "_Static_assert",	&static_assert_op },
 
 	/* Attribute */
-	{ "packed",	NS_KEYWORD, .op = &packed_op },
-	{ "__packed__",	NS_KEYWORD, .op = &packed_op },
-	{ "aligned",	NS_KEYWORD, .op = &aligned_op },
-	{ "__aligned__",NS_KEYWORD, .op = &aligned_op },
-	{ "nocast",	NS_KEYWORD,	MOD_NOCAST,	.op = &attr_mod_op },
-	{ "__nocast__",	NS_KEYWORD,	MOD_NOCAST,	.op = &attr_mod_op },
-	{ "noderef",	NS_KEYWORD,	MOD_NODEREF,	.op = &attr_mod_op },
-	{ "__noderef__",NS_KEYWORD,	MOD_NODEREF,	.op = &attr_mod_op },
-	{ "safe",	NS_KEYWORD,	MOD_SAFE, 	.op = &attr_mod_op },
-	{ "__safe__",	NS_KEYWORD,	MOD_SAFE, 	.op = &attr_mod_op },
-	{ "unused",	NS_KEYWORD,	MOD_UNUSED,	.op = &attr_mod_op },
-	{ "__unused__",	NS_KEYWORD,	MOD_UNUSED,	.op = &attr_mod_op },
-	{ "externally_visible",	NS_KEYWORD, MOD_EXT_VISIBLE,.op = &attr_mod_op },
-	{ "__externally_visible__", NS_KEYWORD,MOD_EXT_VISIBLE,.op = &attr_mod_op },
-	{ "force",	NS_KEYWORD,	.op = &attr_force_op },
-	{ "__force__",	NS_KEYWORD,	.op = &attr_force_op },
-	{ "bitwise",	NS_KEYWORD,	MOD_BITWISE,	.op = &attr_bitwise_op },
-	{ "__bitwise__",NS_KEYWORD,	MOD_BITWISE,	.op = &attr_bitwise_op },
-	{ "address_space",NS_KEYWORD,	.op = &address_space_op },
-	{ "__address_space__",NS_KEYWORD,	.op = &address_space_op },
-	{ "designated_init",	NS_KEYWORD,	.op = &designated_init_op },
-	{ "__designated_init__",	NS_KEYWORD,	.op = &designated_init_op },
-	{ "transparent_union",	NS_KEYWORD,	.op = &transparent_union_op },
-	{ "__transparent_union__",	NS_KEYWORD,	.op = &transparent_union_op },
-	{ "noreturn",	NS_KEYWORD,	MOD_NORETURN,	.op = &attr_fun_op },
-	{ "__noreturn__",	NS_KEYWORD,	MOD_NORETURN,	.op = &attr_fun_op },
-	{ "pure",	NS_KEYWORD,	MOD_PURE,	.op = &attr_fun_op },
-	{"__pure__",	NS_KEYWORD,	MOD_PURE,	.op = &attr_fun_op },
-	{"const",	NS_KEYWORD,	MOD_PURE,	.op = &attr_fun_op },
-	{"__const",	NS_KEYWORD,	MOD_PURE,	.op = &attr_fun_op },
-	{"__const__",	NS_KEYWORD,	MOD_PURE,	.op = &attr_fun_op },
-	{"gnu_inline",	NS_KEYWORD,	MOD_GNU_INLINE,	.op = &attr_fun_op },
-	{"__gnu_inline__",NS_KEYWORD,	MOD_GNU_INLINE,	.op = &attr_fun_op },
-
-	{ "mode",	NS_KEYWORD,	.op = &mode_op },
-	{ "__mode__",	NS_KEYWORD,	.op = &mode_op },
-	{ "QI",		NS_KEYWORD,	.op = &mode_QI_op },
-	{ "__QI__",	NS_KEYWORD,	.op = &mode_QI_op },
-	{ "HI",		NS_KEYWORD,	.op = &mode_HI_op },
-	{ "__HI__",	NS_KEYWORD,	.op = &mode_HI_op },
-	{ "SI",		NS_KEYWORD,	.op = &mode_SI_op },
-	{ "__SI__",	NS_KEYWORD,	.op = &mode_SI_op },
-	{ "DI",		NS_KEYWORD,	.op = &mode_DI_op },
-	{ "__DI__",	NS_KEYWORD,	.op = &mode_DI_op },
-	{ "TI",		NS_KEYWORD,	.op = &mode_TI_op },
-	{ "__TI__",	NS_KEYWORD,	.op = &mode_TI_op },
-	{ "byte",	NS_KEYWORD,	.op = &mode_QI_op },
-	{ "__byte__",	NS_KEYWORD,	.op = &mode_QI_op },
-	{ "pointer",	NS_KEYWORD,	.op = &mode_pointer_op },
-	{ "__pointer__",NS_KEYWORD,	.op = &mode_pointer_op },
-	{ "word",	NS_KEYWORD,	.op = &mode_word_op },
-	{ "__word__",	NS_KEYWORD,	.op = &mode_word_op },
+	{ "packed",		&packed_op },
+	{ "__packed__",		&packed_op },
+	{ "aligned",		&aligned_op },
+	{ "__aligned__",	&aligned_op },
+	{ "nocast",		&attr_mod_op,		.mods = MOD_NOCAST },
+	{ "__nocast__",		&attr_mod_op,		.mods = MOD_NOCAST },
+	{ "noderef",		&attr_mod_op,		.mods = MOD_NODEREF },
+	{ "__noderef__",	&attr_mod_op,		.mods = MOD_NODEREF },
+	{ "safe",		&attr_mod_op,		.mods = MOD_SAFE },
+	{ "__safe__",		&attr_mod_op,		.mods = MOD_SAFE },
+	{ "unused",		&attr_mod_op,		.mods = MOD_UNUSED },
+	{ "__unused__",		&attr_mod_op,		.mods = MOD_UNUSED },
+	{ "externally_visible",&attr_mod_op,		.mods = MOD_EXT_VISIBLE },
+	{ "__externally_visible__",&attr_mod_op,	.mods = MOD_EXT_VISIBLE },
+	{ "force",		&attr_force_op },
+	{ "__force__",		&attr_force_op },
+	{ "bitwise",		&attr_bitwise_op,	.mods = MOD_BITWISE },
+	{ "__bitwise__",	&attr_bitwise_op,	.mods = MOD_BITWISE },
+	{ "address_space",	&address_space_op },
+	{ "__address_space__",	&address_space_op },
+	{ "designated_init",	&designated_init_op },
+	{ "__designated_init__",&designated_init_op },
+	{ "transparent_union",	&transparent_union_op },
+	{ "__transparent_union__",&transparent_union_op },
+	{ "noreturn",		&attr_fun_op,		.mods = MOD_NORETURN },
+	{ "__noreturn__",	&attr_fun_op,		.mods = MOD_NORETURN },
+	{ "pure",		&attr_fun_op,		.mods = MOD_PURE },
+	{ "__pure__",		&attr_fun_op,		.mods = MOD_PURE },
+	{ "const",		&attr_fun_op,		.mods = MOD_PURE },
+	{ "__const__",		&attr_fun_op,		.mods = MOD_PURE },
+	{ "__const",		&attr_fun_op,		.mods = MOD_PURE },
+	{ "gnu_inline",		&attr_fun_op,		.mods = MOD_GNU_INLINE },
+	{ "__gnu_inline__",	&attr_fun_op,		.mods = MOD_GNU_INLINE },
+
+	{ "mode",		&mode_op },
+	{ "__mode__",		&mode_op },
+	{ "QI",			&mode_QI_op },
+	{ "__QI__",		&mode_QI_op },
+	{ "HI",			&mode_HI_op },
+	{ "__HI__",		&mode_HI_op },
+	{ "SI",			&mode_SI_op },
+	{ "__SI__",		&mode_SI_op },
+	{ "DI",			&mode_DI_op },
+	{ "__DI__",		&mode_DI_op },
+	{ "TI",			&mode_TI_op },
+	{ "__TI__",		&mode_TI_op },
+	{ "byte",		&mode_QI_op },
+	{ "__byte__",		&mode_QI_op },
+	{ "pointer",		&mode_pointer_op },
+	{ "__pointer__",	&mode_pointer_op },
+	{ "word",		&mode_word_op },
+	{ "__word__",		&mode_word_op },
 };
 
 
@@ -629,19 +633,24 @@ static const char *ignored_attributes[] = {
 };
 
 
+static void init_keyword(int stream, struct init_keyword *kw, enum namespace ns)
+{
+	struct symbol *sym = create_symbol(stream, kw->name, SYM_KEYWORD, ns);
+	sym->ident->keyword = 1;
+	sym->ident->reserved |= (ns == NS_TYPEDEF);
+	sym->ctype.modifiers = kw->mods;
+	sym->ctype.base_type = kw->type;
+	sym->op = kw->op;
+}
+
 void init_parser(int stream)
 {
 	int i;
-	for (i = 0; i < ARRAY_SIZE(keyword_table); i++) {
-		struct init_keyword *ptr = keyword_table + i;
-		struct symbol *sym = create_symbol(stream, ptr->name, SYM_KEYWORD, ptr->ns);
-		sym->ident->keyword = 1;
-		if (ptr->ns == NS_TYPEDEF)
-			sym->ident->reserved = 1;
-		sym->ctype.modifiers = ptr->modifiers;
-		sym->ctype.base_type = ptr->type;
-		sym->op = ptr->op;
-	}
+
+	for (i = 0; i < ARRAY_SIZE(typedefs); i++)
+		init_keyword(stream, &typedefs[i], NS_TYPEDEF);
+	for (i = 0; i < ARRAY_SIZE(keywords); i++)
+		init_keyword(stream, &keywords[i], NS_KEYWORD);
 
 	for (i = 0; i < ARRAY_SIZE(ignored_attributes); i++) {
 		const char * name = ignored_attributes[i];
-- 
2.27.0

