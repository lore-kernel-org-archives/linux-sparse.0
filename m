Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E26BAC433E9
	for <linux-sparse@archiver.kernel.org>; Wed, 10 Mar 2021 22:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFBCA64FC6
	for <linux-sparse@archiver.kernel.org>; Wed, 10 Mar 2021 22:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233209AbhCJWLP (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 10 Mar 2021 17:11:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233489AbhCJWLI (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 10 Mar 2021 17:11:08 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16AFC061574
        for <linux-sparse@vger.kernel.org>; Wed, 10 Mar 2021 14:11:07 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id l12so127338edt.3
        for <linux-sparse@vger.kernel.org>; Wed, 10 Mar 2021 14:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WukwxrAgEZQS4XHFx5UY3Y0yVGYgz54qpKrVcDNDIU0=;
        b=px/cFI9ENfwQp81X4qc2g/cPjFONSAhvxzNzE1bH0z8NBEwOEcZ5cnTTFYb+kMGib2
         OHKvr8eGedScoMl1LDceRypP1AwAuNKpadUdgpWX/c361dlThm53FLb7pdO8hPKH4T2W
         4uf2g/Jrp58tKsff/7BzhQQQ5Z+VGLIyWjuIYw3oely2CEm3Idx5ciZx/+Fi2YFlTU9e
         btT/ZT/KMI/+W7NnIz1pRYsKgPRKdw9GpJWCnsQB0SIJktpwICfCUAPlXyMqG9d3ukp7
         tipGMUIQYQ54ydmBbWQEctinpVPYjWNC3Rc4vDQ20ylj1kCs6KNjzuC38FBVt5Qku8hQ
         Aylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WukwxrAgEZQS4XHFx5UY3Y0yVGYgz54qpKrVcDNDIU0=;
        b=T6OLyBssru5G5hobbb8rwZbi7oeGyv+6HDdhoLRKzctWd4Ry6DstzKA3xpthizq1kd
         6WwIE5fnXbq6XyB0Pxhq0wAreeVyNsGS49oV2bBCDMGfA/J+JuQX3lCfZgT0dFqxoO1s
         nEYt5cFmy6rf/Aw4cCksNavciMS3qWxgz0p6ynZ8n10Esyhe5vRp71CJ0OdXaYysRJa/
         HbTsUYRXBacnJYrqok561cxHcmfuS00fTM9SQqCAqDs3H1FJuRonEyiiUdFRKT37uY6+
         dFCZPJ1tllvTG38EPxxpmhrkFRdKRtGoC6DgHFfcZxJLHwxVUFu0V/OvFnhOcAnSGx2n
         LWCQ==
X-Gm-Message-State: AOAM5305XF5rvaLaiTwRIkNKFn0MWUIvlGuHkRVTEorxmeP0XRV9lS4D
        Vh5WdwhZ3rEvODk745jwC0Em8NzANGA=
X-Google-Smtp-Source: ABdhPJzF9ipOL1aBwe7Qjp7i/zmKQCHevFwxEiMBxo4cg1GpaOk2t25W188BFv1Wqs3iIwJ25QgcKA==
X-Received: by 2002:a05:6402:22f6:: with SMTP id dn22mr5506909edb.214.1615414266779;
        Wed, 10 Mar 2021 14:11:06 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:196c:c08:d4ab:a1ba])
        by smtp.gmail.com with ESMTPSA id ld19sm344326ejb.102.2021.03.10.14.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 14:11:06 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 9/9] simplify (x | M) cmpu C
Date:   Wed, 10 Mar 2021 22:49:50 +0100
Message-Id: <20210310214950.84192-10-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210310214950.84192-1-luc.vanoostenryck@gmail.com>
References: <20210310214950.84192-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                  | 16 ++++++++++++++++
 validation/optim/cmpu-or0.c |  1 -
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/simplify.c b/simplify.c
index e721f9f860a0..9e3514d838a9 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1324,6 +1324,22 @@ static int simplify_compare_constant(struct instruction *insn, long long value)
 			if ((value & bits) != bits)
 				return replace_with_value(insn, 1);
 			break;
+		case OP_SET_B:
+			if (bits >= value)
+				return replace_with_value(insn, 0);
+			break;
+		case OP_SET_BE:
+			if (bits > value)
+				return replace_with_value(insn, 0);
+			break;
+		case OP_SET_AE:
+			if (bits > value)
+				return replace_with_value(insn, 1);
+			break;
+		case OP_SET_A:
+			if (bits >= value)
+				return replace_with_value(insn, 1);
+			break;
 		case OP_SET_LE:
 			value = sign_extend(value, def->size);
 			if (bits & sign_bit(def->size)) {
diff --git a/validation/optim/cmpu-or0.c b/validation/optim/cmpu-or0.c
index 77360d3feb0f..e97e91809461 100644
--- a/validation/optim/cmpu-or0.c
+++ b/validation/optim/cmpu-or0.c
@@ -12,7 +12,6 @@ int cmpu_ior_gt_lt(int a) { return ((a | MASK) >  (MASK - 1)) EQ(1); }
 /*
  * check-name: cmpu-or0
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-returns: 1
-- 
2.30.0

