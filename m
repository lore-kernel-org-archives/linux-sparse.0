Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE40BC433FE
	for <linux-sparse@archiver.kernel.org>; Sat,  2 Apr 2022 05:04:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245246AbiDBFF7 (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 2 Apr 2022 01:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245704AbiDBFFr (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 2 Apr 2022 01:05:47 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2712C47569
        for <linux-sparse@vger.kernel.org>; Fri,  1 Apr 2022 22:03:57 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id i11so4077311plg.12
        for <linux-sparse@vger.kernel.org>; Fri, 01 Apr 2022 22:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=iJ7fDikEqxd3GQyUocX9wfBcccairETEQwPSFnMPpXo=;
        b=g8LcAt61UEx9yt7MWyScZYveSn/vFYcCGkBunwwIdZQZcamvIemmUr4GO5W9ximu9q
         2D2FT4C1o5AuLuNgDZnYDJ3cvndbVlCs2U+YNvMlDM34B3RzGCkDCbaT3WHMXorHdSE2
         wvHt1PLakzKy0LfnlLUYzx/OcFAdxRldQI+6L3zJRu+Dqq/P0Zuc4uqdn87EUac9tjA/
         RmYM1shl9saPk3MfQ67VZK8b0jG0vqBhzdmlO9GL+kOsKCGueY1N+2MysOjGD31oFdgO
         s6G60n8XV6AN43A28FU0cuS2kgKZWtbTaolxj//q4EspOOHzV1ejh03himE4uANlF9ue
         OcDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=iJ7fDikEqxd3GQyUocX9wfBcccairETEQwPSFnMPpXo=;
        b=nget31aAy5BOpL7P6MqL3eZ/JS0KpmztiOD1SUgpfOVD+qQClnLJTW/J3QgKTWQbWi
         vdrEtXjbbu3yS9NdJQDTqFobKSuzCGQ4fTRIw9uZHKQkL9GkT9S1URWDosyTwAalTGQc
         2rf0n7fYTeReqkWrhnEAtXf+hdg6V2dKBztiJHn0m7VBhyOeWPx9q6fIWIThmqS7wPRa
         wEYJ/W/XQmlvkUe7xU7wXbA0Yb6pDll/tsNuCSQHv0OJu06snuf7B95xSjwK6UOYTY2D
         6/pPS0jULSfDc3jNGCYziLpQVMkS+DmNrb+rY6Mh/mB/Z0Dj18/g/Az4sXnYzPsTRzpy
         1+Og==
X-Gm-Message-State: AOAM533yPE58mxJo4Si2JvHhAxVByWB+70Pkf0W4fths9lnYknJucgpF
        q2OIZXPVI0PGuLGCZzmHJs/Cjg==
X-Google-Smtp-Source: ABdhPJwm12U+bQZZZiIWlcjUiM4qVbUHU8stSqN84SjntqT6rmw6vuOxTNzZ4EV5HsrEmwJM+5VehQ==
X-Received: by 2002:a17:90b:1b10:b0:1c7:3413:87e0 with SMTP id nu16-20020a17090b1b1000b001c7341387e0mr15537870pjb.132.1648875836629;
        Fri, 01 Apr 2022 22:03:56 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id v189-20020a622fc6000000b004fb72e95806sm4574382pfv.48.2022.04.01.22.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 22:03:56 -0700 (PDT)
Subject: [PATCH v1 4/6] RISC-V: Remove "g" from the extension list
Date:   Fri,  1 Apr 2022 22:00:39 -0700
Message-Id: <20220402050041.21302-5-palmer@rivosinc.com>
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

"g" goes along with the base ISA, but it was being treated as an
extension.  This allows for all sorts of odd ISA strings to be accepted
by sparse, things like "rv32ig" or "rv32gg".  We're still allowing
some oddities, like "rv32ga", but this one was easy to catch.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 target-riscv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target-riscv.c b/target-riscv.c
index 924259af..5076bbaf 100644
--- a/target-riscv.c
+++ b/target-riscv.c
@@ -36,7 +36,6 @@ static void parse_march_riscv(const char *arg)
 		{ "a",		RISCV_ATOMIC },
 		{ "f",		RISCV_FLOAT|RISCV_FDIV },
 		{ "d",		RISCV_DOUBLE|RISCV_FDIV },
-		{ "g",		RISCV_GENERIC },
 		{ "c",		RISCV_COMP },
 	};
 	int i;
-- 
2.34.1

