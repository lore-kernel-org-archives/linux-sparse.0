Return-Path: <SRS0=4is7=DM=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0381FC4727D
	for <linux-sparse@archiver.kernel.org>; Mon,  5 Oct 2020 23:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91567207F7
	for <linux-sparse@archiver.kernel.org>; Mon,  5 Oct 2020 23:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imHnVBrM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbgJEXEJ (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 5 Oct 2020 19:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbgJEXEJ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 5 Oct 2020 19:04:09 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC583C0613A7
        for <linux-sparse@vger.kernel.org>; Mon,  5 Oct 2020 16:04:08 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id c8so11332004edv.5
        for <linux-sparse@vger.kernel.org>; Mon, 05 Oct 2020 16:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2JYTd+rr6fX04XaP1JXhhikfoU3BigBW3o+ly0EUsoQ=;
        b=imHnVBrMtR/ZwW02qDePJg6zavNbyyxirUFXUUMNAlx+poVNp3aSi8GIwK3isJaDsR
         KHa2f2qHAGt4liFZnp9/DBeupWPqwrd1AiAs4imY6SY2MXPiP0tTUt7/pvMvwtBkEgjw
         3X34yVVRZ/aWCVRwrgmy962Im8YdgsRKbT0jpTbBHYSj3Ey6K0fz8QDiQzqEHu17XTvz
         7lVAOw7hRjloYmvLx/zrElD/CIWiFn/grovgYvjgC7TXVY7rTm1YgW0V0e62jjpKg9s8
         mgiZCNA7vSQYh2gt+CVgcGiCsIw248LRtSdwFzQ7mqLw2+vnGF1jRrt7riCCEB1V7RPd
         KkgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2JYTd+rr6fX04XaP1JXhhikfoU3BigBW3o+ly0EUsoQ=;
        b=h+h2JfFZXFs6la6zjAaYgkODNclNCVX28vCbWaS7rdER2CQSE8d85xRrqw18Vy1W5U
         Cxizz5Y9JrjXf5Z1Mgb/e6fIF2I3ATJuvF649ItvhPQm4F/LUlVZBqd6G6eqUSQbIiH6
         0G9VCKFUp4u4Pa4dnoBQkYp/WIne5/PLC5x3zSmQgly5ozrEggqTqYEczxDUB2rr1OBR
         1zjMiLMxKq05A9sWGOWhmz0Pjo5PwOIguu7PNr2Pqd+tZrmbTdjrbGbLyIVn7zhIN3y/
         PsqqGXlwgHdNgolrefO6ALhn+SwLxDUr0+Bkg/uUdO0XE65hEc54yXuG70IvrgGg2NWb
         CHDw==
X-Gm-Message-State: AOAM533B2sq0FHW8FxJvD0UCZ9FlefL8P5Sgp/ad/+dePQrsJQBXfXYz
        hN0pOTHjtf7hXM1YzqtpzeLJUbDM+i4=
X-Google-Smtp-Source: ABdhPJyH7k9hNHBrQtnJ3ud1IL1BXsafXzxRxg/au1cgGB+hY3LTPFwpeLJNGZaKHaVDMHcht1UKNg==
X-Received: by 2002:a05:6402:b8f:: with SMTP id cf15mr2135271edb.369.1601939047323;
        Mon, 05 Oct 2020 16:04:07 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:414e:4652:8edc:a08f])
        by smtp.gmail.com with ESMTPSA id r9sm673546ejc.102.2020.10.05.16.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 16:04:06 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/4] fix prototype of __sync_bool_compare_and_swap()
Date:   Tue,  6 Oct 2020 01:03:59 +0200
Message-Id: <20201005230401.74777-3-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201005230401.74777-1-luc.vanoostenryck@gmail.com>
References: <20201005230401.74777-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The prototype was incomplete and typechecking failed after
some changes in the usual conversions.

So, add the full prototype.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 builtin.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin.c b/builtin.c
index 26b612dc401b..b134754b5831 100644
--- a/builtin.c
+++ b/builtin.c
@@ -607,7 +607,7 @@ static const struct builtin_fn builtins_common[] = {
 
 	{ "__sync_add_and_fetch", &int_ctype, 1, { &ptr_ctype }},
 	{ "__sync_and_and_fetch", &int_ctype, 1, { &ptr_ctype }},
-	{ "__sync_bool_compare_and_swap", &bool_ctype, 1, { &ptr_ctype }, .op = &sync_compare_and_swap_op},
+	{ "__sync_bool_compare_and_swap", &bool_ctype, 1, { &bool_ptr_ctype, &bool_ctype, &bool_ctype }, .op = &sync_compare_and_swap_op},
 	{ "__sync_fetch_and_add", &int_ctype, 1, { &ptr_ctype }},
 	{ "__sync_fetch_and_and", &int_ctype, 1, { &ptr_ctype }},
 	{ "__sync_fetch_and_nand", &int_ctype, 1, { &ptr_ctype }},
-- 
2.28.0

