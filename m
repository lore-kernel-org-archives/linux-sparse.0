From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 5/5] do not depends on limits.h to test __CHAR_BIT__
Date: Mon, 27 Mar 2017 16:19:18 +0200
Message-ID: <20170327141918.61151-6-luc.vanoostenryck@gmail.com>
References: <20170327141918.61151-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35624 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753483AbdC0OV4 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Mar 2017 10:21:56 -0400
Received: by mail-wr0-f196.google.com with SMTP id p52so10815518wrc.2
        for <linux-sparse@vger.kernel.org>; Mon, 27 Mar 2017 07:21:50 -0700 (PDT)
In-Reply-To: <20170327141918.61151-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This test depends on the header <limits.h> which itself depends
on some macros being defined by the compiler.

Now these macros are predefined (at least the obvious ones)
but it's annoying for the tests to depends on external things
like this header.

Remove this dependence by rewriting the test to use the predefined
macros directly.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/builtin_char_bit.c             |  7 -------
 validation/preprocessor/predef-char-bit.c | 16 ++++++++++++++++
 2 files changed, 16 insertions(+), 7 deletions(-)
 delete mode 100644 validation/builtin_char_bit.c
 create mode 100644 validation/preprocessor/predef-char-bit.c

diff --git a/validation/builtin_char_bit.c b/validation/builtin_char_bit.c
deleted file mode 100644
index 30e6bed46..000000000
--- a/validation/builtin_char_bit.c
+++ /dev/null
@@ -1,7 +0,0 @@
-#include <limits.h>
-
-static unsigned int word_bits = sizeof(unsigned int) * CHAR_BIT;
-
-/*
- * check-name: __CHAR_BIT__
- */
diff --git a/validation/preprocessor/predef-char-bit.c b/validation/preprocessor/predef-char-bit.c
new file mode 100644
index 000000000..fed0166e4
--- /dev/null
+++ b/validation/preprocessor/predef-char-bit.c
@@ -0,0 +1,16 @@
+#define TEST_BIT(X, T)	if (__ ## X ## _BIT__  != 8 * sizeof(T)) return 1
+
+int test(void)
+{
+	TEST_BIT(CHAR, char);
+
+	return 0;
+}
+
+/*
+ * check-name: predefined __<type>_BIT__
+ * check-command: test-linearize -Wno-decl $file
+ * check-output-ignore
+ *
+ * check-output-contains: ret\\..*\\$0
+ */
-- 
2.12.0

