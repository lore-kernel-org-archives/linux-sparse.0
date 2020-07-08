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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8EAFC433E0
	for <linux-sparse@archiver.kernel.org>; Wed,  8 Jul 2020 22:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D7E02065F
	for <linux-sparse@archiver.kernel.org>; Wed,  8 Jul 2020 22:20:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HW4QzV08"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgGHWUm (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 8 Jul 2020 18:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgGHWUm (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 8 Jul 2020 18:20:42 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3FD9C061A0B
        for <linux-sparse@vger.kernel.org>; Wed,  8 Jul 2020 15:20:41 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id l12so107371ejn.10
        for <linux-sparse@vger.kernel.org>; Wed, 08 Jul 2020 15:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4Mjaq0CEvhxb4VavYRA7LAb9ZHs0A8MvmgYvi0XptnQ=;
        b=HW4QzV089l/uTNbdllIq+7OWQu0X5kwH7v3pP2gfpc1lhMRz5xgAeOj/r2WLZogwTD
         AS+fEp0zlskyGFn3HK0LQMu/HMPeeiDeWwLdqm/kWS5792V16k5ywgilTQ8LwH3VXT9h
         s/nU/5xN+Z94h2SQYMDsl4LTHmg4I+18XVvyVBBiiP6ZYmW1mONPudkh8pHyG6KY2T64
         zsEHJXhJkMuYohtEoPBUhj2pwhPx4ALWv3yHIU9Vg+oYcgHj3hzFzSwDDlYlUH+DCi2C
         Kra/i1a5iyiGkwDfzkan9XOqP48wRMpY+THvJyiPDVetRRomZ4/Za24TbLUURDxQ6aWz
         2jjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4Mjaq0CEvhxb4VavYRA7LAb9ZHs0A8MvmgYvi0XptnQ=;
        b=EuWBi6H72RImrqS/yRGFXsnvCBLCqIuWsFf3B3KRj/+9GEdYb+aPcOY4+IafhbKTQZ
         di+SyAZglDWen2R2dBPFw5rT3ElpL2KzE5jMMDv9ewLVaUMQkoxs52F1n4K7TczWo8JT
         mGx/9tL03m3fn+AfK85QwqllMvCjob60jRetolgimoDtEvEqKRpjVpe/kMvE+h9yhOf/
         qfTH8hKK8y3C+3XoTtZdEw3DtdcIO8sHy3GO48buV/cQKPe6wjE5H13WDg4/gd52KMF0
         ut7uNnMk9hoKRvQY/qKQKYy3WIv9GuoGLqA2qgjHlTf82f1KeYdEg010hgcd2p8Jo1lt
         gWBQ==
X-Gm-Message-State: AOAM532DeU93Wl+/U3tFOtQtCKsskzPAOD69RszRdDU5kQQnYMgtj15d
        EkoNuvfaf/F8r8Fuyl6IsiFWDipC
X-Google-Smtp-Source: ABdhPJz54xZU0V1dio0Fp7wsveYJDg8h105sTRx/AfUS6QN6CBIU0j+paOT7xEcRMYrs1T3twECpMw==
X-Received: by 2002:a17:906:2616:: with SMTP id h22mr52881740ejc.154.1594246840438;
        Wed, 08 Jul 2020 15:20:40 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:8478:3ba8:10ed:37ab])
        by smtp.gmail.com with ESMTPSA id ck6sm567571edb.18.2020.07.08.15.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 15:20:40 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/2] nios2: long double is 64-bit
Date:   Thu,  9 Jul 2020 00:19:15 +0200
Message-Id: <20200708221916.56665-2-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200708221916.56665-1-luc.vanoostenryck@gmail.com>
References: <20200708221916.56665-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Nios2, long double are (of course) only 64 bits width.
Specify this in the target file.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 target-nios2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target-nios2.c b/target-nios2.c
index 05f0926e2df9..98813765b925 100644
--- a/target-nios2.c
+++ b/target-nios2.c
@@ -26,6 +26,8 @@ const struct target target_nios2 = {
 	.mach = MACH_NIOS2,
 	.bitness = ARCH_LP32,
 
+	.bits_in_longdouble = 64,
+
 	.predefine = predefine_nios2,
 	.builtins = builtins_nios2,
 };
-- 
2.27.0

