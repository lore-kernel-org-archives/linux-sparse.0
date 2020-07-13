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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A354C433DF
	for <linux-sparse@archiver.kernel.org>; Mon, 13 Jul 2020 22:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78F8A20DD4
	for <linux-sparse@archiver.kernel.org>; Mon, 13 Jul 2020 22:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JhI2L/Fn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbgGMWdS (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 13 Jul 2020 18:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbgGMWdR (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 13 Jul 2020 18:33:17 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7C8C061755
        for <linux-sparse@vger.kernel.org>; Mon, 13 Jul 2020 15:33:16 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id a1so9734646edt.10
        for <linux-sparse@vger.kernel.org>; Mon, 13 Jul 2020 15:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PYeNADQPBpM9u+rFh8J9FhNBQ2UpyHrJlgeDfOKAop0=;
        b=JhI2L/FnD3kgqupuoP4xkAKCahRkdCJ5uf+ht0cnEKmbs4rUIBMOOQgGehcZgnzLAb
         YmJikv2iruL/3inzCmWExNs47I5cYQKXyXDCl0EDJ/X+HyCFnrUiJL7knDxrBvgYY2Y+
         55120aGKPnKmICl/YVEdoR9rE1zgGcaPvqqK9kJ3oDCIqBsMBnO+KFjyLBIbqtZyniI+
         x3r2DdkgcjSmRXZoBNishgGJhinJ5+7zMr1N+WKm7viZMVTVbgPKoDtjjpKT3d2RtcPS
         XrASkcXrpc+oR5hvrvXtPEVzxF9kWKAcfD7ISgZC+aktM7eh/SI3g7E76K8HiHJfYgZH
         g97w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PYeNADQPBpM9u+rFh8J9FhNBQ2UpyHrJlgeDfOKAop0=;
        b=ZLoNlSp0SUkumr2/+l+wlx/TwXBXIaiU6hFNiOQibas0LjDLbveij0i8x5sxvk1Q7Q
         ImO4b+wa7ouqME5iwJB9axiLXxvDrdVrbk528J0j8WWlnaN4xk4oNIC4NT8DOLrUziSM
         8ctixKEsJSW1CFwaLyu/mHrHnQilu/Nnf8qeu5stHufTO0Vmw+dPucSXdW03XeFWNFyw
         3W5ZLOcKitliXhq6VL6xvC2v8fHhQ+j4CbSCcQhk6Ft8VEgZaIS7Q00scNyVZy04hYWs
         K/FGbhZ7dx/ptyS+lKTwLtm35xkppUKvAmC1T6ZbKXD/vhmjtWZ1LayBtJI2zDocZu34
         FvPA==
X-Gm-Message-State: AOAM532ilFTIdCFlqeJiTez9BjiWjO3+bKd265LT4HbYGIaPejqcAAJy
        je+5U9nHN+93tEZX+HwJRDv/Tps/
X-Google-Smtp-Source: ABdhPJwl9VQqsDdhuBxEpeLLKL8wjs56r3hzlXl8HcvlHbf2JLuPQoit20FFT9R6l2C1T8hYDyGTXA==
X-Received: by 2002:a50:e60d:: with SMTP id y13mr1495693edm.225.1594679595339;
        Mon, 13 Jul 2020 15:33:15 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:64:f40c:5c10:8e2d])
        by smtp.gmail.com with ESMTPSA id y7sm10792431ejd.73.2020.07.13.15.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 15:33:14 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 9/9] predefine: let predefine_width() take the usual interface
Date:   Tue, 14 Jul 2020 00:33:03 +0200
Message-Id: <20200713223304.83666-10-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200713223304.83666-1-luc.vanoostenryck@gmail.com>
References: <20200713223304.83666-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

All the helpers for type-related predefines directly take in
argument the pointer to the type. All but predefine_width().
This must be an historical relic.

So, let predefine_width() to also take the pointer to the type
in argument.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 predefine.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/predefine.c b/predefine.c
index 7120d4381f16..f898cdfa39b8 100644
--- a/predefine.c
+++ b/predefine.c
@@ -25,12 +25,12 @@ static void predefined_sizeof(const char *name, const char *suffix, unsigned bit
 	predefine(buf, 1, "%d", bits/8);
 }
 
-static void predefined_width(const char *name, unsigned bits)
+static void predefined_width(const char *name, struct symbol *type)
 {
 	char buf[32];
 
 	snprintf(buf, sizeof(buf), "__%s_WIDTH__", name);
-	predefine(buf, 1, "%d", bits);
+	predefine(buf, 1, "%d", type->bit_size);
 }
 
 static void predefined_max(const char *name, struct symbol *type)
@@ -78,7 +78,7 @@ static void predefined_ctype(const char *name, struct symbol *type, int flags)
 	if (flags & PTYPE_TYPE)
 		predefined_type(name, type);
 	if (flags & PTYPE_WIDTH)
-		predefined_width(name, bits);
+		predefined_width(name, type);
 }
 
 void predefined_macros(void)
-- 
2.27.0

