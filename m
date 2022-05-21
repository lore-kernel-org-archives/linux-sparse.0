Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2075CC433EF
	for <linux-sparse@archiver.kernel.org>; Sat, 21 May 2022 09:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbiEUJuq (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 21 May 2022 05:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiEUJup (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 21 May 2022 05:50:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1021B3A9
        for <linux-sparse@vger.kernel.org>; Sat, 21 May 2022 02:50:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9ED3161192
        for <linux-sparse@vger.kernel.org>; Sat, 21 May 2022 09:50:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79828C34115;
        Sat, 21 May 2022 09:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653126643;
        bh=dyVLj2Cc3QgDbnjId9bcGZMh5vMlNSTcdDq0ABPcewI=;
        h=From:To:Cc:Subject:Date:From;
        b=TAWCACbIV16xOqMhufWGU9dJoCSpzqfMSg2yNJxo83nB2NH4ENw1cKa3KRABdKqeI
         eN46o0rU3scqqnHOgCQDpuFMyByMn3FW6xC7zIlDbHVdI8kq43Ih7qcQQK6Jk0NAy0
         VZFWRzBVOpzJPKVRU/G3sIb3mWnaTWFAuacQQ/FevXxrVa3kUneP3s1dv62kBZ+mmU
         ztFoZS9UzGl3YaWn3YWK0kMqyeHnZha5sx3ODlIv/0dW8b0dZQKw4nbfk4T3Edmwx+
         BOPjw2EmH2wTZjo8DQjViBG8K1jGCV3d81VQAKKAEi9Y1wzVHs8TJCw7ak3oixhR1d
         u3qf6pS+duMRw==
From:   Luc Van Oostenryck <lucvoo@kernel.org>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] fix infinite loop when expanding __builtin_object_size() with self-init vars
Date:   Sat, 21 May 2022 11:49:59 +0200
Message-Id: <20220521094959.48865-1-lucvoo@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

expand_object_size(), used to expand __builtin_object_size(),
recursively try to get the parent initializer. This fails miserably
by looping endlessly when the object is a self-initialized variable.

For the moment, fix this in the most obvious way: stop the recursion
and do not expand such variables.

Note: I wouldn't be surprised if these self-initialized variables create
      other problems elsewhere. Maybe we should remove their initializer
      and somehow mark them as "do not warn about -Wuninitialized"
      (well, there is no such warnings *yet*).

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 builtin.c                              |  8 ++++++++
 validation/builtin-objsize-self-init.c | 11 +++++++++++
 2 files changed, 19 insertions(+)
 create mode 100644 validation/builtin-objsize-self-init.c

diff --git a/builtin.c b/builtin.c
index 8e1d2d7e9386..3a29c3aec8a6 100644
--- a/builtin.c
+++ b/builtin.c
@@ -546,11 +546,19 @@ static int expand_object_size(struct expression *expr, int cost)
 			// a deref is just intermediate variable
 			// and so the offset needs to be zeroed.
 			if (arg->op == '*') {
+				struct expression *parent = arg;
 				arg = arg->unop;
 				off = 0;
 				switch (arg->type) {
 				case EXPR_SYMBOL:
 					arg = arg->symbol->initializer;
+					if (arg == parent) {
+						// stop at self-initialized vars
+						// and do not expand them.
+						arg = NULL;
+						val = -1;
+						break;
+					}
 					continue;
 				default:
 					break;
diff --git a/validation/builtin-objsize-self-init.c b/validation/builtin-objsize-self-init.c
new file mode 100644
index 000000000000..77e3da43e6d2
--- /dev/null
+++ b/validation/builtin-objsize-self-init.c
@@ -0,0 +1,11 @@
+static void f(void)
+{
+	void *param = param;
+	__builtin_object_size(param, 0);
+}
+
+/*
+ * check-name: builtin-objsize-self-init
+ * check-timeout:
+ * check-error-end
+ */
-- 
2.36.1

