From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 02/15] add test case for VLA sizeof
Date: Fri, 15 Sep 2017 10:46:51 +0200
Message-ID: <20170915084704.39196-3-luc.vanoostenryck@gmail.com>
References: <20170915084704.39196-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38722 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751111AbdIOIrM (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 15 Sep 2017 04:47:12 -0400
Received: by mail-wm0-f68.google.com with SMTP id x17so2140357wmd.5
        for <linux-sparse@vger.kernel.org>; Fri, 15 Sep 2017 01:47:12 -0700 (PDT)
In-Reply-To: <20170915084704.39196-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/vla-sizeof.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 validation/vla-sizeof.c

diff --git a/validation/vla-sizeof.c b/validation/vla-sizeof.c
new file mode 100644
index 000000000..43079992c
--- /dev/null
+++ b/validation/vla-sizeof.c
@@ -0,0 +1,37 @@
+unsigned long vla_sizeof0(int size)
+{
+	int a[size];
+	return sizeof(a);
+}
+
+unsigned long vla_sizeof1(int size)
+{
+	struct s {
+		int a[size];
+	};
+	return sizeof(struct s);
+}
+
+unsigned long vla_sizeof2(int size)
+{
+	struct s {
+		int a[size];
+	} *p;
+	return sizeof(*p);
+}
+
+void* vla_inc(int size, void *base)
+{
+	struct s {
+		int a[size];
+	} *p = base;
+
+	++p;
+	return p;
+}
+
+/*
+ * check-name: vla-sizeof.c
+ *
+ * check-known-to-fail
+ */
-- 
2.14.0

