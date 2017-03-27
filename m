From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/5] predefine __SIZEOF_INT__ & friends
Date: Mon, 27 Mar 2017 16:19:16 +0200
Message-ID: <20170327141918.61151-4-luc.vanoostenryck@gmail.com>
References: <20170327141918.61151-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33567 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752800AbdC0OVk (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Mar 2017 10:21:40 -0400
Received: by mail-wr0-f195.google.com with SMTP id 20so13746627wrx.0
        for <linux-sparse@vger.kernel.org>; Mon, 27 Mar 2017 07:21:28 -0700 (PDT)
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
 lib.c                                   | 10 ++++++++++
 validation/preprocessor/predef-sizeof.c | 25 +++++++++++++++++++++++++
 2 files changed, 35 insertions(+)
 create mode 100644 validation/preprocessor/predef-sizeof.c

diff --git a/lib.c b/lib.c
index 4e6e6acd6..cf6bea645 100644
--- a/lib.c
+++ b/lib.c
@@ -844,11 +844,21 @@ static void predefined_macros(void)
 {
 	add_pre_buffer("#define __CHECKER__ 1\n");
 
+	predefined_sizeof("SHORT", bits_in_short);
+
 	predefined_type_size("INT", "", bits_in_int);
 	predefined_type_size("LONG", "L", bits_in_long);
 	predefined_type_size("LONG_LONG", "LL", bits_in_longlong);
 
+	predefined_sizeof("INT128", 128);
+
+	predefined_sizeof("SIZE_T", bits_in_pointer);
+	predefined_sizeof("PTRDIFF_T", bits_in_pointer);
 	predefined_sizeof("POINTER", bits_in_pointer);
+
+	predefined_sizeof("FLOAT", bits_in_float);
+	predefined_sizeof("DOUBLE", bits_in_double);
+	predefined_sizeof("LONG_DOUBLE", bits_in_longdouble);
 }
 
 void declare_builtin_functions(void)
diff --git a/validation/preprocessor/predef-sizeof.c b/validation/preprocessor/predef-sizeof.c
new file mode 100644
index 000000000..12be2dd1d
--- /dev/null
+++ b/validation/preprocessor/predef-sizeof.c
@@ -0,0 +1,25 @@
+#define TEST(X, T)	if (__SIZEOF_ ## X ## __ != sizeof(T))	return 1
+
+int test_sizeof(void)
+{
+	TEST(SHORT, short);
+	TEST(INT, int);
+	TEST(LONG, long);
+	TEST(LONG_LONG, long long);
+	TEST(INT128, __int128);
+	TEST(SIZE_T, __SIZE_TYPE__);
+	TEST(POINTER, void*);
+	TEST(FLOAT, float);
+	TEST(DOUBLE, double);
+	TEST(LONG_DOUBLE, long double);
+
+	return 0;
+}
+
+/*
+ * check-name: predefined __SIZEOF_<type>__
+ * check-command: test-linearize -Wno-decl $file
+ * check-output-ignore
+ *
+ * check-output-contains: ret\\..*\\$0
+ */
-- 
2.12.0

