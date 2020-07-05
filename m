From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 13/15] cleanup: move predefines in a separate file
Date: Sun,  5 Jul 2020 15:02:18 +0200
Message-ID: <20200705130220.26230-14-luc.vanoostenryck@gmail.com>
References: <20200705130220.26230-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbgGENCn (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Jul 2020 09:02:43 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58EE3C061794
        for <linux-sparse@vger.kernel.org>; Sun,  5 Jul 2020 06:02:42 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id d16so25545098edz.12
        for <linux-sparse@vger.kernel.org>; Sun, 05 Jul 2020 06:02:42 -0700 (PDT)
In-Reply-To: <20200705130220.26230-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Now that option parsing have moved to a separate file, move
everything related to predefined macros to a separate file too.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile    |   1 +
 lib.c       | 221 ---------------------------------------------------
 lib.h       |   1 +
 predefine.c | 225 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 227 insertions(+), 221 deletions(-)
 create mode 100644 predefine.c

diff --git a/Makefile b/Makefile
index dce666d27c41..f4483f5a1deb 100644
--- a/Makefile
+++ b/Makefile
@@ -54,6 +54,7 @@ LIB_OBJS += opcode.o
 LIB_OBJS += optimize.o
 LIB_OBJS += options.o
 LIB_OBJS += parse.o
+LIB_OBJS += predefine.o
 LIB_OBJS += pre-process.o
 LIB_OBJS += ptrlist.o
 LIB_OBJS += ptrmap.o
diff --git a/lib.c b/lib.c
index 53b107d2d063..fd1fe6cb3ba5 100644
--- a/lib.c
+++ b/lib.c
@@ -248,227 +248,6 @@ void add_pre_buffer(const char *fmt, ...)
 	pre_buffer_end = end;
 }
 
