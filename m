From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH 1/2] Compiler Attributes: add support for __fallthrough
 (gcc >= 7.1)
Date: Mon, 22 Oct 2018 11:32:29 +0200
Message-ID: <CANiq72nKkJgLuHVTEZAMPcrXeTd1OvP2owCAUjqnYtru4JeMYA@mail.gmail.com>
References: <20181021171414.22674-1-miguel.ojeda.sandonis@gmail.com>
 <20181021171414.22674-2-miguel.ojeda.sandonis@gmail.com> <20181022004217.GA4941@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181022004217.GA4941@bombadil.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Wilcox <willy@infradead.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, Dan <dan.carpenter@oracle.com>, Andreas Dilger <adilger.kernel@dilger.ca>, Masahiro Yamada <yamada.masahiro@socionext.com>, Michal Marek <michal.lkml@markovi.net>, Steven Rostedt <rostedt@goodmis.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Olof Johansson <olof@lxom.net>, Konstantin Ryabitsev <konstantin@linuxfoundation.org>, David Miller <davem@davemloft.net>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Kees Cook <keescook@chromium.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Paul Lawrence <paullawrence@google.com>, Sandipan Das <sandipan@linux.vnet.ibm.com>, Andrey Konovalov <andreyknvl@google.com>
List-Id: linux-sparse@vger.kernel.org

On Mon, Oct 22, 2018 at 2:42 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Sun, Oct 21, 2018 at 07:14:13PM +0200, Miguel Ojeda wrote:
> > +#if __has_attribute(__fallthrough__)
> > +# define __fallthrough                  __attribute__((__fallthrough__))
> > +#else
> > +# define __fallthrough
> > +#endif
>
> Why is the #else not:
>
> # define __fallthrough          /* fallthrough */
>
> Would this solve the Coverity problem, or does Coverity look at the raw
> source code before preprocessing?

That wouldn't work if Coverity follows the standard, because it is
required that comments are removed right before the preprocessing
phase.

That is one of the advantages vs. the attribute that I mentioned:

    """
    We can actually use a #define for it like for the rest of
    attributes/extensions, which is not possible with a comment, (...)
    """

Cheers,
Miguel
