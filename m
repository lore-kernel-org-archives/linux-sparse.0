Return-Path: <SRS0=6y8R=D2=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E3FBC43457
	for <linux-sparse@archiver.kernel.org>; Mon, 19 Oct 2020 16:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32E702225F
	for <linux-sparse@archiver.kernel.org>; Mon, 19 Oct 2020 16:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uM6i7j7F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730476AbgJSQMk (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 19 Oct 2020 12:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730320AbgJSQMk (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 19 Oct 2020 12:12:40 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705F2C0613CE
        for <linux-sparse@vger.kernel.org>; Mon, 19 Oct 2020 09:12:40 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id c22so14731892ejx.0
        for <linux-sparse@vger.kernel.org>; Mon, 19 Oct 2020 09:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j1mC+vuuKrENX6OtLeOV6YE0WyULOhU8pt82X6U/T5k=;
        b=uM6i7j7FQbzkaVZdKPHUEhHil6lfSB9jx08NZUU2cCIOnjSdFZZUwQiBfwGPaULZjY
         xTkTPkOlH1pTc6o1n0OXopZ7Rzk73S2IXG2PICcaLoZd3ZyzfFpEZ4U8qwOuSupth1Py
         rBgsaQLKgFI8fTqutwA7/U3s/xBFSMhmAsyuGOkT/hHpM+y8kvur8REoigPwXT+8D3NB
         70Xr4tGLidFAh61Gh2qE19VGPteH0t2Ms3R/uhnk4mZjB++wJrA9Et3Ec+kgz/ZsKOW4
         dRP0GK1KICNhu2GuD+aLN/yIGV7sHZUJ1dJh/1DZGB1ZlX8Uv9B8fvntyJCKz+AUo8ZN
         FMMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j1mC+vuuKrENX6OtLeOV6YE0WyULOhU8pt82X6U/T5k=;
        b=gx4iyvm/Uw+WFO5ROXAiRYUzTQR4gRc4RmNoCoBq0xnPlz/gl+PygA5/gAmbRX138g
         ZXjnqq1cA1uj9hZ43+b3TPnf+6Wp9QDDJMJHTjSwk2o24CFQ2PsIf1eciQ6ApvOoqQc7
         cgV/2BKxhl3/Kf4uVTXdq3tVWxtVfl/j3YovP84gZCD4WmLsu91komjZzaXEDZ+fkVYt
         cJ/aOEweLF1s8iL5Djwxcorkk15kv7oRXSwdK8DSPz5SOskWFOnTprZIMVU5OLCteJCw
         my3kzWHBHxhMC/5gWAxN9zyPf7tNFl8IQ33WkB0KQqZdMiWN3lpBvsav1UKp7lUePHRo
         RbWw==
X-Gm-Message-State: AOAM532fAlIBO/ypLn6Lhx7KDPw9N6bIEor+gHgVnhh3fCxYOMTyGb0u
        VbDR8+rHa3dHAmOyGnmJU28PrVCLPMg=
X-Google-Smtp-Source: ABdhPJweKSSWzLzGJZ1db1jh79Axif2hLIod5rbYUDdT+GAbWkfsFsnyiZTMCh1OFAqzHYT5kCPPZw==
X-Received: by 2002:a17:906:400b:: with SMTP id v11mr566044ejj.421.1603123958968;
        Mon, 19 Oct 2020 09:12:38 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:d505:a252:4cc1:d15d])
        by smtp.gmail.com with ESMTPSA id r24sm144658eds.67.2020.10.19.09.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 09:12:38 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 05/12] builtin: fix evaluation of __sync_lock_release
Date:   Mon, 19 Oct 2020 18:12:19 +0200
Message-Id: <20201019161226.97429-6-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201019161226.97429-1-luc.vanoostenryck@gmail.com>
References: <20201019161226.97429-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

It must use the generic method too.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 builtin.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin.c b/builtin.c
index bd12d5651f44..7ff1071d721d 100644
--- a/builtin.c
+++ b/builtin.c
@@ -636,7 +636,7 @@ static const struct builtin_fn builtins_common[] = {
 	{ "__sync_fetch_and_or", NULL, 1, { vol_ptr, &dyntype }, .op = &atomic_op },
 	{ "__sync_fetch_and_sub", NULL, 1, { vol_ptr, &dyntype }, .op = &atomic_op },
 	{ "__sync_fetch_and_xor", NULL, 1, { vol_ptr, &dyntype }, .op = &atomic_op },
-	{ "__sync_lock_release", &void_ctype, 1, { &ptr_ctype }},
+	{ "__sync_lock_release", &void_ctype, 1, { vol_ptr }, .op = &atomic_op },
 	{ "__sync_lock_test_and_set", NULL, 1, { vol_ptr, &dyntype }, .op = &atomic_op },
 	{ "__sync_nand_and_fetch", NULL, 1, { vol_ptr, &dyntype }, .op = &atomic_op },
 	{ "__sync_or_and_fetch", NULL, 1, { vol_ptr, &dyntype }, .op = &atomic_op },
-- 
2.28.0

