From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 04/29] add test case for incomplete type
Date: Wed, 16 Aug 2017 17:34:30 +0200
Message-ID: <20170816153455.97693-5-luc.vanoostenryck@gmail.com>
References: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33875 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751605AbdHPPfO (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 16 Aug 2017 11:35:14 -0400
Received: by mail-wr0-f193.google.com with SMTP id x43so3696342wrb.1
        for <linux-sparse@vger.kernel.org>; Wed, 16 Aug 2017 08:35:13 -0700 (PDT)
In-Reply-To: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Add a test case for the diagnostic of returning an
incomplete type.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/incomplete-struct.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 validation/incomplete-struct.c

diff --git a/validation/incomplete-struct.c b/validation/incomplete-struct.c
new file mode 100644
index 000000000..f9429f33a
--- /dev/null
+++ b/validation/incomplete-struct.c
@@ -0,0 +1,23 @@
+struct s;
+
+void foo(struct s s)
+{
+}
+
+struct s bar(void)
+{
+	struct s s;
+	return s;
+}
+
+/*
+ * check-name: incomplete struct
+ * check-command: sparse -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-error-start
+incomplete-struct.c:3:19: error: parameter 's' has incomplete type
+incomplete-struct.c:7:10: error: return type is incomplete
+incomplete-struct.c:9:11: error: 's' has incompelete type
+ * check-error-end
+ */
-- 
2.14.0

