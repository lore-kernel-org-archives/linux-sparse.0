From: Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH 1/2] Compiler Attributes: add support for __fallthrough
 (gcc >= 7.1)
Date: Mon, 22 Oct 2018 10:23:14 -0700
Message-ID: <CAKwvOdm7Ts1ZpYV2qw1YLSg8ntjPekY8Gu=Q1CbSq_7==ekUMw@mail.gmail.com>
References: <20181021171414.22674-1-miguel.ojeda.sandonis@gmail.com>
 <20181021171414.22674-2-miguel.ojeda.sandonis@gmail.com> <20181021222712.GI1617@thunk.org>
 <CANiq72mXV6WTyHXNZJDTfFOpPrXD0zD6cB30bGOuKO44AvRiog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CANiq72mXV6WTyHXNZJDTfFOpPrXD0zD6cB30bGOuKO44AvRiog@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Theodore Ts'o <tytso@mit.edu>, Greg KH <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, dan.carpenter@oracle.com, adilger.kernel@dilger.ca, Masahiro Yamada <yamada.masahiro@socionext.com>, Michal Marek <michal.lkml@markovi.net>, rostedt@goodmis.org, mchehab+samsung@kernel.org, olof@lxom.net, Konstantin Ryabitsev <konstantin@linuxfoundation.org>, "David S. Miller" <davem@davemloft.net>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Kees Cook <keescook@chromium.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Paul Lawrence <paullawrence@google.com>, sandipan@linux.vnet.ibm.com, Andrey Konovalov <andreyknvl@google.com>, David Woodhouse <dwmw2@infradead.org>, Will Deacon <will.deacon@arm.com>, Philippe
List-Id: linux-sparse@vger.kernel.org

On Mon, Oct 22, 2018 at 2:26 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Mon, Oct 22, 2018 at 12:27 AM Theodore Y. Ts'o <tytso@mit.edu> wrote:
> >
> > On Sun, Oct 21, 2018 at 07:14:13PM +0200, Miguel Ojeda wrote:
> > > From the GCC manual:
> > >
> > >   fallthrough
> > >
> > >     The fallthrough attribute with a null statement serves as a
> > >     fallthrough statement. It hints to the compiler that a statement
> > >     that falls through to another case label, or user-defined label
> > >     in a switch statement is intentional and thus the -Wimplicit-fallthrough
> > >     warning must not trigger. The fallthrough attribute may appear
> > >     at most once in each attribute list, and may not be mixed with
> > >     other attributes. It can only be used in a switch statement
> > >     (the compiler will issue an error otherwise), after a preceding
> > >     statement and before a logically succeeding case label,
> > >     or user-defined label.
> > >
> > >   https://gcc.gnu.org/onlinedocs/gcc/Statement-Attributes.html
> >
> > Do we know if coverity understands the fallthrough attribute?  One of
> > the reasons why I started using /* fallthrough */ is because it kept
> > Coverity happy.
>
> If Coverity is like gcc, they should be doing both (i.e. I see the
> comment parsing as an "extra" that gcc did, but the "basic stuff" is
> the attribute -- and I would guess it is way easier for them to
> support than the comment parsing).
>
> But I cannot test it myself :-( Someone, please?

+ Colin, who has been running Coverity on the kernel, and sending patches.

>
> However, if I understood Greg correctly in his reply to the cover
> letter, he replied that Coverity knows about it (?).
>
> >
> > If the conversion from /* fallthrough */ to the __fallthrough__
> > attribute means that we start gethting a lot of Coverity warnings,
> > that would be unfortunate.  OTOH, if this is getting standardized,
> > maybe we can get Coverity to understand this attribute?
>
> Indeed! That would be the best for everyone, including Coverity customers.
>
> Cheers,
> Miguel



-- 
Thanks,
~Nick Desaulniers
