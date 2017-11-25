From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/2] add test case unexamined base type
Date: Sat, 25 Nov 2017 10:31:14 +0100
Message-ID: <20171125093115.95791-2-luc.vanoostenryck@gmail.com>
References: <20171125093115.95791-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37819 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750819AbdKYJdi (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 25 Nov 2017 04:33:38 -0500
Received: by mail-wm0-f66.google.com with SMTP id v186so26317380wma.2
        for <linux-sparse@vger.kernel.org>; Sat, 25 Nov 2017 01:33:38 -0800 (PST)
In-Reply-To: <20171125093115.95791-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/bugs/unexamined-base-type-00.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 validation/bugs/unexamined-base-type-00.c

diff --git a/validation/bugs/unexamined-base-type-00.c b/validation/bugs/unexamined-base-type-00.c
new file mode 100644
index 000000000..2032599b7
--- /dev/null
+++ b/validation/bugs/unexamined-base-type-00.c
@@ -0,0 +1,29 @@
+# define __force	__attribute__((force))
+
+
+struct s {
+	int a;
+};
+
+static int foo(struct s *s)
+{
+	return (*((typeof(s->a) __force *) &s->a)) & 1;
+}
+
+
+/*
+ * check-name: unexamined base type 00
+ * check-command: test-linearize -Wno-decl $file
+ * check-description:
+ *	The wrong generated is:
+ *		ptrcast.64  %r3 <- (64) %arg1
+ *		load        %r4 <- 0[%r3]	; !! WRONG
+ *		cast.32     %r5 <- (0) %r4	; !! WRONG
+ *		and.32      %r6 <- %r5, $1
+ *		ret.32      %r6
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-excludes: load[^.]
+ * check-output-excludes: cast\..*(0)
+ */
-- 
2.15.0

