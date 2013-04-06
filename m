From: Masatake YAMATO <yamato@redhat.com>
Subject: [PATCH 2/3] Test case for -Winit-cstring option
Date: Sun,  7 Apr 2013 01:58:56 +0900
Message-ID: <1365267537-3787-2-git-send-email-yamato@redhat.com>
References: <1365267537-3787-1-git-send-email-yamato@redhat.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from h219-110-095-248.catv01.itscom.jp ([219.110.95.248]:53280 "EHLO
	localhost.localdomain" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751780Ab3DFRLE (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 6 Apr 2013 13:11:04 -0400
In-Reply-To: <1365267537-3787-1-git-send-email-yamato@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: yamato@redhat.com

This patch added a test case for -Winit-cstring option
to validation directory.

Signed-off-by: Masatake YAMATO <yamato@redhat.com>
---
 validation/init_cstring.c | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 validation/init_cstring.c

diff --git a/validation/init_cstring.c b/validation/init_cstring.c
new file mode 100644
index 0000000..00eca20
--- /dev/null
+++ b/validation/init_cstring.c
@@ -0,0 +1,11 @@
+static struct alpha {
+  char a[2];
+} x = { .a = "ab" };
+/*
+ * check-name: -Winit-cstring option
+ *
+ * check-command: sparse -Winit-cstring $file
+ * check-error-start
+init_cstring.c:3:14: warning: too long initializer-string for array of char(no space for nul char)
+ * check-error-end
+ */
-- 
1.7.11.7

