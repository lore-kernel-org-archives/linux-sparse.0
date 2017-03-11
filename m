From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 18/27] llvm: add test cases for degenerated pointers
Date: Sat, 11 Mar 2017 10:06:57 +0100
Message-ID: <20170311090706.17171-19-luc.vanoostenryck@gmail.com>
References: <20170311090706.17171-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35189 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755129AbdCKJHl (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Mar 2017 04:07:41 -0500
Received: by mail-wm0-f67.google.com with SMTP id z63so2305219wmg.2
        for <linux-sparse@vger.kernel.org>; Sat, 11 Mar 2017 01:07:40 -0800 (PST)
In-Reply-To: <20170311090706.17171-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Pekka Enberg <penberg@kernel.org>, Jeff Garzik <jeff@garzik.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

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
2.11.1

