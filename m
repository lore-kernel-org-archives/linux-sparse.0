From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 16/27] llvm: add test cases for pointers passed as argument
Date: Sat, 11 Mar 2017 10:06:55 +0100
Message-ID: <20170311090706.17171-17-luc.vanoostenryck@gmail.com>
References: <20170311090706.17171-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35179 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755108AbdCKJHj (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Mar 2017 04:07:39 -0500
Received: by mail-wm0-f66.google.com with SMTP id z63so2305159wmg.2
        for <linux-sparse@vger.kernel.org>; Sat, 11 Mar 2017 01:07:38 -0800 (PST)
In-Reply-To: <20170311090706.17171-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Pekka Enberg <penberg@kernel.org>, Jeff Garzik <jeff@garzik.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/backend/pointer-param.c | 42 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 validation/backend/pointer-param.c

diff --git a/validation/backend/pointer-param.c b/validation/backend/pointer-param.c
new file mode 100644
index 000000000..b705e6f4d
--- /dev/null
+++ b/validation/backend/pointer-param.c
@@ -0,0 +1,42 @@
+extern int gfun(int);
+static int sfun(int a) { return a; }
+
+void usei(int *);
+void usef(int (*)(int));
+void usev(void *);
+
+void foo(int *p, int a[5], int (*pfun)(int));
+void foo(int *p, int a[5], int (*pfun)(int))
+{
+	extern int valg[5], valh[5], vali[5];
+	static int vals[5], valt[5], valr[5];
+	       int vala[5], valb[5], valc[5];
+
+	usei(p);
+	usei(valg);
+	usei(&valh[0]);
+	usei(&vali[1]);
+	usei(vals);
+	usei(&valt[0]);
+	usei(&valr[1]);
+	usei(vala);
+	usei(&valb[0]);
+	usei(&valc[1]);
+
+	usef(pfun);
+	usef(gfun);
+	usef(&gfun);
+	usef(sfun);
+	usef(&sfun);
+
+	usev(pfun);
+	usev(gfun);
+	usev(&gfun);
+	usev(sfun);
+	usev(&sfun);
+}
+
+/*
+ * check-name: pointer-param
+ * check-command: ./sparsec -c $file -o tmp.o
+ */
-- 
2.11.1

