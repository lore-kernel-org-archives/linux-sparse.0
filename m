Return-Path: <SRS0=w175=AY=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48CF0C433E1
	for <linux-sparse@archiver.kernel.org>; Mon, 13 Jul 2020 22:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1912D2089D
	for <linux-sparse@archiver.kernel.org>; Mon, 13 Jul 2020 22:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRdfn6W6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgGMWdQ (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 13 Jul 2020 18:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgGMWdO (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 13 Jul 2020 18:33:14 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD3DC061755
        for <linux-sparse@vger.kernel.org>; Mon, 13 Jul 2020 15:33:13 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id a1so9734523edt.10
        for <linux-sparse@vger.kernel.org>; Mon, 13 Jul 2020 15:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q8Cj8uzm2lCmU75JNXVMP2iSdX56eMTSRXo6qQ0daRU=;
        b=hRdfn6W6N6xH9it58fsOJR644M1dGBX4Q1l1gM7kC9ilqq6nch01dWp6LKHBjtqcW7
         HMmcdNaIgcOcJoBCny5w7ySOD6tGHAR+9YGVlWaOkHsQOw2fF0Lb10t7AJeUSCCtWprR
         AzF753DoKXsgg9U2EQgduhkQQIQDYnCIcckggqxbtdPGcyzmRn9ebkxVFeE6GtauX62p
         picvmSVBfgVnhH2e28u/ZYj4u6kVTgDlS+8VOnVU81anetYBfqeqG6o2cV4UkvU3U/Ae
         XjB0B/+qxRHllvhb1Uegk75RXkWPD3VwcSOxf1DThzZOmQPnSxaFBMv4NHhBGu5gWJkX
         KLFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q8Cj8uzm2lCmU75JNXVMP2iSdX56eMTSRXo6qQ0daRU=;
        b=GOk6GA+HdcJ1OfjteBzKeRzNetpNECVarv5s7Zl1tBd/TPncHcOokHFFJ0BWr41kvu
         lt0Xj9ibygFgPsLVY71pU2FSOvNjz4sqDnpY4QGqrjDA9fNKbu+bggAi34/EOHUE1EAw
         4MaW+jh6cQL4HDdV4xHeuvJdgJCrqS7tRcX2cU6U1ix1M1s2WsQXg93vIMtjF0/0NNtE
         rj9Ip8CwlPqtiTOcYDyvS91PxbGwZ2aK9fFKwsYCAlbnZzLojlG0mvL565RfruSrlTGD
         HAWWVyX436NbLSXXoxKwlViqumZDY8Q0vMwKZkn0p9N8B1IT1amb8BGjM8qkuA85FDYM
         g+qA==
X-Gm-Message-State: AOAM5336OzbvOXOe+4CqpOBCwfLgU2Y15et2pT75mDNzXKJY5eb32RrO
        T9FShLgblW0HlgK/ng660gsrhRHN
X-Google-Smtp-Source: ABdhPJwIW2ZvdN7+ficcHQJjDs1yHhz1ImjhJRTJpVmIt4jU7pkinCt4VCLIIeDQ/3apTBPdzZARbw==
X-Received: by 2002:aa7:c808:: with SMTP id a8mr1588339edt.259.1594679592062;
        Mon, 13 Jul 2020 15:33:12 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:64:f40c:5c10:8e2d])
        by smtp.gmail.com with ESMTPSA id y7sm10792431ejd.73.2020.07.13.15.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 15:33:11 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 5/9] arch: add predefines __INT_FAST${N}_TYPE__
Date:   Tue, 14 Jul 2020 00:32:59 +0200
Message-Id: <20200713223304.83666-6-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200713223304.83666-1-luc.vanoostenryck@gmail.com>
References: <20200713223304.83666-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

