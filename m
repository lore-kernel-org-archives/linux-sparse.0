From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 29/63] llvm: add test cases for arrays passed as argument
Date: Tue, 21 Mar 2017 01:15:33 +0100
Message-ID: <20170321001607.75169-30-luc.vanoostenryck@gmail.com>
References: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34857 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755951AbdCUAQw (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 20 Mar 2017 20:16:52 -0400
Received: by mail-wm0-f67.google.com with SMTP id z133so258477wmb.2
        for <linux-sparse@vger.kernel.org>; Mon, 20 Mar 2017 17:16:51 -0700 (PDT)
In-Reply-To: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/backend/function-ptr.c | 148 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 145 insertions(+), 3 deletions(-)

diff --git a/validation/backend/function-ptr.c b/validation/backend/function-ptr.c
index fc022b3cd..47e85deab 100644
--- a/validation/backend/function-ptr.c
+++ b/validation/backend/function-ptr.c
@@ -1,8 +1,150 @@
-typedef int (*fn_t)(int x, int y);
+extern int ival;
+extern int *ipval;
+extern int array[3];
+extern int matrix[3][3];
+extern int fun(int);
 
-static int run(fn_t fn, int x, int y)
+// via an argument
+void arg(int a, int *p, int (*fb)(unsigned char), int (*fi)(int), int (*fl)(long), int (*fv)(void), int (*fip)(int *), int (*fim)(int (*)[3]), int (*fvp)(void *), int (*ffp)(int (*)(int)));
+void arg(int a, int *p, int (*fb)(unsigned char), int (*fi)(int), int (*fl)(long), int (*fv)(void), int (*fip)(int *), int (*fim)(int (*)[3]), int (*fvp)(void *), int (*ffp)(int (*)(int)))
 {
-	return fn(x, y);
+	fv();
+
+	fb(a);
+	fi(a);
+	fl(a);
+	fb(123);
+	fi(123);
+	fl(123);
+	fb(123L);
+	fi(123L);
+	fl(123L);
+	fb(ival);
+	fi(ival);
+	fl(ival);
+
+	fip(p);
+	fip((void*)0);
+	fip(ipval);
+	fip(&ival);
+	fip(array);
+	fim(matrix);
+
+	fvp(p);
+	fvp((void*)0);
+	fvp(ipval);
+	fvp(&ival);
+	fvp(array);
+	fvp(matrix);
+
+	fvp(fun);
+	fvp(&fun);
+	ffp(fun);
+	ffp(&fun);
+}
+
+// a global
+extern int (*fb)(unsigned char);
+extern int (*fi)(int);
+extern int (*fl)(long);
+extern int (*fv)(void);
+extern int (*fip)(int *);
+extern int (*fim)(int (*)[3]);
+extern int (*fvp)(void *);
+extern int (*ffp)(int (*)(int));
+
+void glb(int a, int *p);
+void glb(int a, int *p)
+{
+	fv();
+
+	fb(a);
+	fi(a);
+	fl(a);
+	fb(123);
+	fi(123);
+	fl(123);
+	fb(123L);
+	fi(123L);
+	fl(123L);
+	fb(ival);
+	fi(ival);
+	fl(ival);
+
+	fip(p);
+	fip((void*)0);
+	fip(ipval);
+	fip(&ival);
+	fip(array);
+	fim(matrix);
+
+	fvp(p);
+	fvp((void*)0);
+	fvp(ipval);
+	fvp(&ival);
+	fvp(array);
+	fvp(matrix);
+
+	fvp(fun);
+	fvp(&fun);
+	ffp(fun);
+	ffp(&fun);
+}
+
+// via a struct member:
+// -> force to create a register containing the function pointer
+struct ops {
+	int (*fb)(unsigned char);
+	int (*fi)(int);
+	int (*fl)(long);
+	int (*fv)(void);
+	int (*fip)(int *);
+	int (*fim)(int (*)[3]);
+	int (*fvp)(void *);
+	int (*ffp)(int (*)(int));
+
+	int (*const cfi)(int);		// for the fun of it
+};
+
+void ops(int a, int *p, struct ops *ops);
+void ops(int a, int *p, struct ops *ops)
+{
+	ops->fv();
+
+	ops->fb(a);
+	ops->fi(a);
+	ops->fl(a);
+	ops->fb(123);
+	ops->fi(123);
+	ops->fl(123);
+	ops->fb(123L);
+	ops->fi(123L);
+	ops->fl(123L);
+	ops->fb(ival);
+	ops->fi(ival);
+	ops->fl(ival);
+
+	ops->fip(p);
+	ops->fip((void*)0);
+	ops->fip(ipval);
+	ops->fip(&ival);
+	ops->fip(array);
+	ops->fim(matrix);
+
+	ops->fvp(p);
+	ops->fvp((void*)0);
+	ops->fvp(ipval);
+	ops->fvp(&ival);
+	ops->fvp(array);
+	ops->fvp(matrix);
+
+	ops->fvp(fun);
+	ops->fvp(&fun);
+	ops->ffp(fun);
+	ops->ffp(&fun);
+	ops->fvp(fi);
+
+	ops->cfi(42);
 }
 
 /*
-- 
2.12.0

