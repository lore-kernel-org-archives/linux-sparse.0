From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/5] predefine __INT_MAX__ and friends
Date: Mon, 27 Mar 2017 16:19:15 +0200
Message-ID: <20170327141918.61151-3-luc.vanoostenryck@gmail.com>
References: <20170327141918.61151-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33552 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753489AbdC0OV5 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Mar 2017 10:21:57 -0400
Received: by mail-wr0-f193.google.com with SMTP id 20so13746457wrx.0
        for <linux-sparse@vger.kernel.org>; Mon, 27 Mar 2017 07:21:41 -0700 (PDT)
In-Reply-To: <20170327141918.61151-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Some tests or some code depends on these macros being predefined
by the compiler.

Predefine them.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c                                | 23 ++++++++++++++++++-----
 validation/preprocessor/predef-max.c | 18 ++++++++++++++++++
 2 files changed, 36 insertions(+), 5 deletions(-)
 create mode 100644 validation/preprocessor/predef-max.c

diff --git a/lib.c b/lib.c
index 272d2c88a..4e6e6acd6 100644
--- a/lib.c
+++ b/lib.c
@@ -827,15 +827,28 @@ static char **handle_switch(char *arg, char **next)
 	return next;
 }
 
-static void predefined_macros(void)
+static void predefined_sizeof(const char *name, unsigned bits)
 {
-	unsigned long long val;
+	add_pre_buffer("#weak_define __SIZEOF_%s__ %d\n", name, bits/8);
+}
 
+static void predefined_type_size(const char *name, const char *suffix, unsigned bits)
+{
+	unsigned long long max = (1ULL << (bits - 1 )) - 1;
+
+	add_pre_buffer("#weak_define __%s_MAX__ %#llx%s\n", name, max, suffix);
+	predefined_sizeof(name, bits);
+}
+
+static void predefined_macros(void)
+{
 	add_pre_buffer("#define __CHECKER__ 1\n");
 
-	val = (1ULL << (bits_in_long-1)) - 1;
-	add_pre_buffer("#weak_define __LONG_MAX__ %#llxLL\n", val);
-	add_pre_buffer("#weak_define __SIZEOF_POINTER__ %d\n", bits_in_pointer/8);
+	predefined_type_size("INT", "", bits_in_int);
+	predefined_type_size("LONG", "L", bits_in_long);
+	predefined_type_size("LONG_LONG", "LL", bits_in_longlong);
+
+	predefined_sizeof("POINTER", bits_in_pointer);
 }
 
 void declare_builtin_functions(void)
diff --git a/validation/preprocessor/predef-max.c b/validation/preprocessor/predef-max.c
new file mode 100644
index 000000000..ad4b7eaf1
--- /dev/null
+++ b/validation/preprocessor/predef-max.c
@@ -0,0 +1,18 @@
+#define TEST_MAX(X, Z)	if (X != ((~ Z) >> 1))	return 1
+
+int test_max(void)
+{
+	TEST_MAX(__INT_MAX__, 0U);
+	TEST_MAX(__LONG_MAX__, 0UL);
+	TEST_MAX(__LONG_LONG_MAX__, 0ULL);
+
+	return 0;
+}
+
+/*
+ * check-name: predefined __<type>_MAX__
+ * check-command: test-linearize -Wno-decl $file
+ * check-output-ignore
+ *
+ * check-output-contains: ret\\..*\\$0
+ */
-- 
2.12.0

