Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45EE8C55ABD
	for <linux-sparse@archiver.kernel.org>; Sat, 14 Nov 2020 10:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB7C322252
	for <linux-sparse@archiver.kernel.org>; Sat, 14 Nov 2020 10:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WkucwRj6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbgKNKYH (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 14 Nov 2020 05:24:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbgKNKYG (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 14 Nov 2020 05:24:06 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28158C0617A6
        for <linux-sparse@vger.kernel.org>; Sat, 14 Nov 2020 02:24:06 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id l5so13666382edq.11
        for <linux-sparse@vger.kernel.org>; Sat, 14 Nov 2020 02:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+1+A41RWxMyxTg/Q5ogVThtp0pYpuCB5oOnWGpcw80k=;
        b=WkucwRj6FLY+AcGQaqc6M+HYESrDZ3IwQtECGKJ/gctkQ+vzIHjMhpD8sIPfZvPl5y
         RKZfnDKtc0IQxQUpwH776k9n1SnRgTqGLtCvw0GnOZL+SKX1GBkk/iBANgIuqnGdUIUN
         7Bydb5gj4Vss/m//KsIF6dPCxzu0VXw1k/OT4g0yY3dXtf3+ha8WA5Z5NU2kIBdRNAR7
         w4+qLPZa6XxajCx9Yyr3tYAgiDff0rlF3h8asmBUhn8Lr9tX7IJSBQUAo8oQrfZet7U1
         /I1RsQZTlabRay2zBSGUofgHcwZfbjzFuPmqdzdMJROzkvZ7m8/bFHa95mYTTNR94rzN
         q5sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+1+A41RWxMyxTg/Q5ogVThtp0pYpuCB5oOnWGpcw80k=;
        b=UhByKsUsH25svuKzLsaEG1uD/CUee/kWODf9DQUBj2lWRq5pzOcbHSQ6hVGBOK60q7
         aQ5OPPmkmIujpcpjQWpGphsyQ3PMhkGW75uLsmBy/8hZ067RIeW45wH1prZ3m3A4CMjC
         ZRgzIm+V24pXwRY6GGXe3fU65uoR7/jY2KpZMCmGyNsI64dthm7SST6BjjkIpxEMkBMf
         kn41lABau4uiUo605ZJMCoP0vZT/wY0cll8pLek9+GAseruAfNmlyYETnpIHV0n62yWz
         t5ohLps2bMi6MA9LE3Rnmz4iGtYw9oj0yVbyL9ZfrKQZfuGJjMIQTs9P5y/1m3R02Zqk
         dM5g==
X-Gm-Message-State: AOAM5311WRyGY76ZFThu8yN8C1R+ua1gaytBZrKZTatxEp/nJGYLaiy+
        yAom/rhZ63kUskLm8HYfDDAqmqDrBV4=
X-Google-Smtp-Source: ABdhPJyMtQ6tD+v+dNwOr3slvECUgTTUMFb44tuN6GK3FDb5FxMiDJ8ON4Pu28zmd8ksNMt5ZxzZeQ==
X-Received: by 2002:a05:6402:17ac:: with SMTP id j12mr6764207edy.31.1605349444659;
        Sat, 14 Nov 2020 02:24:04 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:e8ee:663e:d7a3:b425])
        by smtp.gmail.com with ESMTPSA id f19sm6479758edy.13.2020.11.14.02.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2020 02:24:04 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 4/4] doc: add header for flow simplification related documentation
Date:   Sat, 14 Nov 2020 11:23:56 +0100
Message-Id: <20201114102356.61234-5-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201114102356.61234-1-luc.vanoostenryck@gmail.com>
References: <20201114102356.61234-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Documentation/api.rst | 1 +
 flow.c                | 7 ++++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/api.rst b/Documentation/api.rst
index 0cc830165e70..22b7dfd221fd 100644
--- a/Documentation/api.rst
+++ b/Documentation/api.rst
@@ -26,4 +26,5 @@ Optimization
 ~~~~~~~~~~~~
 
 .. c:autodoc:: optimize.c
+.. c:autodoc:: flow.c
 .. c:autodoc:: simplify.c
diff --git a/flow.c b/flow.c
index a74769c37659..f55ab1deae0c 100644
--- a/flow.c
+++ b/flow.c
@@ -1,10 +1,11 @@
 /*
- * Flow - walk the linearized flowgraph, simplifying it as we
- * go along.
- *
  * Copyright (C) 2004 Linus Torvalds
  */
 
+///
+// Flow simplification
+// -------------------
+
 #include <string.h>
 #include <stdarg.h>
 #include <stdlib.h>
-- 
2.29.2

