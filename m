Return-Path: <SRS0=5g4H=CP=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04106C433E2
	for <linux-sparse@archiver.kernel.org>; Sun,  6 Sep 2020 21:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD1092078E
	for <linux-sparse@archiver.kernel.org>; Sun,  6 Sep 2020 21:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUXjjubA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgIFVQy (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 6 Sep 2020 17:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbgIFVQx (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 6 Sep 2020 17:16:53 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD48C061574
        for <linux-sparse@vger.kernel.org>; Sun,  6 Sep 2020 14:16:52 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id l17so10792869edq.12
        for <linux-sparse@vger.kernel.org>; Sun, 06 Sep 2020 14:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c64wvGdld9X9uM7LQlyBjdYRPbeio+0mNJr+KuY049U=;
        b=TUXjjubAS5zIvjodttZeJRm0oPfVN+MJ+3+xqp/qfuQR+vHjSeujws+guPTYFvKxnP
         7rMnuZI+u3gg9BFPhF1zAOFxlXVJTcUm60HOG13fM1cUT4giXnJaEZtUgr2KLrnKAtbn
         +XWHKCjlKJFB1mZ76ssOQDli96BJY4Qz4v12yQkbrs3yeK9Up6sSVFHsQPhvkPleX2XK
         bUiYAAS088fJF13/mwiurjeAVSfa1xd1CgIaWcaCSGE2dW+qzRpzdjroL5AxZ9Cq+IJo
         nKQtkfE5lTQKVmGMPXurncKPW24xFHUzoS0cbKXT3Srset60Ut8gjH3mSnd1f9iU+hl9
         iFyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c64wvGdld9X9uM7LQlyBjdYRPbeio+0mNJr+KuY049U=;
        b=QHF8D4VtSs+Iqxhc77bEzbZNE9nlSOimLd3A/BMaasOCOKzcfBkcP3jyCyRi7wQWAH
         Di/Y0JkQWW0O0eG8QRIPVfmwIMMsofTpIr17KFw1tYdkR/4j11dqUKMX3iMsoS0RiOKp
         FmMVzZ9j0jUfH8ejikkcIpxyFkLp5VTgZkAyG47WIV+JMKCPkz1O9m/MtNihuv5oDF8D
         YT4HMowKs1P8GeMsKG/M3D6ZW/aKlB2Y5DowLr2WizWnAFbj3yFG6ZZnW7OqW15lELeh
         eJewC5f5OTZrAG3aGIrXZCDzomoiA45Rj4glE1QhpXY9FZd3vORGLtsj48xAaI5nUK2Y
         sl2g==
X-Gm-Message-State: AOAM530TdMofuepDkwh14LR6RBGMX3xsXcgzFGUTh6CdpQMvlX/yaLZU
        +hv00yacFzCswTsUPEj8kthGeekJDCY=
X-Google-Smtp-Source: ABdhPJw7uDLh0NRu/0lea0SP0mUkG4VTcZlFt3Uo0dwr4dV77GgB7KzWySqe6hAij/kIIPa+1UdeAg==
X-Received: by 2002:aa7:c1c3:: with SMTP id d3mr19025625edp.228.1599427010821;
        Sun, 06 Sep 2020 14:16:50 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:1c0f:34d8:de78:ecc0])
        by smtp.gmail.com with ESMTPSA id e4sm13057645ejk.76.2020.09.06.14.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2020 14:16:50 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 1/3] optim: fix some testcases related to bitfield manipulation
Date:   Sun,  6 Sep 2020 23:16:44 +0200
Message-Id: <20200906211646.58946-2-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200906211646.58946-1-luc.vanoostenryck@gmail.com>
References: <20200906211646.58946-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The patterns used here were based on looser semantic for OP_{SEXT,TRUNC}.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/optim/sext.c         | 7 +++----
 validation/optim/trunc-or-shl.c | 7 ++++++-
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/validation/optim/sext.c b/validation/optim/sext.c
index 719730d50739..a3aa14945f11 100644
--- a/validation/optim/sext.c
+++ b/validation/optim/sext.c
@@ -6,10 +6,9 @@ int sext(int x)
 /*
  * check-name: sext
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
- * check-output-contains: sext\\.$27
- * check-output-excludes: asr\\.
- * check-output-excludes: shl\\.
+ * check-output-pattern(3): \\.32
+ * check-output-contains: shl\\.
+ * check-output-contains: asr\\.
  */
diff --git a/validation/optim/trunc-or-shl.c b/validation/optim/trunc-or-shl.c
index 70d8bd1de5bb..04bc8383a81e 100644
--- a/validation/optim/trunc-or-shl.c
+++ b/validation/optim/trunc-or-shl.c
@@ -1,3 +1,5 @@
+// => TRUNC(b, 8)
+
 char foo(int a, int b)
 {
 	return (a << 8) | b;
@@ -9,5 +11,8 @@ char foo(int a, int b)
  * check-known-to-fail
  *
  * check-output-ignore
- * check-output-contains: ret\\..*%arg2
+ * check-output-contains: trunc\\..*%arg2
+ * check-output-excludes: or\\.
+ * check-output-excludes: shl\\.
+ * check-output-excludes: %arg1\\.
  */
-- 
2.28.0

