From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v5 07/14] inlined calls should not block BB packing
Date: Sat, 25 Mar 2017 00:14:14 +0100
Message-ID: <20170324231421.14869-8-luc.vanoostenryck@gmail.com>
References: <20170324231421.14869-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35913 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755312AbdCXXOg (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 24 Mar 2017 19:14:36 -0400
Received: by mail-wm0-f67.google.com with SMTP id x124so780334wmf.3
        for <linux-sparse@vger.kernel.org>; Fri, 24 Mar 2017 16:14:35 -0700 (PDT)
In-Reply-To: <20170324231421.14869-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

OP_INLINED_CALL are there only as a sort of annotation
for debugging purpose.
Their presence should thus not block the packing of
basic blocks.

Fix this by ignoring OP_INLINED_CALL when trying to pack
a basic block.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 flow.c                          |  1 +
 validation/call-inlined.c       |  4 ----
 validation/optim/call-inlined.c | 30 ++++++++++++++++++++++++++++++
 3 files changed, 31 insertions(+), 4 deletions(-)
 create mode 100644 validation/optim/call-inlined.c

diff --git a/flow.c b/flow.c
index 237c9f1fa..ec7e3f22c 100644
--- a/flow.c
+++ b/flow.c
@@ -949,6 +949,7 @@ void pack_basic_blocks(struct entrypoint *ep)
 				continue;
 			switch (first->opcode) {
 			case OP_NOP: case OP_LNOP: case OP_SNOP:
+			case OP_INLINED_CALL:
 				continue;
 			case OP_CBR:
 			case OP_BR: {
diff --git a/validation/call-inlined.c b/validation/call-inlined.c
index 6fd94edcb..dae68f0e2 100644
--- a/validation/call-inlined.c
+++ b/validation/call-inlined.c
@@ -27,14 +27,12 @@ foo:
 	<entry-point>
 	add.32      %r3 <- %arg1, %arg2
 	add.32      %r5 <- %r3, $1
-	# call      %r5 <- add, %r3, $1
 	ret.32      %r5
 
 
 bar:
 .L3:
 	<entry-point>
-	# call      %r12 <- add, %r10, $1
 	ret
 
 
@@ -42,7 +40,6 @@ bas:
 .L6:
 	<entry-point>
 	add.64      %r16 <- "abc", $1
-	# call      %r16 <- lstrip, %r14
 	ret.64      %r16
 
 
@@ -50,7 +47,6 @@ qus:
 .L9:
 	<entry-point>
 	add.64      %r21 <- messg, $1
-	# call      %r21 <- lstrip, %r19
 	ret.64      %r21
 
 
diff --git a/validation/optim/call-inlined.c b/validation/optim/call-inlined.c
new file mode 100644
index 000000000..00698a4b1
--- /dev/null
+++ b/validation/optim/call-inlined.c
@@ -0,0 +1,30 @@
+static const char messg[] = "def";
+
+static inline int add(int a, int b)
+{
+	return a + b;
+}
+
+int foo(int a, int b, int p)
+{
+	if (p) {
+		add(a + b, 1);
+		return p;
+	}
+	return 0;
+}
+
+/*
+ * check-name: call-inlined
+ * check-command: test-linearize -Wno-decl $file
+ *
+ * check-output-start
+foo:
+.L0:
+	<entry-point>
+	select.32   %r9 <- %arg3, %arg3, $0
+	ret.32      %r9
+
+
+ * check-output-end
+ */
-- 
2.12.0

