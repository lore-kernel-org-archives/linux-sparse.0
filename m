From: Kees Cook <keescook@chromium.org>
Subject: Re: [RFC PATCH] compiler.h: give up __compiletime_assert_fallback()
Date: Tue, 21 Aug 2018 12:04:50 -0700
Message-ID: <CAGXu5j+g97kaCimRd1euRdFNg1aNQFoaVV7V6PBPOA0P51=3xg@mail.gmail.com>
References: <1534657880-11573-1-git-send-email-yamada.masahiro@socionext.com>
 <CAGXu5j+t7c31xVXD+pu3Xhv10Nj0rWsGW=H1OgXh+uKGJRicnA@mail.gmail.com>
 <CAKwvOdmPF29ywp-qx7dBTQoZPEE29QwqZL4Un==Z3T_nm0u8cQ@mail.gmail.com> <CAK7LNAQeY1kHxPpGgLfP=GUZ7nB6DQy3mYsMzLduUagGAB=OXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK7LNAQeY1kHxPpGgLfP=GUZ7nB6DQy3mYsMzLduUagGAB=OXQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, James Hogan <james.hogan@imgtec.com>, Joe Stringer <joe@ovn.org>, Daniel Santos <daniel.santos@pobox.com>, Rusty Russell <rusty@rustcorp.com.au>, Arnd Bergmann <arnd@arndb.de>, Christopher Li <sparse@chrisli.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, George Burgess <gbiv@google.com>, James Y Knight <jyknight@google.com>
List-Id: linux-sparse@vger.kernel.org

On Tue, Aug 21, 2018 at 9:15 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>> Note that there are a few definitions of BUILD_BUG_ON that still use
>> this negative array size trick.  Should that pattern be removed from
>> them as well?  See:
>> * arch/x86/boot/boot.h#L33
>> * include/linux/build_bug.h#L66
>> * tools/include/linux/kernel.h#L38
>
> At this moment, -Wvla is the warning-3 level
> in scripts/Makefile.extrawarn.

We're down to a handful of VLA uses, but I don't think the negative
cases should matter since they're _intended_ to break a compile.

-Kees

-- 
Kees Cook
Pixel Security
