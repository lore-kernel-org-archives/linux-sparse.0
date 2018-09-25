From: Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v3 1/2] Compiler Attributes: naked can be shared
Date: Tue, 25 Sep 2018 11:53:38 -0700
Message-ID: <20180925185339.80701-2-mka@chromium.org>
References: <20180925185339.80701-1-mka@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180925185339.80701-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, Marcin Wojtas <mw@semihalf.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Sinan Kaya <okaya@codeaurora.org>, Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Pekka Enberg <penberg@kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, Balakrishna Godavarthi <bgodavar@codeaurora.org>, Loic Poulain <loic.poulain@linaro.org>, Brian Norris <briannorris@chromium.org>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Eli Friedman <efriedma@codeaurora.org>, Christopher Li <sparse@chrisli.org>, Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Joe Perches <joe@perches.com>, Dominique Martinet <asmadeus@codewreck.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-sparse@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

The naked attribute is supported by at least gcc >= 4.6 (for ARM,
which is the only current user), gcc >= 8 (for x86), clang >= 3.1
and icc >= 13. See https://godbolt.org/z/350Dyc

Therefore, move it out of compiler-gcc.h so that the definition
is shared by all compilers.

This also fixes Clang support for ARM32 --- 815f0ddb346c
("include/linux/compiler*.h: make compiler-*.h mutually exclusive").

Fixes: 815f0ddb346c ("include/linux/compiler*.h: make compiler-*.h mutually exclusive")
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
2.19.0.605.g01d371f741-goog
