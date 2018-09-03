From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: [PATCH 02/12] Compiler Attributes: always use the extra-underscores syntax
Date: Mon,  3 Sep 2018 22:33:06 +0200
Message-ID: <20180903203316.16183-3-miguel.ojeda.sandonis@gmail.com>
References: <20180903203316.16183-1-miguel.ojeda.sandonis@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180903203316.16183-1-miguel.ojeda.sandonis@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Eli Friedman <efriedma@codeaurora.org>, Christopher Li <sparse@chrisli.org>, Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Joe Perches <joe@perches.com>, Dominique Martinet <asmadeus@codewreck.org>, linux-sparse@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

The attribute syntax optionally allows to surround attribute names
with "__" in order to avoid collisions with macros of the same name
(see https://gcc.gnu.org/onlinedocs/gcc/Attribute-Syntax.html).

This homogenizes all attributes to use the syntax with underscores.
While there are currently only a handful of cases of some TUs defining
macros like "error" which may collide with the attributes,
this should prevent futures surprises.

This has been done only for "standard" attributes supported by
the major compilers. In other words, those of third-party tools
(e.g. sparse, plugins...) have not been changed for the moment.

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
 include/linux/compiler-clang.h |  2 +-
 include/linux/compiler-gcc.h   | 14 ++++++------
 include/linux/compiler-intel.h |  2 +-
 include/linux/compiler.h       |  8 +++----
 include/linux/compiler_types.h | 40 +++++++++++++++++-----------------
 5 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index b1ce500fe8b3..d11cad61ba5c 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -21,7 +21,7 @@
 #define __SANITIZE_ADDRESS__
 #endif
 
-#define __no_sanitize_address __attribute__((no_sanitize("address")))
+#define __no_sanitize_address __attribute__((__no_sanitize__("address")))
 
 /*
  * Not all versions of clang implement the the type-generic versions
diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 0a2d06677d83..371b6fa2d074 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -76,7 +76,7 @@
 #endif
 
 #ifdef RETPOLINE
-#define __noretpoline __attribute__((indirect_branch("keep")))
+#define __noretpoline __attribute__((__indirect_branch__("keep")))
 #endif
 
 /*
@@ -91,15 +91,15 @@
  * GCC 4.[56] currently fail to enforce this, so we must do so ourselves.
  * See GCC PR44290.
  */
-#define __naked		__attribute__((naked)) noinline __noclone notrace
+#define __naked		__attribute__((__naked__)) noinline __noclone notrace
 
 #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
 
 #define __compiletime_object_size(obj) __builtin_object_size(obj, 0)
 
 #ifndef __CHECKER__
-#define __compiletime_warning(message) __attribute__((warning(message)))
-#define __compiletime_error(message) __attribute__((error(message)))
+#define __compiletime_warning(message) __attribute__((__warning__(message)))
+#define __compiletime_error(message) __attribute__((__error__(message)))
 
 #ifdef LATENT_ENTROPY_PLUGIN
 #define __latent_entropy __attribute__((latent_entropy))
@@ -148,7 +148,7 @@
  * optimizer that something else uses this function or variable, thus preventing
  * this.
  */
-#define __visible	__attribute__((externally_visible))
+#define __visible	__attribute__((__externally_visible__))
 
 /* gcc version specific checks */
 
@@ -205,7 +205,7 @@
  * should not be applied to that function.
  * Conflicts with inlining: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=67368
  */
-#define __no_sanitize_address __attribute__((no_sanitize_address))
+#define __no_sanitize_address __attribute__((__no_sanitize_address__))
 #endif
 
 #if GCC_VERSION >= 50100
@@ -213,7 +213,7 @@
  * Mark structures as requiring designated initializers.
  * https://gcc.gnu.org/onlinedocs/gcc/Designated-Inits.html
  */
-#define __designated_init __attribute__((designated_init))
+#define __designated_init __attribute__((__designated_init__))
 #define COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW 1
 #endif
 
diff --git a/include/linux/compiler-intel.h b/include/linux/compiler-intel.h
index 4c7f9befa9f6..fef8bb3e53ef 100644
--- a/include/linux/compiler-intel.h
+++ b/include/linux/compiler-intel.h
@@ -42,4 +42,4 @@
  * and may be redefined here because they should not be shared with other
  * compilers, like clang.
  */
-#define __visible	__attribute__((externally_visible))
+#define __visible	__attribute__((__externally_visible__))
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 7c0157d50964..ec4a28bad2c6 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -24,7 +24,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 			long ______r;					\
 			static struct ftrace_likely_data		\
 				__attribute__((__aligned__(4)))		\
-				__attribute__((section("_ftrace_annotated_branch"))) \
+				__attribute__((__section__("_ftrace_annotated_branch"))) \
 				______f = {				\
 				.data.func = __func__,			\
 				.data.file = __FILE__,			\
@@ -60,7 +60,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 		int ______r;						\
 		static struct ftrace_branch_data			\
 			__attribute__((__aligned__(4)))			\
-			__attribute__((section("_ftrace_branch")))	\
+			__attribute__((__section__("_ftrace_branch")))	\
 			______f = {					\
 				.func = __func__,			\
 				.file = __FILE__,			\
@@ -146,7 +146,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 	extern typeof(sym) sym;					\
 	static const unsigned long __kentry_##sym		\
 	__used							\
-	__attribute__((section("___kentry" "+" #sym ), used))	\
+	__attribute__((__section__("___kentry" "+" #sym ), used))	\
 	= (unsigned long)&sym;
 #endif
 
@@ -287,7 +287,7 @@ unsigned long read_word_at_a_time(const void *addr)
  * visible to the compiler.
  */
 #define __ADDRESSABLE(sym) \
-	static void * __attribute__((section(".discard.addressable"), used)) \
+	static void * __attribute__((__section__(".discard.addressable"), used)) \
 		__PASTE(__addressable_##sym, __LINE__) = (void *)&sym;
 
 /**
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index b6534292ea33..2bc0f94df38e 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -195,26 +195,26 @@ struct ftrace_likely_data {
  * would be.
  * [...]
  */
-#define __pure			__attribute__((pure))
-#define __aligned(x)		__attribute__((aligned(x)))
-#define __aligned_largest	__attribute__((aligned))
-#define __printf(a, b)		__attribute__((format(printf, a, b)))
-#define __scanf(a, b)		__attribute__((format(scanf, a, b)))
-#define __maybe_unused		__attribute__((unused))
-#define __always_unused		__attribute__((unused))
-#define __mode(x)		__attribute__((mode(x)))
+#define __pure			__attribute__((__pure__))
+#define __aligned(x)		__attribute__((__aligned__(x)))
+#define __aligned_largest	__attribute__((__aligned__))
+#define __printf(a, b)		__attribute__((__format__(printf, a, b)))
+#define __scanf(a, b)		__attribute__((__format__(scanf, a, b)))
+#define __maybe_unused		__attribute__((__unused__))
+#define __always_unused		__attribute__((__unused__))
+#define __mode(x)		__attribute__((__mode__(x)))
 #define __malloc		__attribute__((__malloc__))
 #define __used			__attribute__((__used__))
-#define __noreturn		__attribute__((noreturn))
-#define __packed		__attribute__((packed))
-#define __weak			__attribute__((weak))
-#define __alias(symbol)		__attribute__((alias(#symbol)))
-#define __cold			__attribute__((cold))
+#define __noreturn		__attribute__((__noreturn__))
+#define __packed		__attribute__((__packed__))
+#define __weak			__attribute__((__weak__))
+#define __alias(symbol)		__attribute__((__alias__(#symbol)))
+#define __cold			__attribute__((__cold__))
 #define __section(S)		__attribute__((__section__(#S)))
 
 
 #ifdef CONFIG_ENABLE_MUST_CHECK
-#define __must_check		__attribute__((warn_unused_result))
+#define __must_check		__attribute__((__warn_unused_result__))
 #else
 #define __must_check
 #endif
@@ -222,7 +222,7 @@ struct ftrace_likely_data {
 #if defined(CC_USING_HOTPATCH) && !defined(__CHECKER__)
 #define notrace			__attribute__((hotpatch(0, 0)))
 #else
-#define notrace			__attribute__((no_instrument_function))
+#define notrace			__attribute__((__no_instrument_function__))
 #endif
 
 #define __compiler_offsetof(a, b)	__builtin_offsetof(a, b)
@@ -234,7 +234,7 @@ struct ftrace_likely_data {
  * defined so the gnu89 semantics are the default.
  */
 #ifdef __GNUC_STDC_INLINE__
-# define __gnu_inline	__attribute__((gnu_inline))
+# define __gnu_inline	__attribute__((__gnu_inline__))
 #else
 # define __gnu_inline
 #endif
@@ -254,17 +254,17 @@ struct ftrace_likely_data {
 #if !defined(CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING) || \
 	!defined(CONFIG_OPTIMIZE_INLINING)
 #define inline \
-	inline __attribute__((always_inline, unused)) notrace __gnu_inline
+	inline __attribute__((__always_inline__, __unused__)) notrace __gnu_inline
 #else
-#define inline inline	__attribute__((unused)) notrace __gnu_inline
+#define inline inline	__attribute__((__unused__)) notrace __gnu_inline
 #endif
 
 #define __inline__ inline
 #define __inline inline
-#define noinline	__attribute__((noinline))
+#define noinline	__attribute__((__noinline__))
 
 #ifndef __always_inline
-#define __always_inline inline __attribute__((always_inline))
+#define __always_inline inline __attribute__((__always_inline__))
 #endif
 
 /*
-- 
2.17.1
