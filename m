From: Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v4 00/13] Compiler Attributes
Date: Mon, 10 Sep 2018 10:17:20 -0700
Message-ID: <CAKwvOdnTxABJkQjdu6cv3e5zKB1z4n+rGkuzFxKvLAjUrqqCFA@mail.gmail.com>
References: <20180908212459.19736-1-miguel.ojeda.sandonis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180908212459.19736-1-miguel.ojeda.sandonis@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, efriedma@codeaurora.org, sparse@chrisli.org, Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>, Greg KH <gregkh@linuxfoundation.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, joe@perches.com, asmadeus@codewreck.org, linux-sparse@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

On Sat, Sep 8, 2018 at 2:25 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> The Compiler Attributes series is an effort to disentangle
> the include/linux/compiler*.h headers and bring them up to date.
>
> The main idea behind the series is to use feature checking macros
> (i.e. __has_attribute) instead of compiler version checks (e.g. GCC_VERSION),
> which are compiler-agnostic (so they can be shared, reducing the size
> of compiler-specific headers) and version-agnostic.
>
> Other related improvements have been performed in the headers as well,
> which on top of the use of __has_attribute it has amounted to a significant
> simplification of these headers (e.g. GCC_VERSION is now only guarding 4
> non-attribute macros).
>
> This series should also help the efforts to support compiling the kernel
> with clang and icc. A fair amount of documentation and comments have also
> been added, clarified or removed; and the headers are now more readable,
> which should help kernel developers in general.
>
> The series was triggered due to the move to gcc >= 4.6. In turn, this series
> has also triggered Sparse to gain the ability to recognize __has_attribute
> on its own.
>
> You can also fetch it from:
>
>   https://github.com/ojeda/linux/tree/compiler-attributes-v4
>
> Enjoy!
>
> Cheers,
> Miguel
>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> Cc: Eli Friedman <efriedma@codeaurora.org>
> Cc: Christopher Li <sparse@chrisli.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Joe Perches <joe@perches.com>
> Cc: Dominique Martinet <asmadeus@codewreck.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: linux-sparse@vger.kernel.org
> Cc: linux-doc@vger.kernel.org
> Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
>
> v3 -> v4
>
>   This time it is an important fix I found while doing randconfigs, plus
>   the documentation sentence that Nick suggested and the MAINTAINERS file.
>
>   Compile-tested for a while on (x86_64, gcc-7.3) on a few randconfs.
>
>   New:
>
>   * Add MAINTAINERS entry for the new file (compiler_attributes.h)
>     so that we try to maintain that one as clean as possible.
>     (if someone else wants to join, feel free!)
>
>   Modified:
>
>   * Fix inline macro
>
>     __always_inline cannot be used in the inline macro,
>     because people marking a function as __always_inline would
>     expand to inline which in turn would expand back to __always_inline
>     (under some configs), which would not be expanded again.
>     Added a comment about this in the inline macro.
>
>     Also added another comment about __always_inline in compiler_attributes.h
>     to note that users expect to not have to write inline (as well as
>     the attribute). We cannot simply remove "inline" there (which would
>     solve the problem described above) because using the attribute is
>     not enough for gcc. A function marked as always_inline seems to require
>     to be marked as inline itself so that the attribute is applied:
>
>       "warning: always_inline function might not be inlinable [-Wattributes]"
>
>     From the gcc docs:
>
>       "For functions declared inline, this attribute inlines the function
>        independent of any restrictions that otherwise apply to inlining."
>
>     See https://godbolt.org/z/LpzUPj for an example.
>
>   From reviews:
>
>   * Add sentence about feature-detection in Docs (Nick)
>
> Miguel Ojeda (13):
>   Compiler Attributes: remove unused attributes
>   Compiler Attributes: always use the extra-underscores syntax
>   Compiler Attributes: remove unneeded tests
>   Compiler Attributes: homogenize __must_be_array
>   Compiler Attributes: naked was fixed in gcc 4.6
>   Compiler Attributes: naked can be shared
>   Compiler Attributes: remove unneeded sparse (__CHECKER__) tests
>   Compiler Attributes: add missing SPDX ID in compiler_types.h
>   Compiler Attributes: use feature checks instead of version checks
>   Compiler Attributes: KENTRY used twice the "used" attribute
>   Compiler Attributes: remove uses of __attribute__ from compiler.h
>   Compiler Attributes: add Doc/process/programming-language.rst
>   Compiler Attributes: Add MAINTAINERS entry
>
>  Documentation/process/index.rst               |   1 +
>  .../process/programming-language.rst          |  45 ++++
>  MAINTAINERS                                   |   5 +
>  include/linux/compiler-clang.h                |   5 -
>  include/linux/compiler-gcc.h                  |  84 +-----
>  include/linux/compiler-intel.h                |   9 -
>  include/linux/compiler.h                      |  19 +-
>  include/linux/compiler_attributes.h           | 244 ++++++++++++++++++
>  include/linux/compiler_types.h                | 105 ++------
>  9 files changed, 329 insertions(+), 188 deletions(-)
>  create mode 100644 Documentation/process/programming-language.rst
>  create mode 100644 include/linux/compiler_attributes.h
>
> --
> 2.17.1
>

For the ones I didn't already review:
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

-- 
Thanks,
~Nick Desaulniers
