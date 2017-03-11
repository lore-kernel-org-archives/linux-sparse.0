From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 09/27] llvm: add test cases for the type of constants
Date: Sat, 11 Mar 2017 10:06:48 +0100
Message-ID: <20170311090706.17171-10-luc.vanoostenryck@gmail.com>
References: <20170311090706.17171-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33087 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755338AbdCKJHb (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Mar 2017 04:07:31 -0500
Received: by mail-wm0-f65.google.com with SMTP id n11so2314818wma.0
        for <linux-sparse@vger.kernel.org>; Sat, 11 Mar 2017 01:07:30 -0800 (PST)
In-Reply-To: <20170311090706.17171-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Pekka Enberg <penberg@kernel.org>, Jeff Garzik <jeff@garzik.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/backend/type-constant.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 validation/backend/type-constant.c

diff --git a/validation/backend/type-constant.c b/validation/backend/type-constant.c
new file mode 100644
index 000000000..cded7f2ea
--- /dev/null
+++ b/validation/backend/type-constant.c
@@ -0,0 +1,23 @@
+char creti(void) { return 3; }
+int  ireti(void) { return 3; }
+long lreti(void) { return 3; }
+
+char cinii(void) { char r = 3; return r; }
+int  iinii(void) { int  r = 3; return r; }
+long linii(void) { long r = 3; return r; }
+
+
+void *vretn(void) { return (void*)0; }
+char *cretn(void) { return (void*)0; }
+int  *iretn(void) { return (void*)0; }
+long *lretn(void) { return (void*)0; }
+
+void *vinin(void) { void *r = (void*)0; return r; }
+char *cinin(void) { char *r = (void*)0; return r; }
+int  *iinin(void) { int  *r = (void*)0; return r; }
+long *linin(void) { long *r = (void*)0; return r; }
+
+/*
+ * check-name: type-constant
+ * check-command: ./sparsec -Wno-decl -c $file -o r.o
+ */
-- 
2.11.1

