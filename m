From: Kees Cook <keescook@chromium.org>
Subject: Re: [RFC PATCH] compiler.h: give up __compiletime_assert_fallback()
Date: Sun, 19 Aug 2018 09:13:58 -0700
Message-ID: <CAGXu5j+t7c31xVXD+pu3Xhv10Nj0rWsGW=H1OgXh+uKGJRicnA@mail.gmail.com>
References: <1534657880-11573-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1534657880-11573-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, James Hogan <james.hogan@imgtec.com>, Joe Stringer <joe@ovn.org>, Daniel Santos <daniel.santos@pobox.com>, Rusty Russell <rusty@rustcorp.com.au>, Arnd Bergmann <arnd@arndb.de>, Christopher Li <sparse@chrisli.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Nick Desaulniers <ndesaulniers@google.com>
List-Id: linux-sparse@vger.kernel.org

On Sat, Aug 18, 2018 at 10:51 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> __compiletime_assert_fallback() is supposed to stop building earlier
> by using the negative-array-size method in case the compiler does not
> support "error" attribute, but has never worked like that.
>
> You can try this simple code:
>
>     #include <linux/build_bug.h>
>     void foo(void)
>     {
>             BUILD_BUG_ON(1);
>     }
>
> GCC (precisely, GCC 4.3 or later) immediately terminates the build,
> but Clang does not report anything because Clang does not support the
> "error" attribute now.  It will eventually fail in the link stage,
> but at least __compiletime_assert_fallback() is not working.
>
> The root cause is commit 1d6a0d19c855 ("bug.h: prevent double evaluation
> of `condition' in BUILD_BUG_ON").  Prior to that commit, BUILD_BUG_ON()
> was checked by the negative-array-size method *and* the link-time trick.
> Since that commit, the negative-array-size is not effective because
> '__cond' is no longer constant.  As the comment in <linux/build_bug.h>
> says, GCC (and Clang as well) only emits the error for obvious cases.
>
> When '__cond' is a variable,
>
>     ((void)sizeof(char[1 - 2 * __cond]))
>
> ... is not obvious for the compiler to know the array size is negative.
>
> One way to fix this is to stop the variable assignment, i.e. to pass
> '!(condition)' directly to __compiletime_error_fallback() at the cost
> of the double evaluation of 'condition'.  However, all calls of
> BUILD_BUG() would be turned into errors even if they are called from
> dead-code.
>
> This commit does not change the current behavior since it just rips
> off the code that has not been effective for some years.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Yeah, Clang would only complain about the VLA (and not error) and then
later fail at link time. This seems like a reasonable change to me.

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>
>  include/linux/compiler.h | 17 +----------------
>  1 file changed, 1 insertion(+), 16 deletions(-)
>
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index 42506e4..c062238f4 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -295,29 +295,14 @@ unsigned long read_word_at_a_time(const void *addr)
>  #endif
>  #ifndef __compiletime_error
>  # define __compiletime_error(message)
> -/*
> - * Sparse complains of variable sized arrays due to the temporary variable in
> - * __compiletime_assert. Unfortunately we can't just expand it out to make
> - * sparse see a constant array size without breaking compiletime_assert on old
> - * versions of GCC (e.g. 4.2.4), so hide the array from sparse altogether.
> - */
> -# ifndef __CHECKER__
> -#  define __compiletime_error_fallback(condition) \
> -       do { ((void)sizeof(char[1 - 2 * condition])); } while (0)
> -# endif
> -#endif
> -#ifndef __compiletime_error_fallback
> -# define __compiletime_error_fallback(condition) do { } while (0)
>  #endif
>
>  #ifdef __OPTIMIZE__
>  # define __compiletime_assert(condition, msg, prefix, suffix)          \
>         do {                                                            \
> -               bool __cond = !(condition);                             \
>                 extern void prefix ## suffix(void) __compiletime_error(msg); \
> -               if (__cond)                                             \
> +               if (!(condition))                                       \
>                         prefix ## suffix();                             \
> -               __compiletime_error_fallback(__cond);                   \
>         } while (0)
>  #else
>  # define __compiletime_assert(condition, msg, prefix, suffix) do { } while (0)
> --
> 2.7.4
>



-- 
Kees Cook
Pixel Security
