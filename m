From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [SPARSE PATCH 2/5] add testcases for linearization of invalid labels
Date: Fri, 10 Apr 2020 20:49:15 +0200
Message-ID: <20200410184918.64692-3-luc.vanoostenryck@gmail.com>
References: <20200410184918.64692-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43171 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgDJStb (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 10 Apr 2020 14:49:31 -0400
Received: by mail-wr1-f68.google.com with SMTP id i10so3237807wrv.10
        for <linux-sparse@vger.kernel.org>; Fri, 10 Apr 2020 11:49:30 -0700 (PDT)
In-Reply-To: <20200410184918.64692-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

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
