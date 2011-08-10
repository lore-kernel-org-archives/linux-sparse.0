From: Chris Forbes <chrisf@ijw.co.nz>
Subject: [PATCH 1/2] add test case for identical exprs on LHS and RHS of '&&' operator
Date: Wed, 10 Aug 2011 21:07:14 +1200
Message-ID: <1312967235-23817-2-git-send-email-chrisf@ijw.co.nz>
References: <1312967235-23817-1-git-send-email-chrisf@ijw.co.nz>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:35936 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750922Ab1HJJHs (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 10 Aug 2011 05:07:48 -0400
Received: by gxk21 with SMTP id 21so529189gxk.19
        for <linux-sparse@vger.kernel.org>; Wed, 10 Aug 2011 02:07:48 -0700 (PDT)
In-Reply-To: <1312967235-23817-1-git-send-email-chrisf@ijw.co.nz>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Chris Forbes <chrisf@ijw.co.nz>

---
 validation/check_identical_exprs_on_and.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)
 create mode 100644 validation/check_identical_exprs_on_and.c

diff --git a/validation/check_identical_exprs_on_and.c b/validation/check_identical_exprs_on_and.c
new file mode 100644
index 0000000..712395d
--- /dev/null
+++ b/validation/check_identical_exprs_on_and.c
@@ -0,0 +1,24 @@
+extern void bar(void);
+
+static void foo(void *a, void *b, void *c)
+{
+	if (a && a)	/* should warn */
+		bar();
+
+	if (a && b)	/* should not warn */
+		bar();
+
+	if ((a == b) && (a == b))	/* should warn */
+		bar();
+
+	if ((a == b) && (b == c))	/* should not warn */
+		bar();
+}
+/*
+ * check-name: A warning should be issued for identical expressions on both sides of the '&&' operator.
+ *
+ * check-error-start
+check_identical_exprs_on_and.c:5:15: warning: identical expressions on both sides of '&&'
+check_identical_exprs_on_and.c:11:22: warning: identical expressions on both sides of '&&'
+ * check-error-end
+ */
-- 
1.7.4.1

