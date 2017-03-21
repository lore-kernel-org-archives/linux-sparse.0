From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 30/63] llvm: add test cases for degenerated pointers
Date: Tue, 21 Mar 2017 01:15:34 +0100
Message-ID: <20170321001607.75169-31-luc.vanoostenryck@gmail.com>
References: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34861 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755969AbdCUAQx (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 20 Mar 2017 20:16:53 -0400
Received: by mail-wm0-f66.google.com with SMTP id z133so258502wmb.2
        for <linux-sparse@vger.kernel.org>; Mon, 20 Mar 2017 17:16:52 -0700 (PDT)
In-Reply-To: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

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

