From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [RFC PATCH] compiler.h: give up __compiletime_assert_fallback()
Date: Wed, 22 Aug 2018 01:15:48 +0900
Message-ID: <CAK7LNAQeY1kHxPpGgLfP=GUZ7nB6DQy3mYsMzLduUagGAB=OXQ@mail.gmail.com>
References: <1534657880-11573-1-git-send-email-yamada.masahiro@socionext.com>
 <CAGXu5j+t7c31xVXD+pu3Xhv10Nj0rWsGW=H1OgXh+uKGJRicnA@mail.gmail.com> <CAKwvOdmPF29ywp-qx7dBTQoZPEE29QwqZL4Un==Z3T_nm0u8cQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKwvOdmPF29ywp-qx7dBTQoZPEE29QwqZL4Un==Z3T_nm0u8cQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Kees Cook <keescook@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, James Hogan <james.hogan@imgtec.com>, joe@ovn.org, daniel.santos@pobox.com, Rusty Russell <rusty@rustcorp.com.au>, Arnd Bergmann <arnd@arndb.de>, Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, George Burgess <gbiv@google.com>, James Y Knight <jyknight@google.com>
List-Id: linux-sparse@vger.kernel.org

Hi Nick,


2018-08-20 5:25 GMT+09:00 Nick Desaulniers <ndesaulniers@google.com>:
> + gbiv who wrote this cool paste (showing alternatives to
> _Static_assert, which is supported by both compilers in -std=gnu89,
> but not until gcc 4.6): https://godbolt.org/g/DuLsxu
>
> I can't help but think that BUILD_BUG_ON_MSG should use
> _Static_assert, then have fallbacks for gcc < 4.6.
>
> On Sun, Aug 19, 2018 at 9:14 AM Kees Cook <keescook@chromium.org> wrote:
>>
>> On Sat, Aug 18, 2018 at 10:51 PM, Masahiro Yamada
>> <yamada.masahiro@socionext.com> wrote:
>> > __compiletime_assert_fallback() is supposed to stop building earlier
>> > by using the negative-array-size method in case the compiler does not
>> > support "error" attribute, but has never worked like that.
>> >
>> > You can try this simple code:
>> >
>> >     #include <linux/build_bug.h>
>> >     void foo(void)
>> >     {
>> >             BUILD_BUG_ON(1);
>> >     }
>> >
>> > GCC (precisely, GCC 4.3 or later) immediately terminates the build,
>> > but Clang does not report anything because Clang does not support the
>> > "error" attribute now.  It will eventually fail in the link stage,
>> > but at least __compiletime_assert_fallback() is not working.
>> >
>> > The root cause is commit 1d6a0d19c855 ("bug.h: prevent double evaluation
>> > of `condition' in BUILD_BUG_ON").  Prior to that commit, BUILD_BUG_ON()
>> > was checked by the negative-array-size method *and* the link-time trick.
>> > Since that commit, the negative-array-size is not effective because
>> > '__cond' is no longer constant.  As the comment in <linux/build_bug.h>
>> > says, GCC (and Clang as well) only emits the error for obvious cases.
>> >
>> > When '__cond' is a variable,
>> >
>> >     ((void)sizeof(char[1 - 2 * __cond]))
>> >
>> > ... is not obvious for the compiler to know the array size is negative.
>> >
>> > One way to fix this is to stop the variable assignment, i.e. to pass
>> > '!(condition)' directly to __compiletime_error_fallback() at the cost
>> > of the double evaluation of 'condition'.  However, all calls of
>> > BUILD_BUG() would be turned into errors even if they are called from
>> > dead-code.
>> >
>> > This commit does not change the current behavior since it just rips
>> > off the code that has not been effective for some years.
>> >
>> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>>
>> Yeah, Clang would only complain about the VLA (and not error) and then
>> later fail at link time. This seems like a reasonable change to me.
>
> Heh, we were just talking about this (-Wvla warnings from this macro).
> Was there a previous thread before this patch?


No.
I had noticed that this code was not working some months before,
but have been wondering what to do.


I was not tracking the -Wvla thread because
the discussion was very long.


>>
>> Reviewed-by: Kees Cook <keescook@chromium.org>
>>
>> -Kees
>>
>> > ---
>> >
>> >  include/linux/compiler.h | 17 +----------------
>> >  1 file changed, 1 insertion(+), 16 deletions(-)
>> >
>> > diff --git a/include/linux/compiler.h b/include/linux/compiler.h
>> > index 42506e4..c062238f4 100644
>> > --- a/include/linux/compiler.h
>> > +++ b/include/linux/compiler.h
>> > @@ -295,29 +295,14 @@ unsigned long read_word_at_a_time(const void *addr)
>> >  #endif
>> >  #ifndef __compiletime_error
>> >  # define __compiletime_error(message)
>> > -/*
>> > - * Sparse complains of variable sized arrays due to the temporary variable in
>> > - * __compiletime_assert. Unfortunately we can't just expand it out to make
>> > - * sparse see a constant array size without breaking compiletime_assert on old
>> > - * versions of GCC (e.g. 4.2.4), so hide the array from sparse altogether.
>> > - */
>> > -# ifndef __CHECKER__
>> > -#  define __compiletime_error_fallback(condition) \
>> > -       do { ((void)sizeof(char[1 - 2 * condition])); } while (0)
>
> Note that there are a few definitions of BUILD_BUG_ON that still use
> this negative array size trick.  Should that pattern be removed from
> them as well?  See:
> * arch/x86/boot/boot.h#L33
> * include/linux/build_bug.h#L66
> * tools/include/linux/kernel.h#L38

At this moment, -Wvla is the warning-3 level
in scripts/Makefile.extrawarn.

Personally, I do not care that much.


Thanks.



> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> --
> Thanks,
> ~Nick Desaulniers



-- 
Best Regards
Masahiro Yamada
