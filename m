From: Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: Conflict between sparse and commit cafa0010cd51f ("Raise the
 minimum required gcc version to 4.6")
Date: Fri, 7 Sep 2018 11:19:43 -0700
Message-ID: <CAKwvOdmXs+pWJGXu-zr-XSu7p-7hw=2m1vVQmVLwJcmGEFz0gg@mail.gmail.com>
References: <81a5fd11-366c-0897-4143-d8d041420a41@c-s.fr> <1324e7d6-83f8-f40f-ad34-c46e4ad3139b@c-s.fr>
 <CAKwvOdmuXydQsQyD2CUyoSkkDpF1e1CXg6v1SRv2q-bpYa9SQg@mail.gmail.com> <20180907181337.peyfq7yvhahduvmq@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180907181337.peyfq7yvhahduvmq@ltop.local>
Sender: linux-kernel-owner@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: christophe.leroy@c-s.fr, joe@perches.com, Kees Cook <keescook@chromium.org>, LKML <linux-kernel@vger.kernel.org>, linux-sparse@vger.kernel.org, sparse@chrisli.org
List-Id: linux-sparse@vger.kernel.org

On Fri, Sep 7, 2018 at 11:13 AM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> On Fri, Sep 07, 2018 at 10:22:56AM -0700, Nick Desaulniers wrote:
> > On Fri, Sep 7, 2018 at 7:34 AM Christophe LEROY <christophe.leroy@c-s.f=
r> wrote:
> > >
> > > Cc linux-sparse@vger.kernel.org
> > >
> > > Le 07/09/2018 =C3=A0 14:22, Christophe Leroy a =C3=A9crit :
> > > > Since commit cafa0010cd51f ("Raise the minimum required gcc version=
 to
> > > > 4.6"), sparse check fails as follows:
> > > >
> > > > [root@pc16082vm linux-powerpc]# make C=3D2 arch/powerpc/kernel/proc=
ess.o
> > > >    CALL    scripts/checksyscalls.sh
> > > >    CHECK   scripts/mod/empty.c
> > > > ./include/linux/compiler-gcc.h:14:3: error: Sorry, your compiler is=
 too
> > > > old - please upgrade it.
> > > >    CHECK   arch/powerpc/kernel/process.c
> > > > ./include/linux/compiler-gcc.h:14:3: error: Sorry, your compiler is=
 too
> > > > old - please upgrade it.
> > > >
> > > >
> > > > I have sparse version 0.5.2
> > > >
> > > > What can be done to fix that ?
> > > >
> > > > Christophe
> >
> > Oof, sorry Christophe.  Looks like that's the latest version of sparse:
> > https://sparse.wiki.kernel.org/index.php/Main_Page#News
> >
> > I'm curious what sparse expands __GNUC__, __GNUC_MINOR__, and
> > __GNUC_PATCHLEVEL__ to?  Pre commit cafa0010cd51f, it MUST be
> > expanding them to something, otherwise you'd have seen the error then,
> > too.  The previous check was GCC < 3.3, now it's GCC < 4.6.
>
> Sparse expand these macros to the same version than the compiler used
> to compile GCC. I find a bit strange though to have sparse v0.5.2 but
> using an old compiler.

So Christophe must have a version of gcc < 4.6 installed somewhere?
Does sparse use `cc`? If so, Christophe, does your `ls -l $(which cc)`
point to an old version of gcc maybe?

>
> Also, it's worth to look at what is said in this email:
>   https://lore.kernel.org/lkml/CA+55aFzYEnZR2GZLR-DwpONjMNYGYoDy+6AWLCVNa=
yWiaZuqoA@mail.gmail.com/
>
>
> -- Luc



--=20
Thanks,
~Nick Desaulniers
