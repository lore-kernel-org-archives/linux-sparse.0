From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 21/30] llvm: add test cases for pointers passed as argument
Date: Sun, 19 Mar 2017 02:42:18 +0100
Message-ID: <20170319014227.8833-22-luc.vanoostenryck@gmail.com>
References: <20170319014227.8833-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34305 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751417AbdCSBnA (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 18 Mar 2017 21:43:00 -0400
Received: by mail-wr0-f195.google.com with SMTP id u48so13843140wrc.1
        for <linux-sparse@vger.kernel.org>; Sat, 18 Mar 2017 18:42:59 -0700 (PDT)
In-Reply-To: <20170319014227.8833-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

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
2.12.0

