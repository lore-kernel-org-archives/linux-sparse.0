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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32CD9C433E0
	for <linux-sparse@archiver.kernel.org>; Wed,  8 Jul 2020 21:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F97320772
	for <linux-sparse@archiver.kernel.org>; Wed,  8 Jul 2020 21:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqgvwxKf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgGHVsS (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 8 Jul 2020 17:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgGHVsS (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 8 Jul 2020 17:48:18 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D5DC061A0B
        for <linux-sparse@vger.kernel.org>; Wed,  8 Jul 2020 14:48:18 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id w16so59679ejj.5
        for <linux-sparse@vger.kernel.org>; Wed, 08 Jul 2020 14:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ck2eF3uwoIPgb8DIRtQUMU/tYiEWecjeHtZWn9LBa9Q=;
        b=dqgvwxKfGiKaNS9fpam+N5cmc+s0/xTwHqVy7D89SB+6K+DxpeoIANq+HjTMcK/4Ps
         nTgYn0Q9m+kTwMZBNgtY7RR8GCmXIdu7hO4fH58zU5d/1Z/hIg6plPmwEb1WNhyo2WyH
         D3HaB6xWTGylRaSUKNBeVVFcLNW8lIIIwUPf0ZmwxdoqiArENoakB0jguQpUYGFR4+HV
         NK4g3shxbtHzFaKHCTzPJnpP/Vq4baQjwya5Gi5+3Xtl2aDnz/v9ydYdLrpiCiEMVX/M
         S49F2oQAeKduyjlY7PXPhJLlLms2d27UuaSfU/EfYTnwr+Z5c5npp84iyHX81dZ0tWno
         TY9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ck2eF3uwoIPgb8DIRtQUMU/tYiEWecjeHtZWn9LBa9Q=;
        b=lArVBuzBvfBpWnM6aASkJy/teo8Vn96tG2DOG4mBSvySyh796ZAuYFV7ZXnvzUV3zM
         i7U/TJmVQaketIHFgpN4tZXNsVxwEjcOzX5KBwYH0gJOMRwjacPn3cdqNpyvHZ4pLh9M
         YmqY3zWgJ97Zh5whnHWAQRsWeNC+0hZxB+jmNIggj2cvSScBOCRQOFa1ym55+EwYNaOF
         BPSF/sOF2uV3/EuIC5CUsFScWMQwSJV0SG7jcVRafwaH+GeSrt64DJDA+40SSS2DOlq8
         mxDb8+hO9V2cQxuJzU5cZmWuQTpN+KCNqezx3jHlk0SYBFVtktjodNSyoX10A3ICVpA1
         jgZw==
X-Gm-Message-State: AOAM5323z6+76D+P4x+nbey7+l8shzPnU+Z2mLuHEisXn0w0Q4TNrBHV
        2xMYlWKpR2D3axpgXh2nvWh/f84o
X-Google-Smtp-Source: ABdhPJywLPjZlGshM+lz0Jspg9C8yq7N335MmbZ6TISBBmj3IwAWz/kTH7AxxLOlTM1NAHxd5R/kRw==
X-Received: by 2002:a17:906:6d4d:: with SMTP id a13mr29229974ejt.146.1594244896620;
        Wed, 08 Jul 2020 14:48:16 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:b1eb:f280:ff97:eab2])
        by smtp.gmail.com with ESMTPSA id l15sm450370ejd.100.2020.07.08.14.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 14:48:16 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/3] riscv: add the predefines for the extensions
Date:   Wed,  8 Jul 2020 23:48:09 +0200
Message-Id: <20200708214810.56214-4-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200708214810.56214-1-luc.vanoostenryck@gmail.com>
References: <20200708214810.56214-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The RISC-V architecture has some predefined macros
to specify which extensions are supported.

So, now that these extensions are known via the '-march'
options, add the corresponding predefines.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 target-riscv.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/target-riscv.c b/target-riscv.c
index 9431ebc9cabb..e7f2b03b821b 100644
--- a/target-riscv.c
+++ b/target-riscv.c
@@ -99,6 +99,25 @@ static void predefine_riscv(const struct target *self)
 	predefine("__riscv", 1, "1");
 	predefine("__riscv_xlen", 1, "%d", ptr_ctype.bit_size);
 
+	if (riscv_flags & RISCV_ATOMIC)
+		predefine("__riscv_atomic", 1, "1");
+	if (riscv_flags & RISCV_COMP)
+		predefine("__riscv_compressed", 1, "1");
+	if (riscv_flags & RISCV_DIV)
+		predefine("__riscv_div", 1, "1");
+	if (riscv_flags & RISCV_EMBD)
+		predefine("__riscv_32e", 1, "1");
+	if (riscv_flags & RISCV_FPU)
+		predefine("__riscv_flen", 1, "%d", (riscv_flags & RISCV_DOUBLE) ? 64 : 32);
+	if (riscv_flags & RISCV_FDIV)
+		predefine("__riscv_fdiv", 1, "1");
+	if (riscv_flags & RISCV_FDIV)
+		predefine("__riscv_fsqrt", 1, "1");
+	if (riscv_flags & RISCV_MUL)
+		predefine("__riscv_mul", 1, "1");
+	if ((riscv_flags & RISCV_MUL) && (riscv_flags & RISCV_DIV))
+		predefine("__riscv_muldiv", 1, "1");
+
 	if (cmodel)
 		predefine_strong("__riscv_cmodel_%s", cmodel);
 }
-- 
2.27.0

