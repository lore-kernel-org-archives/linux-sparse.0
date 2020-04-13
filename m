From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 02/17] bad-goto: add testcases for linearization of invalid labels
Date: Mon, 13 Apr 2020 18:15:50 +0200
Message-ID: <20200413161605.95900-3-luc.vanoostenryck@gmail.com>
References: <20200413161605.95900-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731396AbgDMQQP (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 13 Apr 2020 12:16:15 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7984DC008748
        for <linux-sparse@vger.kernel.org>; Mon, 13 Apr 2020 09:16:14 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id z6so10556144wml.2
        for <linux-sparse@vger.kernel.org>; Mon, 13 Apr 2020 09:16:14 -0700 (PDT)
In-Reply-To: <20200413161605.95900-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

A goto to a reserved or a undeclared label will generate
an IR with a branch to a non-existing BB. Bad.

Add a testcase for these.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/linear/invalid-labels0.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 validation/linear/invalid-labels0.c

diff --git a/validation/linear/invalid-labels0.c b/validation/linear/invalid-labels0.c
new file mode 100644
index 000000000000..ae3bf7283fb8
--- /dev/null
+++ b/validation/linear/invalid-labels0.c
@@ -0,0 +1,19 @@
+static void foo(void)
+{
+	goto return;
+}
+
+void bar(void)
+{
+	goto neverland;
+}
+
+/*
+ * check-name: invalid-labels0
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-excludes: END
+ * check-error-ignore
+ */
-- 
2.26.0
