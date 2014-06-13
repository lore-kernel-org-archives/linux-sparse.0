From: Jeff Layton <jlayton@poochiereds.net>
Subject: Re: [PATCH][RFC] err.h: silence sparse warning: dereference of
 noderef expression
Date: Fri, 13 Jun 2014 08:05:37 -0400
Message-ID: <20140613080537.75635d81@f20.localdomain>
References: <1402436329-24750-1-git-send-email-jlayton@poochiereds.net>
	<20140611052040.GM5500@mwanda>
	<20140611070632.639e07ce@f20.localdomain>
	<20140611131146.GS5500@mwanda>
	<20140611095102.5bba1200@f20.localdomain>
	<CAH42NiXUE70oVnZJNhkvgKT5FSfnMVOBEWau84E9YAbufBDHMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yk0-f174.google.com ([209.85.160.174]:43163 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750788AbaFMMFm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 13 Jun 2014 08:05:42 -0400
Received: by mail-yk0-f174.google.com with SMTP id 19so1946955ykq.5
        for <linux-sparse@vger.kernel.org>; Fri, 13 Jun 2014 05:05:42 -0700 (PDT)
In-Reply-To: <CAH42NiXUE70oVnZJNhkvgKT5FSfnMVOBEWau84E9YAbufBDHMw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Vitaly Osipov <vitaly.osipov@gmail.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, linux-sparse@vger.kernel.org, Jeff Layton <jlayton@primarydata.com>

On Thu, 12 Jun 2014 18:06:25 +1000
Vitaly Osipov <vitaly.osipov@gmail.com> wrote:

> Nothing shows up for me on x86_64, allmodconfig, linux-next from 10 o=
f
> June. My sparse has been compiled from sources.
>=20
> $ make fs/locks.o C=3D2 CHECK=3D"/home/vosipov/bin/sparse"
>   CHK     include/config/kernel.release
>   CHK     include/generated/uapi/linux/version.h
>   CHK     include/generated/utsrelease.h
>   CALL    scripts/checksyscalls.sh
>   CHECK   scripts/mod/empty.c
>   CHECK   fs/locks.c
>=20
> $ sparse =E2=80=94version
> v0.5.0
>=20
> $ which sparse
> /home/vosipov/bin/sparse
>=20
> Regards,
> Vitaly
>=20
>=20
> On Wed, Jun 11, 2014 at 11:51 PM, Jeff Layton <jlayton@poochiereds.ne=
t> wrote:
> > On Wed, 11 Jun 2014 16:11:46 +0300
> > Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> >> On Wed, Jun 11, 2014 at 07:06:32AM -0400, Jeff Layton wrote:
> >> > $ rpm -q sparse
> >> > sparse-0.5.0-1.fc20.x86_64
> >> >
> >> > I see it all over the tree, but an easy example is fs/locks.c:
> >> >
> >> > $ make fs/locks.o C=3D1
> >> > make[1]: Nothing to be done for `all'.
> >> > make[1]: Nothing to be done for `relocs'.
> >> >   CHK     include/config/kernel.release
> >> >   CHK     include/generated/uapi/linux/version.h
> >> >   CHK     include/generated/utsrelease.h
> >> >   CALL    scripts/checksyscalls.sh
> >> >   CHECK   fs/locks.c
> >> > include/linux/err.h:35:16: warning: dereference of noderef expre=
ssion
> >> > include/linux/err.h:30:23: warning: dereference of noderef expre=
ssion
> >> > include/linux/err.h:35:16: warning: dereference of noderef expre=
ssion
> >> > include/linux/err.h:30:23: warning: dereference of noderef expre=
ssion
> >> >   CC      fs/locks.o
> >> >
> >> > It has two IS_ERR calls and two PTR_ERR calls, and each generate=
s the
> >> > warning.
> >> >
> >>
> >> I downloaded the Fedora SRPM and built the binary but I still wasn=
't
> >> able to reproduce the bug.
> >>
> >> dcarpenter@speke:~/progs/kernel/devel$ /tmp/sparse/sparse-0.5.0/sp=
arse --version
> >> 0.5.0
> >> dcarpenter@speke:~/progs/kernel/devel$ make C=3D2 CHECK=3D/tmp/spa=
rse/sparse-0.5.0/sparse fs/locks.o
> >>   CHK     include/config/kernel.release
> >>   CHK     include/generated/uapi/linux/version.h
> >>   CHK     include/generated/utsrelease.h
> >>   CALL    scripts/checksyscalls.sh
> >> <stdin>:1226:2: warning: #warning syscall finit_module not impleme=
nted [-Wcpp]
> >> <stdin>:1229:2: warning: #warning syscall sched_setattr not implem=
ented [-Wcpp]
> >> <stdin>:1232:2: warning: #warning syscall sched_getattr not implem=
ented [-Wcpp]
> >> <stdin>:1235:2: warning: #warning syscall renameat2 not implemente=
d [-Wcpp]
> >>   CHECK   scripts/mod/empty.c
> >>   CHECK   fs/locks.c
> >> dcarpenter@speke:~/progs/kernel/devel$
> >>
> >> I'm on today's linux-next.  I can't think of a kernel configuratio=
n
> >> issue which would cause this...
> >>
> >> regards,
> >> dan carpenter
> >
> > Could it be arch-specific then? What arch are you using? I'm on x86=
_64.
> > I know that quite a few other people have mentioned seeing these
> > warnings as well, so I'm pretty sure it's not just me.
> >

Ha! It turns out that my hand-built sparse also works fine, so the
problem seems to be in the Fedora package.

With a little trial-and-error, I figured out what's causing the
problem, but I'm a little baffled as to why it's occurring.=20

The Fedora SRPM builds the program with -fpic. When I remove that flag,
this problem goes away. I'd appreciate any insight into why that would
break things. I doubt PIC really makes much difference security-wise in
sparse, so removing it shouldn't matter much, but I wonder if this
indicates an underlying bug in sparse itself?

I'll do a bit more investigation, but I should be able to get a fixed
package pushed into Fedora soon. Thanks for the help, and obviously the
RFC patch I originally "proposed" can be dropped.

--=20
Jeff Layton <jlayton@poochiereds.net>
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