We just added __INT_LEAST${N}_TYPE__, so add these ones
too as they looks slightly more useful.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 predefine.c         |  9 +++++++++
 target-arm.c        |  7 +++++++
 target-h8300.c      |  5 +++++
 target-m68k.c       |  9 +++++++++
 target-microblaze.c |  9 +++++++++
 target-nds32.c      |  5 +++++
 target-nios2.c      |  9 +++++++++
 target-openrisc.c   |  5 +++++
 target-ppc.c        |  9 +++++++++
 target-riscv.c      | 12 +++++++++++-
 target-s390.c       |  9 +++++++++
 target-sh.c         |  6 ++++++
 target-sparc.c      |  5 +++++
 target-x86.c        | 25 +++++++++++++++++++++++++
 target-xtensa.c     |  5 +++++
 target.c            | 10 ++++++++++
 target.h            |  8 ++++++++
 17 files changed, 146 insertions(+), 1 deletion(-)

diff --git a/predefine.c b/predefine.c
index 062e754bf20f..2e9913d5c0bc 100644
--- a/predefine.c
+++ b/predefine.c
@@ -154,6 +154,15 @@ void predefined_macros(void)
 	predefined_ctype("INT_LEAST64",   int64_ctype, PTYPE_MAX|PTYPE_TYPE|PTYPE_WIDTH);
 	predefined_ctype("UINT_LEAST64", uint64_ctype, PTYPE_MAX|PTYPE_TYPE);
 
+	predefined_ctype("INT_FAST8",    fast8_ctype, PTYPE_MAX|PTYPE_TYPE|PTYPE_WIDTH);
+	predefined_ctype("UINT_FAST8",  ufast8_ctype, PTYPE_MAX|PTYPE_TYPE);
+	predefined_ctype("INT_FAST16",  fast16_ctype, PTYPE_MAX|PTYPE_TYPE|PTYPE_WIDTH);
+	predefined_ctype("UINT_FAST16",ufast16_ctype, PTYPE_MAX|PTYPE_TYPE);
+	predefined_ctype("INT_FAST32",  fast32_ctype, PTYPE_MAX|PTYPE_TYPE|PTYPE_WIDTH);
+	predefined_ctype("UINT_FAST32",ufast32_ctype, PTYPE_MAX|PTYPE_TYPE);
+	predefined_ctype("INT_FAST64",  fast64_ctype, PTYPE_MAX|PTYPE_TYPE|PTYPE_WIDTH);
+	predefined_ctype("UINT_FAST64",ufast64_ctype, PTYPE_MAX|PTYPE_TYPE);
+
 	predefined_ctype("INTMAX",    intmax_ctype, PTYPE_MAX|PTYPE_TYPE|PTYPE_WIDTH);
 	predefined_ctype("UINTMAX",  uintmax_ctype, PTYPE_MAX|PTYPE_TYPE);
 	predefined_ctype("INTPTR",   ssize_t_ctype, PTYPE_MAX|PTYPE_TYPE|PTYPE_WIDTH);
diff --git a/target-arm.c b/target-arm.c
index 5fc15c511e1a..104c319b23dd 100644
--- a/target-arm.c
+++ b/target-arm.c
@@ -5,9 +5,16 @@
 
 static void init_arm(const struct target *self)
 {
+	fast16_ctype = &int_ctype;
+	ufast16_ctype = &uint_ctype;
+	fast32_ctype = &int_ctype;
+	ufast32_ctype = &uint_ctype;
+
 	if (arch_os == OS_NONE) {
 		int32_ctype = &long_ctype;
 		uint32_ctype = &ulong_ctype;
+		fast8_ctype = &int_ctype;
+		ufast8_ctype = &uint_ctype;
 	}
 }
 
diff --git a/target-h8300.c b/target-h8300.c
index 47872b38a1ad..84d168b7410a 100644
--- a/target-h8300.c
+++ b/target-h8300.c
@@ -8,6 +8,11 @@ static void init_h8300(const struct target *self)
 	ssize_t_ctype = &long_ctype;
 	size_t_ctype = &ulong_ctype;
 	wchar_ctype = &ushort_ctype;
+
+	fast16_ctype = &int_ctype;
+	ufast16_ctype = &uint_ctype;
+	fast32_ctype = &int_ctype;
+	ufast32_ctype = &uint_ctype;
 }
 
 static void predefine_h8300(const struct target *self)
diff --git a/target-m68k.c b/target-m68k.c
index ed4a92733efe..0aed2eb362eb 100644
--- a/target-m68k.c
+++ b/target-m68k.c
@@ -3,6 +3,14 @@
 #include "machine.h"
 
 
