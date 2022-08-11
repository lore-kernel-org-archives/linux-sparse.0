Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE58C25B0C
	for <linux-sparse@archiver.kernel.org>; Thu, 11 Aug 2022 05:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233601AbiHKFeO (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 11 Aug 2022 01:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233820AbiHKFeN (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 11 Aug 2022 01:34:13 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9E289CF4
        for <linux-sparse@vger.kernel.org>; Wed, 10 Aug 2022 22:34:13 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id z187so15591247pfb.12
        for <linux-sparse@vger.kernel.org>; Wed, 10 Aug 2022 22:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:from:to:cc;
        bh=poL32i9FN8BXa/T55NDTTeBSufDN57FtVvyoUXTIZXY=;
        b=jR2/6ctcNyoYEFcwVG66P1uVyxuP/qccFErns3cVN5tz4frOAp6gUyw3gtOJ10Er0g
         z/p+m9fvYrNLhLX2JGmg80bCJ/9b8F1Ys1Ndif+KdbbKs/J9J6efF0QDuvn9nww9J/+c
         N7+r6CZLsJojFtQas+QNVZXFxPAgdiVpAAhlk2CSMy9f57m+HxEFbH7KCqK+PG/Go/1k
         SZgR8oVTQvGR0WEUFAge1/Y4rRkbshccgNm17U/4Y9rxS6630io7gXM7YafBm65lbsn+
         xGcf1BG7Q6ZHELrPOZjWBPtjJr/KqpzeRUMVFuS/PywHCwK/LKR8jeiGVc5VotjAa32L
         u1jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:x-gm-message-state:from:to:cc;
        bh=poL32i9FN8BXa/T55NDTTeBSufDN57FtVvyoUXTIZXY=;
        b=Sy12/52bCnRV7vv+K6GJslenZKoeyKqSF0b+iHvYTrc0JjJ6HLfyyu3AqwojRwnMu8
         iJfbWopKYciIEK05nEUt/SO+DMqzI7VB4mPCu+ZAHKGnbsi6Z9pRXGR1BLQ5sQ9rsRhU
         SCP/m8L3YDKujbq1NwIA8S0J4mLlnTRo/P+yQWz6clLwx2Zf+q/XDo1TntkUWVbdRcXi
         +FI5MT3OWD9HFdsbdd7ALoGNFcEW0bZ6roff7ZDXPbPYL/bXRfsqgor7aTjJA57KCDOx
         phBLENTgOtbUlKOoWT3x6GAg6okxmP3l0qKLnlwPqn52ZwpshhAp6mjh5I4dq4ttow4g
         5igA==
X-Gm-Message-State: ACgBeo3kvT1pw3Ms8GnDasDnD2EAuGTIoyu4TyW786BfjEojb4shagxN
        50LTh300eT/0NtIZdyFTpL4xSw==
X-Google-Smtp-Source: AA6agR7rkjp1E1B6TnMPyy4dESnQkrruH0ALI6RPABrsOLVyRr6nNdvSCfPlOrhWV2EKFaxOveBNEA==
X-Received: by 2002:aa7:8c51:0:b0:528:2ed8:7e35 with SMTP id e17-20020aa78c51000000b005282ed87e35mr29774574pfd.13.1660196052481;
        Wed, 10 Aug 2022 22:34:12 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id 1-20020a621501000000b0052b9351737fsm3112894pfv.92.2022.08.10.22.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 22:34:12 -0700 (PDT)
Subject: [PATCH] RISC-V: Add support fo the zihintpause extension
Date:   Wed, 10 Aug 2022 22:33:56 -0700
Message-Id: <20220811053356.17375-1-palmer@rivosinc.com>
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

