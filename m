From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/5] add test case for scope of C99 for-loop declarations
Date: Sat, 18 Feb 2017 21:30:45 +0100
Message-ID: <20170218203048.22276-3-luc.vanoostenryck@gmail.com>
References: <20170218203048.22276-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33760 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753461AbdBRUa5 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 18 Feb 2017 15:30:57 -0500
Received: by mail-wr0-f196.google.com with SMTP id g51so1268345wrg.0
        for <linux-sparse@vger.kernel.org>; Sat, 18 Feb 2017 12:30:57 -0800 (PST)
In-Reply-To: <20170218203048.22276-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Insure that variable declared inside a C99 for-loop
have their scope restricted to this loop.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/c99-for-loop-decl.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 validation/c99-for-loop-decl.c

diff --git a/validation/c99-for-loop-decl.c b/validation/c99-for-loop-decl.c
new file mode 100644
index 000000000..c2ceaab99
--- /dev/null
+++ b/validation/c99-for-loop-decl.c
@@ -0,0 +1,18 @@
+static int bad_scope(void)
+{
+	int r = 0;
+
+	for (int i = 0; i < 10; i++) {
+		r = i;
+	}
+
+	return i;			/* check-should-fail */
+}
+
+/*
+ * check-name: C99 for-loop declarations
+ *
+ * check-error-start
+c99-for-loop-decl.c:9:16: error: undefined identifier 'i'
+ * check-error-end
+ */
-- 
2.11.0

