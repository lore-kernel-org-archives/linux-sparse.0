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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83572C433DF
	for <linux-sparse@archiver.kernel.org>; Wed,  8 Jul 2020 22:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 599DA20772
	for <linux-sparse@archiver.kernel.org>; Wed,  8 Jul 2020 22:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSBIrWQ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgGHW0X (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 8 Jul 2020 18:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgGHW0W (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 8 Jul 2020 18:26:22 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F2AC061A0B
        for <linux-sparse@vger.kernel.org>; Wed,  8 Jul 2020 15:26:22 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id dr13so152984ejc.3
        for <linux-sparse@vger.kernel.org>; Wed, 08 Jul 2020 15:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PbUoneishhPwkbxLtp6Clg4SxV22UZi8/lo3FyV9Z0M=;
        b=XSBIrWQ8KCFPO8kaBpDmmHWfkQXZ5O8Fcd44bqY0BXKWe8z+nry83d3ItsC47u+s0a
         6Cj6LWk76QfaeR9gd214IKYHxA5sbRq+XX2adNulHD5L+F6rPJC6gdtbTz2chFq8cSKl
         JaawM1Vx6EoKzI+10fHCHWg3oJi0iDPmTZ+UyzGFq+JPzv5/rkhSM+mm66kfN8dA4Etl
         10Vzv5n7J/rnhfvsZZkpYuKT4sJjNoxy+RRPMYtdAL769xENgtFFlWjZS0TCcEvJuoMq
         YXMrtjtdoZ7XBBdMnIqHQUJSjg0ArITyIsGw7UG6XZOpXgrKIUelNmdLJ9DdZZLjKjlZ
         svYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PbUoneishhPwkbxLtp6Clg4SxV22UZi8/lo3FyV9Z0M=;
        b=Um1J26fNPIpDP4xLDrD/BjX9axtz6rAFMQkpcUxPsJyr0ZggiBz332ic5XD/fwA9de
         h8EUq9VrAWE4ttqr3mQBstsf/yvpNDmeIcDV5IoZe+37HWUekeH8f8z4Ozmks/3U3wkB
         5UYVK1DYJyB5zya2NguL7VO9nLmAB4D1xMlviPYNgHz2KJao1vIgmzzG+yRRwBAlOaQh
         JD5B+nz9HnYL/GZDiyTgNbG71j++9dKwcj4YAADxuc6+chu6GYc9Zac/l0GFSkbpQiTD
         7c66pk7gEFw+feEJ16R0Jj39dQFfEC5buYyFa3u+bzT9rbjulZ9gwpWwafnzSrSK+xoh
         ZeqA==
X-Gm-Message-State: AOAM532KVEz9lYVudvZCP75xPBj5yqaJi+VpY4MC12213rSM4k+Yag8W
        vx7a3z7tgFzrItkCr1L7lC+eLv3z
X-Google-Smtp-Source: ABdhPJwYmYnit5cMV65zuLXeR0br8cosu5o0N0iSKjBRBAYLEUD3rex5BOyG3CRu4W3lpXPDY4Xcbg==
X-Received: by 2002:a17:906:8157:: with SMTP id z23mr32137427ejw.349.1594247180917;
        Wed, 08 Jul 2020 15:26:20 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:8478:3ba8:10ed:37ab])
        by smtp.gmail.com with ESMTPSA id h10sm565656eds.0.2020.07.08.15.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 15:26:20 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] h8300: add minimal support
Date:   Thu,  9 Jul 2020 00:24:58 +0200
Message-Id: <20200708222458.56909-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

This is now the only architecture needing '-msize-long'.

Prepare the obsolescence of this option by adding the
target file for this architecture.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile       |  1 +
 machine.h      |  1 +
 target-h8300.c | 27 +++++++++++++++++++++++++++
 target.c       |  2 ++
 target.h       |  1 +
 5 files changed, 32 insertions(+)
 create mode 100644 target-h8300.c

diff --git a/Makefile b/Makefile
index 35098940080b..d7cfe4f5c4f6 100644
--- a/Makefile
+++ b/Makefile
@@ -73,6 +73,7 @@ LIB_OBJS += target-arm.o
 LIB_OBJS += target-arm64.o
 LIB_OBJS += target-bfin.o
 LIB_OBJS += target-default.o
+LIB_OBJS += target-h8300.o
 LIB_OBJS += target-m68k.o
 LIB_OBJS += target-microblaze.o
 LIB_OBJS += target-mips.o
diff --git a/machine.h b/machine.h
index 7407e71627e1..1b8b862a5175 100644
--- a/machine.h
+++ b/machine.h
@@ -34,6 +34,7 @@ enum machine {
 	MACH_S390,	MACH_S390X,
 	MACH_ALPHA,
 	MACH_BFIN,
+	MACH_H8300,
 	MACH_M68K,
 	MACH_MICROBLAZE,
 	MACH_NIOS2,
diff --git a/target-h8300.c b/target-h8300.c
new file mode 100644
index 000000000000..47872b38a1ad
--- /dev/null
+++ b/target-h8300.c
@@ -0,0 +1,27 @@
+#include "symbol.h"
+#include "target.h"
+#include "machine.h"
+
+
+static void init_h8300(const struct target *self)
+{
+	ssize_t_ctype = &long_ctype;
+	size_t_ctype = &ulong_ctype;
+	wchar_ctype = &ushort_ctype;
+}
+
+static void predefine_h8300(const struct target *self)
+{
+	predefine("__H8300H__", 1, "1");
+}
+
+const struct target target_h8300 = {
+	.mach = MACH_H8300,
+	.bitness = ARCH_LP32,
+	.big_endian = true,
+
+	.bits_in_longdouble = 64,
+
+	.init = init_h8300,
+	.predefine = predefine_h8300,
+};
diff --git a/target.c b/target.c
index e512f7f1b618..b39661515005 100644
--- a/target.c
+++ b/target.c
@@ -61,6 +61,7 @@ static const struct target *targets[] = {
 	[MACH_ARM] =		&target_arm,
 	[MACH_ARM64] =		&target_arm64,
 	[MACH_BFIN] =		&target_bfin,
+	[MACH_H8300] =		&target_h8300,
 	[MACH_I386] =		&target_i386,
 	[MACH_M68K] =		&target_m68k,
 	[MACH_MICROBLAZE] =	&target_microblaze,
@@ -92,6 +93,7 @@ enum machine target_parse(const char *name)
 		{ "arm64",	MACH_ARM64,	64, },
 		{ "arm",	MACH_ARM,	32, },
 		{ "bfin",	MACH_BFIN,	32, },
+		{ "h8300",	MACH_H8300,	32, },
 		{ "i386",	MACH_I386,	32, },
 		{ "m68k",	MACH_M68K,	32, },
 		{ "microblaze",	MACH_MICROBLAZE,32, },
diff --git a/target.h b/target.h
index 8f79426c096a..45ee40f1ca12 100644
--- a/target.h
+++ b/target.h
@@ -85,6 +85,7 @@ extern const struct target target_alpha;
 extern const struct target target_arm;
 extern const struct target target_arm64;
 extern const struct target target_bfin;
+extern const struct target target_h8300;
 extern const struct target target_m68k;
 extern const struct target target_microblaze;
 extern const struct target target_mips32;

base-commit: bb372492c40d71cc27952e815612db36aadf65bb
-- 
2.27.0

