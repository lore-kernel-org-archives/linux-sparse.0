From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH 1/2] Compiler Attributes: add support for __fallthrough
 (gcc >= 7.1)
Date: Mon, 22 Oct 2018 23:17:15 +0200
Message-ID: <CANiq72k2z78uae1GWjECo+OB7GC90b8irt0SHYtnSXT8F2Grrw@mail.gmail.com>
References: <20181021171414.22674-1-miguel.ojeda.sandonis@gmail.com>
 <20181021171414.22674-2-miguel.ojeda.sandonis@gmail.com> <CAKwvOdmPj_mm+9t1i=yLhvO0FAe6Kd7ezjOoTnp1fzcoikPHpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKwvOdmPj_mm+9t1i=yLhvO0FAe6Kd7ezjOoTnp1fzcoikPHpw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, Dan <dan.carpenter@oracle.com>, Andreas Dilger <adilger.kernel@dilger.ca>, Masahiro Yamada <yamada.masahiro@socionext.com>, Michal Marek <michal.lkml@markovi.net>, Steven Rostedt <rostedt@goodmis.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Olof Johansson <olof@lxom.net>, Konstantin Ryabitsev <konstantin@linuxfoundation.org>, David Miller <davem@davemloft.net>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Kees Cook <keescook@chromium.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Paul Lawrence <paullawrence@google.com>, Sandipan Das <sandipan@linux.vnet.ibm.com>, Andrey Konovalov <andreyknvl@google.com>
List-Id: linux-sparse@vger.kernel.org

On Mon, Oct 22, 2018 at 7:36 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Sun, Oct 21, 2018 at 10:14 AM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> >
> > of its kind) to deal with this: [[fallthrough]] is meant to be
> > a new control keyword in the form of an extension.
>
> I think we can leave the details about the [[]] notation out. IIUC,
> it's only applicable to C++.

No, because C++ is the driving force for the standard attributes
syntax; i.e. C2x is adding them because of the syntax published by
C++17; and possibly gcc 7.1 added support for fallthrough (and comment
parsing) due to C++17 too.

Basically, it is a small paragraph explaining how this came to be.

> > +#if __has_attribute(__fallthrough__)
> > +# define __fallthrough                  __attribute__((__fallthrough__))
> > +#else
> > +# define __fallthrough
>
> While this is in the correct format as the other attributes in this
> file, I think this particular attribute is a special case, because of
> the variety of fallbacks and differing support for them.  I'd like to

No, is it the correct format because we cannot add support for the
other syntax in gcc; so the best way to proceed is to simply wait
until clang supports the GNU attribute in C mode.

The tooling, of course, is another matter and independent of this.

> see in the commit message maybe a list of tools we'd like to support

Yes, I already said I would write it in one of the other threads.

> and links to the feature requests/bug reports for them.  I acknowledge
> it's more work to file bugs, but it's being a good open source
> citizen, IMO.

Who said we aren't going to do it? :-)

I was actually in the process of checking which OSS tools supported
what and how easy it was to fix in each of them (gcc's [[...]] syntax,
clang's GNU and C++ attrs in C mode, cppcheck's fallthrough
support...), but it takes time; I prefer to do the research
beforehand; so that the submitted bug reports are better/more
precise/more helpful, etc.

However, you already sent the LLVM report (without mentioning this
thread or me, nor the -fdouble-square-bracket-attributes clang flag
that I mentioned). That is a bit rude :-) Please take things a little
easier, there is no need to rush stuff. If I didn't have submitted the
LLVM bug report is because I hadn't finish looking at the issue. In
general, I think it is polite (and also more productive to avoid
duplicating efforts) to first ask whoever is working on something
before you rush to do it...

>
> I'm also curious which is the first version of GCC to support the
> comment format?

gcc 7.1 started everything. It is stated in the commit message and
several messages/threads already. Again, please pause, relax and read
a bit before sending stuff around :-)

Cheers,
Miguel
