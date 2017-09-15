From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 08/15] add test case using sizeof on incomplete type
Date: Fri, 15 Sep 2017 10:46:57 +0200
Message-ID: <20170915084704.39196-9-luc.vanoostenryck@gmail.com>
References: <20170915084704.39196-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38766 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751146AbdIOIrS (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 15 Sep 2017 04:47:18 -0400
Received: by mail-wm0-f66.google.com with SMTP id x17so2140603wmd.5
        for <linux-sparse@vger.kernel.org>; Fri, 15 Sep 2017 01:47:18 -0700 (PDT)
In-Reply-To: <20170915084704.39196-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/sizeof-incomplete-type.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 validation/sizeof-incomplete-type.c

diff --git a/validation/sizeof-incomplete-type.c b/validation/sizeof-incomplete-type.c
new file mode 100644
index 000000000..9fba00b38
--- /dev/null
+++ b/validation/sizeof-incomplete-type.c
@@ -0,0 +1,27 @@
+struct s {
+	char a;
+	char b[sizeof(struct s)];
+	char c;
+	char d[sizeof(struct s)];
+	int  j:sizeof(struct s);
+};
+
+static int array[] = {
+	[0]		= 0,
+	[sizeof(array)] = 1,
+	[2]		= 0,
+	[sizeof(array)] = 2,
+};
+
+/*
+ * check-name: sizeof incomplete type
+ *
+ * check-known-to-fail
+ * check-error-start
+sizeof-incomplete-type.c:3:16: error: invalid application of 'sizeof' to incomplete type 'struct s'
+sizeof-incomplete-type.c:5:16: error: invalid application of 'sizeof' to incomplete type 'struct s'
+sizeof-incomplete-type.c:6:16: error: invalid application of 'sizeof' to incomplete type 'struct s'
+sizeof-incomplete-type.c:11:17: error: invalid application of 'sizeof' to incomplete type 'int[]'
+sizeof-incomplete-type.c:13:17: error: invalid application of 'sizeof' to incomplete type 'int[]'
+ * check-error-end
+ */
-- 
2.14.0

