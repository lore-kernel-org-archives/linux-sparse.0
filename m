Return-Path: <SRS0=DkR5=BU=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF013C433E1
	for <linux-sparse@archiver.kernel.org>; Mon, 10 Aug 2020 21:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0C6020734
	for <linux-sparse@archiver.kernel.org>; Mon, 10 Aug 2020 21:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNAjqwRn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgHJVyu (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 10 Aug 2020 17:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbgHJVyt (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 10 Aug 2020 17:54:49 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF07C061756
        for <linux-sparse@vger.kernel.org>; Mon, 10 Aug 2020 14:54:49 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id t10so6569313ejs.8
        for <linux-sparse@vger.kernel.org>; Mon, 10 Aug 2020 14:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xcLQaenjDzUA557DeWm7c4DM2Wv8cl+M43dV4ZUcfeI=;
        b=nNAjqwRnryyZ+N/uTc4dR9/AdGbpz/y7AB07HNLnz+dUijp9App3tLJeOjyfTRcDGJ
         nhcgT/VApfezxirSiHFQWg6ESKQC45maw2iKcALuX8oF3YtI3pskTybCI70pesevRlw2
         wCjQO3N8BSlgIkYIv40+CbAjJKyqGDT6JJJ4xp+eDAnpQ/Kum4CLAvqpYSimXoi8+8bP
         4/B16Mcu1GH5NT+pSj0oXVN87BxuZvKCC7lw8wgsVmhlG/yPqcYWItDZXw59qUvCT3mX
         vTQfIG7hBtIjR2Wq0DcVoyPGkRTueqyU3TVu7zjcUDS4L+iy4PPrl8ybYKdxVK2HPODT
         46mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xcLQaenjDzUA557DeWm7c4DM2Wv8cl+M43dV4ZUcfeI=;
        b=kV/WgGEbGiypQsh/NKu7+tEDmKIZVvQWti3Lm0pLi8m2tfgAiH76GAljty5sf97EVM
         Z1OZ6ErR3I/Nj3a3aRBSAPe0r4D5ZH3CaJEx/fxB1h2XjF83p/SSlmVjg7pirBkKNCLQ
         am+2++HyPgRC5ZZTpYsYgaNYUQEZv7J7JCmmGWu+Gaz3OBvj78MmGCqF6FaZbs6n5Anv
         wtoEG4+SG8+yUUPR1AtyWqTmyfoWftqiPUMGHp6koSgvjzh5RdCWz50qPkSAgiEv8Ll0
         wvs05uR6gWwoo4rFX2fJIyu9gdPiFzXSZDw3hCns7UmN5c8XGqTxD8EBNHX+DsNG8urm
         GULQ==
X-Gm-Message-State: AOAM5317o03iSkwvbCOW0PwKFl5VJFMyRWr2FNgkcpcGeXgRCBlH16AH
        TNSCsg/eZaIEmMpiqyMe/NqHNXek
X-Google-Smtp-Source: ABdhPJzRAEN068wlIiXxU8hskkyq5trUWjwlXA1WyBmEkiq7lT3X3ooJ5qqv3B/LDrBoOoCqqqlUCw==
X-Received: by 2002:a17:906:7855:: with SMTP id p21mr23493532ejm.492.1597096487727;
        Mon, 10 Aug 2020 14:54:47 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:80df:2003:9ede:fcdf])
        by smtp.gmail.com with ESMTPSA id p8sm13771777ejx.53.2020.08.10.14.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 14:54:47 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 7/7] doc: add links to some external doc
Date:   Mon, 10 Aug 2020 23:53:36 +0200
Message-Id: <20200810215336.76070-8-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200810215336.76070-1-luc.vanoostenryck@gmail.com>
References: <20200810215336.76070-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

One is a LWN article which covers sparse very well, the other
is a pdf giving a short overview of sparse.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Documentation/index.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/index.rst b/Documentation/index.rst
index 4bca8c7e47f3..e29a5643849a 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -69,6 +69,11 @@ Bugs can also be reported and tracked via the `Linux kernel's bugzilla for spars
 
    annotations
 
+Some interesting external documentation:
+
+* `Sparse: a look under the hood <https://lwn.net/Articles/689907/>`_
+* `Sparse: a short overview <https://sil2.osadl.org/events/ewc-2019-hands-on/sparse_slides.pdf>`_
+
 .. toctree::
    :caption: Development
    :maxdepth: 1
-- 
2.28.0

