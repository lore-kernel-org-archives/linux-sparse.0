From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/4] add test cases for canonicalization of mul chains
Date: Fri, 15 Sep 2017 10:55:09 +0200
Message-ID: <20170915085511.43429-3-luc.vanoostenryck@gmail.com>
References: <20170915085511.43429-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36332 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751146AbdIOIzT (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 15 Sep 2017 04:55:19 -0400
Received: by mail-wm0-f68.google.com with SMTP id r136so2169274wmf.3
        for <linux-sparse@vger.kernel.org>; Fri, 15 Sep 2017 01:55:19 -0700 (PDT)
In-Reply-To: <20170915085511.43429-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/optim/canonical-mul.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 validation/optim/canonical-mul.c

diff --git a/validation/optim/canonical-mul.c b/validation/optim/canonical-mul.c
new file mode 100644
index 000000000..90d59f2e2
--- /dev/null
+++ b/validation/optim/canonical-mul.c
@@ -0,0 +1,24 @@
+#define uint unsigned int
+
+uint xtc_umul_ytc(uint x, uint y) { return (x * 3) * (y * 2); }
+
+/*
+ * check-name: canonical-muldiv
+ * check-description:
+ *	1) verify that constants in mul chains are
+ *	   pushed at the right of the whole chain.
+ *	   For example '(a * 3) * b' must be canonicalized into '(a * b) * 1'
+ *	   This is needed in general for constant simplification;
+ *	   for example, for:
+ *		'(a * 3) * (b * 2)'
+ *	   to be simplified into:
+ *		'(a * b) * 6'
+ *
+ * check-command: test-linearize -Wno-decl $file
+ * check-known-to-fail
+ * check-output-ignore
+ *
+ * check-output-excludes: \$3
+ * check-output-excludes: \$2
+ * check-output-contains: \$6
+ */
-- 
2.14.0

