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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1DECC433E0
	for <linux-sparse@archiver.kernel.org>; Wed,  8 Jul 2020 23:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E9EE20772
	for <linux-sparse@archiver.kernel.org>; Wed,  8 Jul 2020 23:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YfYmLRoP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgGHXmA (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 8 Jul 2020 19:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgGHXl7 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 8 Jul 2020 19:41:59 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F4AC061A0B
        for <linux-sparse@vger.kernel.org>; Wed,  8 Jul 2020 16:41:59 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id y10so306817eje.1
        for <linux-sparse@vger.kernel.org>; Wed, 08 Jul 2020 16:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wTDo4uiVP1Rg1rSnC2axBJHeU4i7bPp4soH7oKct6gY=;
        b=YfYmLRoP5PNjDqj3A2m5dn11KxfFRoBnPLtIxC6Zq+8iouWbr2Oy2UCqPNJ04KvhM5
         mX5ms5ZHe3x52NIxQwQftt4+xXghBwX1MVw/4gCYHRHer6BGF+qo5m2/3Rr+a65zKJfa
         ARIqvLX3kjQZWvTZJMJ2LsFt8DQlLOcRv6W3lpQDmsmGSN5JilILYqReQZ36M4kwbz/j
         FDGY0omPD/mJhWx6q+uukIGj9YZPMz49PXEBu0d0ubG0kP7PxdPngzd5BbLr8YEz0Eqh
         uPuq3Rl67Osjyn6jCSRa9B1e+daf/sx6jAm98cdiq0pp+L3uUPaenYsHu13oFb5oWUmq
         LtBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wTDo4uiVP1Rg1rSnC2axBJHeU4i7bPp4soH7oKct6gY=;
        b=bsLKAcjV8hbgha89i9wE89dRqiX7x82Zt7kHg1m1OeCIfKNi6oaFf71sJaIR9Pyflr
         waMNWGL/QchDq37qlDd6PY3q4DpF1R+XElLgKGO0m8WnGCYEhjmdw+MgsJ+MaTMMDNYF
         1snzdRCHbyzX5dRJMRbVz7ZAkTvrdQRmi1hR6LlQG8SpuK6w7xtSDJpVrIHuOgwOMn1l
         xEZzBHzQGD7bggWsoVzOIoB5GskcXRNqwPTSp8+454csgahRTPxkaVU211lssaHBwbrP
         CpcKk/1rH8+zyFxa31AhBh31PV1e9RRiAi5ImD3x/rOfLxIZHSgmX+KpnOf4Vitm/aVk
         uSRw==
X-Gm-Message-State: AOAM532MVcMy+p4YVvEvhTlhUH/5Z0VUShYIPdCIrLLm4xzXR4EV9ofa
        UqaW3F3Od5VXTnq0+oXVkZzMXz4V
X-Google-Smtp-Source: ABdhPJxkOWd+aahguQBMYMu0sPuUkIsZ7vGTaQNtlVFwo6eqvO3AhQQnGb9NKSB8lvE46O5lFcMK8Q==
X-Received: by 2002:a17:906:4acc:: with SMTP id u12mr29728973ejt.358.1594251717558;
        Wed, 08 Jul 2020 16:41:57 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:8478:3ba8:10ed:37ab])
        by smtp.gmail.com with ESMTPSA id z25sm616464ejd.38.2020.07.08.16.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 16:41:57 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/9] x86: reorg the target file
Date:   Thu,  9 Jul 2020 01:41:43 +0200
Message-Id: <20200708234151.57845-2-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200708234151.57845-1-luc.vanoostenryck@gmail.com>
References: <20200708234151.57845-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

More, specifically, split the 'init' method into a common part
and add one for each of the i386 (32-bit) and another one for 64-bit.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 target-x86.c | 52 +++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 17 deletions(-)

diff --git a/target-x86.c b/target-x86.c
index d770349c27e7..01117bb6ecc8 100644
--- a/target-x86.c
+++ b/target-x86.c
@@ -3,17 +3,28 @@
 #include "machine.h"
 
 
-static void init_x86(const struct target *target)
+static void predefine_i386(const struct target *self)
+{
+	predefine("__i386__", 1, "1");
+	predefine("__i386", 1, "1");
+	predefine_nostd("i386");
+}
+
+static void predefine_x86_64(const struct target *self)
+{
+	predefine("__x86_64__", 1, "1");
+	predefine("__x86_64", 1, "1");
+	predefine("__amd64__", 1, "1");
+	predefine("__amd64", 1, "1");
+}
+
+
+static void init_x86_common(const struct target *target)
 {
 	switch (arch_os) {
 	case OS_CYGWIN:
 		wchar_ctype = &ushort_ctype;
 		break;
-	case OS_DARWIN:
-		int64_ctype = &llong_ctype;
-		uint64_ctype = &ullong_ctype;
-		wint_ctype = &int_ctype;
-		break;
 	case OS_FREEBSD:
 		wint_ctype = &int_ctype;
 		break;
@@ -25,11 +36,9 @@ static void init_x86(const struct target *target)
 }
 
 
-static void predefine_i386(const struct target *self)
+static void init_i386(const struct target *target)
 {
-	predefine("__i386__", 1, "1");
-	predefine("__i386", 1, "1");
-	predefine_nostd("i386");
+	init_x86_common(target);
 }
 
 const struct target target_i386 = {
@@ -42,19 +51,28 @@ const struct target target_i386 = {
 	.bits_in_longdouble = 96,
 	.max_fp_alignment = 4,
 
-	.init = init_x86,
 	.target_64bit = &target_x86_64,
 
+	.init = init_i386,
 	.predefine = predefine_i386,
 };
 
 
-static void predefine_x86_64(const struct target *self)
+static void init_x86_64(const struct target *target)
 {
-	predefine("__x86_64__", 1, "1");
-	predefine("__x86_64", 1, "1");
-	predefine("__amd64__", 1, "1");
-	predefine("__amd64", 1, "1");
+	init_x86_common(target);
+
+	switch (arch_os) {
+	case OS_CYGWIN:
+		break;
+	case OS_DARWIN:
+		int64_ctype = &llong_ctype;
+		uint64_ctype = &ullong_ctype;
+		wint_ctype = &int_ctype;
+		break;
+	case OS_FREEBSD:
+		break;
+	}
 }
 
 const struct target target_x86_64 = {
@@ -67,8 +85,8 @@ const struct target target_x86_64 = {
 	.bits_in_longdouble = 128,
 	.max_fp_alignment = 16,
 
-	.init = init_x86,
 	.target_32bit = &target_i386,
 
+	.init = init_x86_64,
 	.predefine = predefine_x86_64,
 };
-- 
2.27.0

