Return-Path: <SRS0=QtWi=BE=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74880C433E0
	for <linux-sparse@archiver.kernel.org>; Sat, 25 Jul 2020 20:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B05B206C1
	for <linux-sparse@archiver.kernel.org>; Sat, 25 Jul 2020 20:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBxP5dUD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbgGYU50 (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 25 Jul 2020 16:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbgGYU5Z (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 25 Jul 2020 16:57:25 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1ECC08C5C0
        for <linux-sparse@vger.kernel.org>; Sat, 25 Jul 2020 13:57:25 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id c2so3571300edx.8
        for <linux-sparse@vger.kernel.org>; Sat, 25 Jul 2020 13:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FKkiv33OXiJJWORmIfrTNvskFW0TVRYfOLljN0EIcoo=;
        b=KBxP5dUDHxRu5XoY8HzmELodgY6EK5SkQZyu9POG2T+xiAN7/7t+I2POFFBYUz07Hn
         4Byl298iGi/v7yPfKmcrFQlZ0YoJ2W4zwJ2S5IfgIfyVSuoDVua+LMTP8lJNJysimddw
         icUgARSeHj/v/UQID7bO8rtRa0Rf85wPIqtbytjN6fwxvznEPBsuFJn6aWF7xzHDekin
         LQPthmsYC9wLzrRrb9RX41PQrLFLywXOcgkmFPPC8EWGV4SHROTqlc97gbI/WVsWO9Es
         a15A9WnnefAs3fuwOEvRmttBDoLSwIQculKSYuQkvX3KsB09VMVTT1Kqwvb+CqxjRpYG
         kD/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FKkiv33OXiJJWORmIfrTNvskFW0TVRYfOLljN0EIcoo=;
        b=Lpaq7Xf3mYpbGbwGz910u6+Xt0YmYVNj5IPlMwiahYyHZWtGBeahK9XInBucMY2jLc
         kpg/F7UUF9A07dn5O3mORqakrHYY1kzqvxF8J6JjVrKI5PE06JPdznRoXR69vynXjf7t
         9xAK8TRVwTr8jqO3p2vOUQ+UNFIUeb8tpEtrCS+Y4lYkFGRgCrCbdog9s0RtpT9/Wyhd
         6dk/auFKmHCXOShsW2/VTpvMKD77y3EHMZxRP4bIXbYIUBLXfcnAJ5UiXOLhkFX7cwgw
         lxj7E/VCr70RX6vaCxVbcb20d5qAv0sQRqFRQG2wnnBeM09Nkj8Soh959vThBVw3wb1w
         YklA==
X-Gm-Message-State: AOAM533lBHOiAn5dOXMRMeyrdCNh47+3DNQTJ2XzmAVZvtwOyqWC58DA
        iXg83Zfs42BiIsMy+wK9EXTmGgfR
X-Google-Smtp-Source: ABdhPJwkio6kae8d8zMzhvxth6GoBA45Eb3U/W797eqzdeym8FCpMlZMTw2e+5I9E5+XpgGS1elcpA==
X-Received: by 2002:a50:e1cc:: with SMTP id m12mr7006885edl.378.1595710644149;
        Sat, 25 Jul 2020 13:57:24 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:385e:d385:2556:4c62])
        by smtp.gmail.com with ESMTPSA id p21sm317572eds.11.2020.07.25.13.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2020 13:57:23 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] xtensa: fix configuration of endianness
Date:   Sat, 25 Jul 2020 22:56:57 +0200
Message-Id: <20200725205657.73768-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Since gcc 3.4.0 there is no option to specify the endianness for
the Xtensa architecture, so the kernel relies on autodetecting
the endianness and then defining the macros __XTENSA_E{B,L}__.

But this means that sparse's 'arch_big_endian' can't be used
for the predefine.

So, do not predefine these macros anymore, they will transparently
be set directly from the command line.

Reported-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 target-xtensa.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/target-xtensa.c b/target-xtensa.c
index 26bda47f02f0..3620b4a311cc 100644
--- a/target-xtensa.c
+++ b/target-xtensa.c
@@ -17,11 +17,6 @@ static void predefine_xtensa(const struct target *self)
 {
 	predefine("__XTENSA__", 1, "1");
 	predefine("__xtensa__", 1, "1");
-
-	if (arch_big_endian)
-		predefine("__XTENSA_EB__", 1, "1");
-	else
-		predefine("__XTENSA_EL__", 1, "1");
 }
 
 const struct target target_xtensa = {
-- 
2.27.0

