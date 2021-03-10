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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92732C433DB
	for <linux-sparse@archiver.kernel.org>; Wed, 10 Mar 2021 22:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65FA364FAB
	for <linux-sparse@archiver.kernel.org>; Wed, 10 Mar 2021 22:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbhCJWLN (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 10 Mar 2021 17:11:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbhCJWLC (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 10 Mar 2021 17:11:02 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA44C061574
        for <linux-sparse@vger.kernel.org>; Wed, 10 Mar 2021 14:11:01 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id bm21so41924821ejb.4
        for <linux-sparse@vger.kernel.org>; Wed, 10 Mar 2021 14:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s5g21rtrUkKyIAe0NxocjKGj1w5N65WEaFKudZER4Bg=;
        b=f7kATUtNXP7XI8jdvYNvllNdodOSeKY6fhR7KUS40qLDVP31J8RZgy2njImdzLrlci
         I+yzA3TR8sBTa5hasrRcNkPYn+b/yI+F+luajm9B5ysud1jCATgwi5fCr/4fvb8JO9L1
         h4elR5OYn27OJJOATWUhM97b6Sqif/0kKhxhudK1C/koCoSMLGXiQRt+sn9y7TTHe+0T
         TcrvvhjEHfeVkKrQk9IVbrYV1+Ykkuc2Tbb+1CLZjC9SryJYG7N7jbqPh7Pb/kEEPW3D
         jaXZiOcyT1s1rrSRBLu9mFx3FlAOaw+Wg4KitWES6tx1twVXLCYICo8s9KtNQt1mD5rB
         nbFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s5g21rtrUkKyIAe0NxocjKGj1w5N65WEaFKudZER4Bg=;
        b=AAQHwQBcqnIgFL+QlbKMxL55Ni1UeE7CmXrlSstVZ5b6nPlQOAmRKYnuGNPINafcye
         GKHEjyklL38J0fpm6g5QgRlBlIa6NafLuDmvfQnGOIiP3BwxQ0R2dZtt4CKu0J/6tdL+
         wVAowDNvwqhoD9pOJBpQitpXjfLAyXhPRGh7xN7d6irXDeuvUCDBTT/eTMs8EKQafNAr
         53aGXC8XX15pX2TrMn+UkZELa7H+7KNMHMabvY/pf+UxSnYajJ+/A4FgPkM0Ro75HQvn
         w8+celEKYx+V2H0nW2Ghr0GYVJKDoOxP26tujBIYsnjVHZB2UwUzs0nlj05c8YF2doU3
         jqvg==
X-Gm-Message-State: AOAM533RctvL+I+bV0gNiix0lWch9M2rz1NcLXf3dCIcFIlEBU7H+Qc1
        e5j5Su66oM31kGjX/RbqDVlDSDKC0pQ=
X-Google-Smtp-Source: ABdhPJxB4xPiT7Vo3ckl6HVvX31H1P9GUcLxVtcYlQKXBgpShf0jH0twoc5H3ch2T+QPR2Y4SyRt1w==
X-Received: by 2002:a17:906:1c41:: with SMTP id l1mr50574ejg.299.1615414260534;
        Wed, 10 Mar 2021 14:11:00 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:196c:c08:d4ab:a1ba])
        by smtp.gmail.com with ESMTPSA id ld19sm344326ejb.102.2021.03.10.14.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 14:11:00 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/9] change testing of signed compares against SMIN or SMAX
Date:   Wed, 10 Mar 2021 22:49:42 +0100
Message-Id: <20210310214950.84192-2-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210310214950.84192-1-luc.vanoostenryck@gmail.com>
References: <20210310214950.84192-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

These tests are written by testing if the comparisons are equal
to their expected value: 0 or 1. So, a compare of a compare
but such compares of compare have their own simplification
which defeats what's tested here.

So, rewrite the test to avoid such compares of compare.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/optim/cmps-minmax.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/validation/optim/cmps-minmax.c b/validation/optim/cmps-minmax.c
index 5802cdbcafd1..0b1a0a099d7d 100644
--- a/validation/optim/cmps-minmax.c
+++ b/validation/optim/cmps-minmax.c
@@ -1,11 +1,11 @@
 #define SMAX __INT_MAX__
 #define SMIN (-__INT_MAX__-1)
 
-int lt_smin(int a) { return (a <  SMIN) == 0; }
-int le_smax(int a) { return (a <= SMAX) == 1; }
+int lt_smin(int a) { return (a <  SMIN) + 1; }
+int le_smax(int a) { return (a <= SMAX) + 0; }
 
-int ge_smin(int a) { return (a >= SMIN) == 1; }
-int gt_smax(int a) { return (a >  SMAX) == 0; }
+int ge_smin(int a) { return (a >= SMIN) + 0; }
+int gt_smax(int a) { return (a >  SMAX) + 1; }
 
 /*
  * check-name: cmps-minmax
-- 
2.30.0

