From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: [PATCH v2 2/2] Compiler Attributes: naked can be shared
Date: Tue, 18 Sep 2018 18:55:42 +0200
Message-ID: <20180918165542.4691-3-miguel.ojeda.sandonis@gmail.com>
References: <20180918165542.4691-1-miguel.ojeda.sandonis@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180918165542.4691-1-miguel.ojeda.sandonis@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Eli Friedman <efriedma@codeaurora.org>, Christopher Li <sparse@chrisli.org>, Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Joe Perches <joe@perches.com>, Dominique Martinet <asmadeus@codewreck.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-sparse@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

The naked attribute is supported by at least gcc >= 4.6 (for ARM,
which is the only current user), gcc >= 8 (for x86), clang >= 3.1
and icc >= 13. See https://godbolt.org/z/350Dyc

Therefore, move it out of compiler-gcc.h so that the definition
is shared by all compilers.

This also fixes Clang support for ARM32 --- 815f0ddb346c
("include/linux/compiler*.h: make compiler-*.h mutually exclusive").

Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Eli Friedman <efriedma@codeaurora.org>
Cc: Christopher Li <sparse@chrisli.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Joe Perches <joe@perches.com>
Cc: Dominique Martinet <asmadeus@codewreck.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sparse@vger.kernel.org
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Tested-by: Stefan Agner <stefan@agner.ch>
Reviewed-by: Stefan Agner <stefan@agner.ch>
Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
---
 include/linux/compiler-gcc.h   | 8 --------
 include/linux/compiler_types.h | 8 ++++++++
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 25d3dd6b2702..4d36b27214fd 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -79,14 +79,6 @@
 #define __noretpoline __attribute__((indirect_branch("keep")))
 #endif
 
-/*
- * it doesn't make sense on ARM (currently the only user of __naked)
- * to trace naked functions because then mcount is called without
- * stack and frame pointer being set up and there is no chance to
- * restore the lr register to the value before mcount was called.
- */
-#define __naked		__attribute__((naked)) notrace
-
 #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
 
 #define __optimize(level)	__attribute__((__optimize__(level)))
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 3525c179698c..db192becfec4 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -226,6 +226,14 @@ struct ftrace_likely_data {
 #define notrace			__attribute__((no_instrument_function))
 #endif
 
+/*
+ * it doesn't make sense on ARM (currently the only user of __naked)
+ * to trace naked functions because then mcount is called without
+ * stack and frame pointer being set up and there is no chance to
+ * restore the lr register to the value before mcount was called.
+ */
+#define __naked			__attribute__((naked)) notrace
+
 #define __compiler_offsetof(a, b)	__builtin_offsetof(a, b)
 
 /*
-- 
2.17.1
