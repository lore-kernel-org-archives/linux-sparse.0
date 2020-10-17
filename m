Return-Path: <SRS0=IUSJ=DY=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF56BC433E7
	for <linux-sparse@archiver.kernel.org>; Sat, 17 Oct 2020 22:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2DA020897
	for <linux-sparse@archiver.kernel.org>; Sat, 17 Oct 2020 22:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+y7MNuN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439817AbgJQW4q (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 17 Oct 2020 18:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439822AbgJQW4q (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 17 Oct 2020 18:56:46 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9457C0613CE
        for <linux-sparse@vger.kernel.org>; Sat, 17 Oct 2020 15:56:45 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id lw21so8703887ejb.6
        for <linux-sparse@vger.kernel.org>; Sat, 17 Oct 2020 15:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/hKNvpvSHPf7IgS4snsk3zTEIH6ExTBe5klcnoYkbHQ=;
        b=E+y7MNuNdw9RNHpIc5LpoUD97UVzr8H812+D7yz+5b0cr17LIgQbAIKdDptoYM3SFg
         d/QUwU4rFfmV5NPEUQR9dWtS1k8pSAPvNCpl+iCvbzV/7zX1GKEM569a3p45SYZ8UJDm
         ez2io4DVN5vhNXXRqANyExhZmnScOVjJRX53PiJ4DrPfPSRHItf6jP2vflEvBoTY06pS
         3ZRtCUi+M+UXOyPTm9aUidq+zFLjEARun+6PR/IZWPIQK3TlbOeJRCeRMAjQV5Rn9E+U
         uzIndRWMSLpZWUhRirF1SFFmwViyK39FdIcpzsTurZKQ3OA+NAlbGeg7ztLA+Qr2zT9M
         C1Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/hKNvpvSHPf7IgS4snsk3zTEIH6ExTBe5klcnoYkbHQ=;
        b=fUOGqcE/bXOmSer0yZZnBunkACQC4ajfgk7EXrovM+ckbmOMFOBOfFpK+xeUZtp9Hs
         63wPu2jZs+3bdFzGf+SCYS1AZ+OXosDIFaN5PVxzKQN21enzZrojmAztqFm7xEhzhR7G
         i0MkQnCh8zIHU7BvfnzlZ1DICu8PQ9MtaZndGp9Moi1nFL9IQfoTml0f0qNqYYR6PGzp
         G7mQq8zgjYUS+Ss5Al930VbryeixPcg8vM2eQUsPZyEJe/5GjSi24lD1ssWEUNOfrLxK
         YwASV21CX5FZgxeSMjYdS0CeOAk1TBT6/7lhiy7q4Zr3jqOBJ9Icw+D/wQo+UZY2usB1
         nt7g==
X-Gm-Message-State: AOAM532B9w0l/RU7hvvVRTj0LrFBhZ+RH7wirzBOVLrN/74zhoqJkJN3
        otXhhWmjvW9BNEwmBPtillyjHy6d4Jg=
X-Google-Smtp-Source: ABdhPJwVAc4hgMvXBv8Hy4mKcEVn2JZFqiic2Fbm9QOwHlDQqD677RqiFwXNwnBKcV+7ww/i7Dg8zA==
X-Received: by 2002:a17:906:cd14:: with SMTP id oz20mr10519613ejb.7.1602975402577;
        Sat, 17 Oct 2020 15:56:42 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:c81f:df9c:7723:c5a1])
        by smtp.gmail.com with ESMTPSA id k26sm6129311eji.22.2020.10.17.15.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2020 15:56:42 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 05/12] builtin: fix evaluation of __sync_lock_release
Date:   Sun, 18 Oct 2020 00:56:26 +0200
Message-Id: <20201017225633.53274-6-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201017225633.53274-1-luc.vanoostenryck@gmail.com>
References: <20201017225633.53274-1-luc.vanoostenryck@gmail.com>
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
index 5e490830e147..cb900599f112 100644
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

