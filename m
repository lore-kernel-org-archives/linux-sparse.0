From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH 1/2] Compiler Attributes: add support for __fallthrough
 (gcc >= 7.1)
Date: Mon, 22 Oct 2018 14:09:54 +0200
Message-ID: <CANiq72ncRcjZE-mgjXJwbggZ_Nr5dZuZc4AuayKEuh074CWjcg@mail.gmail.com>
References: <20181021171414.22674-1-miguel.ojeda.sandonis@gmail.com>
 <20181021171414.22674-2-miguel.ojeda.sandonis@gmail.com> <20181022120658.jm7dv7jiq7riuqci@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181022120658.jm7dv7jiq7riuqci@ltop.local>
Sender: linux-kernel-owner@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, Dan <dan.carpenter@oracle.com>, Andreas Dilger <adilger.kernel@dilger.ca>, Masahiro Yamada <yamada.masahiro@socionext.com>, Michal Marek <michal.lkml@markovi.net>, Steven Rostedt <rostedt@goodmis.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Olof Johansson <olof@lxom.net>, Konstantin Ryabitsev <konstantin@linuxfoundation.org>, David Miller <davem@davemloft.net>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Kees Cook <keescook@chromium.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Paul Lawrence <paullawrence@google.com>, Sandipan Das <sandipan@linux.vnet.ibm.com>, Andrey Konovalov <andreyknvl@google.com>
List-Id: linux-sparse@vger.kernel.org

On Mon, Oct 22, 2018 at 2:07 PM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> On Sun, Oct 21, 2018 at 07:14:13PM +0200, Miguel Ojeda wrote:
> >
> > While comment parsing is a good idea to deal with old codebases
> > that used such a comment as documentation for humans, the best
> > solution is to use the attribute:
> >
> >   * It is a "real" part of the AST (=> better for tooling).
>
> This will create a problem for the recent versions of sparse which
> support __has_attribute() because sparse falsely pretends to support
> this attribute while, to play nice with -Wdeclaration-after-statement,
> it needs some adaptation to the parsing (it's actually seen not as a
> statement but as a declaration).  I'll see to fix it this evening.

No rush Luc! (I have sent the PR to Linus without this two patches for
the moment).

And thanks a lot for having being so quick to improve sparse to
support all these series!

Cheers,
Miguel
