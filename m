From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH 1/2] Compiler Attributes: add support for __fallthrough
 (gcc >= 7.1)
Date: Mon, 22 Oct 2018 15:39:47 +0200
Message-ID: <CANiq72k_uBxjzguG8YBmSaV5XUYoOsuHk+UHFdgCarr4--uGDA@mail.gmail.com>
References: <20181021171414.22674-1-miguel.ojeda.sandonis@gmail.com>
 <20181021171414.22674-2-miguel.ojeda.sandonis@gmail.com> <20181021222712.GI1617@thunk.org>
 <CANiq72mXV6WTyHXNZJDTfFOpPrXD0zD6cB30bGOuKO44AvRiog@mail.gmail.com>
 <CAGXu5jKb-0H+smRAW6ngQKDZ-PbTThhMwhmu34iB8vjTa-4H8Q@mail.gmail.com>
 <CANiq72n4+HDXPqr7xySSGx49g8vEcXaxO7a-By9cSg7YSxOS_A@mail.gmail.com>
 <CAGXu5jLzfuEnWpJFL1Caq94nKbPps-QTaYGpge2CfZWj1Zzf9g@mail.gmail.com> <CANiq72kpCoVwCzMUVYB_km+9xr41gBZLo_K203e_t4_QZ9-r1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CANiq72kpCoVwCzMUVYB_km+9xr41gBZLo_K203e_t4_QZ9-r1Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Ted Ts'o <tytso@mit.edu>, Greg KH <gregkh@linuxfoundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, Dan <dan.carpenter@oracle.com>, Andreas Dilger <adilger.kernel@dilger.ca>, Masahiro Yamada <yamada.masahiro@socionext.com>, Michal Marek <michal.lkml@markovi.net>, Steven Rostedt <rostedt@goodmis.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Olof Johansson <olof@lxom.net>, Konstantin Ryabitsev <konstantin@linuxfoundation.org>, David Miller <davem@davemloft.net>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Paul Lawrence <paullawrence@google.com>, Sandipan Das <sandipan@linux.vnet.ibm.com>, Andrey Konovalov <andreykn>
List-Id: linux-sparse@vger.kernel.org

On Mon, Oct 22, 2018 at 1:24 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Mon, Oct 22, 2018 at 12:53 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Mon, Oct 22, 2018 at 2:41 AM, Miguel Ojeda
> > <miguel.ojeda.sandonis@gmail.com> wrote:
> >
> > >   * clang does *not* support the attribute in C.
> >
> > Well that's not good. :)
>
> I will see with clang if they plan to add it.
>

So I have looked in the clang sources and I have seen that clang is
already preparing for C2x: since clang >= 6 we can actually enable the
C++-like attributes with "-fdouble-square-bracket-attributes" in C
mode, which in turn makes the warning work in C mode and can be
suppressed with [[fallthrough]]. This would give us the warning also
in clang, which would be a win vs. the comments. Nick?

However, I don't see a way to enable [[fallthrough]] in C mode for gcc
>= 7.1 -- from a quick look, the C parser does not know about [[]]
attributes, so I don't think we can use [[fallthrough]] for both
compilers (yet).

Cheers,
Miguel
