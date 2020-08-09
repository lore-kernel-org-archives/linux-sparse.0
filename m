Return-Path: <SRS0=O0OO=BT=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD387C433E1
	for <linux-sparse@archiver.kernel.org>; Sun,  9 Aug 2020 14:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBA1E206B2
	for <linux-sparse@archiver.kernel.org>; Sun,  9 Aug 2020 14:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gry5PTbi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbgHIORk (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 9 Aug 2020 10:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbgHIORj (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 9 Aug 2020 10:17:39 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D0CC061756
        for <linux-sparse@vger.kernel.org>; Sun,  9 Aug 2020 07:17:39 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id df16so4566822edb.9
        for <linux-sparse@vger.kernel.org>; Sun, 09 Aug 2020 07:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vMR958jp0vJQLVfI8K9AS2+BZAqdKo73Q3KMou+/moQ=;
        b=gry5PTbivruLgld4ypi/vmVPyk8xtr+NuWfI6p1m5CV44pQnMiPkXfn5mHex3fLn1v
         Ci05jjqRp3wzsjdwm5xnN9K3NA6IZbC6iGEMByeuvdWypVFCa+0l+Mai7QxB1gYkfIgs
         si9ObMddq0RvK2mAJddF2Bk5vHGq0vYYbSQHt61+cZUQam3rdIugsOJ58ocu3zoq3244
         p/lW2PcrKVbXz6iTLwaWt1DlcNOS76HYJi4YUMtyhMrQTt0EAoW2YZ/FAQXSgERr0p9f
         kAYUUCuNDMH1wgroTA01Zv1uQfzDTwf4lFRHgULVux6ES8Pr0Q+H3OJXm4xr1yciuTu5
         dfug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vMR958jp0vJQLVfI8K9AS2+BZAqdKo73Q3KMou+/moQ=;
        b=Bw0wPOJCLBI7WXaaUJ6WVQ72DoZZQ05q2tuUghQzMuwRyjzxTuEjeUihhibUl4N1B3
         gA0GTn3aWsWzaB0zvHzoFpmAchAyh+tXR/EbFUHmthR7rHAN091QRjambTcC9fhqiabs
         0xlwNZqYrl8t0OonHJEbqB8rXOlt2xjHX2OLQyoEazqEnWJhsWorNGwoqOL0HsN8M3fu
         epDaEd8I+v44Uu6wl9dSE6Yug00YNlVoLjRxoLCuZgN4EAMkbgL+Xq0ripRU5GocOswi
         cS7yeCMU/92QVPpr35UE3Dx6xB4BvQsQAcdZgI0pZyCis8eUswE4smwA94zzgmyrYMFD
         1XiQ==
X-Gm-Message-State: AOAM531RJVDwG/PGoaqH887+Ggv+c17w2WYDV/Wc3kqDE1RPt6tIpukL
        xlpiKGnQl+7d0Kf9+yc6vBO5gmbj
X-Google-Smtp-Source: ABdhPJxLVceopFBtPML8e9QrADIlcLPR9LEk4E6tl6oL5ZsoDNDCyxtNpY3XZhGZZaSjC0O37W1jyg==
X-Received: by 2002:a05:6402:1386:: with SMTP id b6mr1077777edv.296.1596982657676;
        Sun, 09 Aug 2020 07:17:37 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:788a:816d:ff27:8087])
        by smtp.gmail.com with ESMTPSA id p1sm9917956edu.11.2020.08.09.07.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 07:17:37 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/5] doc: simplify the toctree
Date:   Sun,  9 Aug 2020 16:17:28 +0200
Message-Id: <20200809141731.32433-3-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200809141731.32433-1-luc.vanoostenryck@gmail.com>
References: <20200809141731.32433-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Combine the 'user' documentation with the one for developers
and add captions for each sections in order to have this
structuration visible in the sidebar.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Documentation/index.rst | 28 +++++++---------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/Documentation/index.rst b/Documentation/index.rst
index cbe0521b7091..e8e40c0cd109 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -63,42 +63,28 @@ To subscribe to the list, send an email with
 Bugs can also be reported and tracked via the Linux kernel's bugzilla:
 http://bugzilla.kernel.org/enter_bug.cgi?component=Sparse&product=Tools.
 
-User documentation
-------------------
-.. toctree::
-   :maxdepth: 1
-
-   annotations
 
-Developer documentation
------------------------
 .. toctree::
+   :caption: Documentation
    :maxdepth: 1
 
-   test-suite
+   annotations
    dev-options
+   types
    api
    IR
-   types
+   test-suite
+   doc-guide
 
-How to contribute
------------------
 .. toctree::
+   :caption: How to contribute
    :maxdepth: 1
 
    submitting-patches
    TODO
 
-Documentation
--------------
-.. toctree::
-   :maxdepth: 1
-
-   doc-guide
-
-Release Notes
--------------
 .. toctree::
+   :caption: Release Notes
    :maxdepth: 1
 
    release-notes/index
-- 
2.28.0

