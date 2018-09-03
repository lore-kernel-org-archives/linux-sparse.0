From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: [PATCH 07/12] Compiler Attributes: remove unneeded sparse (__CHECKER__) tests
Date: Mon,  3 Sep 2018 22:33:11 +0200
Message-ID: <20180903203316.16183-8-miguel.ojeda.sandonis@gmail.com>
References: <20180903203316.16183-1-miguel.ojeda.sandonis@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180903203316.16183-1-miguel.ojeda.sandonis@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Eli Friedman <efriedma@codeaurora.org>, Christopher Li <sparse@chrisli.org>, Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Joe Perches <joe@perches.com>, Dominique Martinet <asmadeus@codewreck.org>, linux-sparse@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

Sparse knows about a few more attributes now, so we can remove
the __CHECKER__ conditions from them (which, in turn, allow us
to move some of them later on to compiler_attributes.h).

  * assume_aligned: since sparse's commit ffc860b ("sparse:
    ignore __assume_aligned__ attribute"), included in 0.5.1

  * error: since sparse's commit 0a04210 ("sparse: Add 'error'
    to ignored attributes"), included in 0.5.0

  * hotpatch: since sparse's commit 6043210 ("sparse/parse.c:
    ignore hotpatch attribute"), included in 0.5.1

  * warning: since sparse's commit 977365d ("Avoid "attribute
    'warning': unknown attribute" warning"), included in 0.4.2

On top of that, __must_be_array does not need it either because:

  * Even ancient versions of sparse do not have a problem

  * BUILD_BUG_ON_ZERO() is currently disabled for __CHECKER__

Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
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
Acked-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
---
 include/linux/compiler-gcc.h   | 6 ++----
 include/linux/compiler.h       | 4 ----
 include/linux/compiler_types.h | 2 +-
 3 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 3b32bbfa5a49..1ca6a51cfaa9 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -76,14 +76,12 @@
 
 #define __compiletime_object_size(obj) __builtin_object_size(obj, 0)
 
-#ifndef __CHECKER__
 #define __compiletime_warning(message) __attribute__((__warning__(message)))
 #define __compiletime_error(message) __attribute__((__error__(message)))
 
-#ifdef LATENT_ENTROPY_PLUGIN
+#if defined(LATENT_ENTROPY_PLUGIN) && !defined(__CHECKER__)
 #define __latent_entropy __attribute__((latent_entropy))
 #endif
-#endif /* __CHECKER__ */
 
 /*
  * calling noreturn functions, __builtin_unreachable() and __builtin_trap()
@@ -131,7 +129,7 @@
 
 /* gcc version specific checks */
 
-#if GCC_VERSION >= 40900 && !defined(__CHECKER__)
+#if GCC_VERSION >= 40900
 /*
  * __assume_aligned(n, k): Tell the optimizer that the returned
  * pointer can be assumed to be k modulo n. The second argument is
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 165b1d5683ed..4030a2940d6b 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -357,11 +357,7 @@ static inline void *offset_to_ptr(const int *off)
 	compiletime_assert(__native_word(t),				\
 		"Need native word sized stores/loads for atomicity.")
 
-#ifdef __CHECKER__
-#define __must_be_array(a)	0
-#else
 /* &a[0] degrades to a pointer: a different type from an array */
 #define __must_be_array(a)	BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
-#endif
 
 #endif /* __LINUX_COMPILER_H */
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index f182f2ef3227..65b10b1e2a59 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -217,7 +217,7 @@ struct ftrace_likely_data {
 #define __must_check
 #endif
 
-#if defined(CC_USING_HOTPATCH) && !defined(__CHECKER__)
+#if defined(CC_USING_HOTPATCH)
 #define notrace			__attribute__((hotpatch(0, 0)))
 #else
 #define notrace			__attribute__((__no_instrument_function__))
-- 
2.17.1
