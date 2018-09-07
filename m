From: Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: Conflict between sparse and commit cafa0010cd51f ("Raise the
 minimum required gcc version to 4.6")
Date: Fri, 7 Sep 2018 10:22:56 -0700
Message-ID: <CAKwvOdmuXydQsQyD2CUyoSkkDpF1e1CXg6v1SRv2q-bpYa9SQg@mail.gmail.com>
References: <81a5fd11-366c-0897-4143-d8d041420a41@c-s.fr> <1324e7d6-83f8-f40f-ad34-c46e4ad3139b@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1324e7d6-83f8-f40f-ad34-c46e4ad3139b@c-s.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: christophe.leroy@c-s.fr
Cc: joe@perches.com, Kees Cook <keescook@chromium.org>, LKML <linux-kernel@vger.kernel.org>, linux-sparse@vger.kernel.org, sparse@chrisli.org
List-Id: linux-sparse@vger.kernel.org

On Fri, Sep 7, 2018 at 7:34 AM Christophe LEROY <christophe.leroy@c-s.fr> w=
rote:
>
> Cc linux-sparse@vger.kernel.org
>
> Le 07/09/2018 =C3=A0 14:22, Christophe Leroy a =C3=A9crit :
> > Since commit cafa0010cd51f ("Raise the minimum required gcc version to
> > 4.6"), sparse check fails as follows:
> >
> > [root@pc16082vm linux-powerpc]# make C=3D2 arch/powerpc/kernel/process.=
o
> >    CALL    scripts/checksyscalls.sh
> >    CHECK   scripts/mod/empty.c
> > ./include/linux/compiler-gcc.h:14:3: error: Sorry, your compiler is too
> > old - please upgrade it.
> >    CHECK   arch/powerpc/kernel/process.c
> > ./include/linux/compiler-gcc.h:14:3: error: Sorry, your compiler is too
> > old - please upgrade it.
> >
> >
> > I have sparse version 0.5.2
> >
> > What can be done to fix that ?
> >
> > Christophe

Oof, sorry Christophe.  Looks like that's the latest version of sparse:
https://sparse.wiki.kernel.org/index.php/Main_Page#News

I'm curious what sparse expands __GNUC__, __GNUC_MINOR__, and
__GNUC_PATCHLEVEL__ to?  Pre commit cafa0010cd51f, it MUST be
expanding them to something, otherwise you'd have seen the error then,
too.  The previous check was GCC < 3.3, now it's GCC < 4.6.

We could change the check to:

-#if GCC_VERSION < 40600
+#if GCC_VERSION < 40600 && !defined(__CHECKER__)

But it would be good to know what those sub macros that compose
GCC_VERSION evaluate to in sparse; maybe they can be upgraded in
Sparse unless they're matching __builtin_*() compatability?
--=20
Thanks,
~Nick Desaulniers
