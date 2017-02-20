From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 2/5] add test case for scope of C99 for-loop declarations
Date: Mon, 20 Feb 2017 08:20:49 +0100
Message-ID: <20170220072052.2429-3-luc.vanoostenryck@gmail.com>
References: <1ebf742e-5680-4160-6dc5-808fcfb5cc44@ramsayjones.plus.com>
 <20170220072052.2429-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34221 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750872AbdBTHcQ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 20 Feb 2017 02:32:16 -0500
Received: by mail-wm0-f65.google.com with SMTP id c85so12722946wmi.1
        for <linux-sparse@vger.kernel.org>; Sun, 19 Feb 2017 23:30:58 -0800 (PST)
In-Reply-To: <20170220072052.2429-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

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

