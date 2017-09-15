From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 09/15] add test case for bad layout of bool in bitfields
Date: Fri, 15 Sep 2017 10:46:58 +0200
Message-ID: <20170915084704.39196-10-luc.vanoostenryck@gmail.com>
References: <20170915084704.39196-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38772 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750838AbdIOIrT (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 15 Sep 2017 04:47:19 -0400
Received: by mail-wm0-f68.google.com with SMTP id x17so2140644wmd.5
        for <linux-sparse@vger.kernel.org>; Fri, 15 Sep 2017 01:47:19 -0700 (PDT)
In-Reply-To: <20170915084704.39196-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/bitfield-bool-layout.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 validation/bitfield-bool-layout.c

diff --git a/validation/bitfield-bool-layout.c b/validation/bitfield-bool-layout.c
new file mode 100644
index 000000000..4e0a2b4a2
--- /dev/null
+++ b/validation/bitfield-bool-layout.c
@@ -0,0 +1,26 @@
+struct bfb {
+	_Bool a:1;
+	_Bool f:1;
+	_Bool z:1;
+};
+
+
+struct bfb foo(struct bfb s)
+{
+	return s;
+}
+
+/*
+ * check-name: bitfield-bool-layout
+ * check-description: given that bool is here 1-bit wide
+ *	each field here above completely 'fill' a bool.
+ *	Thus 3 bools need to be allocated, but since the
+ *	alignment is 1-byte the result has a size of 3
+ *	bytes, 24 bits thus instead of 8.
+ * check-command: test-linearize -Wno-decl $file
+ *
+ * check-known-to-fail
+ * check-output-ignore
+ * check-output-excludes: ret\\.24
+ * check-output-contains: ret\\.8
+ */
-- 
2.14.0

