From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: [PATCH v3 00/12] Compiler Attributes
Date: Mon,  3 Sep 2018 22:33:04 +0200
Message-ID: <20180903203316.16183-1-miguel.ojeda.sandonis@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Eli Friedman <efriedma@codeaurora.org>, Christopher Li <sparse@chrisli.org>, Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Joe Perches <joe@perches.com>, Dominique Martinet <asmadeus@codewreck.org>, Nick Desaulniers <ndesaulniers@google.com>, linux-sparse@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

The Compiler Attributes series is an effort to disentangle
the include/linux/compiler*.h headers and bring them up to date.

The main idea behind the series is to use feature checking macros
(i.e. __has_attribute) instead of compiler version checks (e.g. GCC_VERSION),
which are compiler-agnostic (so they can be shared, reducing the size
of compiler-specific headers) and version-agnostic.

Other related improvements have been performed in the headers as well,
which on top of the use of __has_attribute it has amounted to a significant
simplification of these headers (e.g. GCC_VERSION is now only guarding 4
non-attribute macros).

This series should also help the efforts to support compiling the kernel
with clang and icc. A fair amount of documentation and comments have also
been added, clarified or removed; and the headers are now more readable,
which should help kernel developers in general.

The series was triggered due to the move to gcc >= 4.6. In turn, this series
has also triggered Sparse to gain the ability to recognize __has_attribute
on its own.

You can also fetch it from:

  https://github.com/ojeda/linux/tree/compiler-attributes-v3

Enjoy!

Cheers,
Miguel

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

v2 -> v3:

  New:

  * Remove duplicated "used" attribute in KENTRY
  * Silence sparse warnings on __has_attribute & simplify the macro block
  * Add Documentation/process/programming-language.rst
  * Improve _attribute.h description
  * Improve some commit descriptions
  * Add Reviewed-by's/Acked-by's/Suggested-by's
    (hopefully I didn't miss anybody!)
  * Rebase on top of v4.19-rc2
  * Cc Rasmus, Luc

  From reviews:

  * Fix __attribute_const__ rename typo (Nick)
  * Add SPDX identifier to _attributes.h (Nick)
  * Add SPDX identifier to _types.h (Greg)
  * Remove __attribute__ uses from compiler.h (Nick)
  * Tweak clang doc comments (Nick)
  * Move __naked out of -gcc.h to be shared (Arnd)
  * Use __name__ syntax instead (Rasmus)
  * Update sparse description (Luc)
  * Remove __CHECKER__ test from __must_be_array (Luc)
  * Add note on __has_attribute regarding sparse (Luc)
  * Cc linux-sparse (Luc)

It is quite a lot of stuff changed this time around, I hope I haven't missed
anything said in the emails. Please take a look!

Compile-tested for a while on (x86_64, gcc-7.3, allmodconfig).

Miguel Ojeda (12):
  Compiler Attributes: remove unused attributes
  Compiler Attributes: always use the extra-underscores syntax
  Compiler Attributes: remove unneeded tests
  Compiler Attributes: homogenize __must_be_array
  Compiler Attributes: naked was fixed in gcc 4.6
  Compiler Attributes: naked can be shared
  Compiler Attributes: remove unneeded sparse (__CHECKER__) tests
  Compiler Attributes: add missing SPDX ID in compiler_types.h
  Compiler Attributes: use feature checks instead of version checks
  Compiler Attributes: KENTRY used twice the "used" attribute
  Compiler Attributes: remove uses of __attribute__ from compiler.h
  Compiler Attributes: add Doc/process/programming-language.rst

 Documentation/process/index.rst               |   1 +
 .../process/programming-language.rst          |  44 ++++
 include/linux/compiler-clang.h                |   5 -
 include/linux/compiler-gcc.h                  |  84 +-----
 include/linux/compiler-intel.h                |   9 -
 include/linux/compiler.h                      |  19 +-
 include/linux/compiler_attributes.h           | 239 ++++++++++++++++++
 include/linux/compiler_types.h                | 101 ++------
 8 files changed, 314 insertions(+), 188 deletions(-)
 create mode 100644 Documentation/process/programming-language.rst
 create mode 100644 include/linux/compiler_attributes.h

-- 
2.17.1
