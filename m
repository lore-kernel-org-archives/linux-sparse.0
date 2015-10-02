From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 1/2] compiler.h: add support for function attribute assume_aligned
Date: Fri,  2 Oct 2015 12:12:54 +0200
Message-ID: <1443780775-10304-1-git-send-email-linux@rasmusvillemoes.dk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:34342 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751170AbbJBKOL (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 2 Oct 2015 06:14:11 -0400
Received: by labzv5 with SMTP id zv5so90207090lab.1
        for <linux-sparse@vger.kernel.org>; Fri, 02 Oct 2015 03:14:09 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, David Rientjes <rientjes@google.com>, Christopher Li <sparse@chrisli.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org

gcc 4.9 added the function attribute assume_aligned, indicating to the
caller that the returned pointer may be assumed to have a certain
minimal alignment. This is useful if, for example, the return value is
passed to memset(). Add a shorthand macro for that.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/compiler-gcc.h | 17 +++++++++++++++++
 include/linux/compiler.h     |  8 ++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index dfaa7b3e9ae9..18606a460baf 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -210,6 +210,23 @@
 #define __visible	__attribute__((externally_visible))
 #endif
 
+
+#if GCC_VERSION >= 40900
+/*
+ * __assume_aligned(n, k): Tell the optimizer that the returned
+ * pointer can be assumed to be k modulo n. The second argument is
+ * optional (default 0), so we use a variadic macro to make the
+ * shorthand.
+ *
+ * Beware: Do not apply this to functions which may return
+ * ERR_PTRs. Also, it is probably unwise to apply it to functions
+ * returning extra information in the low bits (but in that case the
+ * compiler should see some alignment anyway, when the return value is
+ * massaged by 'flags = ptr & 3; ptr &= ~3;').
+ */
+#define __assume_aligned(a, ...) __attribute__((__assume_aligned__(a, ## __VA_ARGS__)))
+#endif
+
 /*
  * GCC 'asm goto' miscompiles certain code sequences:
  *
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index c836eb2dc44d..6167ca663ad9 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -393,6 +393,14 @@ static __always_inline void __write_once_size(volatile void *p, void *res, int s
 #define __visible
 #endif
 
+/*
+ * Assume alignment of return value.
+ */
+#ifndef __assume_aligned
+#define __assume_aligned(a, ...)
+#endif
+
+
 /* Are two types/vars the same type (ignoring qualifiers)? */
 #ifndef __same_type
 # define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
-- 
2.1.3

