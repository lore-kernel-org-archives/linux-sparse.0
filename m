Return-Path: <SRS0=w175=AY=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B39C433E1
	for <linux-sparse@archiver.kernel.org>; Mon, 13 Jul 2020 22:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27DB92089D
	for <linux-sparse@archiver.kernel.org>; Mon, 13 Jul 2020 22:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1GRHqiU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbgGMWdN (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 13 Jul 2020 18:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgGMWdL (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 13 Jul 2020 18:33:11 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8F3C061755
        for <linux-sparse@vger.kernel.org>; Mon, 13 Jul 2020 15:33:11 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id f12so19266973eja.9
        for <linux-sparse@vger.kernel.org>; Mon, 13 Jul 2020 15:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YqptpQoyUU0nrCtw/BWlXLGY0AcY1EzlZpqEzaO1DR8=;
        b=d1GRHqiUpfx+ffLRlwRYqpP2ToTg7jf+jKM5SPaB0YtC7e0SM4qOp7sUzuxzLyXlKG
         X7/usQ1u8DidGA63IVF/s/eRusEecBoLPYzVOf1gaHu6Zu/DxWxpRsuSUNrdSM3VEqqR
         dB+zIOvtLl74WK1LIp1TYvBb3OzjDAySV2N7Gqim5XJ6kHuBHwCg4E3KCdcZtkn4TaUL
         oainAPnaPySXkiyrfB9vyIEGpu8J96YfZ60XSk3x2ldSZ0LpmKpaPQJKqV1SXGCLoN/R
         hA54zcd7ris/PJ9wuWeWyG95kolDy18kNaA51l70Yyuv+X6mifGMSWapt2TYSwCutRWq
         uAbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YqptpQoyUU0nrCtw/BWlXLGY0AcY1EzlZpqEzaO1DR8=;
        b=mjbQnqRMHlyNuttFymeo9yucVpiSHi0GwceTt7DZpipDQm6dy7MEPw6hh2NMO/noyc
         KMlvN1SMDfydT7vFs/SblE0vhCDlphytSCji5fuer5rpwLwDqET2mFT+LLGqCAzX+wAE
         tCbj0hIcIZ2t3PhlmxfaUMBZHmcGBf1D/eZizgBhSa4SKea0l3mS6pHdm9jZG7ab2iS6
         Prb4ol5uekqiJe6YuQA+vWBleQ03/9OtzrksMvByNm2Fpb9sdodBmm4j3ZPK8r43UAok
         Hq5GDcaq8vxHE4A5mKozDqT5GsqXe7yYgVt8/mxkERbzYXEcAivDs341HstkRZi277as
         vJYw==
X-Gm-Message-State: AOAM533N75mh26l981JOwJlHhKQatsjVLax/Cb0OB0vn83+JVPY0u6SA
        fcerAs1xI6FMbQqv4mTNrkW7g2gx
X-Google-Smtp-Source: ABdhPJyisr4G+UAkqpwESZsyMWVHA8V5ECbLIaBDHIq0EDrufSs+ZCg0cVSpI3mSspB+paiopJJ8YQ==
X-Received: by 2002:a17:906:700f:: with SMTP id n15mr1890788ejj.390.1594679589792;
        Mon, 13 Jul 2020 15:33:09 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:64:f40c:5c10:8e2d])
        by smtp.gmail.com with ESMTPSA id y7sm10792431ejd.73.2020.07.13.15.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 15:33:09 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/9] alpha: has 64-bit long double & int128
Date:   Tue, 14 Jul 2020 00:32:56 +0200
Message-Id: <20200713223304.83666-3-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200713223304.83666-1-luc.vanoostenryck@gmail.com>
References: <20200713223304.83666-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Support for alpha was added in order to move the specific builtins
away from the common list without changing the defaults.

Improve the support for this arch by fixing a few specificities:
* support of 128-bit integers
* long doubles are 64-bit.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 target-alpha.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target-alpha.c b/target-alpha.c
index 3f582997eb96..4c622aec194f 100644
--- a/target-alpha.c
+++ b/target-alpha.c
@@ -24,6 +24,9 @@ static const struct builtin_fn builtins_alpha[] = {
 const struct target target_alpha = {
 	.mach = MACH_ALPHA,
 	.bitness = ARCH_LP64,
+	.has_int128 = 1,
+
+	.bits_in_longdouble = 64,
 
 	.predefine = predefine_alpha,
 	.builtins = builtins_alpha,
-- 
2.27.0

