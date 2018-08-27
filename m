From: Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2] compiler.h: give up __compiletime_assert_fallback()
Date: Mon, 27 Aug 2018 13:09:57 -0700
Message-ID: <CAKwvOdm7RrGpwk4LMFhsKx=5QMDoFAF8JX=RMZ9YXwOptDfhCg@mail.gmail.com>
References: <1535220989-27645-1-git-send-email-yamada.masahiro@socionext.com> <84cf6ae0-97c8-6b73-ca86-b3d3b3daba5b@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <84cf6ae0-97c8-6b73-ca86-b3d3b3daba5b@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: daniel.santos@pobox.com
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Linus Torvalds <torvalds@linux-foundation.org>, Kees Cook <keescook@chromium.org>, sparse@chrisli.org, linux-sparse@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-sparse@vger.kernel.org

On Mon, Aug 27, 2018 at 1:05 PM Daniel Santos <daniel.santos@pobox.com> wrote:
>
> Hello Masahiro,
>
>
> On 08/25/2018 01:16 PM, Masahiro Yamada wrote:
> > __compiletime_assert_fallback() is supposed to stop building earlier
> > by using the negative-array-size method in case the compiler does not
> > support "error" attribute, but has never worked like that.
> >
> > You can simply try:
> >
> >     BUILD_BUG_ON(1);
> >
> > GCC immediately terminates the build, but Clang does not report
> > anything because Clang does not support the "error" attribute now.
> > It will later fail at link time, but __compiletime_assert_fallback()
> > is not working at least.
> >
> > The root cause is commit 1d6a0d19c855 ("bug.h: prevent double evaluation
> > of `condition' in BUILD_BUG_ON").
>
> I didn't really think this particular patch was necessary, but it was
> requested that I eliminate double evaluation and I didn't feel like
> arguing it at the time. :)  In my philosophy however, one should *never*
> use an expression with side effects in any type of assert.
>
> > Prior to that commit, BUILD_BUG_ON()
> > was checked by the negative-array-size method *and* the link-time trick.
> > Since that commit, the negative-array-size is not effective because
> > '__cond' is no longer constant.
>
> Now we're back to the question of "what do you mean by 'constant'"?  If
> you mean a C constant expression (as defined in the C standard) than
> almost none of this code fits that criteria.  For these compile-time
> assertions to work, we are concerned with the data flow analysis and
> constant propagation performed by the compiler during optimization.  You
> will notice in include/linux/compiler.h that __compiletime_assert is a
> no-op when __OPTIMIZE__ is not defined.

Depending on optimizations for static assertions sounds problematic.

>
> > As the comment in <linux/build_bug.h>
> > says, GCC (and Clang as well) only emits the error for obvious cases.
> >
> > When '__cond' is a variable,
> >
> >     ((void)sizeof(char[1 - 2 * __cond]))
> >
> > ... is not obvious for the compiler to know the array size is negative.
> >
> > Reverting that commit would break BUILD_BUG() because negative-size-array
> > is evaluated before the code is optimized out.
> >
> > Let's give up __compiletime_assert_fallback().  This commit does not
> > change the current behavior since it just rips off the useless code.
>
> Clang is not the only target audience of
> __compiletime_assert_fallback().  Instead of ripping out something that
> may benefit builds with gcc 4.2 and earlier, why not override its

Note that with commit cafa0010cd51 ("Raise the minimum required gcc
version to 4.6") that gcc < 4.6 is irrelevant.

> definition in compiler-clang.h with something that will break the build
> for Clang?  It would need an #ifndef __compiletime_error_fallback here
> though.
>
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> > ---
> >
> > Changes in v2:
> >   - Rebase
> >
> >  include/linux/compiler.h | 17 +----------------
> >  1 file changed, 1 insertion(+), 16 deletions(-)
> >
> > diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> > index 681d866..87c776c 100644
> > --- a/include/linux/compiler.h
> > +++ b/include/linux/compiler.h
> > @@ -314,29 +314,14 @@ static inline void *offset_to_ptr(const int *off)
> >  #endif
> >  #ifndef __compiletime_error
> >  # define __compiletime_error(message)
> > -/*
> > - * Sparse complains of variable sized arrays due to the temporary variable in
> > - * __compiletime_assert. Unfortunately we can't just expand it out to make
> > - * sparse see a constant array size without breaking compiletime_assert on old
> > - * versions of GCC (e.g. 4.2.4), so hide the array from sparse altogether.
> > - */
> > -# ifndef __CHECKER__
> > -#  define __compiletime_error_fallback(condition) \
> > -     do { ((void)sizeof(char[1 - 2 * condition])); } while (0)
> > -# endif
> > -#endif
> > -#ifndef __compiletime_error_fallback
> > -# define __compiletime_error_fallback(condition) do { } while (0)
> >  #endif
> >
> >  #ifdef __OPTIMIZE__
> >  # define __compiletime_assert(condition, msg, prefix, suffix)                \
> >       do {                                                            \
> > -             int __cond = !(condition);                              \
> >               extern void prefix ## suffix(void) __compiletime_error(msg); \
> > -             if (__cond)                                             \
> > +             if (!(condition))                                       \
> >                       prefix ## suffix();                             \
> > -             __compiletime_error_fallback(__cond);                   \
> >       } while (0)
> >  #else
> >  # define __compiletime_assert(condition, msg, prefix, suffix) do { } while (0)
>
> To give any more meaningful feedback I think I will need to experiment
> with Clang, older GCC versions and icc.  It occurred to me that I should
> probably clean up and publish my __builtin_constant_p test program and
> also generate results for more recent compilers.  I can extend it to
> test various negative sized array constructs and it could help inform
> this decision.
>
> IMO, the most ideal solution would be a set of C2x (or future)
> extensions providing something similar to C++'s constexpr, GCC's
> __builtin_constant_p and our BUILD_BUG_ON.  This would cross deeply into

Note that __builtin_constant_p is a wild beast with lots of edge
cases, and dependencies on compiler and optimization level.  I'm
trying to sort out some of these differences right now with llvm
developers.

> territory traditionally considered to belong to the implementation, so
> it's no small request.  A lot would have to be resolved for it to work
> in the standard.
>
> Daniel



-- 
Thanks,
~Nick Desaulniers
