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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B328C433E1
	for <linux-sparse@archiver.kernel.org>; Sun,  9 Aug 2020 14:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AB5E206E9
	for <linux-sparse@archiver.kernel.org>; Sun,  9 Aug 2020 14:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gy7bIST/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbgHIORo (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 9 Aug 2020 10:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbgHIORm (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 9 Aug 2020 10:17:42 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D567C061787
        for <linux-sparse@vger.kernel.org>; Sun,  9 Aug 2020 07:17:42 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id i26so4582141edv.4
        for <linux-sparse@vger.kernel.org>; Sun, 09 Aug 2020 07:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ItfZzrkH2XxylQjc1Fg63UxGYkx3Ea15KMrGhNnI6xc=;
        b=gy7bIST/whvb8qjtZhH6FDsrpUHR729r4XoUHCIq/pLaHpbxcFLwmFrdgmTIZk1MKo
         MrkveBs8CwhG56hbvb1b/veRA3pGh3aHVB1gqZSJKkEaSxXZOIUwExAqBhWeYNK/Z9sk
         7m/7mQCp/9ytSjs2eMrbicw5V068zpoxl0MGC/D3A3c3ybmYOnlns1H/h36zb8hazUQS
         TSjluy2vROEdrv2N0SE6E/hcXcrA2NQxoKzpv55DJnkoa3HasKoHPbbu6bu/Ux0Cmb0m
         G5U8NNfR0W9RxCUArU5zhKOn37Jnbq4e1tVyekqWmoehAd7m5gwgaIL6sKb0P4qyyRXj
         81kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ItfZzrkH2XxylQjc1Fg63UxGYkx3Ea15KMrGhNnI6xc=;
        b=ttvdxhyzzoE9Uh8UXsqMVaiHGyFutdIuIfwStoeNAZyRscxemtUTHSmvJq8vd3TSba
         p6+jK4rqM1o0CT2783uZJ3NG0B1+dzWQsWHgyCRFyGBEmzymAZW4To0/6VDwKOaxUwmy
         honeIHuxEaLfa1mnLVqGI3gIdGBiMWP9TxzCzx4EWg48/SPPVhIBBeTk+AmKT46+LN8v
         uwOmGEvA8ueTMrNRglxqJBZrRXZt7wWYrSY9YBHFcHoVK/X4gezaSD0/c+dDBrWVy5R9
         aq2vddggiyrdViGkm8fkYNsJPP6381wiP2kZDb1h7sk01GABgWDy++Tppni7QpyLP6wo
         NWBQ==
X-Gm-Message-State: AOAM530UtliHdDa6meH9iN554ks/5fPOW2G82DcZ17vXv4QvSQvTQrXc
        Q1dw+wYUQR4S4TDLLqc6fk0kXbV0
X-Google-Smtp-Source: ABdhPJzGYBuQqXlwb1ANJ3iblbxIjS3oFrHdZjM8M6ip9QLexp/8SpbtNgA9qLqSG7mgPcgXoPB08A==
X-Received: by 2002:a05:6402:17c2:: with SMTP id s2mr16742321edy.188.1596982660893;
        Sun, 09 Aug 2020 07:17:40 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:788a:816d:ff27:8087])
        by smtp.gmail.com with ESMTPSA id p1sm9917956edu.11.2020.08.09.07.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 07:17:40 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 5/5] doc: shorter title for "submitting-patches.md"
Date:   Sun,  9 Aug 2020 16:17:31 +0200
Message-Id: <20200809141731.32433-6-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200809141731.32433-1-luc.vanoostenryck@gmail.com>
References: <20200809141731.32433-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The documentation for submitting patches has ": the sparse version"
is in its title. This is quite useless and makes it longer than
needed.

So, remove this part from the title.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Documentation/submitting-patches.md | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/submitting-patches.md b/Documentation/submitting-patches.md
index fb176ce51d46..6a4275c3fd35 100644
--- a/Documentation/submitting-patches.md
+++ b/Documentation/submitting-patches.md
@@ -1,5 +1,5 @@
-Submitting patches: the sparse version
-======================================
+Submitting patches
+==================
 
 Sparse uses a patch submit process similar to the Linux Kernel
 [Submitting Patches](https://www.kernel.org/doc/html/v4.12/process/submitting-patches.html)
-- 
2.28.0

