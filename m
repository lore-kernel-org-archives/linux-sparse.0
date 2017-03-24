From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v5 18/51] llvm: add test cases for degenerated pointers
Date: Sat, 25 Mar 2017 00:20:24 +0100
Message-ID: <20170324232057.15033-19-luc.vanoostenryck@gmail.com>
References: <20170324232057.15033-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33096 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935390AbdCXXXp (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 24 Mar 2017 19:23:45 -0400
Received: by mail-wm0-f65.google.com with SMTP id n11so820645wma.0
        for <linux-sparse@vger.kernel.org>; Fri, 24 Mar 2017 16:23:44 -0700 (PDT)
In-Reply-To: <20170324232057.15033-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

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

