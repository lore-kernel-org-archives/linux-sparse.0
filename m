From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC PATCH 06/48] add test case for bad return type
Date: Wed, 23 Aug 2017 22:15:12 +0200
Message-ID: <20170823201554.90551-7-luc.vanoostenryck@gmail.com>
References: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37031 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932443AbdHWUQN (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 23 Aug 2017 16:16:13 -0400
Received: by mail-wm0-f65.google.com with SMTP id v186so630087wmf.4
        for <linux-sparse@vger.kernel.org>; Wed, 23 Aug 2017 13:16:13 -0700 (PDT)
In-Reply-To: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

add test cases for the diagnostic of:
- void function returning an integer
- int function returning with a bare 'return'

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/bad-return-type.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 validation/bad-return-type.c

diff --git a/validation/bad-return-type.c b/validation/bad-return-type.c
new file mode 100644
index 000000000..0f3b3f516
--- /dev/null
+++ b/validation/bad-return-type.c
@@ -0,0 +1,19 @@
+void foo(int a)
+{
+	return a;
+}
+
+int bar(void)
+{
+	return;
+}
+
+/*
+ * check-name: bad return type
+ * check-command: sparse -Wno-decl $file
+ *
+ * check-error-start
+bad-return-type.c:3:16: error: return expression in void function
+bad-return-type.c:8:9: error: return with no return value
+ * check-error-end
+ */
-- 
2.14.0

