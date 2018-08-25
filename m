From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [RFC PATCH] compiler.h: give up __compiletime_assert_fallback()
Date: Sun, 26 Aug 2018 03:11:38 +0900
Message-ID: <CAK7LNAQ-i0T7sZBg5baFTXEwekbhWVLDSfOKCmHmNX-gHd5JHA@mail.gmail.com>
References: <1534657880-11573-1-git-send-email-yamada.masahiro@socionext.com>
 <CAGXu5j+t7c31xVXD+pu3Xhv10Nj0rWsGW=H1OgXh+uKGJRicnA@mail.gmail.com>
 <CAKwvOdmPF29ywp-qx7dBTQoZPEE29QwqZL4Un==Z3T_nm0u8cQ@mail.gmail.com> <6b25ce92-7ffa-9fdb-c114-e7aa8f987b06@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6b25ce92-7ffa-9fdb-c114-e7aa8f987b06@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Santos <daniel.santos@pobox.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>, Kees Cook <keescook@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, James Hogan <james.hogan@imgtec.com>, Joe Stringer <joe@ovn.org>, Rusty Russell <rusty@rustcorp.com.au>, Arnd Bergmann <arnd@arndb.de>, Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, George Burgess <gbiv@google.com>, James Y Knight <jyknight@google.com>
List-Id: linux-sparse@vger.kernel.org

Hi Daniel,


2018-08-21 17:11 GMT+09:00 Daniel Santos <daniel.santos@pobox.com>:
> On 08/19/2018 03:25 PM, Nick Desaulniers wrote:
>> + gbiv who wrote this cool paste (showing alternatives to
>> _Static_assert, which is supported by both compilers in -std=gnu89,
>> but not until gcc 4.6): https://godbolt.org/g/DuLsxu
>>
>> I can't help but think that BUILD_BUG_ON_MSG should use
>> _Static_assert, then have fallbacks for gcc < 4.6.
>
> Unfortunately _Static_assert is a woefully inadequate replacement
> because it requires a C constant expression.  Example:
>
>     int a = 1;
>     _Static_assert(a == 1, "a != 1");
>
> results in "error: expression in static assertion is not constant."


You are right.




I tried diagnose_if from Clang:

static inline void assert_d(int i) __attribute__((diagnose_if(!i, "oh
no", "error")))
{
}



Clang is silent about

       int a = 1;
       assert_d(a);




But,

       if (0)
              assert_d(0);


is error.

Hence, it cannot be used for BUILD_BUG().







Anyway, I will just try to rebase this patch and send it to Linus.



> Language standards tend to shy away from defining implementation details
> like optimizations, but we need to have completed a good data flow
> analysis and constant propagation in order to do BUILD_BUG_ON_MSG, et.
> al.; this is why they only work when optimizations are enabled.  As the
> optimizer improves, new expressions can be used with BUILD_BUG_ON*.  I
> did an analysis of this back in 2012 of how various types of variables
> could be resolved to constants at compile-time and how that evolved from
> gcc 3.4 to 4.7:
>
> https://drive.google.com/open?id=1cQRAAOzjFy6Aw7CDc4QauHvd_spVkd5a
>
> This changed again when -findirect-inline was added -- i.e.,
> BUILD_BUG_ON could be used on parameters of inline functions even when
> called by pointer, although the caller needed __flatten in some cases --
> a bit messy.
>
> Daniel



-- 
Best Regards
Masahiro Yamada
