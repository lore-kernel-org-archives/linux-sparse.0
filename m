Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6329FC433F5
	for <linux-sparse@archiver.kernel.org>; Sat,  2 Apr 2022 05:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbiDBFGB (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 2 Apr 2022 01:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343814AbiDBFFt (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 2 Apr 2022 01:05:49 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E69717FD09
        for <linux-sparse@vger.kernel.org>; Fri,  1 Apr 2022 22:03:59 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id b130so3845684pga.13
        for <linux-sparse@vger.kernel.org>; Fri, 01 Apr 2022 22:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=MOEc80EVu9LfPpN54gEHoEdN0FMqafE5/jJyB+b2mcQ=;
        b=jhrejZOdnoC3eyhsTj3pPDaw6LbO/PRUtVHyrItKfu/Hxp9RzGdFirr0W/I0tAJzd0
         mMjap3JgxYJgaFwpQ17fzCS+xLQgKSGj9OkIijYfvQaTPIKQmCI2S4gQMYAuKDfgPGvM
         oaYgqZLnRyyevysIfQO3LAH3EbF5I2NmQhcS5v1asdrgFTZqWb54rMjwGF+azI/uvh/a
         NLsoHR0z1lwC+C9d1qaN6P2KhMzf1QvrqYa/hK6h/j/96ThM0XZdFtLq7qG6afqM0S+o
         hx2h6oXYH11QU6oqmg/466YiTwH0MfGR78NXsKNSkH0Y2ovlVXpFRb1+oy0v2yoTjAQb
         i2fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=MOEc80EVu9LfPpN54gEHoEdN0FMqafE5/jJyB+b2mcQ=;
        b=jL7w9NAL7VIJGEtGvjHyuFLOnnBkf6P88UnYMkftRtk/9Rp/604ZtxNXVafUGVPC8I
         2D+QUa2pxoR7V4vZilf2SSKhKeILsAvhCqrmGrT42dsUx9YKO68YcikFsIiAzdV3tlBS
         4WKSBN/mxl+aEZUrYDQSOhKBm7oPcoPxgUKH76eSgO0nTh+vRKT0zq/901myhiTaem73
         LKhdU6A3zCibUnAf6HrRdwHC/ikwi3ciz3eLMSso+ztcn+5kby5/Piril01sMRtfBRed
         hN5DujqGBVwkhX6rTQE29ILyiOX8/dt+jKLt5zIWc19QSxj6mPg7G+QykiWuIiVHXB71
         XdRw==
X-Gm-Message-State: AOAM5314ty2BeMiNIEigYETC1tVXYDMZuOCPQDfEt7+WHVUNJwY63Ygc
        MtqQxZSa7tYGopfMhDpL2quJlQ==
X-Google-Smtp-Source: ABdhPJzjE4F5YlDo9VkfroSgEXumyc5+9wPltlUAM1k1EEn2FDmR+A5Gu8mTDmCCERRgBRQ+C5t9IQ==
X-Received: by 2002:a63:4c6:0:b0:385:f757:1e65 with SMTP id 189-20020a6304c6000000b00385f7571e65mr17993384pge.453.1648875837535;
        Fri, 01 Apr 2022 22:03:57 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id y30-20020a056a001c9e00b004fa9246adcbsm4376917pfw.144.2022.04.01.22.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 22:03:57 -0700 (PDT)
Subject: [PATCH v1 5/6] RISC-V: Add the Zicsr extension
Date:   Fri,  1 Apr 2022 22:00:40 -0700
Message-Id: <20220402050041.21302-6-palmer@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220402050041.21302-1-palmer@rivosinc.com>
References: <20220402050041.21302-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     linux-sparse@vger.kernel.org, Kito Cheng <kito.cheng@gmail.com>,
        linux-riscv@lists.infradead.org, mkl@pengutronix.de,
        aurelien@aurel32.net,
        Linus Torvalds <torvalds@linux-foundation.org>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Recent versions of binutils default to an ISA spec version that doesn't
include Zicsr as part of I, so Linux has recently started passing this
in -march.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 target-riscv.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/target-riscv.c b/target-riscv.c
index 5076bbaf..afd6fafa 100644
--- a/target-riscv.c
+++ b/target-riscv.c
@@ -17,6 +17,7 @@
 #define RISCV_EMBD	(1 << 9)
 #define RISCV_FPU	(RISCV_FLOAT|RISCV_DOUBLE|RISCV_FDIV)
 #define RISCV_GENERIC	(RISCV_MUL|RISCV_DIV|RISCV_ATOMIC|RISCV_FPU)
+#define RISCV_ZICSR	(1 << 10)
 
 static unsigned int riscv_flags;
 
@@ -34,9 +35,10 @@ static void parse_march_riscv(const char *arg)
 	}, extensions[] = {
 		{ "m",		RISCV_MUL|RISCV_DIV },
 		{ "a",		RISCV_ATOMIC },
-		{ "f",		RISCV_FLOAT|RISCV_FDIV },
-		{ "d",		RISCV_DOUBLE|RISCV_FDIV },
+		{ "f",		RISCV_FLOAT|RISCV_FDIV|RISCV_ZICSR },
+		{ "d",		RISCV_DOUBLE|RISCV_FDIV|RISCV_ZICSR },
 		{ "c",		RISCV_COMP },
+		{ "_zicsr",	RISCV_ZICSR },
 	};
 	int i;
 
@@ -128,6 +130,8 @@ static void predefine_riscv(const struct target *self)
 		predefine("__riscv_mul", 1, "1");
 	if ((riscv_flags & RISCV_MUL) && (riscv_flags & RISCV_DIV))
 		predefine("__riscv_muldiv", 1, "1");
+	if (riscv_flags & RISCV_ZICSR)
+		predefine("__riscv_zicsr", 1, "1");
 
 	if (cmodel)
 		predefine_strong("__riscv_cmodel_%s", cmodel);
-- 
2.34.1

