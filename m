From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH v5 00/15] Compiler Attributes
Date: Sun, 30 Sep 2018 13:13:36 +0200
Message-ID: <CANiq72=Aom+D8LsvMDgD3Am9n3DH13CzZKuL3dfanyqFEGyNbA@mail.gmail.com>
References: <20180920172301.21868-1-miguel.ojeda.sandonis@gmail.com> <20180924143608.aiyehiibgc7isk7k@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180924143608.aiyehiibgc7isk7k@ltop.local>
Sender: linux-kernel-owner@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, Andreas Dilger <adilger.kernel@dilger.ca>, Masahiro Yamada <yamada.masahiro@socionext.com>, Michal Marek <michal.lkml@markovi.net>, Steven Rostedt <rostedt@goodmis.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Olof Johansson <olof@lxom.net>, Konstantin Ryabitsev <konstantin@linuxfoundation.org>, David Miller <davem@davemloft.net>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Kees Cook <keescook@chromium.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Paul Lawrence <paullawrence@google.com>, Sandipan Das <sandipan@linux.vnet.ibm.com>, Andrey Konovalov <andreyknvl@google.com>, David Woodhouse <dwmw2@infradead.org>, Will
List-Id: linux-sparse@vger.kernel.org

On Mon, Sep 24, 2018 at 4:36 PM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> On Thu, Sep 20, 2018 at 07:22:46PM +0200, Miguel Ojeda wrote:
> > The Compiler Attributes series is an effort to disentangle
> > the include/linux/compiler*.h headers and bring them up to date.
> >
> > The main idea behind the series is to use feature checking macros
> > (i.e. __has_attribute) instead of compiler version checks (e.g. GCC_VERSION),
> > which are compiler-agnostic (so they can be shared, reducing the size
> > of compiler-specific headers) and version-agnostic.
> >
> > Other related improvements have been performed in the headers as well,
> > which on top of the use of __has_attribute it has amounted to a significant
> > simplification of these headers (e.g. GCC_VERSION is now only guarding 4
> > non-attribute macros).
> >
> > This series should also help the efforts to support compiling the kernel
> > with clang and icc. A fair amount of documentation and comments have also
> > been added, clarified or removed; and the headers are now more readable,
> > which should help kernel developers in general.
> >
> > The series was triggered due to the move to gcc >= 4.6. In turn, this series
> > has also triggered Sparse to gain the ability to recognize __has_attribute
> > on its own.
> >
> > Finally, the nonstring variable attribute series has been applied on top
> > of this one.
>
> Hi Miguel,
> Feel free to add my
>   Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> on patches 11-15 (I think the others ones already have it).
>

Done for both Nick and you!

Cheers,
Miguel
