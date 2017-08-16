From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 05/29] add test case for bad return type
Date: Wed, 16 Aug 2017 17:34:31 +0200
Message-ID: <20170816153455.97693-6-luc.vanoostenryck@gmail.com>
References: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:38796 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751637AbdHPPfQ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 16 Aug 2017 11:35:16 -0400
Received: by mail-wr0-f195.google.com with SMTP id g32so3682370wrd.5
        for <linux-sparse@vger.kernel.org>; Wed, 16 Aug 2017 08:35:15 -0700 (PDT)
In-Reply-To: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

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

