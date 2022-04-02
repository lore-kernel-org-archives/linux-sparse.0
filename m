Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5835C433EF
	for <linux-sparse@archiver.kernel.org>; Sat,  2 Apr 2022 05:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243565AbiDBFFu (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 2 Apr 2022 01:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbiDBFFr (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 2 Apr 2022 01:05:47 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6561400B
        for <linux-sparse@vger.kernel.org>; Fri,  1 Apr 2022 22:03:56 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id i11so4077294plg.12
        for <linux-sparse@vger.kernel.org>; Fri, 01 Apr 2022 22:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=JxE+RWEW+46zWhCkShHjyZUwP7jLdproVcOpdmDQ50o=;
        b=Cb9ifftuOEg4bNIrtw2PRgGNZ2zu7j48jLZDwdofAi6CqwlcsmMdIa0SaqlgRhbOOq
         zsIqhzxJ2u4/ygwb7x/QX14/1Gspc9EPZJoLcajTf8Qe9zHhirHZIhy4HlqO6RHVBzgc
         rk9eJX1QjVcTGG+s4XKQDgZtN0oF81PqWi12GvRAJnSChbE2F/Y0QBm9hN4/u8BMsQqn
         jCCfmmnN+U9SKeQf5puP9YF8npNbzY2wxmxxLuXugpWdx63XAh0gh7AT2ZZDasBlH+7A
         jv6LM/DJ7lQsDvtFWuKxYg0MT3fOqtiU/HG9FRAoTf3BOglfLdNnHvfnKH8oohOpTfGW
         iHHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=JxE+RWEW+46zWhCkShHjyZUwP7jLdproVcOpdmDQ50o=;
        b=BtAb4pltpAQyPYdYBO0uxxX1f8djaIgdyjf8N8gtLODbkapJzYvO+7bTt9/VU7AvSq
         aOVrL475Qleg3MFia8pKEhj+a9rbBCH9Xr+XPTt6/8gHjPBgX+JSNUPBWiEEm7EGZPzd
         hBLAhRHKxBeQtv0wkvleD1GgW1bDn+T0Epp6ia5EEGoep1O4ED0sCHoCk4wJU1bNByW+
         z/HVvpqoaepRlGMgTBvLMw7jf3htftLFSOVcPEwpDIr7dV2i/ymoGGWDB234EtPAxkvP
         lVhe8JeIIl9UNJHzbByuE3yR9eQWYS5xoguzskj1xUfZA/wJEWM0WJgVLpx0Vsx0sTi8
         eHgQ==
X-Gm-Message-State: AOAM533+ExzXPdBJy4TA20+uW3FovUHnTPsdTdc6ElUb7wDmJ7Sysk0y
        RiGbjp5jb15fwmbHW3/pnYL9dg==
X-Google-Smtp-Source: ABdhPJzb7WbfvbooQaPrSRud7psH6IEeYzSpvZX8Dk+vvYhoItvyyDWEmMngwytzbryJWGpSKer4Qg==
X-Received: by 2002:a17:902:ef47:b0:156:646b:58e7 with SMTP id e7-20020a170902ef4700b00156646b58e7mr7741339plx.57.1648875835762;
        Fri, 01 Apr 2022 22:03:55 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id w129-20020a628287000000b004fdc453b49asm4790103pfd.39.2022.04.01.22.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 22:03:55 -0700 (PDT)
Subject: [PATCH v1 3/6] RISC-V: Remove the unimplemented ISA extensions
Date:   Fri,  1 Apr 2022 22:00:38 -0700
Message-Id: <20220402050041.21302-4-palmer@rivosinc.com>
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

This made sense when we die()d on unknown ISA extensions, but now that
we're just warning it's actually a bit detrimental: users won't see that
their unimplemented ISA extensions are silently having the wrong
definitions set, which may cause hard to debug failures.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 target-riscv.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/target-riscv.c b/target-riscv.c
index 494c08db..924259af 100644
--- a/target-riscv.c
+++ b/target-riscv.c
@@ -37,17 +37,7 @@ static void parse_march_riscv(const char *arg)
 		{ "f",		RISCV_FLOAT|RISCV_FDIV },
 		{ "d",		RISCV_DOUBLE|RISCV_FDIV },
 		{ "g",		RISCV_GENERIC },
-		{ "q",		0 },
-		{ "l",		0 },
 		{ "c",		RISCV_COMP },
-		{ "b",		0 },
-		{ "j",		0 },
-		{ "t",		0 },
-		{ "p",		0 },
-		{ "v",		0 },
-		{ "n",		0 },
-		{ "h",		0 },
-		{ "s",		0 },
 	};
 	int i;
 
-- 
2.34.1

