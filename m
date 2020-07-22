Return-Path: <SRS0=QBgf=BB=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D6F8C433E0
	for <linux-sparse@archiver.kernel.org>; Wed, 22 Jul 2020 21:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 684E820825
	for <linux-sparse@archiver.kernel.org>; Wed, 22 Jul 2020 21:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pQB06vKO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgGVVrd (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 22 Jul 2020 17:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgGVVrc (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 22 Jul 2020 17:47:32 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4726FC0619DC
        for <linux-sparse@vger.kernel.org>; Wed, 22 Jul 2020 14:47:32 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id b13so501126edz.7
        for <linux-sparse@vger.kernel.org>; Wed, 22 Jul 2020 14:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mcEjPSevSOnSQ4PseC+EJ5/oSFZDp02NTwrnc8xxepY=;
        b=pQB06vKO5HmJvGnPrsCi5ipdjq1pIcVX9aNvl9p1Ao5YXQvqYL4f3ENh6Xl3JaTFof
         knEcC6puL7TEltttGgCKP1ls6bp2Sr7K0sA/Ox3toV9cuhy2FXJiefLp6m3PnptaLJXQ
         YGduYVJClGTcvWOS6zhEoI5kumWZ/te0AiYfKOU5JJcbGC2tgj0D32abYm7MNIJgbbjZ
         PX+f+Pu1ao/8jJaX+ndlnb8TnDRggheKco7jwGEQoHz83zOfTYncwoPwTsdUx6/s4sDX
         BfPLmIC0k3NoZSQatdbSBuRJ8lKCJ0W+ScL9xSORpFzy7eJhFO8OjIoAu8rdIUfXm1Cn
         8DfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mcEjPSevSOnSQ4PseC+EJ5/oSFZDp02NTwrnc8xxepY=;
        b=SI9UH16PL+jXvkYpk9BuwKCW816SPv3BALp++gRptH/hAdBhKojCY3TIs3wKCS+fHP
         Ken6j93JUPxORZeg/6jQksD7hPGB6lPFfqRshvsP8AfRzns5fAwyLanP7NphxYQjWkpz
         3wdyFcp2xeCCrmk0FARazb5hBj5FL9vCj4lTVpsqYxvuo29erxNRZ52aDOLUtedl/L4m
         liXd5WALg+AqAgyYHBz2q2fANj+Jqjwsb/0IZc5bQUbftwvx3kVxrNV/mv/uNKXDBp2l
         ocNeUl7a9z0ygobfXZTEP2mh/wCJ4D/m4daNISeIaieA1sCsR+DENbsc6p0icQTSJIWZ
         BstQ==
X-Gm-Message-State: AOAM533pyFh+24YE7kCYYOQYLyjgK88FU/v+v8qY4xUiJMWo7puno2sv
        ZGrMHx2DgNnzcie4bJQlCfMnQ1jY
X-Google-Smtp-Source: ABdhPJzO1168DdkZLchwByhAuzJWhZwnMNKu/OZmi5weSpfmpwAcxoDBzgJOOzzZ1UUrs/WDuwymjQ==
X-Received: by 2002:aa7:d8c2:: with SMTP id k2mr1380910eds.346.1595454450649;
        Wed, 22 Jul 2020 14:47:30 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:905b:ad5c:bc87:c79e])
        by smtp.gmail.com with ESMTPSA id ce19sm595320ejb.24.2020.07.22.14.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 14:47:30 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] doc: use https URLs
Date:   Wed, 22 Jul 2020 23:47:26 +0200
Message-Id: <20200722214726.36945-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Use 'https' instead of 'http' for pages needing some level of trust.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Documentation/index.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/index.rst b/Documentation/index.rst
index 737f442323b5..1ea87ae5e0d9 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -26,7 +26,7 @@ Getting Sparse
 --------------
 
 You can find tarballs of released versions of Sparse at
-http://www.kernel.org/pub/software/devel/sparse/dist/.
+https://www.kernel.org/pub/software/devel/sparse/dist/.
 
 The most recent version can be obtained directly from the Git
 repository with the command::
@@ -61,7 +61,7 @@ To subscribe to the list, send an email with
 ``subscribe linux-sparse`` in the body to ``majordomo@vger.kernel.org``.
 
 Bugs can also be reported and tracked via the Linux kernel's bugzilla:
-http://bugzilla.kernel.org/enter_bug.cgi?component=Sparse&product=Tools.
+https://bugzilla.kernel.org/enter_bug.cgi?component=Sparse&product=Tools.
 
 User documentation
 ------------------
-- 
2.27.0

