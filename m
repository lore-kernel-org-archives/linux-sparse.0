From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 20/30] llvm: add test cases for symbol's address
Date: Sun, 19 Mar 2017 02:42:17 +0100
Message-ID: <20170319014227.8833-21-luc.vanoostenryck@gmail.com>
References: <20170319014227.8833-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35310 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751416AbdCSBm7 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 18 Mar 2017 21:42:59 -0400
Received: by mail-wr0-f196.google.com with SMTP id u108so13841359wrb.2
        for <linux-sparse@vger.kernel.org>; Sat, 18 Mar 2017 18:42:58 -0700 (PDT)
In-Reply-To: <20170319014227.8833-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/backend/symaddr.c | 62 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 validation/backend/symaddr.c

diff --git a/validation/backend/symaddr.c b/validation/backend/symaddr.c
new file mode 100644
index 000000000..71bca2d76
--- /dev/null
+++ b/validation/backend/symaddr.c
@@ -0,0 +1,62 @@
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
+	useip(&larrd[1]);
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
+	useip(&sarrd[1]);
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
+	useip(&xarrd[1]);
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
+	useip(&garrd[1]);
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
2.12.0

