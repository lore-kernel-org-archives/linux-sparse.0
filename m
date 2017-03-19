From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 23/30] llvm: add test cases for degenerated pointers
Date: Sun, 19 Mar 2017 02:42:20 +0100
Message-ID: <20170319014227.8833-24-luc.vanoostenryck@gmail.com>
References: <20170319014227.8833-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36176 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751424AbdCSBnC (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 18 Mar 2017 21:43:02 -0400
Received: by mail-wr0-f196.google.com with SMTP id l37so13792252wrc.3
        for <linux-sparse@vger.kernel.org>; Sat, 18 Mar 2017 18:43:01 -0700 (PDT)
In-Reply-To: <20170319014227.8833-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/backend/degenerate-ptr.c | 72 +++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 validation/backend/degenerate-ptr.c

diff --git a/validation/backend/degenerate-ptr.c b/validation/backend/degenerate-ptr.c
new file mode 100644
index 000000000..8de979e06
--- /dev/null
+++ b/validation/backend/degenerate-ptr.c
@@ -0,0 +1,72 @@
+extern int array[3];
+extern int matrix[3][3];
+extern int fun(int);
+
+extern int fia(int []);
+extern int fip(int *);
+extern int fim(int (*)[3]);
+extern int fvp(void *);
+extern int ffp(int (*)(int));
+
+void call(void);
+void call(void)
+{
+	fia(array);
+
+	fip(array);
+	fim(matrix);
+
+	fvp(array);
+	fvp(matrix);
+
+	fvp(fun);
+	fvp(&fun);
+	ffp(fun);
+	ffp(&fun);
+}
+
+void local(void);
+void local(void)
+{
+	int *ip;
+	int (*im)[3];
+	void *vp;
+	int (*fp)(int);
+
+	ip = array;
+	im = matrix;
+
+	vp = array;
+	vp = matrix;
+
+	vp = fun;
+	vp = &fun;
+	fp = fun;
+	fp = &fun;
+}
+
+
+extern int *ip;
+extern int (*im)[3];
+extern void *vp;
+extern int (*fp)(int);
+
+void global(void);
+void global(void)
+{
+	ip = array;
+	im = matrix;
+
+	vp = array;
+	vp = matrix;
+
+	vp = fun;
+	vp = &fun;
+	fp = fun;
+	fp = &fun;
+}
+
+/*
+ * check-name: degenerated pointer handling
+ * check-command: ./sparsec -c $file -o tmp.o
+ */
-- 
2.12.0

