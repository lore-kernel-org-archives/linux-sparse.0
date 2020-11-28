Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E447C63798
	for <linux-sparse@archiver.kernel.org>; Sat, 28 Nov 2020 22:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0BC720809
	for <linux-sparse@archiver.kernel.org>; Sat, 28 Nov 2020 22:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VG+2uYHX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbgK1W6a (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 28 Nov 2020 17:58:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbgK1W63 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 28 Nov 2020 17:58:29 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93ADBC0613D1
        for <linux-sparse@vger.kernel.org>; Sat, 28 Nov 2020 14:57:49 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id jx16so12605572ejb.10
        for <linux-sparse@vger.kernel.org>; Sat, 28 Nov 2020 14:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Uf5Mok3S3XemvTbWoJCIVSE6/3go4awNsB+csA/+tyw=;
        b=VG+2uYHXfJNqDZBxEatVY068H6tT5QD8ECS9vzlsO7kW4/5qWRBK1hIruGf9V9zI3z
         uJNNkKaChapp1/ZVBBggRFRqX6U2NQXBLXI6mymYxgOtaScfY56hCmyJw3lOgUCy/mIU
         BxqiI7wfo6l2K8wIILPAkxiIKGe6jD+PYFEhPSa1rxaulJ0lpBcz7bBOL8YLmXqtPiff
         0mycuoePNk/g/Fcu08v2rdsHeK+vHRiKSLqXPbpzEs+SXy+5ZN/XFkGnnnNeoWeyACt1
         RsebuA+xBpjjJTr6pwYTsWjfC5m3wukGtuVcclowLYfkmA/7zScFb3vi6kFBdVrm50ZY
         aETQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Uf5Mok3S3XemvTbWoJCIVSE6/3go4awNsB+csA/+tyw=;
        b=jnFn5zHla+6fo7EKcqUeMIwlWk3VpIjlun12XYy2HqCe8jBkqyaI8o54csfuYh0edS
         dDMRcBqUIar+/R1Q0L5265boxzvGrfdxfZR9xxA7FYBKxxq+EYTzo+uBrw9w0Qm/eXH/
         Hso+G54LUJgJMcrYbjB/9xfN0XGI4OwYLXXP9kHE4LfV6eG6wznByPceTdF5MG4ytXW8
         rU/4uNZPKxln0ibtiQv9Dery1lDzodx0v46mS4CeCk7bAudS1wIBEkhLPJXtGMEKNGGU
         bGgmPRfc3zQGKp3UWgOwSyTA5ee9Ebl4V5JlcveEd610KkM0mSTee/4jqVz+i7fJied0
         cb2Q==
X-Gm-Message-State: AOAM531iv9Gm9YrL224BN3Kx061KT6iws7pWh6PZWHW+eX0ldy0vVqit
        1KiwIko7TzAfLlfiD/Z8B16aDzppbnA=
X-Google-Smtp-Source: ABdhPJwuvYV2wAm+4WnzKA9zaDKC06NW7dYtCaNLZjOGjsWPb6ywBHdZO3tor0nncaeDFk0uMnfB6Q==
X-Received: by 2002:a17:906:a0c3:: with SMTP id bh3mr12310858ejb.497.1606604268092;
        Sat, 28 Nov 2020 14:57:48 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:6c60:a2fb:85f5:63])
        by smtp.gmail.com with ESMTPSA id r7sm1994535eda.23.2020.11.28.14.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 14:57:47 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] fix wrong killing of stores partially dominated by a load
Date:   Sat, 28 Nov 2020 23:57:41 +0100
Message-Id: <20201128225741.49915-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

When a partial but overlapping load is followed by a store, this
load is not considered as dominating the store. This is a problem
for kill_dominated_stores() because the load will be simply ignored.
For example, in code like:
	union {
		u64 l;
		int i;
	} u;
	int i;

	u.l = x;
	i = u.i;
	u.l = y;

The load will be ignored, then the first store can be ignored too
and the value of 'i' will be undefined (but actually set to 0).

The root of the problem seems to be situated in dominates() where
a load is considered as dominating another memop only if both
correspond to the same 'access' (address and size).

This is probably fine when the other memop is itself a load (because
the value of the first load can't be reused for the second one) but
it's not when the other memop if a store.

So, to be safe, consider different-but-overlapping memops as neither
dominated or non-dominated but as "don't know".

Note: as explained here above, this can *probably* be relaxed when
      both memops are loads but it's not 100% clear to me yet and
      I found no examples where it actually make a difference.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 flow.c                             |  2 --
 validation/memops/partial-load00.c | 29 +++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 2 deletions(-)
 create mode 100644 validation/memops/partial-load00.c

diff --git a/flow.c b/flow.c
index 1a871df16bd5..9b43e01a76a2 100644
--- a/flow.c
+++ b/flow.c
@@ -511,8 +511,6 @@ int dominates(pseudo_t pseudo, struct instruction *insn, struct instruction *dom
 		return -1;
 	}
 	if (!same_memop(insn, dom)) {
-		if (dom->opcode == OP_LOAD)
-			return 0;
 		if (!overlapping_memop(insn, dom))
 			return 0;
 		return -1;
diff --git a/validation/memops/partial-load00.c b/validation/memops/partial-load00.c
new file mode 100644
index 000000000000..cc6c31303053
--- /dev/null
+++ b/validation/memops/partial-load00.c
@@ -0,0 +1,29 @@
+union u {
+	double d;
+	int i[2];
+};
+
+void use(union u);
+
+int foo(double x, double y)
+{
+	union u u;
+	int r;
+
+	u.d = x;
+	r = u.i[0];
+	u.d = y;
+
+	use(u);
+	return r;
+}
+
+/*
+ * check-name: partial-load00
+ * check-command: test-linearize -Wno-decl $file
+ *
+ * check-output-ignore
+ * check-output-contains: store\\.
+ * check-output-contains: load\\.
+ * check-output-returns: %r2
+ */
-- 
2.29.2

