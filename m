From: Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [RFC PATCH] compiler.h: give up __compiletime_assert_fallback()
Date: Sun, 19 Aug 2018 13:36:39 -0700
Message-ID: <CAKwvOdk_-vfy7f7PKUELm=FHz9aBKMdbvoMv+5_o9K7jSCG+cw@mail.gmail.com>
References: <1534657880-11573-1-git-send-email-yamada.masahiro@socionext.com>
 <CAGXu5j+t7c31xVXD+pu3Xhv10Nj0rWsGW=H1OgXh+uKGJRicnA@mail.gmail.com>
 <CAKwvOdmPF29ywp-qx7dBTQoZPEE29QwqZL4Un==Z3T_nm0u8cQ@mail.gmail.com> <CA+55aFwbdc5172q5fErgqhUmt48ZYQCrc0ftN+Cn6O-xQ8Tfrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+55aFwbdc5172q5fErgqhUmt48ZYQCrc0ftN+Cn6O-xQ8Tfrg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Andrew Morton <akpm@linux-foundation.org>, james.hogan@imgtec.com, joe@ovn.org, daniel.santos@pobox.com, Rusty Russell <rusty@rustcorp.com.au>, Arnd Bergmann <arnd@arndb.de>, sparse@chrisli.org, linux-sparse@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, George Burgess <gbiv@google.com>, James Y Knight <jyknight@google.com>
List-Id: linux-sparse@vger.kernel.org

On Sun, Aug 19, 2018 at 1:28 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, Aug 19, 2018 at 1:25 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > + gbiv who wrote this cool paste (showing alternatives to
> > _Static_assert, which is supported by both compilers in -std=gnu89,
> > but not until gcc 4.6): https://godbolt.org/g/DuLsxu
> >
> > I can't help but think that BUILD_BUG_ON_MSG should use
> > _Static_assert, then have fallbacks for gcc < 4.6.
>
> Well, it turns out that we effectively stopped supporting gcc < 4.6
> during this merge window for other reasons, so..

For the whole kernel (or just a particular arch)?  Which commit?  Do
we keep track of minimal versions somewhere?
Documentation/process/changes.rst mentions gcc 3.2 (eek), but I assume
there's a compiler version check somewhere (if you're using gcc and
it's version is less than X, abort. Ditto for clang.)
-- 
Thanks,
~Nick Desaulniers
