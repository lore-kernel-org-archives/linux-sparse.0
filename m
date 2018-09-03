From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: [PATCH 05/12] Compiler Attributes: naked was fixed in gcc 4.6
Date: Mon,  3 Sep 2018 22:33:09 +0200
Message-ID: <20180903203316.16183-6-miguel.ojeda.sandonis@gmail.com>
References: <20180903203316.16183-1-miguel.ojeda.sandonis@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180903203316.16183-1-miguel.ojeda.sandonis@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Eli Friedman <efriedma@codeaurora.org>, Christopher Li <sparse@chrisli.org>, Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Joe Perches <joe@perches.com>, Dominique Martinet <asmadeus@codewreck.org>, Nick Desaulniers <ndesaulniers@google.com>, linux-sparse@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

Commit 9c695203a7dd ("compiler-gcc.h: gcc-4.5 needs noclone
and noinline on __naked functions") added noinline and noclone
as a workaround for a gcc 4.5 bug, which was resolved in 4.6.0.

Since now the minimum gcc supported version is 4.6,
we can clean it up.

See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=44290
and https://godbolt.org/z/h6NMIL

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
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sparse@vger.kernel.org
Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
---
 include/linux/compiler-gcc.h | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 76f4907ef707..4cd5e9264bce 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -77,14 +77,8 @@
  * to trace naked functions because then mcount is called without
  * stack and frame pointer being set up and there is no chance to
  * restore the lr register to the value before mcount was called.
- *
- * The asm() bodies of naked functions often depend on standard calling
- * conventions, therefore they must be noinline and noclone.
- *
- * GCC 4.[56] currently fail to enforce this, so we must do so ourselves.
- * See GCC PR44290.
  */
-#define __naked		__attribute__((__naked__)) noinline __noclone notrace
+#define __naked		__attribute__((__naked__)) notrace
 
 #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
 
-- 
2.17.1
