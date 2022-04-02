Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F9EC433F5
	for <linux-sparse@archiver.kernel.org>; Sat,  2 Apr 2022 05:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343741AbiDBFFt (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 2 Apr 2022 01:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243565AbiDBFFq (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 2 Apr 2022 01:05:46 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3571401D
        for <linux-sparse@vger.kernel.org>; Fri,  1 Apr 2022 22:03:55 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id n18-20020a17090ade9200b001ca699ee462so116690pjv.3
        for <linux-sparse@vger.kernel.org>; Fri, 01 Apr 2022 22:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=2KqF8ajkBngCMtpzPUC01p5VZ7+wZvwkah/zYpqeQ7Y=;
        b=jsNsMmae2jOLgaWCtQBOMysvxCiEvJeN3Kqt2gLkzFoNtfya5LhsAFrcOn9mTRKUcG
         7QHMl6wtxR1gnHlglQxBLt59F4AVLKRlMsZXCyVK5Sqcf3OMz6RQ2TGbK0mU6MlyYoev
         qjwn8G+g3hs/D9dXJRYm6BZkCmYzmOECRwYyleE6fMaT6Pb1qffhQ/+N5uqS2PbXGTiY
         mEjFsG7rEFduksDbrHWg+H7a2SN/GVY0BoSw4i/0+acplxKV91bS0Gz8IkzFosonzMrK
         WojUMu7DAuiMnRFCaIbsCGNHuWkfaflcR9DTjju4nB3z2/zXOe2x8DwklNo5aMaL1HvC
         Xx+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=2KqF8ajkBngCMtpzPUC01p5VZ7+wZvwkah/zYpqeQ7Y=;
        b=Gi2sHQ4F0T8H4l7V/ZHhJS8wHxdwrBD/WPxSWAUnv5Zkr3EUUs6ZeJ7pvdrxT6gxIG
         ttLysSo+rw70318/iS/UbJPEo4dK8QMn/FLI64HoF/1/oIQapg/Rv/fgSYu4cf8CEo7j
         nU9MWIJXIoCm9xiXtjr7ELJbf1NRKmod9fBcWPkQTc/uIFPdyskHB3EcmEgn1ROOw6v9
         L1+vlv9i/SZCudfONs/5yt3kc603F4r+YkC0JCqw4HAD0PLhRLDSA0maebLBCom5SWUC
         /2rE61qMmFR+x4O1VyZ6yG4i0d6QxxjICGTayaSBfSo6dJQ7m4zqeKMejGGpnKzqE/RM
         menQ==
X-Gm-Message-State: AOAM531ROPhg8rht/PbhRvg/rdTZJioRCasO1MLNdlsbM7rdMhUKffhY
        CddVF68xw2vbdxkVW3KAysJOL/XZXRZ130CX
X-Google-Smtp-Source: ABdhPJwdkaakkxQ/XfHz+Vtz6Vw/XxCDC2112+bF4XSWnK3bNFCY8bZJf6lZ74ZtFui8xscFnZBM4g==
X-Received: by 2002:a17:90b:1bca:b0:1c9:b76f:8d76 with SMTP id oa10-20020a17090b1bca00b001c9b76f8d76mr15609934pjb.46.1648875834815;
        Fri, 01 Apr 2022 22:03:54 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id p3-20020a056a000b4300b004faee36ea56sm4750517pfo.155.2022.04.01.22.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 22:03:54 -0700 (PDT)
Subject: [PATCH v1 2/6] RISC-V: Match GCC's semantics for multiple -march instances
Date:   Fri,  1 Apr 2022 22:00:37 -0700
Message-Id: <20220402050041.21302-3-palmer@rivosinc.com>
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

GCC's semantics for "-march=X -march=Y" are that Y entirely overrides X,
but sparse takes the union of these two ISA strings.  This fixes the
behavior by setting, instead of oring, the flags whenever a base ISA is
encountered.  RISC-V ISA strings can only have a single base ISA, it's
not like x86 where the 64-bit ISA is an extension of the 32-bit ISA.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 target-riscv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target-riscv.c b/target-riscv.c
index f5cc6cc3..494c08db 100644
--- a/target-riscv.c
+++ b/target-riscv.c
@@ -56,7 +56,7 @@ static void parse_march_riscv(const char *arg)
 		size_t len = strlen(pat);
 
 		if (!strncmp(arg, pat, len)) {
-			riscv_flags |= basic_sets[i].flags;
+			riscv_flags = basic_sets[i].flags;
 			arg += len;
 			goto ext;
 		}
-- 
2.34.1

