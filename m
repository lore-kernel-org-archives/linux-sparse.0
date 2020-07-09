Return-Path: <SRS0=LZeG=AU=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D7BC433DF
	for <linux-sparse@archiver.kernel.org>; Thu,  9 Jul 2020 00:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CF2120739
	for <linux-sparse@archiver.kernel.org>; Thu,  9 Jul 2020 00:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQ6gMZeY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgGIA0x (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 8 Jul 2020 20:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgGIA0w (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 8 Jul 2020 20:26:52 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6ADC061A0B
        for <linux-sparse@vger.kernel.org>; Wed,  8 Jul 2020 17:26:52 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id dp18so350434ejc.8
        for <linux-sparse@vger.kernel.org>; Wed, 08 Jul 2020 17:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DDqJMWOp3Il1aidjmn+/77H4CApL3ucFuII+EbgZvu4=;
        b=VQ6gMZeYuKZ5/CH0vqZ8sBAPqDGgCjdYODyWz91gdX3eHpz1QZ7r03hwpXzgmT9u46
         DM9MHoXkvy3ZJMadAeu+N9PNn4LurXk3YCQPtvAZuuwrysACj+/XQEGvqGtCVRVzD8p3
         4vOd6w8/gh1BUWdCgLG9zScEfniCKznSkM0rej2hXU2lFrPoOQ63Og3yR35Fbe/0T+Wl
         W5W2ifxhKM1kKD25tGbRGe5aw27A5sgQHgr676Qi5e6S+JmWVZe4UBdiOYF7Ti6WVqAo
         7Frxr2Sa/CC8LjHSxfFyU5IXX35w/xSOX4IEVoU3att5T3JsNC4ryLxle/C1o0nDIcxf
         p7xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DDqJMWOp3Il1aidjmn+/77H4CApL3ucFuII+EbgZvu4=;
        b=YiFQt/xN/YKQB69hKILTpZpDZfiwbOUWvPFG5YN3wFXDdt27gkpmFBZuIzwxF76lZ9
         VJ0Vs19Swr4CmTJcfW/exgmA3QSjNYd3o4z0yK3SSX3BvVSPJmdVhlDoO5S9ClAlAFkY
         tQ6hK6aWsrMwN2dJ4V5wZo/vnTpdIu5dE/YnjSdypIA2Yl/6X5yDydMrHWZ06Ry7ncis
         zTThS5N76GFT2J7sgZHS19eMSQmjiVZVQFGMyqHforImrgIiRrEff7tSWEnlPgAjcf1z
         I3bRHtWFvRCTQSlyElectcOPWgfoGG8Zuugzxvhe9dbAKV4jeGx0DPTUOE1B01wfHouK
         9KHQ==
X-Gm-Message-State: AOAM531Zw46MIiSn56mkeJA56uLXreN33Z/tJ6Gq+SiaDeGY/omvLs7N
        RZ7FAM8ZjX/e0mI7C1eaZGT0cqa/
X-Google-Smtp-Source: ABdhPJwWq9hBDwpdtbibErKAA9nvmWY68Wn4R9dzTzMSsR1Z3zt1C1+4ngGx6vCVDjLj3JzIdBMtpA==
X-Received: by 2002:a17:907:212b:: with SMTP id qo11mr53222563ejb.452.1594254411137;
        Wed, 08 Jul 2020 17:26:51 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:8478:3ba8:10ed:37ab])
        by smtp.gmail.com with ESMTPSA id f17sm675742ejr.71.2020.07.08.17.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 17:26:50 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] xtensa: add minimal support
Date:   Thu,  9 Jul 2020 02:26:45 +0200
Message-Id: <20200709002645.62144-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

This is one of the architecture needing a specific predefine
set in order to correctly process byteorder.h.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile        |  1 +
 machine.h       |  1 +
 target-xtensa.c | 31 +++++++++++++++++++++++++++++++
 target.c        |  2 ++
 target.h        |  1 +
 5 files changed, 36 insertions(+)
 create mode 100644 target-xtensa.c

diff --git a/Makefile b/Makefile
index 35098940080b..8b68cb69c896 100644
--- a/Makefile
+++ b/Makefile
@@ -82,6 +82,7 @@ LIB_OBJS += target-riscv.o
 LIB_OBJS += target-s390.o
 LIB_OBJS += target-sparc.o
 LIB_OBJS += target-x86.o
+LIB_OBJS += target-xtensa.o
 LIB_OBJS += tokenize.o
 LIB_OBJS += unssa.o
 LIB_OBJS += utils.o
diff --git a/machine.h b/machine.h
index 7407e71627e1..22da9c781a8a 100644
--- a/machine.h
+++ b/machine.h
@@ -37,6 +37,7 @@ enum machine {
 	MACH_M68K,
 	MACH_MICROBLAZE,
 	MACH_NIOS2,
+	MACH_XTENSA,
 	MACH_UNKNOWN
 };
 
diff --git a/target-xtensa.c b/target-xtensa.c
new file mode 100644
index 000000000000..3e5781c86d82
--- /dev/null
+++ b/target-xtensa.c
@@ -0,0 +1,31 @@
+#include "symbol.h"
+#include "target.h"
+#include "machine.h"
+
+
+static void init_xtensa(const struct target *self)
+{
+	wchar_ctype = &long_ctype;
+}
+
+static void predefine_xtensa(const struct target *self)
+{
+	predefine("__XTENSA__", 1, "1");
+	predefine("__xtensa__", 1, "1");
+
+	if (arch_big_endian)
+		predefine("__XTENSA_EB__", 1, "1");
+	else
+		predefine("__XTENSA_EL__", 1, "1");
+}
+
+const struct target target_xtensa = {
+	.mach = MACH_XTENSA,
+	.bitness = ARCH_LP32,
+	.big_endian = true,
+
+	.bits_in_longdouble = 64,
+
+	.init = init_xtensa,
+	.predefine = predefine_xtensa,
+};
diff --git a/target.c b/target.c
index e512f7f1b618..f6203942a307 100644
--- a/target.c
+++ b/target.c
@@ -76,6 +76,7 @@ static const struct target *targets[] = {
 	[MACH_SPARC32] =	&target_sparc32,
 	[MACH_SPARC64] =	&target_sparc64,
 	[MACH_X86_64] =		&target_x86_64,
+	[MACH_XTENSA] =		&target_xtensa,
 	[MACH_UNKNOWN] =	&target_default,
 };
 const struct target *arch_target = &target_default;
@@ -105,6 +106,7 @@ enum machine target_parse(const char *name)
 		{ "sparc",	MACH_SPARC32,	0,  },
 		{ "x86_64",	MACH_X86_64,	64, },
 		{ "x86-64",	MACH_X86_64,	64, },
+		{ "xtensa",	MACH_XTENSA,	32, },
 		{ NULL },
 	};
 	const struct arch *p;
diff --git a/target.h b/target.h
index 8f79426c096a..839d8600758a 100644
--- a/target.h
+++ b/target.h
@@ -100,6 +100,7 @@ extern const struct target target_sparc32;
 extern const struct target target_sparc64;
 extern const struct target target_i386;
 extern const struct target target_x86_64;
+extern const struct target target_xtensa;
 
 /* target.c */
 extern const struct target *arch_target;

base-commit: bb372492c40d71cc27952e815612db36aadf65bb
-- 
2.27.0