-////////////////////////////////////////////////////////////////////////////////
-// Predefines
-
-#define	PTYPE_SIZEOF	(1U << 0)
-#define	PTYPE_T		(1U << 1)
-#define	PTYPE_MAX	(1U << 2)
-#define	PTYPE_MIN	(1U << 3)
-#define	PTYPE_WIDTH	(1U << 4)
-#define	PTYPE_TYPE	(1U << 5)
-#define	PTYPE_ALL	(PTYPE_MAX|PTYPE_SIZEOF|PTYPE_WIDTH)
-#define	PTYPE_ALL_T	(PTYPE_MAX|PTYPE_SIZEOF|PTYPE_WIDTH|PTYPE_T)
-
-static void predefined_sizeof(const char *name, const char *suffix, unsigned bits)
-{
-	char buf[32];
-
-	snprintf(buf, sizeof(buf), "__SIZEOF_%s%s__", name, suffix);
-	predefine(buf, 1, "%d", bits/8);
-}
-
-static void predefined_width(const char *name, unsigned bits)
-{
-	char buf[32];
-
-	snprintf(buf, sizeof(buf), "__%s_WIDTH__", name);
-	predefine(buf, 1, "%d", bits);
-}
-
-static void predefined_max(const char *name, struct symbol *type)
-{
-	const char *suffix = builtin_type_suffix(type);
-	unsigned bits = type->bit_size - is_signed_type(type);
-	unsigned long long max = bits_mask(bits);
-	char buf[32];
-
-	snprintf(buf, sizeof(buf), "__%s_MAX__", name);
-	predefine(buf, 1, "%#llx%s", max, suffix);
-}
-
-static void predefined_min(const char *name, struct symbol *type)
-{
-	const char *suffix = builtin_type_suffix(type);
-	char buf[32];
-
-	snprintf(buf, sizeof(buf), "__%s_MIN__", name);
-
-	if (is_signed_type(type))
-		predefine(buf, 1, "(-__%s_MAX__ - 1)", name);
-	else
-		predefine(buf, 1, "0%s", suffix);
-}
-
-static void predefined_type(const char *name, struct symbol *type)
-{
-	const char *typename = builtin_typename(type);
-	add_pre_buffer("#weak_define __%s_TYPE__ %s\n", name, typename);
-}
-
-static void predefined_ctype(const char *name, struct symbol *type, int flags)
-{
-	unsigned bits = type->bit_size;
-
-	if (flags & PTYPE_SIZEOF) {
-		const char *suffix = (flags & PTYPE_T) ? "_T" : "";
-		predefined_sizeof(name, suffix, bits);
-	}
-	if (flags & PTYPE_MAX)
-		predefined_max(name, type);
-	if (flags & PTYPE_MIN)
-		predefined_min(name, type);
-	if (flags & PTYPE_TYPE)
-		predefined_type(name, type);
-	if (flags & PTYPE_WIDTH)
-		predefined_width(name, bits);
-}
-
-static void predefined_macros(void)
-{
-	predefine("__CHECKER__", 0, "1");
-	predefine("__GNUC__", 1, "%d", gcc_major);
-	predefine("__GNUC_MINOR__", 1, "%d", gcc_minor);
-	predefine("__GNUC_PATCHLEVEL__", 1, "%d", gcc_patchlevel);
-
-	predefine("__STDC__", 1, "1");
-	predefine("__STDC_HOSTED__", 0, fhosted ? "1" : "0");
-	switch (standard) {
-	default:
-		break;
-
-	case STANDARD_C94:
-		predefine("__STDC_VERSION__", 1, "199409L");
-		break;
-
-	case STANDARD_C99:
-	case STANDARD_GNU99:
-		predefine("__STDC_VERSION__", 1, "199901L");
-		break;
-
-	case STANDARD_C11:
-	case STANDARD_GNU11:
-		predefine("__STDC_VERSION__", 1, "201112L");
-		break;
-	case STANDARD_C17:
-	case STANDARD_GNU17:
-		predefine("__STDC_VERSION__", 1, "201710L");
-		break;
-	}
-	if (!(standard & STANDARD_GNU) && (standard != STANDARD_NONE))
-		predefine("__STRICT_ANSI__", 1, "1");
-	if (standard >= STANDARD_C11) {
-		predefine("__STDC_NO_ATOMICS__", 1, "1");
-		predefine("__STDC_NO_COMPLEX__", 1, "1");
-		predefine("__STDC_NO_THREADS__", 1, "1");
-	}
-
-	predefine("__CHAR_BIT__", 1, "%d", bits_in_char);
-	if (funsigned_char)
-		predefine("__CHAR_UNSIGNED__", 1, "1");
-
-	predefined_ctype("SHORT",     &short_ctype, PTYPE_SIZEOF);
-	predefined_ctype("SHRT",      &short_ctype, PTYPE_MAX|PTYPE_WIDTH);
-	predefined_ctype("SCHAR",     &schar_ctype, PTYPE_MAX|PTYPE_WIDTH);
-	predefined_ctype("WCHAR",      wchar_ctype, PTYPE_ALL_T|PTYPE_MIN|PTYPE_TYPE);
-	predefined_ctype("WINT",        wint_ctype, PTYPE_ALL_T|PTYPE_MIN|PTYPE_TYPE);
-	predefined_ctype("CHAR16",   &ushort_ctype, PTYPE_TYPE);
-	predefined_ctype("CHAR32",    uint32_ctype, PTYPE_TYPE);
-
-	predefined_ctype("INT",         &int_ctype, PTYPE_ALL);
-	predefined_ctype("LONG",       &long_ctype, PTYPE_ALL);
-	predefined_ctype("LONG_LONG", &llong_ctype, PTYPE_ALL);
-
-	predefined_ctype("INT8",      &schar_ctype, PTYPE_MAX|PTYPE_TYPE);
-	predefined_ctype("UINT8",     &uchar_ctype, PTYPE_MAX|PTYPE_TYPE);
-	predefined_ctype("INT16",     &short_ctype, PTYPE_MAX|PTYPE_TYPE);
-	predefined_ctype("UINT16",   &ushort_ctype, PTYPE_MAX|PTYPE_TYPE);
-	predefined_ctype("INT32",      int32_ctype, PTYPE_MAX|PTYPE_TYPE);
-	predefined_ctype("UINT32",    uint32_ctype, PTYPE_MAX|PTYPE_TYPE);
-	predefined_ctype("INT64",      int64_ctype, PTYPE_MAX|PTYPE_TYPE);
-	predefined_ctype("UINT64",    uint64_ctype, PTYPE_MAX|PTYPE_TYPE);
-
-	predefined_ctype("INTMAX",    intmax_ctype, PTYPE_MAX|PTYPE_TYPE|PTYPE_WIDTH);
-	predefined_ctype("UINTMAX",  uintmax_ctype, PTYPE_MAX|PTYPE_TYPE);
-	predefined_ctype("INTPTR",   ssize_t_ctype, PTYPE_MAX|PTYPE_TYPE|PTYPE_WIDTH);
-	predefined_ctype("UINTPTR",   size_t_ctype, PTYPE_MAX|PTYPE_TYPE);
-	predefined_ctype("PTRDIFF",  ssize_t_ctype, PTYPE_ALL_T|PTYPE_TYPE);
-	predefined_ctype("SIZE",      size_t_ctype, PTYPE_ALL_T|PTYPE_TYPE);
-	predefined_ctype("POINTER",     &ptr_ctype, PTYPE_SIZEOF);
-
-	predefined_sizeof("FLOAT", "", bits_in_float);
-	predefined_sizeof("DOUBLE", "", bits_in_double);
-	predefined_sizeof("LONG_DOUBLE", "", bits_in_longdouble);
-
-	if (arch_target->has_int128)
-		predefined_sizeof("INT128", "", 128);
-
-	predefine("__ORDER_LITTLE_ENDIAN__", 1, "1234");
-	predefine("__ORDER_BIG_ENDIAN__", 1, "4321");
-	predefine("__ORDER_PDP_ENDIAN__", 1, "3412");
-	if (arch_big_endian) {
-		predefine("__BIG_ENDIAN__", 1, "1");
-		predefine("__BYTE_ORDER__", 1, "__ORDER_BIG_ENDIAN__");
-	} else {
-		predefine("__LITTLE_ENDIAN__", 1, "1");
-		predefine("__BYTE_ORDER__", 1, "__ORDER_LITTLE_ENDIAN__");
-	}
-
-	if (optimize_level)
-		predefine("__OPTIMIZE__", 0, "1");
-	if (optimize_size)
-		predefine("__OPTIMIZE_SIZE__", 0, "1");
-
-	predefine("__PRAGMA_REDEFINE_EXTNAME", 1, "1");
-
-	// Temporary hacks
-	predefine("__extension__", 0, NULL);
-	predefine("__pragma__", 0, NULL);
-
-	switch (arch_m64) {
-	case ARCH_LP32:
-		break;
-	case ARCH_X32:
-		predefine("__ILP32__", 1, "1");
-		predefine("_ILP32", 1, "1");
-		break;
-	case ARCH_LP64:
-		predefine("__LP64__", 1, "1");
-		predefine("_LP64", 1, "1");
-		break;
-	case ARCH_LLP64:
-		predefine("__LLP64__", 1, "1");
-		break;
-	}
-
-	if (fpic) {
-		predefine("__pic__", 0, "%d", fpic);
-		predefine("__PIC__", 0, "%d", fpic);
-	}
-	if (fpie) {
-		predefine("__pie__", 0, "%d", fpie);
-		predefine("__PIE__", 0, "%d", fpie);
-	}
-
-	if (arch_target->predefine)
-		arch_target->predefine(arch_target);
-
-	if (arch_os >= OS_UNIX) {
-		predefine("__unix__", 1, "1");
-		predefine("__unix", 1, "1");
-		predefine_nostd("unix");
-	}
-
-	if (arch_os == OS_SUNOS) {
-		predefine("__sun__", 1, "1");
-		predefine("__sun", 1, "1");
-		predefine_nostd("sun");
-		predefine("__svr4__", 1, "1");
-	}
-}
-
-////////////////////////////////////////////////////////////////////////////////
-
 static void create_builtin_stream(void)
 {
 	// Temporary hack
diff --git a/lib.h b/lib.h
index b47505f638b4..81253a3e7ee5 100644
--- a/lib.h
+++ b/lib.h
@@ -130,6 +130,7 @@ enum phase {
 extern void add_pre_buffer(const char *fmt, ...) FORMAT_ATTR(1);
 extern void predefine(const char *name, int weak, const char *fmt, ...) FORMAT_ATTR(3);
 extern void predefine_nostd(const char *name);
+extern void predefined_macros(void);
 
 
 extern void dump_macro_definitions(void);
diff --git a/predefine.c b/predefine.c
new file mode 100644
index 000000000000..ff457b389480
--- /dev/null
+++ b/predefine.c
@@ -0,0 +1,225 @@
+// SPDX-License-Identifier: MIT
+// Copyright (C) 2017-2020 Luc Van Oostenryck.
+
+#include <stdio.h>
+
+#include "lib.h"
+#include "machine.h"
+#include "symbol.h"
+
+#define PTYPE_SIZEOF	(1U << 0)
+#define PTYPE_T		(1U << 1)
+#define PTYPE_MAX	(1U << 2)
+#define PTYPE_MIN	(1U << 3)
+#define PTYPE_WIDTH	(1U << 4)
+#define PTYPE_TYPE	(1U << 5)
+#define PTYPE_ALL	(PTYPE_MAX|PTYPE_SIZEOF|PTYPE_WIDTH)
+#define PTYPE_ALL_T	(PTYPE_MAX|PTYPE_SIZEOF|PTYPE_WIDTH|PTYPE_T)
+
+
+static void predefined_sizeof(const char *name, const char *suffix, unsigned bits)
+{
+	char buf[32];
+
+	snprintf(buf, sizeof(buf), "__SIZEOF_%s%s__", name, suffix);
+	predefine(buf, 1, "%d", bits/8);
+}
+
+static void predefined_width(const char *name, unsigned bits)
+{
+	char buf[32];
+
+	snprintf(buf, sizeof(buf), "__%s_WIDTH__", name);
+	predefine(buf, 1, "%d", bits);
+}
+
+static void predefined_max(const char *name, struct symbol *type)
+{
+	const char *suffix = builtin_type_suffix(type);
+	unsigned bits = type->bit_size - is_signed_type(type);
+	unsigned long long max = bits_mask(bits);
+	char buf[32];
+
+	snprintf(buf, sizeof(buf), "__%s_MAX__", name);
+	predefine(buf, 1, "%#llx%s", max, suffix);
+}
+
+static void predefined_min(const char *name, struct symbol *type)
+{
+	const char *suffix = builtin_type_suffix(type);
+	char buf[32];
+
+	snprintf(buf, sizeof(buf), "__%s_MIN__", name);
+
+	if (is_signed_type(type))
+		predefine(buf, 1, "(-__%s_MAX__ - 1)", name);
+	else
+		predefine(buf, 1, "0%s", suffix);
+}
+
+static void predefined_type(const char *name, struct symbol *type)
+{
+	const char *typename = builtin_typename(type);
+	add_pre_buffer("#weak_define __%s_TYPE__ %s\n", name, typename);
+}
+
+static void predefined_ctype(const char *name, struct symbol *type, int flags)
+{
+	unsigned bits = type->bit_size;
+
+	if (flags & PTYPE_SIZEOF) {
+		const char *suffix = (flags & PTYPE_T) ? "_T" : "";
+		predefined_sizeof(name, suffix, bits);
+	}
+	if (flags & PTYPE_MAX)
+		predefined_max(name, type);
+	if (flags & PTYPE_MIN)
+		predefined_min(name, type);
+	if (flags & PTYPE_TYPE)
+		predefined_type(name, type);
+	if (flags & PTYPE_WIDTH)
+		predefined_width(name, bits);
+}
+
+void predefined_macros(void)
+{
+	predefine("__CHECKER__", 0, "1");
+	predefine("__GNUC__", 1, "%d", gcc_major);
+	predefine("__GNUC_MINOR__", 1, "%d", gcc_minor);
+	predefine("__GNUC_PATCHLEVEL__", 1, "%d", gcc_patchlevel);
+
+	predefine("__STDC__", 1, "1");
+	predefine("__STDC_HOSTED__", 0, fhosted ? "1" : "0");
+	switch (standard) {
+	default:
+		break;
+
+	case STANDARD_C94:
+		predefine("__STDC_VERSION__", 1, "199409L");
+		break;
+
+	case STANDARD_C99:
+	case STANDARD_GNU99:
+		predefine("__STDC_VERSION__", 1, "199901L");
+		break;
+
+	case STANDARD_C11:
+	case STANDARD_GNU11:
+		predefine("__STDC_VERSION__", 1, "201112L");
+		break;
+	case STANDARD_C17:
+	case STANDARD_GNU17:
+		predefine("__STDC_VERSION__", 1, "201710L");
+		break;
+	}
+	if (!(standard & STANDARD_GNU) && (standard != STANDARD_NONE))
+		predefine("__STRICT_ANSI__", 1, "1");
+	if (standard >= STANDARD_C11) {
+		predefine("__STDC_NO_ATOMICS__", 1, "1");
+		predefine("__STDC_NO_COMPLEX__", 1, "1");
+		predefine("__STDC_NO_THREADS__", 1, "1");
+	}
+
+	predefine("__CHAR_BIT__", 1, "%d", bits_in_char);
+	if (funsigned_char)
+		predefine("__CHAR_UNSIGNED__", 1, "1");
+
+	predefined_ctype("SHORT",     &short_ctype, PTYPE_SIZEOF);
+	predefined_ctype("SHRT",      &short_ctype, PTYPE_MAX|PTYPE_WIDTH);
+	predefined_ctype("SCHAR",     &schar_ctype, PTYPE_MAX|PTYPE_WIDTH);
+	predefined_ctype("WCHAR",      wchar_ctype, PTYPE_ALL_T|PTYPE_MIN|PTYPE_TYPE);
+	predefined_ctype("WINT",        wint_ctype, PTYPE_ALL_T|PTYPE_MIN|PTYPE_TYPE);
+	predefined_ctype("CHAR16",   &ushort_ctype, PTYPE_TYPE);
+	predefined_ctype("CHAR32",    uint32_ctype, PTYPE_TYPE);
+
+	predefined_ctype("INT",         &int_ctype, PTYPE_ALL);
+	predefined_ctype("LONG",       &long_ctype, PTYPE_ALL);
+	predefined_ctype("LONG_LONG", &llong_ctype, PTYPE_ALL);
+
+	predefined_ctype("INT8",      &schar_ctype, PTYPE_MAX|PTYPE_TYPE);
+	predefined_ctype("UINT8",     &uchar_ctype, PTYPE_MAX|PTYPE_TYPE);
+	predefined_ctype("INT16",     &short_ctype, PTYPE_MAX|PTYPE_TYPE);
+	predefined_ctype("UINT16",   &ushort_ctype, PTYPE_MAX|PTYPE_TYPE);
+	predefined_ctype("INT32",      int32_ctype, PTYPE_MAX|PTYPE_TYPE);
+	predefined_ctype("UINT32",    uint32_ctype, PTYPE_MAX|PTYPE_TYPE);
+	predefined_ctype("INT64",      int64_ctype, PTYPE_MAX|PTYPE_TYPE);
+	predefined_ctype("UINT64",    uint64_ctype, PTYPE_MAX|PTYPE_TYPE);
+
+	predefined_ctype("INTMAX",    intmax_ctype, PTYPE_MAX|PTYPE_TYPE|PTYPE_WIDTH);
+	predefined_ctype("UINTMAX",  uintmax_ctype, PTYPE_MAX|PTYPE_TYPE);
+	predefined_ctype("INTPTR",   ssize_t_ctype, PTYPE_MAX|PTYPE_TYPE|PTYPE_WIDTH);
+	predefined_ctype("UINTPTR",   size_t_ctype, PTYPE_MAX|PTYPE_TYPE);
+	predefined_ctype("PTRDIFF",  ssize_t_ctype, PTYPE_ALL_T|PTYPE_TYPE);
+	predefined_ctype("SIZE",      size_t_ctype, PTYPE_ALL_T|PTYPE_TYPE);
+	predefined_ctype("POINTER",     &ptr_ctype, PTYPE_SIZEOF);
+
+	predefined_sizeof("FLOAT", "", bits_in_float);
+	predefined_sizeof("DOUBLE", "", bits_in_double);
+	predefined_sizeof("LONG_DOUBLE", "", bits_in_longdouble);
+
+	if (arch_target->has_int128)
+		predefined_sizeof("INT128", "", 128);
+
+	predefine("__ORDER_LITTLE_ENDIAN__", 1, "1234");
+	predefine("__ORDER_BIG_ENDIAN__", 1, "4321");
+	predefine("__ORDER_PDP_ENDIAN__", 1, "3412");
+	if (arch_big_endian) {
+		predefine("__BIG_ENDIAN__", 1, "1");
+		predefine("__BYTE_ORDER__", 1, "__ORDER_BIG_ENDIAN__");
+	} else {
+		predefine("__LITTLE_ENDIAN__", 1, "1");
+		predefine("__BYTE_ORDER__", 1, "__ORDER_LITTLE_ENDIAN__");
+	}
+
+	if (optimize_level)
+		predefine("__OPTIMIZE__", 0, "1");
+	if (optimize_size)
+		predefine("__OPTIMIZE_SIZE__", 0, "1");
+
+	predefine("__PRAGMA_REDEFINE_EXTNAME", 1, "1");
+
+	// Temporary hacks
+	predefine("__extension__", 0, NULL);
+	predefine("__pragma__", 0, NULL);
+
+	switch (arch_m64) {
+	case ARCH_LP32:
+		break;
+	case ARCH_X32:
+		predefine("__ILP32__", 1, "1");
+		predefine("_ILP32", 1, "1");
+		break;
+	case ARCH_LP64:
+		predefine("__LP64__", 1, "1");
+		predefine("_LP64", 1, "1");
+		break;
+	case ARCH_LLP64:
+		predefine("__LLP64__", 1, "1");
+		break;
+	}
+
+	if (fpic) {
+		predefine("__pic__", 0, "%d", fpic);
+		predefine("__PIC__", 0, "%d", fpic);
+	}
+	if (fpie) {
+		predefine("__pie__", 0, "%d", fpie);
+		predefine("__PIE__", 0, "%d", fpie);
+	}
+
+	if (arch_target->predefine)
+		arch_target->predefine(arch_target);
+
+	if (arch_os >= OS_UNIX) {
+		predefine("__unix__", 1, "1");
+		predefine("__unix", 1, "1");
+		predefine_nostd("unix");
+	}
+
+	if (arch_os == OS_SUNOS) {
+		predefine("__sun__", 1, "1");
+		predefine("__sun", 1, "1");
+		predefine_nostd("sun");
+		predefine("__svr4__", 1, "1");
+	}
+}
-- 
2.27.0
