From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v6 02/15] add table to "negate" some opcode
Date: Mon, 27 Mar 2017 19:33:52 +0200
Message-ID: <20170327173405.11405-3-luc.vanoostenryck@gmail.com>
References: <20170327173405.11405-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33055 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751364AbdC0RhN (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Mar 2017 13:37:13 -0400
Received: by mail-wr0-f193.google.com with SMTP id 20so15304347wrx.0
        for <linux-sparse@vger.kernel.org>; Mon, 27 Mar 2017 10:36:15 -0700 (PDT)
In-Reply-To: <20170327173405.11405-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Some optimizations transform an instruction opcode
into another. For example, it may be needed to know
the opcode corresponding to the negation of a comparison.

This patch make this easy and flexible by adding a table
for the relation between opcodes.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile    |  1 +
 linearize.h |  3 +++
 opcode.c    | 36 ++++++++++++++++++++++++++++++++++++
 opcode.h    |  9 +++++++++
 4 files changed, 49 insertions(+)
 create mode 100644 opcode.c
 create mode 100644 opcode.h

diff --git a/Makefile b/Makefile
index 76902b75e..3ac100744 100644
--- a/Makefile
+++ b/Makefile
@@ -106,6 +106,7 @@ LIB_OBJS= target.o parse.o tokenize.o pre-process.o symbol.o lib.o scope.o \
 	  expression.o show-parse.o evaluate.o expand.o inline.o linearize.o \
 	  char.o sort.o allocate.o compat-$(OS).o ptrlist.o \
 	  builtin.o \
+	  opcode.o \
 	  flow.o cse.o simplify.o memops.o liveness.o storage.o unssa.o dissect.o
 
 LIB_FILE= libsparse.a
diff --git a/linearize.h b/linearize.h
index bac82d7ff..5ae78f596 100644
--- a/linearize.h
+++ b/linearize.h
@@ -4,6 +4,7 @@
 #include "lib.h"
 #include "allocate.h"
 #include "token.h"
+#include "opcode.h"
 #include "parse.h"
 #include "symbol.h"
 
@@ -217,6 +218,8 @@ enum opcode {
 
 	/* Needed to translate SSA back to normal form */
 	OP_COPY,
+
+	OP_LAST,			/* keep this one last! */
 };
 
 struct basic_block_list;
diff --git a/opcode.c b/opcode.c
new file mode 100644
index 000000000..0aed1ca1f
--- /dev/null
+++ b/opcode.c
@@ -0,0 +1,36 @@
+/*
+ * Copyright (C) 2017 Luc Van Oostenryck
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "linearize.h"
+
+const struct opcode_table opcode_table[OP_LAST] = {
+	[OP_SET_EQ] = {	.negate = OP_SET_NE, },
+	[OP_SET_NE] = {	.negate = OP_SET_EQ, },
+	[OP_SET_LT] = {	.negate = OP_SET_GE, },
+	[OP_SET_LE] = {	.negate = OP_SET_GT, },
+	[OP_SET_GE] = {	.negate = OP_SET_LT, },
+	[OP_SET_GT] = {	.negate = OP_SET_LE, },
+	[OP_SET_B ] = {	.negate = OP_SET_AE, },
+	[OP_SET_BE] = {	.negate = OP_SET_A , },
+	[OP_SET_AE] = {	.negate = OP_SET_B , },
+	[OP_SET_A ] = {	.negate = OP_SET_BE, },
+};
diff --git a/opcode.h b/opcode.h
new file mode 100644
index 000000000..3a89de05e
--- /dev/null
+++ b/opcode.h
@@ -0,0 +1,9 @@
+#ifndef OPCODE_H
+#define OPCODE_H
+
+
+extern const struct opcode_table {
+	int	negate:8;
+} opcode_table[];
+
+#endif
-- 
2.12.0

