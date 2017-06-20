From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/3] teach sparse about __{BIG,LITTLE}_ENDIAN__
Date: Tue, 20 Jun 2017 22:19:30 +0200
Message-ID: <20170620201931.92864-3-luc.vanoostenryck@gmail.com>
References: <20170620201931.92864-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36002 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751118AbdFTUTk (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 20 Jun 2017 16:19:40 -0400
Received: by mail-wr0-f194.google.com with SMTP id 77so20322944wrb.3
        for <linux-sparse@vger.kernel.org>; Tue, 20 Jun 2017 13:19:39 -0700 (PDT)
In-Reply-To: <20170620201931.92864-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Some macros, structures definitions, ... depends on the
endianness. This is generaly done via some header file
but these headers need information from the compiler via
the macros __{BIG,LITTLE}_ENDIAN__.

Let sparse predefine these macros like compilers do.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c                      |  3 +++
 validation/endian-big.c    | 11 +++++++++++
 validation/endian-little.c | 11 +++++++++++
 3 files changed, 25 insertions(+)
 create mode 100644 validation/endian-big.c
 create mode 100644 validation/endian-little.c

diff --git a/lib.c b/lib.c
index a22635ecc..daf7d0219 100644
--- a/lib.c
+++ b/lib.c
@@ -961,6 +961,9 @@ static void predefined_macros(void)
 	predefined_sizeof("FLOAT", bits_in_float);
 	predefined_sizeof("DOUBLE", bits_in_double);
 	predefined_sizeof("LONG_DOUBLE", bits_in_longdouble);
+
+	add_pre_buffer("#weak_define __%s_ENDIAN__ 1\n",
+		arch_big_endian ? "BIG" : "LITTLE");
 }
 
 void declare_builtin_functions(void)
diff --git a/validation/endian-big.c b/validation/endian-big.c
new file mode 100644
index 000000000..d535748cd
--- /dev/null
+++ b/validation/endian-big.c
@@ -0,0 +1,11 @@
+#if defined(__LITTLE_ENDIAN__)
+#error "__LITTLE_ENDIAN__ defined!"
+#endif
+#if (__BIG_ENDIAN__ != 1)
+#error "__BIG_ENDIAN__ not correctly defined!"
+#endif
+
+/*
+ * check-name: endian-big.c
+ * check-command: sparse -mbig-endian $file
+ */
diff --git a/validation/endian-little.c b/validation/endian-little.c
new file mode 100644
index 000000000..cc4a14f73
--- /dev/null
+++ b/validation/endian-little.c
@@ -0,0 +1,11 @@
+#if defined(__BIG_ENDIAN__)
+#error "__BIG_ENDIAN__ defined!"
+#endif
+#if (__LITTLE_ENDIAN__ != 1)
+#error "__LITTLE_ENDIAN__ not correctly defined!"
+#endif
+
+/*
+ * check-name: endian-little.c
+ * check-command: sparse -mlittle-endian $file
+ */
-- 
2.13.0

