Return-Path: <SRS0=ez6N=CO=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E76C43461
	for <linux-sparse@archiver.kernel.org>; Sat,  5 Sep 2020 11:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59ED22074B
	for <linux-sparse@archiver.kernel.org>; Sat,  5 Sep 2020 11:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ja8wJCUf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbgIEL1q (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 5 Sep 2020 07:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728494AbgIEL1e (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 5 Sep 2020 07:27:34 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBD2C061245
        for <linux-sparse@vger.kernel.org>; Sat,  5 Sep 2020 04:19:52 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id i22so11873220eja.5
        for <linux-sparse@vger.kernel.org>; Sat, 05 Sep 2020 04:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ocflqIfxkIuHFCPdEEUvRh6Lyh46WnWmrp0GBEAqRcg=;
        b=Ja8wJCUfjjTSJnw7CzHlYk8OX4lDJekY3Get565fwk/2hfFy8ynBA2epdDugUC2tFE
         0Ojg8zA/nNzpc2HfLPY0weFsJBTtTMaHYH5nz4JtMzK6A/wlySznMir5RsS4sFTGUw2F
         zpLzHu/sQROJOBcG9n8tgYwKFyfMZ7hfw3yceu2YxtuXNRQJyPRIf5qcSqxLU8j+q28K
         wKqAwgT/bzU1p8M/y+HWfar7PpgY+BC5hywGYb+zLUV/RUxhtIXvlMtvg3W6WPdSXrPi
         D5EEpZLZl3Z6oaE9yQcH8SEE+KXA4oNYxaIORbydp4phcqUGfE4ZmaThod4+8P4X445H
         xU5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ocflqIfxkIuHFCPdEEUvRh6Lyh46WnWmrp0GBEAqRcg=;
        b=GRpH9rg78uzN0K/uNnSrlJcYLaKYEOtdLdov39YqPfs8W/lYIw6kjGdj0EkeUiV/JD
         CYRAJDcQBbva1usSFyDQYPXDC+K48Lw4z6AnCwncbZrrF44l9tjnxIDF3OX9ys7u7brg
         SwzrMP7VKUQrVm7xExlSTmJCr4yLOHPGPDrdCyWR4ek8YCesGId6AEn9nkRXO9AJuN24
         BLOcgpzQBIKHcVFUiS36c22HjmEpTMxBsbIkDDlPVAoEa3zo+2BQYKp5Mjdtn7Kn1Rts
         fuC3c/LTptO4WeeXtECCTwSSunhpRPMhJD1cI1fa0d9wkk5Fva66Gbjtx/hXNsdgQyia
         Q3/Q==
X-Gm-Message-State: AOAM530fu8bGZp7QYUoWmnKyCkzM1A+CLVahy4sZQ4hgX3dCX7LEd9Ev
        eS70z85ZGXwuJuqS4mm5L4EdZErEKTI=
X-Google-Smtp-Source: ABdhPJzl0gUqoVBR4RC05ubESx21NqPCbFLDthj3QZ7LE8eHSSL7ZnRpmixb5LFaojFJ/KZcGcbNwQ==
X-Received: by 2002:a17:906:375a:: with SMTP id e26mr11793738ejc.552.1599304790488;
        Sat, 05 Sep 2020 04:19:50 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:e1b1:2430:dffc:e425])
        by smtp.gmail.com with ESMTPSA id a8sm9032972ejx.73.2020.09.05.04.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2020 04:19:50 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] testsuite: easier testing via script & makefile
Date:   Sat,  5 Sep 2020 13:19:39 +0200
Message-Id: <20200905111939.82370-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

With this change, using the testsuite via the Makefile is not
limited anymore to a single file.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 639d4f518b7a..09726ebbd4dd 100644
--- a/Makefile
+++ b/Makefile
@@ -273,8 +273,8 @@ version.h: FORCE
 
 check: all
 	$(Q)cd validation && ./test-suite
-validation/%.t: $(PROGRAMS)
-	@validation/test-suite single $*.c
+validation/%: $(PROGRAMS)
+	$(Q)validation/test-suite $*
 
 
 clean: clean-check
-- 
2.28.0