+static void init_m68k(const struct target *self)
+{
+	fast16_ctype = &int_ctype;
+	ufast16_ctype = &uint_ctype;
+	fast32_ctype = &int_ctype;
+	ufast32_ctype = &uint_ctype;
+}
+
 static void predefine_m68k(const struct target *self)
 {
 	predefine("__m68k__", 1, "1");
@@ -19,5 +27,6 @@ const struct target target_m68k = {
 	.bits_in_longdouble = 96,
 	.max_fp_alignment = 4,
 
+	.init = init_m68k,
 	.predefine = predefine_m68k,
 };
diff --git a/target-microblaze.c b/target-microblaze.c
index 1fbeef3c168d..3a4c3d58d77f 100644
--- a/target-microblaze.c
+++ b/target-microblaze.c
@@ -3,6 +3,14 @@
 #include "machine.h"
 
 
+static void init_microblaze(const struct target *self)
+{
+	fast16_ctype = &int_ctype;
+	ufast16_ctype = &uint_ctype;
+	fast32_ctype = &int_ctype;
+	ufast32_ctype = &uint_ctype;
+}
+
 static void predefine_microblaze(const struct target *self)
 {
 	predefine("__MICROBLAZE__", 1, "1");
@@ -21,5 +29,6 @@ const struct target target_microblaze = {
 
 	.bits_in_longdouble = 64,
 
+	.init = init_microblaze,
 	.predefine = predefine_microblaze,
 };
diff --git a/target-nds32.c b/target-nds32.c
index 0dc483b26396..e3ed2e520883 100644
--- a/target-nds32.c
+++ b/target-nds32.c
@@ -5,6 +5,11 @@
 
 static void init_nds32(const struct target *self)
 {
+	fast16_ctype = &int_ctype;
+	ufast16_ctype = &uint_ctype;
+	fast32_ctype = &int_ctype;
+	ufast32_ctype = &uint_ctype;
+
 	wchar_ctype = &uint_ctype;
 }
 
diff --git a/target-nios2.c b/target-nios2.c
index a478fff51e18..c57b171984a4 100644
--- a/target-nios2.c
+++ b/target-nios2.c
@@ -4,6 +4,14 @@
 #include "builtin.h"
 
 
+static void init_nios2(const struct target *self)
+{
+	fast16_ctype = &int_ctype;
+	ufast16_ctype = &uint_ctype;
+	fast32_ctype = &int_ctype;
+	ufast32_ctype = &uint_ctype;
+}
+
 static void predefine_nios2(const struct target *self)
 {
 	predefine("__NIOS2", 1, "1");
@@ -33,6 +41,7 @@ const struct target target_nios2 = {
 
 	.bits_in_longdouble = 64,
 
+	.init = init_nios2,
 	.predefine = predefine_nios2,
 	.builtins = builtins_nios2,
 };
diff --git a/target-openrisc.c b/target-openrisc.c
index 553963c069ae..ad25ff2791d3 100644
--- a/target-openrisc.c
+++ b/target-openrisc.c
@@ -5,6 +5,11 @@
 
 static void init_openrisc(const struct target *self)
 {
+	fast16_ctype = &int_ctype;
+	ufast16_ctype = &uint_ctype;
+	fast32_ctype = &int_ctype;
+	ufast32_ctype = &uint_ctype;
+
 	wchar_ctype = &uint_ctype;
 }
 
diff --git a/target-ppc.c b/target-ppc.c
index dede8917cbd6..6c0c0737482c 100644
--- a/target-ppc.c
+++ b/target-ppc.c
@@ -31,6 +31,14 @@ static const char *asm_constraint_ppc(struct asm_operand *op, int c, const char
 }
 
 
+static void init_ppc32(const struct target *self)
+{
+	fast16_ctype = &int_ctype;
+	ufast16_ctype = &uint_ctype;
+	fast32_ctype = &int_ctype;
+	ufast32_ctype = &uint_ctype;
+}
+
 static void predefine_ppc32(const struct target *self)
 {
 	predefine_ppc(self);
@@ -46,6 +54,7 @@ const struct target target_ppc32 = {
 
 	.target_64bit = &target_ppc64,
 
+	.init = init_ppc32,
 	.predefine = predefine_ppc32,
 	.asm_constraint = asm_constraint_ppc,
 };
diff --git a/target-riscv.c b/target-riscv.c
index e7f2b03b821b..6d9113c125ee 100644
--- a/target-riscv.c
+++ b/target-riscv.c
@@ -87,6 +87,16 @@ static void init_riscv(const struct target *self)
 		riscv_flags = self->flags;
 }
 
+static void init_riscv32(const struct target *self)
+{
+	fast16_ctype = &int_ctype;
+	ufast16_ctype = &uint_ctype;
+	fast32_ctype = &int_ctype;
+	ufast32_ctype = &uint_ctype;
+
+	init_riscv(self);
+}
+
 static void predefine_riscv(const struct target *self)
 {
 	static const char *cmodels[CMODEL_LAST] = {
@@ -131,7 +141,7 @@ const struct target target_riscv32 = {
 
 	.target_64bit = &target_riscv64,
 
-	.init = init_riscv,
+	.init = init_riscv32,
 	.predefine = predefine_riscv,
 	.parse_march = parse_march_riscv,
 };
diff --git a/target-s390.c b/target-s390.c
index 9dbc810e507c..cdbd685a2099 100644
--- a/target-s390.c
+++ b/target-s390.c
@@ -4,6 +4,14 @@
 #include "expression.h"
 
 
+static void init_s390(const struct target *self)
+{
+	fast16_ctype = &int_ctype;
+	ufast16_ctype = &uint_ctype;
+	fast32_ctype = &int_ctype;
+	ufast32_ctype = &uint_ctype;
+}
+
 static void predefine_s390(const struct target *self)
 {
 	predefine("__s390__", 1, "1");
@@ -31,6 +39,7 @@ const struct target target_s390 = {
 
 	.target_64bit = &target_s390x,
 
+	.init = init_s390,
 	.predefine = predefine_s390,
 	.asm_constraint = asm_constraint_s390,
 };
diff --git a/target-sh.c b/target-sh.c
index db517ccb0f5c..d4ddf45504cf 100644
--- a/target-sh.c
+++ b/target-sh.c
@@ -7,6 +7,12 @@ static void init_sh(const struct target *self)
 {
 	int64_ctype = &llong_ctype;
 	uint64_ctype = &ullong_ctype;
+
+	fast16_ctype = &int_ctype;
+	ufast16_ctype = &uint_ctype;
+	fast32_ctype = &int_ctype;
+	ufast32_ctype = &uint_ctype;
+
 	wchar_ctype = &long_ctype;
 }
 
diff --git a/target-sparc.c b/target-sparc.c
index be4e968ec604..d830f6cbe828 100644
--- a/target-sparc.c
+++ b/target-sparc.c
@@ -19,6 +19,11 @@ static void predefine_sparc(const struct target *self)
 
 static void init_sparc32(const struct target *target)
 {
+	fast16_ctype = &int_ctype;
+	ufast16_ctype = &uint_ctype;
+	fast32_ctype = &int_ctype;
+	ufast32_ctype = &uint_ctype;
+
 	if (!sparc_version)
 		sparc_version = 8;
 
diff --git a/target-x86.c b/target-x86.c
index 956af92efe4e..e69594edac0e 100644
--- a/target-x86.c
+++ b/target-x86.c
@@ -33,6 +33,8 @@ static void init_x86_common(const struct target *target)
 		ssize_t_ctype = &long_ctype;
 		wchar_ctype = &int_ctype;
 		wint_ctype = &int_ctype;
+		fast16_ctype = &short_ctype;
+		ufast16_ctype = &ushort_ctype;
 		break;
 	}
 }
@@ -40,6 +42,11 @@ static void init_x86_common(const struct target *target)
 
 static void init_i386(const struct target *target)
 {
+	fast16_ctype = &int_ctype;
+	ufast16_ctype = &uint_ctype;
+	fast32_ctype = &int_ctype;
+	ufast32_ctype = &uint_ctype;
+
 	init_x86_common(target);
 }
 
@@ -71,13 +78,31 @@ static void init_x86_64(const struct target *target)
 		int64_ctype = &llong_ctype;
 		uint64_ctype = &ullong_ctype;
 		wint_ctype = &int_ctype;
+		fast16_ctype = &short_ctype;
+		ufast16_ctype = &ushort_ctype;
+		fast32_ctype = &int_ctype;
+		ufast32_ctype = &uint_ctype;
+		fast64_ctype = &llong_ctype;
+		ufast64_ctype = &ullong_ctype;
 		break;
 	case OS_FREEBSD:
+		fast16_ctype = &short_ctype;
+		ufast16_ctype = &ushort_ctype;
+		fast32_ctype = &int_ctype;
+		ufast32_ctype = &uint_ctype;
 		break;
 	case OS_NETBSD:
+		fast8_ctype = &int_ctype;
+		ufast8_ctype = &uint_ctype;
+		fast16_ctype = &int_ctype;
+		ufast16_ctype = &uint_ctype;
+		fast32_ctype = &int_ctype;
+		ufast32_ctype = &uint_ctype;
 		wint_ctype = &int_ctype;
 		break;
 	case OS_OPENBSD:
+		fast32_ctype = &int_ctype;
+		ufast32_ctype = &uint_ctype;
 		int64_ctype = &llong_ctype;
 		uint64_ctype = &ullong_ctype;
 		intmax_ctype = &llong_ctype;
diff --git a/target-xtensa.c b/target-xtensa.c
index 3e5781c86d82..26bda47f02f0 100644
--- a/target-xtensa.c
+++ b/target-xtensa.c
@@ -5,6 +5,11 @@
 
 static void init_xtensa(const struct target *self)
 {
+	fast16_ctype = &int_ctype;
+	ufast16_ctype = &uint_ctype;
+	fast32_ctype = &int_ctype;
+	ufast32_ctype = &uint_ctype;
+
 	wchar_ctype = &long_ctype;
 }
 
diff --git a/target.c b/target.c
index e2eb78e25328..655a1527f93f 100644
--- a/target.c
+++ b/target.c
@@ -23,6 +23,14 @@ struct symbol *least32_ctype = &int_ctype;
 struct symbol *uleast32_ctype = &uint_ctype;
 struct symbol *least64_ctype = &llong_ctype;
 struct symbol *uleast64_ctype = &ullong_ctype;
+struct symbol *fast8_ctype = &schar_ctype;
+struct symbol *ufast8_ctype = &uchar_ctype;
+struct symbol *fast16_ctype = &long_ctype;
+struct symbol *ufast16_ctype = &ulong_ctype;
+struct symbol *fast32_ctype = &long_ctype;
+struct symbol *ufast32_ctype = &ulong_ctype;
+struct symbol *fast64_ctype = &long_ctype;
+struct symbol *ufast64_ctype = &ulong_ctype;
 
 /*
  * For "__attribute__((aligned))"
@@ -214,6 +222,8 @@ void target_init(void)
 		uint64_ctype = &ullong_ctype;
 		intmax_ctype = &llong_ctype;
 		uintmax_ctype = &ullong_ctype;
+		fast64_ctype = &llong_ctype;
+		ufast64_ctype = &ullong_ctype;
 		if (target->target_32bit)
 			target = target->target_32bit;
 		break;
diff --git a/target.h b/target.h
index 4140b77c4beb..3fdfc1e69339 100644
--- a/target.h
+++ b/target.h
@@ -21,6 +21,14 @@ extern struct symbol *least32_ctype;
 extern struct symbol *uleast32_ctype;
 extern struct symbol *least64_ctype;
 extern struct symbol *uleast64_ctype;
+extern struct symbol *fast8_ctype;
+extern struct symbol *ufast8_ctype;
+extern struct symbol *fast16_ctype;
+extern struct symbol *ufast16_ctype;
+extern struct symbol *fast32_ctype;
+extern struct symbol *ufast32_ctype;
+extern struct symbol *fast64_ctype;
+extern struct symbol *ufast64_ctype;
 
 /*
  * For "__attribute__((aligned))"
-- 
2.27.0

