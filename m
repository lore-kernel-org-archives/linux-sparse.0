From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 2/6] add test case for scope of C99 for-loop declarations
Date: Sun,  5 Mar 2017 20:21:48 +0100
Message-ID: <20170305192152.67931-3-luc.vanoostenryck@gmail.com>
References: <CANeU7Qk34VzZ6Q2oxEcFrreK=NOwmpSGbiVgvyckpp154xWJaQ@mail.gmail.com>
 <20170305192152.67931-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33387 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752371AbdCETWl (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Mar 2017 14:22:41 -0500
Received: by mail-wr0-f196.google.com with SMTP id g10so19279118wrg.0
        for <linux-sparse@vger.kernel.org>; Sun, 05 Mar 2017 11:22:01 -0800 (PST)
In-Reply-To: <20170305192152.67931-1-luc.vanoostenryck@gmail.com>
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
2.11.1

