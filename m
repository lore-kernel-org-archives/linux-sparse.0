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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CAC6C433DF
	for <linux-sparse@archiver.kernel.org>; Wed,  8 Jul 2020 21:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F100A206C3
	for <linux-sparse@archiver.kernel.org>; Wed,  8 Jul 2020 21:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xxhs/xHt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbgGHVsR (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 8 Jul 2020 17:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgGHVsR (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 8 Jul 2020 17:48:17 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488BCC061A0B
        for <linux-sparse@vger.kernel.org>; Wed,  8 Jul 2020 14:48:17 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id ga4so29305ejb.11
        for <linux-sparse@vger.kernel.org>; Wed, 08 Jul 2020 14:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EjKnwL369JtLls31rYSGteaFWmynoX0fnGDZ3FC1FjI=;
        b=Xxhs/xHtWe68QXPvOiH99zfk2+epc5nx+E1m81GaKO3+vIbkYW6ieeMBXfE/CkrZdx
         3KeT/aJpMmMWk4OU2PkMWelfCwz/djk52z/pOURw45gW/t7zd0WGYyfwzbbDK3OadAGl
         9O5E+F222pdHaKRcqW2e8cP4nFa+GiGWmeeaxBRkLGxAda5W58ItmlYcRECPTTf3NEWH
         GrPPD/DNMPFFlyW03hi+8xtGbrE8GUeozcFLnC4FiBvwyfVGwh2Lp6bjtVBREkyWBqnL
         lxXESsWsZuxlia/aaXeK9rRqbTPTGQ5SYUOx5ygX8nl9kjsc9eA7uJ0f45jzKLu75/oo
         xuQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EjKnwL369JtLls31rYSGteaFWmynoX0fnGDZ3FC1FjI=;
        b=LfgFIdEo2QE1yCpYbIGuwWFayLYG+lxkfGc8W+Ia3KjR1SCehr1q2ugXKduusK44YE
         bOlhDgf8k5tcw6TZKEgA3YEoO6mzHXuMeeDXeybvFfX4GRhWAOmBeBCodoK72+oOCVE8
         o9oe3ifryooGQs33pgUG7wTl+Ub417uS4KUM/d89p/pD5h1k2PTCSUDwU+RYdIV3gmWA
         0J78z2BgjHFkh8f/H8XRxBUu893ip6GedVOqDzOCcB7/xudiL72vg21aK8Gcr8DiOh6O
         8q3gQqmfYI5r/DcuZ5uUgtMTkJJLnujgxOiN0MKy6W5U/ho4qsoI43l7VaJemNhEBoXK
         Zq/w==
X-Gm-Message-State: AOAM530BLZCZ1K6a6nvPev8Ou4J62kW3pfcWcEw90OQ5O7ffXcCmkNIf
        eAtpODFUOAqL1BsfWRTR4DFXJo8Y
X-Google-Smtp-Source: ABdhPJxIeXltTZHPwclLJd+ad0xQU2NHyuC5kQYMPCpKSrmAz22LQvJlqgSikE2LB9KGHhA5bWD2vA==
X-Received: by 2002:a17:906:1102:: with SMTP id h2mr52128281eja.356.1594244895750;
        Wed, 08 Jul 2020 14:48:15 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:b1eb:f280:ff97:eab2])
        by smtp.gmail.com with ESMTPSA id l15sm450370ejd.100.2020.07.08.14.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 14:48:15 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/3] riscv: parse '-march=....'
Date:   Wed,  8 Jul 2020 23:48:08 +0200
Message-Id: <20200708214810.56214-3-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200708214810.56214-1-luc.vanoostenryck@gmail.com>
References: <20200708214810.56214-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The RISC-V architecture has quite a bit of extensions.
Some of these correspond to a predefined macro and thus
parsing correctly the '-march' flag can be important.

So, teach sparse how to parse this flag for RISC-V.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 target-riscv.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++++++
 target.h       |  1 +
 2 files changed, 81 insertions(+)

diff --git a/target-riscv.c b/target-riscv.c
index d68fb585c254..9431ebc9cabb 100644
--- a/target-riscv.c
+++ b/target-riscv.c
@@ -1,7 +1,80 @@
+#include "lib.h"
 #include "symbol.h"
 #include "target.h"
 #include "machine.h"
+#include <string.h>
 
