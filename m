From: Daniel Santos <daniel.santos@pobox.com>
Subject: Re: [RFC PATCH] compiler.h: give up __compiletime_assert_fallback()
Date: Tue, 21 Aug 2018 03:11:18 -0500
Message-ID: <6b25ce92-7ffa-9fdb-c114-e7aa8f987b06@pobox.com>
References: <1534657880-11573-1-git-send-email-yamada.masahiro@socionext.com>
 <CAGXu5j+t7c31xVXD+pu3Xhv10Nj0rWsGW=H1OgXh+uKGJRicnA@mail.gmail.com>
 <CAKwvOdmPF29ywp-qx7dBTQoZPEE29QwqZL4Un==Z3T_nm0u8cQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKwvOdmPF29ywp-qx7dBTQoZPEE29QwqZL4Un==Z3T_nm0u8cQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Nick Desaulniers <ndesaulniers@google.com>, Kees Cook <keescook@chromium.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, james.hogan@imgtec.com, joe@ovn.org, Rusty Russell <rusty@rustcorp.com.au>, Arnd Bergmann <arnd@arndb.de>, sparse@chrisli.org, linux-sparse@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, George Burgess <gbiv@google.com>, James Y Knight <jyknight@google.com>
List-Id: linux-sparse@vger.kernel.org

On 08/19/2018 03:25 PM, Nick Desaulniers wrote:
> + gbiv who wrote this cool paste (showing alternatives to
> _Static_assert, which is supported by both compilers in -std=3Dgnu89,
> but not until gcc 4.6): https://godbolt.org/g/DuLsxu
>
> I can't help but think that BUILD_BUG_ON_MSG should use
> _Static_assert, then have fallbacks for gcc < 4.6.

Unfortunately _Static_assert is a woefully inadequate replacement
because it requires a C constant expression.=C2=A0 Example:

=C2=A0=C2=A0=C2=A0 int a =3D 1;
=C2=A0=C2=A0=C2=A0 _Static_assert(a =3D=3D 1, "a !=3D 1");

results in "error: expression in static assertion is not constant."=C2=A0
Language standards tend to shy away from defining implementation details
like optimizations, but we need to have completed a good data flow
analysis and constant propagation in order to do BUILD_BUG_ON_MSG, et.
al.; this is why they only work when optimizations are enabled.=C2=A0 As =
the
optimizer improves, new expressions can be used with BUILD_BUG_ON*.=C2=A0=
 I
did an analysis of this back in 2012 of how various types of variables
could be resolved to constants at compile-time and how that evolved from
gcc 3.4 to 4.7:

https://drive.google.com/open?id=3D1cQRAAOzjFy6Aw7CDc4QauHvd_spVkd5a

This changed again when -findirect-inline was added -- i.e.,
BUILD_BUG_ON could be used on parameters of inline functions even when
called by pointer, although the caller needed __flatten in some cases --
a bit messy.

Daniel
