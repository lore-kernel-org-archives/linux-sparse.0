From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: [PATCH v4 12/13] Compiler Attributes: add Doc/process/programming-language.rst
Date: Sat,  8 Sep 2018 23:24:58 +0200
Message-ID: <20180908212459.19736-13-miguel.ojeda.sandonis@gmail.com>
References: <20180908212459.19736-1-miguel.ojeda.sandonis@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180908212459.19736-1-miguel.ojeda.sandonis@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Eli Friedman <efriedma@codeaurora.org>, Christopher Li <sparse@chrisli.org>, Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Joe Perches <joe@perches.com>, Dominique Martinet <asmadeus@codewreck.org>, Nick Desaulniers <ndesaulniers@google.com>, linux-sparse@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

Cc: Jonathan Corbet <corbet@lwn.net>
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
Cc: linux-doc@vger.kernel.org
Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
---
 Documentation/process/index.rst               |  1 +
 .../process/programming-language.rst          | 45 +++++++++++++++++++
 2 files changed, 46 insertions(+)
 create mode 100644 Documentation/process/programming-language.rst

diff --git a/Documentation/process/index.rst b/Documentation/process/index.rst
index 37bd0628b6ee..c56f24a22d2a 100644
--- a/Documentation/process/index.rst
+++ b/Documentation/process/index.rst
@@ -23,6 +23,7 @@ Below are the essential guides that every developer should read.
    code-of-conflict
    development-process
    submitting-patches
+   programming-language
    coding-style
    maintainer-pgp-guide
    email-clients
diff --git a/Documentation/process/programming-language.rst b/Documentation/process/programming-language.rst
new file mode 100644
index 000000000000..e5f5f065dc24
--- /dev/null
+++ b/Documentation/process/programming-language.rst
@@ -0,0 +1,45 @@
+.. _programming_language:
+
+Programming Language
+====================
+
+The kernel is written in the C programming language [c-language]_.
+More precisely, the kernel is typically compiled with ``gcc`` [gcc]_
+under ``-std=gnu89`` [gcc-c-dialect-options]_: the GNU dialect of ISO C90
+(including some C99 features).
+
+This dialect contains many extensions to the language [gnu-extensions]_,
+and many of them are used within the kernel as a matter of course.
+
+There is some support for compiling the kernel with ``clang`` [clang]_
+and ``icc`` [icc]_ for several of the architectures, although at the time
+of writing it is not completed, requiring third-party patches.
+
+Attributes
+----------
+
+One of the common extensions used throughout the kernel are attributes
+[gcc-attribute-syntax]_. Attributes allow to introduce
+implementation-defined semantics to language entities (like variables,
+functions or types) without having to make significant syntactic changes
+to the language (e.g. adding a new keyword) [n2049]_.
+
+In some cases, attributes are optional (i.e. a compiler not supporting them
+should still produce proper code, even if it is slower or does not perform
+as many compile-time checks/diagnostics).
+
+The kernel defines pseudo-keywords (e.g. ``__pure``) instead of using
+directly the GNU attribute syntax (e.g. ``__attribute__((__pure__))``)
+in order to feature detect which ones can be used and/or to shorten the code.
+
+Please refer to ``include/linux/compiler_attributes.h`` for more information.
+
+.. [c-language] http://www.open-std.org/jtc1/sc22/wg14/www/standards
+.. [gcc] https://gcc.gnu.org
+.. [clang] https://clang.llvm.org
+.. [icc] https://software.intel.com/en-us/c-compilers
+.. [gcc-c-dialect-options] https://gcc.gnu.org/onlinedocs/gcc/C-Dialect-Options.html
+.. [gnu-extensions] https://gcc.gnu.org/onlinedocs/gcc/C-Extensions.html
+.. [gcc-attribute-syntax] https://gcc.gnu.org/onlinedocs/gcc/Attribute-Syntax.html
+.. [n2049] http://www.open-std.org/jtc1/sc22/wg14/www/docs/n2049.pdf
+
-- 
2.17.1
