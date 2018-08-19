From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH] compiler.h: give up __compiletime_assert_fallback()
Date: Sun, 19 Aug 2018 13:52:28 -0700
Message-ID: <CA+55aFyDZQhBQKLjYP5F7xfONRuu8m+aDXeRXZvk=8kb-+N1Kw@mail.gmail.com>
References: <1534657880-11573-1-git-send-email-yamada.masahiro@socionext.com>
 <CAGXu5j+t7c31xVXD+pu3Xhv10Nj0rWsGW=H1OgXh+uKGJRicnA@mail.gmail.com>
 <CAKwvOdmPF29ywp-qx7dBTQoZPEE29QwqZL4Un==Z3T_nm0u8cQ@mail.gmail.com>
 <CA+55aFwbdc5172q5fErgqhUmt48ZYQCrc0ftN+Cn6O-xQ8Tfrg@mail.gmail.com> <CAKwvOdk_-vfy7f7PKUELm=FHz9aBKMdbvoMv+5_o9K7jSCG+cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKwvOdk_-vfy7f7PKUELm=FHz9aBKMdbvoMv+5_o9K7jSCG+cw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Kees Cook <keescook@chromium.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Andrew Morton <akpm@linux-foundation.org>, James Hogan <james.hogan@imgtec.com>, joe@ovn.org, daniel.santos@pobox.com, Rusty Russell <rusty@rustcorp.com.au>, Arnd Bergmann <arnd@arndb.de>, Christopher Li <sparse@chrisli.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, gbiv@google.com, James Y Knight <jyknight@google.com>
List-Id: linux-sparse@vger.kernel.org

On Sun, Aug 19, 2018 at 1:36 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Sun, Aug 19, 2018 at 1:28 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Well, it turns out that we effectively stopped supporting gcc < 4.6
> > during this merge window for other reasons, so..
>
> For the whole kernel (or just a particular arch)?  Which commit?  Do
> we keep track of minimal versions somewhere?

It's effectively for the whole kernel right now. See:

    https://lore.kernel.org/lkml/20180814170904.GA12768@roeck-us.net/

although it might be fixable. Nobody really *wants* to fix it, though,
because we've had that initializer issue before too, and various other
issues with old gcc versions.

So we have long had reasons why we'd _want_ to upgrade to at least gcc-4.6

The "we support gcc-3.2" in Documentation/process/changes.rst is
complete fantasy.

              Linus
