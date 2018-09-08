From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: [PATCH v4 03/13] Compiler Attributes: remove unneeded tests
Date: Sat,  8 Sep 2018 23:24:49 +0200
Message-ID: <20180908212459.19736-4-miguel.ojeda.sandonis@gmail.com>
References: <20180908212459.19736-1-miguel.ojeda.sandonis@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180908212459.19736-1-miguel.ojeda.sandonis@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Eli Friedman <efriedma@codeaurora.org>, Christopher Li <sparse@chrisli.org>, Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Joe Perches <joe@perches.com>, Dominique Martinet <asmadeus@codewreck.org>, linux-sparse@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

Attributes const and always_inline have tests around them
which are unneeded, since they are supported by gcc >= 4.6,
clang >= 3 and icc >= 13. https://godbolt.org/z/DFPq37

In the case of gnu_inline, we do not need to test for
__GNUC_STDC_INLINE__ because, regardless of the current
inlining behavior, we can simply always force the old
GCC inlining behavior by using the attribute in all cases.

Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Eli Friedman <efriedma@codeaurora.org>
Cc: Christopher Li <sparse@chrisli.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Joe Perches <joe@perches.com>
Cc: Dominique Martinet <asmadeus@codewreck.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sparse@vger.kernel.org
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
---
 include/linux/compiler_types.h | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 2bc0f94df38e..83475515bc39 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -158,10 +158,6 @@ struct ftrace_likely_data {
 	(sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || \
 	 sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
 
-#ifndef __attribute_const__
-#define __attribute_const__	__attribute__((__const__))
-#endif
-
 #ifndef __noclone
 #define __noclone
 #endif
@@ -196,6 +192,7 @@ struct ftrace_likely_data {
  * [...]
  */
 #define __pure			__attribute__((__pure__))
+#define __attribute_const__	__attribute__((__const__))
 #define __aligned(x)		__attribute__((__aligned__(x)))
 #define __aligned_largest	__attribute__((__aligned__))
 #define __printf(a, b)		__attribute__((__format__(printf, a, b)))
@@ -211,6 +208,8 @@ struct ftrace_likely_data {
 #define __alias(symbol)		__attribute__((__alias__(#symbol)))
 #define __cold			__attribute__((__cold__))
 #define __section(S)		__attribute__((__section__(#S)))
+#define __always_inline		inline __attribute__((__always_inline__))
+#define __gnu_inline		__attribute__((__gnu_inline__))
 
 
 #ifdef CONFIG_ENABLE_MUST_CHECK
@@ -227,18 +226,6 @@ struct ftrace_likely_data {
 
 #define __compiler_offsetof(a, b)	__builtin_offsetof(a, b)
 
-/*
- * Feature detection for gnu_inline (gnu89 extern inline semantics). Either
- * __GNUC_STDC_INLINE__ is defined (not using gnu89 extern inline semantics,
- * and we opt in to the gnu89 semantics), or __GNUC_STDC_INLINE__ is not
- * defined so the gnu89 semantics are the default.
- */
-#ifdef __GNUC_STDC_INLINE__
-# define __gnu_inline	__attribute__((__gnu_inline__))
-#else
-# define __gnu_inline
-#endif
-
 /*
  * Force always-inline if the user requests it so via the .config.
  * GCC does not warn about unused static inline functions for
@@ -263,10 +250,6 @@ struct ftrace_likely_data {
 #define __inline inline
 #define noinline	__attribute__((__noinline__))
 
-#ifndef __always_inline
-#define __always_inline inline __attribute__((__always_inline__))
-#endif
-
 /*
  * Rather then using noinline to prevent stack consumption, use
  * noinline_for_stack instead.  For documentation reasons.
-- 
2.17.1
