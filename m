From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH 0/2] Compiler Attributes: __fallthrough
Date: Mon, 22 Oct 2018 11:48:44 +0200
Message-ID: <CANiq72kOE0a4M0oCmmiWO9xTFJsybEirwUyb_ZTXpJJhc7O_TA@mail.gmail.com>
References: <20181021171414.22674-1-miguel.ojeda.sandonis@gmail.com> <20181021182926.GB6683@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181021182926.GB6683@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Dan <dan.carpenter@oracle.com>, Andreas Dilger <adilger.kernel@dilger.ca>, Masahiro Yamada <yamada.masahiro@socionext.com>, Michal Marek <michal.lkml@markovi.net>, Steven Rostedt <rostedt@goodmis.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Olof Johansson <olof@lxom.net>, Konstantin Ryabitsev <konstantin@linuxfoundation.org>, David Miller <davem@davemloft.net>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Kees Cook <keescook@chromium.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Paul Lawrence <paullawrence@google.com>, Sandipan Das <sandipan@linux.vnet.ibm.com>, Andrey Konovalov <andreyknvl@google.com>, David Woodhouse <dwmw2@infradead.org>, Will Deacon <wil>
List-Id: linux-sparse@vger.kernel.org

On Sun, Oct 21, 2018 at 8:29 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sun, Oct 21, 2018 at 07:14:12PM +0200, Miguel Ojeda wrote:
> > These are two patches are meant to go on top of the rest of the compiler
> > attributes series on:
> >
> >   https://github.com/ojeda/linux/tree/compiler-attributes
> >
> > which will be sent to Greg for the next merge window.
> >
> > Please review them and let me know! (specially if someone is against
> > __fallthrough for some reason :-).
>
> Will this work with all of the static tools that are currently looking
> for the comment instead?  I know coverity handles that, what about
> others?

Thank you Greg, good question. I will try to keep all the information
we can get about the tools in the commit message.

I will also contact the different tools about this.

Cheers,
Miguel
