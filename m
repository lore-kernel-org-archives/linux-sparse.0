From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/2] testsuite: add a script to normalize label names
Date: Mon, 21 Nov 2016 05:14:21 +0100
Message-ID: <20161121041421.34576-3-luc.vanoostenryck@gmail.com>
References: <20161121041421.34576-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34566 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752985AbcKUEOd (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 20 Nov 2016 23:14:33 -0500
Received: by mail-wm0-f66.google.com with SMTP id g23so23555238wme.1
        for <linux-sparse@vger.kernel.org>; Sun, 20 Nov 2016 20:14:33 -0800 (PST)
In-Reply-To: <20161121041421.34576-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

test-linearize displays basic block's labels by using
'.L0x' + plus the address of the bb struct. This is certainly
convenient as an UID but it has the disadvantage that these
labels names are not comparable between runs.

This complicate testing quite a bit.

This script more or less solve this by filtering the output of
test-linearize and change these names to some nice sequential
and comparable '.L1', '.L2', ...

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/normalize-bb        | 16 ++++++++++++++++
 validation/test-normalize-bb.c | 31 +++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)
 create mode 100755 validation/normalize-bb
 create mode 100644 validation/test-normalize-bb.c

diff --git a/validation/normalize-bb b/validation/normalize-bb
new file mode 100755
index 00000000..a7c7b73b
--- /dev/null
+++ b/validation/normalize-bb
@@ -0,0 +1,16 @@
+#!/bin/sh
+
+out=$(mktemp)
+sed=$(mktemp)
+
+n=0
+tee $out | grep '^\.L0x' | sort -u | \
+	sed 's/\(.L0x[0-9a-f]*\).*/\1/'	| \
+	while read l; do
+		n=$(($n + 1))
+		echo "s/$l/.L$n/"
+	done > $sed
+
+cat $out | sed -f $sed
+
+rm -f $out $sed
diff --git a/validation/test-normalize-bb.c b/validation/test-normalize-bb.c
new file mode 100644
index 00000000..57a5886e
--- /dev/null
+++ b/validation/test-normalize-bb.c
@@ -0,0 +1,31 @@
+/*
+ * test the normalization of basic block's names
+ */
+
+void use(int);
+void foo(int p);
+void foo(int p)
+{
+	if (p)
+		use(1);
+}
+
+/*
+ * check-name: test-normalize-bb
+ * check-command: test-linearize $file | ./normalize-bb
+ * check-output-start
+foo:
+.L1:
+	<entry-point>
+	br          %arg1, .L2, .L3
+
+.L2:
+	call        use, $1
+	br          .L3
+
+.L3:
+	ret
+
+
+ * check-output-end
+ */
-- 
2.10.2

