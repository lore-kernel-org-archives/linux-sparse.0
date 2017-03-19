From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 02/30] inlined calls should not block BB packing
Date: Sun, 19 Mar 2017 02:41:59 +0100
Message-ID: <20170319014227.8833-3-luc.vanoostenryck@gmail.com>
References: <20170319014227.8833-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34977 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751189AbdCSBml (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 18 Mar 2017 21:42:41 -0400
Received: by mail-wm0-f68.google.com with SMTP id z133so8936943wmb.2
        for <linux-sparse@vger.kernel.org>; Sat, 18 Mar 2017 18:42:40 -0700 (PDT)
In-Reply-To: <20170319014227.8833-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

OP_INLINED_CALL are there only as a sort of annotation
for debugging purpose.
Their presence should thus not block the packing of
basic blocks.

Fix this by ignoring OP_INLINED_CALL when trying to pack
a basic block.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 flow.c                          |  1 +
 validation/optim/call-inlined.c | 30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)
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

