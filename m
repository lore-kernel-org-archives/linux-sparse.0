From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/4] CSE: add test cases for comparisons duality
Date: Fri, 17 Feb 2017 00:12:28 +0100
Message-ID: <20170216231231.5781-2-luc.vanoostenryck@gmail.com>
References: <20170216231231.5781-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35302 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933735AbdBPXOl (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 16 Feb 2017 18:14:41 -0500
Received: by mail-wm0-f68.google.com with SMTP id u63so5235031wmu.2
        for <linux-sparse@vger.kernel.org>; Thu, 16 Feb 2017 15:14:41 -0800 (PST)
In-Reply-To: <20170216231231.5781-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/optim/cse-dual-compare.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 validation/optim/cse-dual-compare.c

diff --git a/validation/optim/cse-dual-compare.c b/validation/optim/cse-dual-compare.c
new file mode 100644
index 000000000..b43cf7899
--- /dev/null
+++ b/validation/optim/cse-dual-compare.c
@@ -0,0 +1,34 @@
+static int eqeq(int a, int b) { return (a == b) == (b == a); }
+static int nene(int a, int b) { return (a != b) == (b != a); }
+
+static int ltgt(int a, int b) { return (a <  b) == (b >  a); }
+static int lege(int a, int b) { return (a <= b) == (b >= a); }
+static int gele(int a, int b) { return (a >= b) == (b <= a); }
+static int gtlt(int a, int b) { return (a >  b) == (b <  a); }
+
+static int eneqne(int a, int b) { return (a == b) == !(b != a); }
+static int enneeq(int a, int b) { return (a != b) == !(b == a); }
+
+static int enltle(int a, int b) { return (a <  b) == !(b <= a); }
+static int enlelt(int a, int b) { return (a <= b) == !(b <  a); }
+static int engegt(int a, int b) { return (a >= b) == !(b >  a); }
+static int engtge(int a, int b) { return (a >  b) == !(b >= a); }
+
+static int neeqne(int a, int b) { return (a == b) != (b != a); }
+static int neneeq(int a, int b) { return (a != b) != (b == a); }
+
+static int neltle(int a, int b) { return (a <  b) != (b <= a); }
+static int nelelt(int a, int b) { return (a <= b) != (b <  a); }
+static int negegt(int a, int b) { return (a >= b) != (b >  a); }
+static int negtge(int a, int b) { return (a >  b) != (b >= a); }
+
+/*
+ * check-name: cse-dual-compare
+ * check-command: test-linearize $file
+ * check-output-ignore
+ * check-known-to-fail
+ *
+ * check-output-excludes: set[gl][et]\\.
+ * check-output-excludes: seteq\\.
+ * check-output-excludes: setne\\.
+ */
-- 
2.11.0

