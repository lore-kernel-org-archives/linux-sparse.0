Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A978C433F5
	for <linux-sparse@archiver.kernel.org>; Sat,  2 Apr 2022 05:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237837AbiDBFFq (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 2 Apr 2022 01:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbiDBFFp (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 2 Apr 2022 01:05:45 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051AB1400B
        for <linux-sparse@vger.kernel.org>; Fri,  1 Apr 2022 22:03:54 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id i10-20020a17090a2aca00b001ca56c9ab16so553014pjg.1
        for <linux-sparse@vger.kernel.org>; Fri, 01 Apr 2022 22:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=jMnX9EwDk9B/aw5bO8HVu/sU4kD+BbpBPauEL2qiKx4=;
        b=ViQw8PLACBP3xKUfrnPxVyLuGlZYQyC8xj1oZnlBSUb7YXlWewI3dNZqJtdcZoL9B+
         KhEhDnvodyTLqs8kG986cVw+wV995en7vQ5K8QXbuWGcWxM754A/hkbK95MsSuAaqGtg
         mp/9ndPxm2y/4vED5DAbcuzPnDglFUmUHc48mxHa7nlhGFwgtSDa6GDEMiIJZwrRKOdM
         Hoej1k3LHvhIuQMv/tyrN2oeYejcN4VWNPwO3uz8N6P6QsDh/qrbnRj02EadoM8Zr9vj
         Nc6FoMwuJf4ljNJhGxMAcRrgyuRPL8aORM98amFNLejxWL2+vQ9yRZGl5wegcmpThfRQ
         4gPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=jMnX9EwDk9B/aw5bO8HVu/sU4kD+BbpBPauEL2qiKx4=;
        b=f2BHFjFQmSzVmEA13qflJXq9UaTIf23+A/Mk52BnHI5xIlu631EK68a9QdSSOSORTV
         Hcs3Ea5saaYEF6FPASerHFAp/9GJCZBt7ItwqHD3ta29ZaBBVCtyrspwbInkeMzn9AlI
         vLOT8QNER6HFb65lSKebECjbJrUnD/031X8HpjdwhCZawfcrI1qdZTd6FL4t3izM1g1R
         tGAYmtvI83jjHkBGYmRh181btVGah6EPUt+f9a4QUmL1gHYfqauG4aNuWm/vdxzyccQk
         6va3KV19f7cfIfwtTPhJbwDbKUNHtcEvXCVRctU5mWWQ6y/iJNxYgMjspEJw2LXtfOcE
         LpzQ==
X-Gm-Message-State: AOAM5326XWtLLZ65QwvHRmdnf3X7nsR6s5Hb+EiMk37lSrOqvukEkR4Y
        KpTr7sRjQReSatjEw631YQSvQA==
X-Google-Smtp-Source: ABdhPJz7SXTBVPKMIoy1/H98gQ1tDFCdG2zxWr503oWcC/rbFVxGf4XiFWtqqRKYYMzaFpyBxmDmVA==
X-Received: by 2002:a17:903:244e:b0:155:e4a0:bbf1 with SMTP id l14-20020a170903244e00b00155e4a0bbf1mr38668296pls.47.1648875833478;
        Fri, 01 Apr 2022 22:03:53 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id gt14-20020a17090af2ce00b001c701e0a129sm14905615pjb.38.2022.04.01.22.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 22:03:53 -0700 (PDT)
Subject: [PATCH v1 1/6] RISC-V: Respect -Wsparse-error for -march errors
Date:   Fri,  1 Apr 2022 22:00:36 -0700
Message-Id: <20220402050041.21302-2-palmer@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220402050041.21302-1-palmer@rivosinc.com>
References: <20220402050041.21302-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     linux-sparse@vger.kernel.org, Kito Cheng <kito.cheng@gmail.com>,
        linux-riscv@lists.infradead.org, mkl@pengutronix.de,
        aurelien@aurel32.net,
        Linus Torvalds <torvalds@linux-foundation.org>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Parsing RISC-V ISA strings is extremely complicated: there are many
extensions, versions of extensions, versions of the ISA string rules,
and a bunch of unwritten rules to deal with all the bugs that fell out
of that complexity.

Rather than forcing users to see an error when the ISA string parsing
fails, just stop parsing where we get lost.  Changes tend to end up at
the end of the ISA string, so that's probably going to work (and if
it doesn't there's a warning to true and clue folks in).

This does have the oddity in that "-Wsparse-error -march=..." behaves
differently than "-march... -Wsparse-error", but that's already the case
for "--arch=... -march=..." and "-march=... --arch=...".  Both
"-Wsparse-error" and "--arch" are sparse-specific arguments, so they're
probably both going to be in the same place.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 lib.h          |  5 +++++
 options.c      |  6 ------
 target-riscv.c | 16 ++++++++++++++--
 3 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/lib.h b/lib.h
index b96e3192..2c0d7116 100644
--- a/lib.h
+++ b/lib.h
@@ -125,6 +125,11 @@ enum phase {
 #define	PASS_OPTIM		(1UL << PASS__OPTIM)
 #define	PASS_FINAL		(1UL << PASS__FINAL)
 
+enum flag_type {
+	FLAG_OFF,
+	FLAG_ON,
+	FLAG_FORCE_OFF,
+};
 
 extern void add_pre_buffer(const char *fmt, ...) FORMAT_ATTR(1);
 extern void predefine(const char *name, int weak, const char *fmt, ...) FORMAT_ATTR(3);
diff --git a/options.c b/options.c
index 6704fc8d..41a98240 100644
--- a/options.c
+++ b/options.c
@@ -23,12 +23,6 @@
 # define __GNUC_PATCHLEVEL__ 0
 #endif
 
-enum flag_type {
-	FLAG_OFF,
-	FLAG_ON,
-	FLAG_FORCE_OFF
-};
-
 int die_if_error = 0;
 int do_output = 1;
 int gcc_major = __GNUC__;
diff --git a/target-riscv.c b/target-riscv.c
index 6d9113c1..f5cc6cc3 100644
--- a/target-riscv.c
+++ b/target-riscv.c
@@ -3,6 +3,7 @@
 #include "target.h"
 #include "machine.h"
 #include <string.h>
+#include <stdio.h>
 
 #define RISCV_32BIT	(1 << 0)
 #define RISCV_64BIT	(1 << 1)
@@ -60,7 +61,18 @@ static void parse_march_riscv(const char *arg)
 			goto ext;
 		}
 	}
-	die("invalid argument to '-march': '%s'\n", arg);
+
+unknown:
+	/*
+	 * This behaves like do_warn() / do_error(), but we don't have a
+	 * position so it's just inline here.
+	 */
+	fflush(stdout);
+	fprintf(stderr, "%s: invalid argument to '-march': '%s'\n",
+		Wsparse_error == FLAG_ON ? "error" : "warning", arg);
+	if (Wsparse_error == FLAG_ON)
+		has_error |= ERROR_CURR_PHASE;
+	return;
 
 ext:
 	for (i = 0; i < ARRAY_SIZE(extensions); i++) {
@@ -73,7 +85,7 @@ ext:
 		}
 	}
 	if (arg[0])
-		die("invalid argument to '-march': '%s'\n", arg);
+		goto unknown;
 }
 
 static void init_riscv(const struct target *self)
-- 
2.34.1

