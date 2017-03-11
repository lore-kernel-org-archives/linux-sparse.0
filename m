From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 15/27] llvm: add test cases for symbol's address
Date: Sat, 11 Mar 2017 10:06:54 +0100
Message-ID: <20170311090706.17171-16-luc.vanoostenryck@gmail.com>
References: <20170311090706.17171-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33121 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755424AbdCKJHi (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Mar 2017 04:07:38 -0500
Received: by mail-wm0-f67.google.com with SMTP id n11so2315158wma.0
        for <linux-sparse@vger.kernel.org>; Sat, 11 Mar 2017 01:07:37 -0800 (PST)
In-Reply-To: <20170311090706.17171-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Pekka Enberg <penberg@kernel.org>, Jeff Garzik <jeff@garzik.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/backend/symaddr.c | 70 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 validation/backend/symaddr.c

diff --git a/validation/backend/symaddr.c b/validation/backend/symaddr.c
new file mode 100644
index 000000000..71fb9deff
--- /dev/null
+++ b/validation/backend/symaddr.c
@@ -0,0 +1,70 @@
+extern void useip(int *);
+extern void useia(int (*)[3]);
+extern void usevp(void *);
+static int  sfun(void) { return 0; }
+static int  spun(void) { return 0; }
+
+void lfoo(int *p, int a)
+{
+	int larra[3], larrb[3], larrc[3], larrd[3], larre[3], larrf[3];
+	useip(p);
+	useip(larra);
+	useip(larrb + 1);
+	useip(larrc + a);
+	useip(&larrd[1]);
+	useip(&larre[a]);
+	useia(&larrf);
+}
+
+static int sarra[3], sarrb[3], sarrc[3], sarrd[3], sarre[3], sarrf[3];
+static int s, sfun(void), spun(void);
+void sfoo(int *p, int a)
+{
+	useip(p);
+	useip(&s);
+	useip(sarra);
+	useip(sarrb + 1);
+	useip(sarrc + a);
+	useip(&sarrd[1]);
+	useip(&sarre[a]);
+	useia(&sarrf);
+	usevp(sfun);
+	usevp(&spun);
+}
+
+extern int xarra[3], xarrb[3], xarrc[3], xarrd[3], xarre[3], xarrf[3];
+extern int x, xfun(void), xpun(void);
+void xfoo(int *p, int a)
+{
+	useip(p);
+	useip(&x);
+	useip(xarra);
+	useip(xarrb + 1);
+	useip(xarrc + a);
+	useip(&xarrd[1]);
+	useip(&xarre[a]);
+	useia(&xarrf);
+	usevp(xfun);
+	usevp(&xpun);
+}
+
+int garra[3], garrb[3], garrc[3], garrd[3], garre[3], garrf[3];
+int g, gfun(void), gpun(void);
+void gfoo(int *p, int a)
+{
+	useip(p);
+	useip(&g);
+	useip(garra);
+	useip(garrb + 1);
+	useip(garrc + a);
+	useip(&garrd[1]);
+	useip(&garre[a]);
+	useia(&garrf);
+	usevp(gfun);
+	usevp(&gpun);
+}
+
+/*
+ * check-name: symbol address
+ * check-command: ./sparsec -Wno-decl -c $file -o tmp.o
+ */
-- 
2.11.1

