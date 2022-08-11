Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F37CC19F2D
	for <linux-sparse@archiver.kernel.org>; Thu, 11 Aug 2022 05:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233695AbiHKFeN (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 11 Aug 2022 01:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233601AbiHKFeM (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 11 Aug 2022 01:34:12 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38F389CE1
        for <linux-sparse@vger.kernel.org>; Wed, 10 Aug 2022 22:34:11 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id f28so15633019pfk.1
        for <linux-sparse@vger.kernel.org>; Wed, 10 Aug 2022 22:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:from:to:cc;
        bh=poL32i9FN8BXa/T55NDTTeBSufDN57FtVvyoUXTIZXY=;
        b=SzQAomMSDEIhrkI6KoKaqeCRnWrinhQtAzbMhBnsWo1q6z/RkC6Qg7+DLU1UiYUT4x
         lceFwxgEc1VnIUoko3Ug7BhbtSDtT1KMtq++mP3AfB0rPh73NWzRUMbJ7W6pY0eqPe/m
         D3jj6JUcOhk/oGonpMvZqxR4M3+nmoVDw9PNWJfve0FbFxNj4YgNji9YaMVkdMalyRLr
         011tEOGwcIzSeZa6eif537fA3GNk1Pj45GaVQqgjjJoEJ41fWIjgPAH89pgqqFwwgI1o
         zfyZR2/h4ytb2M2QE6fHi95NWmN/l8BtNvv6H2ZMerdSPCymyaColJ0VcECoVlAfVkn8
         KNjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:x-gm-message-state:from:to:cc;
        bh=poL32i9FN8BXa/T55NDTTeBSufDN57FtVvyoUXTIZXY=;
        b=X1aTdtLLR9rjFhmQM4vGv2zriMJg+7hvEGjcoG0+H5dV/veEa+TGaw/jiACqaFhN20
         cne/VCmBZRxLn0XZFISGKGpOHRe2d60Li5FltdIhNAGcehS0YIoLN87qHV7K8YjQ2fsM
         0UADmFggvF69HYtrddIgpHsP8t0/CbqpJaT09KKpQVjhezQ0AmEXxVkq0Ux52ZypLDIu
         hVtTowtwlQWCgcosB+o4zvAnQXTc3tUJUDK6A+nuVxZR+o49GL4TY1hR28XP/b5o9Pf/
         VHsK1PEW1MEKaoRd+SgOkOyDRXpcU+lqa3+11wttFT4sswBpgBSITmGcCIWjQd5UjZyr
         tXkg==
X-Gm-Message-State: ACgBeo0BFVgE5BzwzqbGjKq7HEFC0Z/ztTUjst/k9it7/mvdkKN4zgJv
        u6xYz+wD5Jeqjdp71TcbEU8wBQ==
X-Google-Smtp-Source: AA6agR6AUGf4FgTencb0cYu56kNBFFxigYmYR8S7HPDF6UghtndchYFD5IxGrRtErgGQ2zJH/AqKOA==
X-Received: by 2002:a65:6151:0:b0:412:e419:d651 with SMTP id o17-20020a656151000000b00412e419d651mr25616408pgv.378.1660196051327;
        Wed, 10 Aug 2022 22:34:11 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id r24-20020aa79638000000b0052ad6d627a6sm2991872pfg.166.2022.08.10.22.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 22:34:11 -0700 (PDT)
Subject: [PATCH] RISC-V: Add support fo the zihintpause extension
Date:   Wed, 10 Aug 2022 22:29:57 -0700
Message-Id: <20220811052957.16634-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     luc.vanoostenryck@gmail.com, linux-sparse@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

This was recently added to binutils and with any luck will soon be in
Linux, without it sparse will fail when trying to build new kernels on
systems with new toolchains.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
I re-indented the other extensions to match, and this one is on top of
the Zicbom patch as I figured that'd be easier.
---
 target-riscv.c | 50 +++++++++++++++++++++++++++-----------------------
 1 file changed, 27 insertions(+), 23 deletions(-)

diff --git a/target-riscv.c b/target-riscv.c
index db0f7e57..23d28d0e 100644
--- a/target-riscv.c
+++ b/target-riscv.c
@@ -5,21 +5,22 @@
 #include <string.h>
 #include <stdio.h>
 
-#define RISCV_32BIT	(1 << 0)
-#define RISCV_64BIT	(1 << 1)
-#define RISCV_MUL	(1 << 2)
-#define RISCV_DIV	(1 << 3)
-#define RISCV_ATOMIC	(1 << 4)
-#define RISCV_FLOAT	(1 << 5)
-#define RISCV_DOUBLE	(1 << 6)
-#define RISCV_FDIV	(1 << 7)
-#define RISCV_COMP	(1 << 8)
-#define RISCV_EMBD	(1 << 9)
-#define RISCV_FPU	(RISCV_FLOAT|RISCV_DOUBLE|RISCV_FDIV)
-#define RISCV_GENERIC	(RISCV_MUL|RISCV_DIV|RISCV_ATOMIC|RISCV_FPU)
-#define RISCV_ZICSR	(1 << 10)
-#define RISCV_ZIFENCEI	(1 << 11)
-#define RISCV_ZICBOM	(1 << 12)
+#define RISCV_32BIT		(1 << 0)
+#define RISCV_64BIT		(1 << 1)
+#define RISCV_MUL		(1 << 2)
+#define RISCV_DIV		(1 << 3)
+#define RISCV_ATOMIC		(1 << 4)
+#define RISCV_FLOAT		(1 << 5)
+#define RISCV_DOUBLE		(1 << 6)
+#define RISCV_FDIV		(1 << 7)
+#define RISCV_COMP		(1 << 8)
+#define RISCV_EMBD		(1 << 9)
+#define RISCV_FPU		(RISCV_FLOAT|RISCV_DOUBLE|RISCV_FDIV)
+#define RISCV_GENERIC		(RISCV_MUL|RISCV_DIV|RISCV_ATOMIC|RISCV_FPU)
+#define RISCV_ZICSR		(1 << 10)
+#define RISCV_ZIFENCEI		(1 << 11)
+#define RISCV_ZICBOM		(1 << 12)
+#define RISCV_ZIHINTPAUSE	(1 << 13)
 
 static unsigned int riscv_flags;
 
@@ -35,14 +36,15 @@ static void parse_march_riscv(const char *arg)
 		{ "rv64i",	RISCV_64BIT },
 		{ "rv64g",	RISCV_64BIT|RISCV_GENERIC },
 	}, extensions[] = {
-		{ "m",		RISCV_MUL|RISCV_DIV },
-		{ "a",		RISCV_ATOMIC },
-		{ "f",		RISCV_FLOAT|RISCV_FDIV|RISCV_ZICSR },
-		{ "d",		RISCV_DOUBLE|RISCV_FDIV|RISCV_ZICSR },
-		{ "c",		RISCV_COMP },
-		{ "_zicsr",	RISCV_ZICSR },
-		{ "_zifencei",	RISCV_ZIFENCEI },
-		{ "_zicbom",	RISCV_ZICBOM },
+		{ "m",			RISCV_MUL|RISCV_DIV },
+		{ "a",			RISCV_ATOMIC },
+		{ "f",			RISCV_FLOAT|RISCV_FDIV|RISCV_ZICSR },
+		{ "d",			RISCV_DOUBLE|RISCV_FDIV|RISCV_ZICSR },
+		{ "c",			RISCV_COMP },
+		{ "_zicsr",		RISCV_ZICSR },
+		{ "_zifencei",		RISCV_ZIFENCEI },
+		{ "_zicbom",		RISCV_ZICBOM },
+		{ "_zihintpause",	RISCV_ZIHINTPAUSE },
 	};
 	int i;
 
@@ -135,6 +137,8 @@ static void predefine_riscv(const struct target *self)
 		predefine("__riscv_zifencei", 1, "1");
 	if (riscv_flags & RISCV_ZICBOM)
 		predefine("__riscv_zicbom", 1, "1");
+	if (riscv_flags & RISCV_ZIHINTPAUSE)
+		predefine("__riscv_zihintpause", 1, "1");
 
 	if (cmodel)
 		predefine_strong("__riscv_cmodel_%s", cmodel);
-- 
2.34.1

