Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9135EC43334
	for <linux-sparse@archiver.kernel.org>; Tue,  7 Jun 2022 12:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242982AbiFGMrf (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 7 Jun 2022 08:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242948AbiFGMrd (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 7 Jun 2022 08:47:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B161118
        for <linux-sparse@vger.kernel.org>; Tue,  7 Jun 2022 05:47:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2943460DE1
        for <linux-sparse@vger.kernel.org>; Tue,  7 Jun 2022 12:47:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41FC5C385A5;
        Tue,  7 Jun 2022 12:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654606051;
        bh=3wh5SdFtiodLyDUgLKkCVf7R5s6NEmgejh80qzAINzI=;
        h=From:To:Cc:Subject:Date:From;
        b=j8uSedQVi0ASbJ2l9I0fdTYtX37uFlY0JZZVD3ROUdJ6zPu6dxWvGYNQgpw6jF6Sn
         S1/bMsveBrc/lsdFSGfhvUN5tSAYd3GGvOHklfxbqw8SHwy2tRnZ5RPTPZv8YNrMe2
         hkbtbSeJgRWivQx37yLoyfnrEl3q54+B/aFldhU0oTeCFuEzW0J6UTAnnTVtQ3YsRD
         R9WJPggzkzcLxyIgVQTIZm3mtW18SBE+Gvy/Hs+TDLONvbGHNu7PATX1D4aac9aowr
         eNXQ3inO4ljq8UyF9fJdIUkPvWciyN3/uR68XryMO9+1rl6w15X3z8wM7lw3e8SHeq
         kSZVp1sDJhCVA==
From:   Luc Van Oostenryck <lucvoo@kernel.org>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Yujie Liu <yujie.liu@intel.com>
Subject: [PATCH] fix crash when inlining casts of erroneous expressions
Date:   Tue,  7 Jun 2022 14:43:33 +0200
Message-Id: <20220607124333.23988-1-lucvoo@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Sparse do inlining very early, during expansion, just after (type)
evaluation and before IR linearization, and is done even if some
errors have been found. This means that the inlining must be robust
against erroneous code.

However, during inlining, a cast expression is always dereferenced and
a crash will occur if not valid (in which case it should be null).

Fix this by checking for null cast expressions and directly returning
NULL, like done for the inlining of the other invalid expressions.

Link: https://lore.kernel.org/r/e42698a9-494c-619f-ac16-8ffe2c87e04e@intel.com
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Yafang Shao <laoar.shao@gmail.com>
Reported-by: Yujie Liu <yujie.liu@intel.com>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 inline.c                                |  2 ++
 validation/inline-early/bug-bad-token.c | 15 +++++++++++++++
 2 files changed, 17 insertions(+)
 create mode 100644 validation/inline-early/bug-bad-token.c

diff --git a/inline.c b/inline.c
index eceef8ba0443..0097e4bf620a 100644
--- a/inline.c
+++ b/inline.c
@@ -155,6 +155,8 @@ static struct expression * copy_expression(struct expression *expr)
 
 	/* Cast/sizeof/__alignof__ */
 	case EXPR_CAST:
+		if (!expr->cast_expression)
+			return NULL;
 		if (expr->cast_expression->type == EXPR_INITIALIZER) {
 			struct expression *cast = expr->cast_expression;
 			struct symbol *sym = expr->cast_type;
diff --git a/validation/inline-early/bug-bad-token.c b/validation/inline-early/bug-bad-token.c
new file mode 100644
index 000000000000..9049bdb48ab0
--- /dev/null
+++ b/validation/inline-early/bug-bad-token.c
@@ -0,0 +1,15 @@
+inline void fun(int x)
+{
+	(typeof(@)) x;
+}
+
+void foo(void)
+{
+	fun;
+}
+
+/*
+ * check-name: bug-bad-token
+ * check-exit-value: 0
+ * check-error-ignore
+ */
-- 
2.36.1

