From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/2] CSE: split optim/cse-dual-compare.c in two files
Date: Wed, 12 Apr 2017 14:59:11 +0200
Message-ID: <20170412125912.46641-2-luc.vanoostenryck@gmail.com>
References: <20170412125912.46641-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34539 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753214AbdDLNB3 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 12 Apr 2017 09:01:29 -0400
Received: by mail-wm0-f66.google.com with SMTP id x75so6270802wma.1
        for <linux-sparse@vger.kernel.org>; Wed, 12 Apr 2017 06:01:28 -0700 (PDT)
In-Reply-To: <20170412125912.46641-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This is a preparatory step for the nex patch
(half of the tests will succeed).

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 .../optim/{cse-dual-compare.c => cse-dual-cmpeq.c} | 10 +-----
 validation/optim/cse-dual-cmpne.c                  | 40 ++++++++++++++++++++++
 2 files changed, 41 insertions(+), 9 deletions(-)
 rename validation/optim/{cse-dual-compare.c => cse-dual-cmpeq.c} (69%)
 create mode 100644 validation/optim/cse-dual-cmpne.c

diff --git a/validation/optim/cse-dual-compare.c b/validation/optim/cse-dual-cmpeq.c
similarity index 69%
rename from validation/optim/cse-dual-compare.c
rename to validation/optim/cse-dual-cmpeq.c
index b43cf7899..45ceee12d 100644
--- a/validation/optim/cse-dual-compare.c
+++ b/validation/optim/cse-dual-cmpeq.c
@@ -14,16 +14,8 @@ static int enlelt(int a, int b) { return (a <= b) == !(b <  a); }
 static int engegt(int a, int b) { return (a >= b) == !(b >  a); }
 static int engtge(int a, int b) { return (a >  b) == !(b >= a); }
 
-static int neeqne(int a, int b) { return (a == b) != (b != a); }
-static int neneeq(int a, int b) { return (a != b) != (b == a); }
-
-static int neltle(int a, int b) { return (a <  b) != (b <= a); }
-static int nelelt(int a, int b) { return (a <= b) != (b <  a); }
-static int negegt(int a, int b) { return (a >= b) != (b >  a); }
-static int negtge(int a, int b) { return (a >  b) != (b >= a); }
-
 /*
- * check-name: cse-dual-compare
+ * check-name: cse-dual-cmpeq
  * check-command: test-linearize $file
  * check-output-ignore
  * check-known-to-fail
diff --git a/validation/optim/cse-dual-cmpne.c b/validation/optim/cse-dual-cmpne.c
new file mode 100644
index 000000000..489150c32
--- /dev/null
+++ b/validation/optim/cse-dual-cmpne.c
@@ -0,0 +1,40 @@
+int eqeqnea(int a, int b) { return (a == b) == (a != b); }
+int eqneeqa(int a, int b) { return (a != b) == (a == b); }
+int eqeqneb(int a, int b) { return (a == b) == (b != a); }
+int eqneeqb(int a, int b) { return (a != b) == (b == a); }
+
+int eqltlea(int a, int b) { return (a <  b) == (a >= b); }
+int eqlelta(int a, int b) { return (a <= b) == (a >  b); }
+int eqgegta(int a, int b) { return (a >= b) == (a <  b); }
+int eqgtgea(int a, int b) { return (a >  b) == (a <= b); }
+
+int eqltleb(int a, int b) { return (a <  b) == (b <= a); }
+int eqleltb(int a, int b) { return (a <= b) == (b <  a); }
+int eqgegtb(int a, int b) { return (a >= b) == (b >  a); }
+int eqgtgeb(int a, int b) { return (a >  b) == (b >= a); }
+
+int neeqnea(int a, int b) { return (a == b) != (a != b); }
+int neneeqa(int a, int b) { return (a != b) != (a == b); }
+int neeqneb(int a, int b) { return (a == b) != (b != a); }
+int neneeqb(int a, int b) { return (a != b) != (b == a); }
+
+int neltlea(int a, int b) { return (a <  b) != (a >= b); }
+int nelelta(int a, int b) { return (a <= b) != (a >  b); }
+int negegta(int a, int b) { return (a >= b) != (a <  b); }
+int negtgea(int a, int b) { return (a >  b) != (a <= b); }
+
+int neltleb(int a, int b) { return (a <  b) != (b <= a); }
+int neleltb(int a, int b) { return (a <= b) != (b <  a); }
+int negegtb(int a, int b) { return (a >= b) != (b >  a); }
+int negtgeb(int a, int b) { return (a >  b) != (b >= a); }
+
+/*
+ * check-name: cse-dual-cmpne
+ * check-command: test-linearize $file
+ * check-output-ignore
+ * check-known-to-fail
+ *
+ * check-output-excludes: set[gl][et]\\.
+ * check-output-excludes: seteq\\.
+ * check-output-excludes: setne\\.
+ */
-- 
2.12.0

