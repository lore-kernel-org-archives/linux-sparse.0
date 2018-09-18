From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH 2/2] Compiler Attributes: naked can be shared
Date: Tue, 18 Sep 2018 18:06:58 +0200
Message-ID: <CANiq72=JnMMp=jTvqi4iiTrOXxRMHs3kk8h_ukr0ughtntdEaw@mail.gmail.com>
References: <20180913235941.31211-1-miguel.ojeda.sandonis@gmail.com>
 <20180913235941.31211-3-miguel.ojeda.sandonis@gmail.com> <40a059bad54389ff2a9ddc26b9d99a4b@agner.ch>
 <20180918073005.GA4067@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180918073005.GA4067@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Stefan Agner <stefan@agner.ch>, Arnd Bergmann <arnd@arndb.de>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Eli Friedman <efriedma@codeaurora.org>, Christopher Li <sparse@chrisli.org>, Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Joe Perches <joe@perches.com>, Dominique Martinet <asmadeus@codewreck.org>, linux-sparse@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

On Tue, Sep 18, 2018 at 9:30 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Mon, Sep 17, 2018 at 08:19:50PM -0700, Stefan Agner wrote:
>> On 13.09.2018 16:59, Miguel Ojeda wrote:
>> > The naked attribute is supported by at least gcc >=3D 4.6 (for ARM,
>> > which is the only current user), gcc >=3D 8 (for x86), clang >=3D 3.1
>> > and icc >=3D 13. See https://godbolt.org/z/350Dyc
>> >
>> > Therefore, move it out of compiler-gcc.h so that the definition
>> > is shared by all compilers.
>> >
>> > This also fixes Clang support for ARM32 --- 815f0ddb346c
>> > ("include/linux/compiler*.h: make compiler-*.h mutually exclusive").
>> >
>> > Cc: Stefan Agner <stefan@agner.ch>
>> > Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>> > Cc: Eli Friedman <efriedma@codeaurora.org>
>> > Cc: Christopher Li <sparse@chrisli.org>
>> > Cc: Kees Cook <keescook@chromium.org>
>> > Cc: Ingo Molnar <mingo@kernel.org>
>> > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> > Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
>> > Cc: Joe Perches <joe@perches.com>
>> > Cc: Dominique Martinet <asmadeus@codewreck.org>
>> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
>> > Cc: linux-sparse@vger.kernel.org
>> > Suggested-by: Arnd Bergmann <arnd@arndb.de>
>> > Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
>> > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>> > Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
>>
>> Reviewed-by: Stefan Agner <stefan@agner.ch>
>>
>> Ideally this two patches should go into v4.19. Not sure which path the p=
atch should take, MAINTAINERS is not quite clear about that. This fixes 815=
f0ddb346c ("include/linux/compiler*.h: make compiler-*.h mutually exclusive=
") for ARM32, which has been merged directly by
>> Linus, afaict...
>
> Good point, can you resend these to me with all of the acks added so
> far?

Sure (I think only Stefan is the added ack, though).

Cheers,
Miguel
