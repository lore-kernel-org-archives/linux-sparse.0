From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: [PATCH v4 06/13] Compiler Attributes: naked can be shared
Date: Sat,  8 Sep 2018 23:24:52 +0200
Message-ID: <20180908212459.19736-7-miguel.ojeda.sandonis@gmail.com>
References: <20180908212459.19736-1-miguel.ojeda.sandonis@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180908212459.19736-1-miguel.ojeda.sandonis@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Eli Friedman <efriedma@codeaurora.org>, Christopher Li <sparse@chrisli.org>, Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Joe Perches <joe@perches.com>, Dominique Martinet <asmadeus@codewreck.org>, Nick Desaulniers <ndesaulniers@google.com>, linux-sparse@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

The naked attribute is supported by at least gcc >= 4.6 (for ARM,
which is the only current user), gcc >= 8 (for x86), clang >= 3.1
and icc >= 13. See https://godbolt.org/z/350Dyc

Therefore, move it out of compiler-gcc.h so that the definition
is shared by all compilers.

Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Eli Friedman <efriedma@codeaurora.org>
Cc: Christopher Li <sparse@chrisli.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Joe Perches <joe@perches.com>
Cc: Dominique Martinet <asmadeus@codewreck.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sparse@vger.kernel.org
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
---
 include/linux/compiler-gcc.h   | 8 --------
 include/linux/compiler_types.h | 8 ++++++++
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 4cd5e9264bce..3b32bbfa5a49 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -72,14 +72,6 @@
 #define __noretpoline __attribute__((__indirect_branch__("keep")))
 #endif
 
-/*
- * it doesn't make sense on ARM (currently the only user of __naked)
- * to trace naked functions because then mcount is called without
- * stack and frame pointer being set up and there is no chance to
- * restore the lr register to the value before mcount was called.
- */
-#define __naked		__attribute__((__naked__)) notrace
-
 #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
 
 #define __compiletime_object_size(obj) __builtin_object_size(obj, 0)
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 83475515bc39..5ff9cda893f4 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -224,6 +224,14 @@ struct ftrace_likely_data {
 #define notrace			__attribute__((__no_instrument_function__))
 #endif
 
+/*
+ * it doesn't make sense on ARM (currently the only user of __naked)
+ * to trace naked functions because then mcount is called without
+ * stack and frame pointer being set up and there is no chance to
+ * restore the lr register to the value before mcount was called.
+ */
+#define __naked			__attribute__((__naked__)) notrace
+
 #define __compiler_offsetof(a, b)	__builtin_offsetof(a, b)
 
 /*
-- 
2.17.1
