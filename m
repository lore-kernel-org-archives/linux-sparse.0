From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] add fallback for missing __builtin_bswapXX()
Date: Mon, 19 Jun 2017 23:14:03 +0200
Message-ID: <20170619211403.45153-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33173 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751085AbdFSVON (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 19 Jun 2017 17:14:13 -0400
Received: by mail-wm0-f66.google.com with SMTP id f90so19108977wmh.0
        for <linux-sparse@vger.kernel.org>; Mon, 19 Jun 2017 14:14:12 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Chris Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Older version of GCC (or clang) or some other compilers
doesn't support the __builtin_bswap{16,32,64)().

Provides a fallback for them.

Note: this patch allow the testsuite to run successfully on openbsd
      (its installed compiler is based on GCC 4.2).

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 builtin.c      |  7 ++++---
 compat/bswap.h | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+), 3 deletions(-)
 create mode 100644 compat/bswap.h

diff --git a/builtin.c b/builtin.c
index dbb81032b..904a6c528 100644
--- a/builtin.c
+++ b/builtin.c
@@ -26,6 +26,7 @@
 #include "expression.h"
 #include "expand.h"
 #include "symbol.h"
+#include "compat/bswap.h"
 
 static int evaluate_to_integer(struct expression *expr)
 {
@@ -187,9 +188,9 @@ static int expand_bswap(struct expression *expr, int cost)
 	/* the arguments number & type have already been checked */
 	val = const_expression_value(first_expression(expr->args));
 	switch (expr->ctype->bit_size) {
-	case 16: expr->value = __builtin_bswap16(val); break;
-	case 32: expr->value = __builtin_bswap32(val); break;
-	case 64: expr->value = __builtin_bswap64(val); break;
+	case 16: expr->value = bswap16(val); break;
+	case 32: expr->value = bswap32(val); break;
+	case 64: expr->value = bswap64(val); break;
 	default: /* impossible error */
 		return SIDE_EFFECTS;
 	}
diff --git a/compat/bswap.h b/compat/bswap.h
new file mode 100644
index 000000000..f0b7e93cc
--- /dev/null
+++ b/compat/bswap.h
@@ -0,0 +1,54 @@
+#ifndef _COMPAT_BSWAP_H_
+#define _COMPAT_BSWAP_H_
+
+#if defined(__GNUC__)
+#if (__GNUC__ > 4) || ((__GNUC__ == 4) && (__GNUC_MINOR__ >= 8))
+#define	__HAS_BUILTIN_BSWAP16
+#endif
+#if (__GNUC__ > 4) || ((__GNUC__ == 4) && (__GNUC_MINOR__ >= 4))
+#define	__HAS_BUILTIN_BSWAP32
+#define	__HAS_BUILTIN_BSWAP64
+#endif
+#endif
+
+#if defined(__clang__)
+#if (__clang_major__ > 3) || ((__clang_major__ == 3) && (__clang_minor__ >= 2))
+#define	__HAS_BUILTIN_BSWAP16
+#endif
+#if (__clang_major__ > 3) || ((__clang_major__ == 3) && (__clang_minor__ >= 0))
+#define	__HAS_BUILTIN_BSWAP32
+#define	__HAS_BUILTIN_BSWAP64
+#endif
+#endif
+
+#ifdef __HAS_BUILTIN_BSWAP16
+#define bswap16(x)	__builtin_bswap16(x)
+#else
+#include <stdint.h>
+static inline uint16_t bswap16(uint16_t x)
+{
+	return x << 8 | x >> 8;
+}
+#endif
+
+#ifdef __HAS_BUILTIN_BSWAP32
+#define bswap32(x)	__builtin_bswap32(x)
+#else
+#include <stdint.h>
+static inline uint32_t bswap32(uint32_t x)
+{
+	return x >> 24 | (x >> 8 & 0xff00) | (x << 8 & 0xff0000) | x << 24;
+}
+#endif
+
+#ifdef __HAS_BUILTIN_BSWAP64
+#define bswap64(x)	__builtin_bswap64(x)
+#else
+#include <stdint.h>
+static inline uint64_t bswap64(uint64_t x)
+{
+	return ((uint64_t)bswap32(x)) << 32 | bswap32(x >> 32);
+}
+#endif
+
+#endif
-- 
2.13.0