+#define RISCV_32BIT	(1 << 0)
+#define RISCV_64BIT	(1 << 1)
+#define RISCV_MUL	(1 << 2)
+#define RISCV_DIV	(1 << 3)
+#define RISCV_ATOMIC	(1 << 4)
+#define RISCV_FLOAT	(1 << 5)
+#define RISCV_DOUBLE	(1 << 6)
+#define RISCV_FDIV	(1 << 7)
+#define RISCV_COMP	(1 << 8)
+#define RISCV_EMBD	(1 << 9)
+#define RISCV_FPU	(RISCV_FLOAT|RISCV_DOUBLE|RISCV_FDIV)
+#define RISCV_GENERIC	(RISCV_MUL|RISCV_DIV|RISCV_ATOMIC|RISCV_FPU)
+
+static unsigned int riscv_flags;
+
+static void parse_march_riscv(const char *arg)
+{
+	static struct {
+		const char *pattern;
+		unsigned int flags;
+	} basic_sets[] = {
+		{ "rv32i",	RISCV_32BIT },
+		{ "rv32e",	RISCV_32BIT|RISCV_EMBD },
+		{ "rv32g",	RISCV_32BIT|RISCV_GENERIC },
+		{ "rv64i",	RISCV_64BIT },
+		{ "rv64g",	RISCV_64BIT|RISCV_GENERIC },
+	}, extensions[] = {
+		{ "m",		RISCV_MUL|RISCV_DIV },
+		{ "a",		RISCV_ATOMIC },
+		{ "f",		RISCV_FLOAT|RISCV_FDIV },
+		{ "d",		RISCV_DOUBLE|RISCV_FDIV },
+		{ "g",		RISCV_GENERIC },
+		{ "q",		0 },
+		{ "l",		0 },
+		{ "c",		RISCV_COMP },
+		{ "b",		0 },
+		{ "j",		0 },
+		{ "t",		0 },
+		{ "p",		0 },
+		{ "v",		0 },
+		{ "n",		0 },
+		{ "h",		0 },
+		{ "s",		0 },
+	};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(basic_sets); i++) {
+		const char *pat = basic_sets[i].pattern;
+		size_t len = strlen(pat);
+
+		if (!strncmp(arg, pat, len)) {
+			riscv_flags |= basic_sets[i].flags;
+			arg += len;
+			goto ext;
+		}
+	}
+	die("invalid argument to '-march': '%s'\n", arg);
+
+ext:
+	for (i = 0; i < ARRAY_SIZE(extensions); i++) {
+		const char *pat = extensions[i].pattern;
+		size_t len = strlen(pat);
+
+		if (!strncmp(arg, pat, len)) {
+			riscv_flags |= extensions[i].flags;
+			arg += len;
+		}
+	}
+	if (arg[0])
+		die("invalid argument to '-march': '%s'\n", arg);
+}
 
 static void init_riscv(const struct target *self)
 {
@@ -9,6 +82,9 @@ static void init_riscv(const struct target *self)
 		arch_cmodel = CMODEL_MEDLOW;
 	if (fpic)
 		arch_cmodel = CMODEL_PIC;
+
+	if (riscv_flags == 0)
+		riscv_flags = self->flags;
 }
 
 static void predefine_riscv(const struct target *self)
@@ -32,11 +108,13 @@ const struct target target_riscv32 = {
 	.bitness = ARCH_LP32,
 	.big_endian = 0,
 	.unsigned_char = 1,
+	.flags = RISCV_32BIT|RISCV_GENERIC|RISCV_COMP,
 
 	.target_64bit = &target_riscv64,
 
 	.init = init_riscv,
 	.predefine = predefine_riscv,
+	.parse_march = parse_march_riscv,
 };
 
 const struct target target_riscv64 = {
@@ -45,9 +123,11 @@ const struct target target_riscv64 = {
 	.big_endian = 0,
 	.unsigned_char = 1,
 	.has_int128 = 1,
+	.flags = RISCV_64BIT|RISCV_GENERIC|RISCV_COMP,
 
 	.target_32bit = &target_riscv32,
 
 	.init = init_riscv,
 	.predefine = predefine_riscv,
+	.parse_march = parse_march_riscv,
 };
diff --git a/target.h b/target.h
index 54e97e83b10d..76b7d12318c6 100644
--- a/target.h
+++ b/target.h
@@ -63,6 +63,7 @@ struct target {
 	unsigned int	unsigned_char:1;
 	unsigned int	size_t_long:1;
 	unsigned int	has_int128:1;
+	unsigned long	flags;
 
 	struct symbol	*wchar;
 	struct symbol	*wint;
-- 
2.27.0

