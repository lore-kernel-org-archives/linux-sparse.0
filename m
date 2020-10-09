Return-Path: <SRS0=CK19=DQ=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08FE3C433DF
	for <linux-sparse@archiver.kernel.org>; Fri,  9 Oct 2020 16:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0E462227F
	for <linux-sparse@archiver.kernel.org>; Fri,  9 Oct 2020 16:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wq4UfMuZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389736AbgJIQ2a (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 9 Oct 2020 12:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389144AbgJIQ2a (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 9 Oct 2020 12:28:30 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15342C0613D2
        for <linux-sparse@vger.kernel.org>; Fri,  9 Oct 2020 09:28:30 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id p13so9976437edi.7
        for <linux-sparse@vger.kernel.org>; Fri, 09 Oct 2020 09:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hiPIHln4k0rftb9vSYWeQtExf1Juk8dwTWy/NblqH+0=;
        b=Wq4UfMuZtz+vL47zuweJ+J6/5dCI3xGrs7u7f4GYftq4OX6HO9+OAy18dzU9x512ZX
         2oTc9MoZWhKGQ+l1xX9/slm4ux0zG3RPTfSeerGleUTdmo6Qjdg7njdBlK3wIe+0i/Q6
         Shjxu/gla3gl1EcmVhd9C7JRF8VTAiGZ9zcttT7QP8PTg8Gjp10U1NmlD9z0vLWe2eJj
         5EJKPIotLoRZV9xcgPOQdOWlPettAlzPktbmePxIhp4GpnZnqabLNl4hRWsJWgafDhoW
         RCpGKg1IdULHZRiPmOVVEIZPgGMlCg8eWJbuQmCguTzy+5zg8dJRLegHgyIOYFemPbXu
         TfrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hiPIHln4k0rftb9vSYWeQtExf1Juk8dwTWy/NblqH+0=;
        b=Jrs6fVauGQEELx59I/uqtK+gx75Mkhs1ESsVNCNOYbR1EA4qbmCOVj4Q/ZpxgE/Vjv
         B7tMMICO9RCdpMSsDEcAQmG98dS6PcracTI9cf64azgSxSMMRgvpm6DHQT9aI4oOqyQT
         dX4baQSXmBFwj0mDCdqu879afbasmaHfOGAeg2LprBnn57lkPXY0+Bkwgt/oc2aJgQPX
         AXa031g9l/iq8TKLR8rkrVRfcw1xFpeuaEtPeD1CfTo20+cPSRq8N3IMDtznhJEKP5AR
         JXvfbX4JW8E1D2e/5vB+YGDQ4XpzxlIy/M3EQU4HzRR6jDH1+WeI/E4otH1+rJWzIlyQ
         zEWg==
X-Gm-Message-State: AOAM530vLV5+dt7kshvf0PjbTr2ycbmozqqa8RP865CaiQUkyL/5qHOF
        fs65LqYq1362bdfXHHklFM+tqdAw+qk=
X-Google-Smtp-Source: ABdhPJzan/5fX9KexQPtccdNqar3EGCs/eciohoXqVatw88W/MIIpNQXmu267C2jmdRgtMmk2O3sdg==
X-Received: by 2002:a05:6402:3184:: with SMTP id di4mr15732170edb.362.1602260908558;
        Fri, 09 Oct 2020 09:28:28 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:b916:75c5:e328:ad7c])
        by smtp.gmail.com with ESMTPSA id ce14sm6565093edb.25.2020.10.09.09.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 09:28:27 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Ilya Maximets <i.maximets@ovn.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] builtin: teach sparse about __builtin_ia32_pause()
Date:   Fri,  9 Oct 2020 18:28:25 +0200
Message-Id: <20201009162825.24498-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

This builtin is used by Open vSwitch, so teach Sparse about it.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 target-x86.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target-x86.c b/target-x86.c
index b7ff8f2ab4ed..9d82869a27b8 100644
--- a/target-x86.c
+++ b/target-x86.c
@@ -1,6 +1,7 @@
 #include "symbol.h"
 #include "target.h"
 #include "machine.h"
+#include "builtin.h"
 
 
 static void predefine_i386(const struct target *self)
@@ -39,6 +40,11 @@ static void init_x86_common(const struct target *target)
 	}
 }
 
+static const struct builtin_fn builtins_x86_common[] = {
+	{ "__builtin_ia32_pause", &void_ctype, 0, },
+	{ }
+};
+
 
 static void init_i386(const struct target *target)
 {
@@ -64,6 +70,7 @@ const struct target target_i386 = {
 
 	.init = init_i386,
 	.predefine = predefine_i386,
+	.builtins = builtins_x86_common,
 };
 
 
@@ -159,4 +166,5 @@ const struct target target_x86_64 = {
 
 	.init = init_x86_64,
 	.predefine = predefine_x86_64,
+	.builtins = builtins_x86_common,
 };
-- 
2.28.0

