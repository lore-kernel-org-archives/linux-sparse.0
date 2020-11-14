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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D39DC63697
	for <linux-sparse@archiver.kernel.org>; Sat, 14 Nov 2020 10:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC40722254
	for <linux-sparse@archiver.kernel.org>; Sat, 14 Nov 2020 10:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u6Y3hs82"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbgKNKYH (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 14 Nov 2020 05:24:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbgKNKYG (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 14 Nov 2020 05:24:06 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C5AC0613D1
        for <linux-sparse@vger.kernel.org>; Sat, 14 Nov 2020 02:24:06 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id o20so13723034eds.3
        for <linux-sparse@vger.kernel.org>; Sat, 14 Nov 2020 02:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UHTS0l0QsVj7JigVh+eY7YTBu2wf6WIyvZVq9ETO6Es=;
        b=u6Y3hs82Arxv4XlJelk1lsRscsR34aIsnT6+DTEDsS8j1zEOxrkG8YOLI9TzwYWpE3
         G2l/erAOiMQbYmvTp1qJSlpVl7JeZyNgjemVoeIijOe/0PntxmrqT9r92UuBUTZBIFi9
         QN/fAw8USDGeKbrCKQ5y3yXNYpDTCIgZGLshck5vnvvYOnCnOqtcOjqIou7tACAsNbr0
         3o27oZus1FiJ0APn4erWf9qUo0/APTque4jrzjC9FBYJ3fYVve1R22zO0x5i03SSa1nq
         7OsZg8PEbpo5kkyDEpOWc6T9E7AZShdyAEMeZJNSiPDhtxk0jNz8folou3Huc+tB4vAQ
         zvUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UHTS0l0QsVj7JigVh+eY7YTBu2wf6WIyvZVq9ETO6Es=;
        b=djiSs4L60pf/3I+OSQskJ8YcrFvSI2vJN6KtolgKnJD6FUrNO7Rn+X+nkqTIuLGzoK
         pf0TWXZp6BjV2i5U8W9oVBtWVal05esNdIkjoWjXmlfx3klGRHmO2R8jF1WYilOdyead
         lg+6KQj0XHFTrUHzo6W2KtbsbLhglnKCpvMxPUEnVd1daOYA+x070OC9SvNC8HyPSlQE
         z7W4Kk11oup2IrHAeYjF32G5+GszeK3waQmVFI0NDupM+edXg2nH096t2fHQWUhOH8Rj
         lxD3eZHX5Bw+spAoa7nSB2bI9W1zoB2bAM9mVOPuW63Hsix95jhgl0uYr6OFTputTCNM
         UHwA==
X-Gm-Message-State: AOAM530MENiGOKKaMmihSBU2hjRh603tv0sZTcK2odr1HFgK735yY7lJ
        RBaRn4ktqWJ5L+k4el97mMsXVbN9qqg=
X-Google-Smtp-Source: ABdhPJzxW/L+N5f/r88iHUqcvn8jNqw6r38oXffY/fW8mJjFAJn7sbfoxqw7ViDfiTpOF8Ni1hqkeQ==
X-Received: by 2002:a05:6402:1456:: with SMTP id d22mr6721576edx.77.1605349442824;
        Sat, 14 Nov 2020 02:24:02 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:e8ee:663e:d7a3:b425])
        by smtp.gmail.com with ESMTPSA id f19sm6479758edy.13.2020.11.14.02.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2020 02:24:02 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/4] doc: add some doc to flowgraph.h
Date:   Sat, 14 Nov 2020 11:23:54 +0100
Message-Id: <20201114102356.61234-3-luc.vanoostenryck@gmail.com>
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
 Documentation/api.rst |  1 +
 flowgraph.h           | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/Documentation/api.rst b/Documentation/api.rst
index cb8a0982011d..09ed0c4d7f9b 100644
--- a/Documentation/api.rst
+++ b/Documentation/api.rst
@@ -10,6 +10,7 @@ Utilities
 
 .. c:autodoc:: ptrlist.c
 .. c:autodoc:: utils.h
+.. c:autodoc:: flowgraph.h
 
 Parsing
 ~~~~~~~
diff --git a/flowgraph.h b/flowgraph.h
index 7226c55f0805..5a9c26073554 100644
--- a/flowgraph.h
+++ b/flowgraph.h
@@ -1,13 +1,33 @@
 #ifndef FLOWGRAPH_H
 #define FLOWGRAPH_H
 
+///
+// Utilities for flowgraphs
+// ------------------------
+
 #include <stdbool.h>
 
 struct entrypoint;
 struct basic_block;
 
+///
+// Set the BB's reverse postorder links
+// Each BB will also have its 'order number' set.
 int cfg_postorder(struct entrypoint *ep);
+
+///
+// Build the dominance tree.
+// Each BB will then have:
+//	- a link to its immediate dominator (::idom)
+//	- the list of BB it immediately dominates (::doms)
+//	- its level in the dominance tree (::dom_level)
 void domtree_build(struct entrypoint *ep);
+
+///
+// Test the dominance between two basic blocks.
+// @a: the basic block expected to dominate
+// @b: the basic block expected to be dominated
+// @return: ``true`` if @a dominates @b, ``false`` otherwise.
 bool domtree_dominates(struct basic_block *a, struct basic_block *b);
 
 #endif
-- 
2.29.2

