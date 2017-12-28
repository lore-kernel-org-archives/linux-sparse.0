From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] add testcases for type comparison
Date: Thu, 28 Dec 2017 21:56:51 +0100
Message-ID: <20171228205651.37319-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39165 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750854AbdL1U5L (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 28 Dec 2017 15:57:11 -0500
Received: by mail-wm0-f66.google.com with SMTP id i11so45388479wmf.4
        for <linux-sparse@vger.kernel.org>; Thu, 28 Dec 2017 12:57:11 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Sparse, as an extension and with a special syntax, supports the
direct comparison of types, either equality modulo qualifiers for
'==' and '!=', or size comparison for '<', '>', '<=' and '>='.

Add some testcases to avoid possible regressions here.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/type-compare.c | 76 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 validation/type-compare.c

diff --git a/validation/type-compare.c b/validation/type-compare.c
new file mode 100644
index 000000000..1adcd7040
--- /dev/null
+++ b/validation/type-compare.c
@@ -0,0 +1,76 @@
+#define __user		__attribute__((address_space(1)))
+#define __safe		__attribute__((safe))
+#define __nocast	__attribute__((nocast))
+#define __bitwise	__attribute__((bitwise))
+#define __noderef	__attribute__((noderef))
+
+int test(void)
+{
+	if ([int] != [int]) return 1;
+	if (!([int] == [int])) return 1;
+
+	if ([int] == [long]) return 1;
+	if (!([int] != [long])) return 1;
+
+	if ([int] == [unsigned int]) return 1;
+	if (!([int] != [unsigned int])) return 1;
+
+	if ([int] != [int]) return 1;
+	if ([typeof(int)] != [int]) return 1;
+	if ([int] != [typeof(int)]) return 1;
+	if ([typeof(int)] != [typeof(int)]) return 1;
+
+	if ([char] > [short]) return 1;
+	if ([short] < [char]) return 1;
+	if (!([char] <= [short])) return 1;
+	if (!([short] >= [char])) return 1;
+
+	if ([short] > [int]) return 1;
+	if ([int] < [short]) return 1;
+	if (!([short] <= [int])) return 1;
+	if (!([int] >= [short])) return 1;
+
+	if ([int] > [long]) return 1;
+	if ([long] < [int]) return 1;
+	if (!([int] <= [long])) return 1;
+	if (!([long] >= [int])) return 1;
+
+	if ([long] > [long long]) return 1;
+	if ([long long] < [long]) return 1;
+	if (!([long] <= [long long])) return 1;
+	if (!([long long] >= [long])) return 1;
+
+	if ([int *] != [int *]) return 1;
+	if ([int *] == [void *]) return 1;
+
+	// qualifiers are ignored
+	if ([int] != [const int]) return 1;
+	if ([int] != [volatile int]) return 1;
+
+	// but others modifiers are significant
+	if ([int] == [int __nocast]) return 1;
+	if ([int] == [int __bitwise]) return 1;
+
+	//
+	if ([int *] == [const int *]) return 1;
+	if ([int *] == [volatile int *]) return 1;
+	if ([int *] == [int __user *]) return 1;
+	if ([int *] == [int __safe *]) return 1;
+	if ([int *] == [int __nocast *]) return 1;
+	if ([int *] == [int __bitwise *]) return 1;
+	if ([int *] == [int __noderef *]) return 1;
+
+	return 0;
+}
+
+/*
+ * check-name: type-as-first-class comparison
+ * check-description: This test the sparse extension making
+ *	types first class citizens which can be compared
+ *	for equality (or size for <, >, <=, >=).
+ *	See expand.c:compare_types().
+ * check-command: test-linearize -Wno-decl $file
+ * check-output-ignore
+ *
+ * check-output-contains: ret\\..*\\$0
+ */
-- 
2.15.0

