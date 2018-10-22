From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH 1/2] Compiler Attributes: add support for __fallthrough
 (gcc >= 7.1)
Date: Mon, 22 Oct 2018 22:59:16 +0200
Message-ID: <CANiq72kUJOSrR=h2=2jXfkBPLrR=DrN8X4OoKOqAte4sMLxkdQ@mail.gmail.com>
References: <20181021171414.22674-1-miguel.ojeda.sandonis@gmail.com>
 <20181021171414.22674-2-miguel.ojeda.sandonis@gmail.com> <20181021222712.GI1617@thunk.org>
 <CANiq72mXV6WTyHXNZJDTfFOpPrXD0zD6cB30bGOuKO44AvRiog@mail.gmail.com>
 <CAGXu5jKb-0H+smRAW6ngQKDZ-PbTThhMwhmu34iB8vjTa-4H8Q@mail.gmail.com>
 <CANiq72n4+HDXPqr7xySSGx49g8vEcXaxO7a-By9cSg7YSxOS_A@mail.gmail.com>
 <CANiq72kNnrhi8OPbF7P+Rw4SGYu=JuvhDKtzGtG2J5AOoC1-Dw@mail.gmail.com> <CAKwvOdn1TOzZYg_i0zB0rU+K3jaQQ8XmWnLXz01NCG9V+8PxHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKwvOdn1TOzZYg_i0zB0rU+K3jaQQ8XmWnLXz01NCG9V+8PxHw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Kees Cook <keescook@chromium.org>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Ted Ts'o <tytso@mit.edu>, Greg KH <gregkh@linuxfoundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, Dan <dan.carpenter@oracle.com>, Andreas Dilger <adilger.kernel@dilger.ca>, Masahiro Yamada <yamada.masahiro@socionext.com>, Michal Marek <michal.lkml@markovi.net>, Steven Rostedt <rostedt@goodmis.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Olof Johansson <olof@lxom.net>, Konstantin Ryabitsev <konstantin@linuxfoundation.org>, David Miller <davem@davemloft.net>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Paul Lawrence <paullawrence@google.com>, Sandipan Das <sandipan@linux.vnet.i>
List-Id: linux-sparse@vger.kernel.org

On Mon, Oct 22, 2018 at 7:17 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Mon, Oct 22, 2018 at 2:43 AM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> >
> > On Mon, Oct 22, 2018 at 11:41 AM Miguel Ojeda
> > <miguel.ojeda.sandonis@gmail.com> wrote:
> > >
> > >   * clang does *not* support the attribute in C.
> >
> > ...nor the warning at all, by the way (which is why this is OK).
> >
> > Cheers,
> > Miguel
>
> Oh? We're going through and annotating all of Android's C++ source
> right now with it.
> https://clang.llvm.org/docs/DiagnosticsReference.html#wimplicit-fallthrough
>

Sure, but I am talking about the C mode only. Please read the previous
messages in the thread :-)

> Though it looks like the attribute syntax I like from GCC is not yet
> supported in Clang.

Indeed, that is what I explained in the last message.

> https://bugs.llvm.org/show_bug.cgi?id=37135
> https://github.com/ClangBuiltLinux/linux/issues/235
> I'll take a look at adding support.
>
> So Kees sent me this embarrassing example:
> https://godbolt.org/z/gV_c9_
> (try changing the language from C++ to C; it works)!  That's embarrassing!

Yup, that is what I have been testing yesterday -- see the linked
thread in the commit message for the summary of the results.

> https://bugs.llvm.org/show_bug.cgi?id=39382
> https://github.com/ClangBuiltLinux/linux/issues/236
> Will get these both fixed up.

Cheers,
Miguel
