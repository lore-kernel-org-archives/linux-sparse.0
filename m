From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH][RFC] err.h: silence sparse warning: dereference of
 noderef expression
Date: Fri, 13 Jun 2014 08:56:50 -0700
Message-ID: <20140613155650.GA13426@thin>
References: <1402436329-24750-1-git-send-email-jlayton@poochiereds.net>
 <20140611052040.GM5500@mwanda>
 <20140611070632.639e07ce@f20.localdomain>
 <20140611131146.GS5500@mwanda>
 <20140611095102.5bba1200@f20.localdomain>
 <CAH42NiXUE70oVnZJNhkvgKT5FSfnMVOBEWau84E9YAbufBDHMw@mail.gmail.com>
 <20140613080537.75635d81@f20.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:39510 "EHLO
	relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751633AbaFMP5A convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 13 Jun 2014 11:57:00 -0400
Content-Disposition: inline
In-Reply-To: <20140613080537.75635d81@f20.localdomain>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jeff Layton <jlayton@poochiereds.net>
Cc: Vitaly Osipov <vitaly.osipov@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>, linux-sparse@vger.kernel.org, Jeff Layton <jlayton@primarydata.com>

On Fri, Jun 13, 2014 at 08:05:37AM -0400, Jeff Layton wrote:
> On Thu, 12 Jun 2014 18:06:25 +1000
> Vitaly Osipov <vitaly.osipov@gmail.com> wrote:
>=20
> > Nothing shows up for me on x86_64, allmodconfig, linux-next from 10=
 of
> > June. My sparse has been compiled from sources.
> >=20
> > $ make fs/locks.o C=3D2 CHECK=3D"/home/vosipov/bin/sparse"
> >   CHK     include/config/kernel.release
> >   CHK     include/generated/uapi/linux/version.h
> >   CHK     include/generated/utsrelease.h
> >   CALL    scripts/checksyscalls.sh
> >   CHECK   scripts/mod/empty.c
> >   CHECK   fs/locks.c
> >=20
> > $ sparse =E2=80=94version
> > v0.5.0
> >=20
> > $ which sparse
> > /home/vosipov/bin/sparse
> >=20
> > Regards,
> > Vitaly
> >=20
> >=20
> > On Wed, Jun 11, 2014 at 11:51 PM, Jeff Layton <jlayton@poochiereds.=
net> wrote:
> > > On Wed, 11 Jun 2014 16:11:46 +0300
> > > Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > >
> > >> On Wed, Jun 11, 2014 at 07:06:32AM -0400, Jeff Layton wrote:
> > >> > $ rpm -q sparse
> > >> > sparse-0.5.0-1.fc20.x86_64
> > >> >
> > >> > I see it all over the tree, but an easy example is fs/locks.c:
> > >> >
> > >> > $ make fs/locks.o C=3D1
> > >> > make[1]: Nothing to be done for `all'.
> > >> > make[1]: Nothing to be done for `relocs'.
> > >> >   CHK     include/config/kernel.release
> > >> >   CHK     include/generated/uapi/linux/version.h
> > >> >   CHK     include/generated/utsrelease.h
> > >> >   CALL    scripts/checksyscalls.sh
> > >> >   CHECK   fs/locks.c
> > >> > include/linux/err.h:35:16: warning: dereference of noderef exp=
ression
> > >> > include/linux/err.h:30:23: warning: dereference of noderef exp=
ression
> > >> > include/linux/err.h:35:16: warning: dereference of noderef exp=
ression
> > >> > include/linux/err.h:30:23: warning: dereference of noderef exp=
ression
> > >> >   CC      fs/locks.o
> > >> >
> > >> > It has two IS_ERR calls and two PTR_ERR calls, and each genera=
tes the
> > >> > warning.
> > >> >
> > >>
> > >> I downloaded the Fedora SRPM and built the binary but I still wa=
sn't
> > >> able to reproduce the bug.
> > >>
> > >> dcarpenter@speke:~/progs/kernel/devel$ /tmp/sparse/sparse-0.5.0/=
sparse --version
> > >> 0.5.0
> > >> dcarpenter@speke:~/progs/kernel/devel$ make C=3D2 CHECK=3D/tmp/s=
parse/sparse-0.5.0/sparse fs/locks.o
> > >>   CHK     include/config/kernel.release
> > >>   CHK     include/generated/uapi/linux/version.h
> > >>   CHK     include/generated/utsrelease.h
> > >>   CALL    scripts/checksyscalls.sh
> > >> <stdin>:1226:2: warning: #warning syscall finit_module not imple=
mented [-Wcpp]
> > >> <stdin>:1229:2: warning: #warning syscall sched_setattr not impl=
emented [-Wcpp]
> > >> <stdin>:1232:2: warning: #warning syscall sched_getattr not impl=
emented [-Wcpp]
> > >> <stdin>:1235:2: warning: #warning syscall renameat2 not implemen=
ted [-Wcpp]
> > >>   CHECK   scripts/mod/empty.c
> > >>   CHECK   fs/locks.c
> > >> dcarpenter@speke:~/progs/kernel/devel$
> > >>
> > >> I'm on today's linux-next.  I can't think of a kernel configurat=
ion
> > >> issue which would cause this...
> > >>
> > >> regards,
> > >> dan carpenter
> > >
> > > Could it be arch-specific then? What arch are you using? I'm on x=
86_64.
> > > I know that quite a few other people have mentioned seeing these
> > > warnings as well, so I'm pretty sure it's not just me.
> > >
>=20
> Ha! It turns out that my hand-built sparse also works fine, so the
> problem seems to be in the Fedora package.
>=20
> With a little trial-and-error, I figured out what's causing the
> problem, but I'm a little baffled as to why it's occurring.=20
>=20
> The Fedora SRPM builds the program with -fpic. When I remove that fla=
g,
> this problem goes away. I'd appreciate any insight into why that woul=
d
> break things. I doubt PIC really makes much difference security-wise =
in
> sparse, so removing it shouldn't matter much, but I wonder if this
> indicates an underlying bug in sparse itself?

Wow, that's horrifying.  I wonder if it might indicate a miscompilation
by GCC.  Does the problem persist if you build with -fpic -g?  If so,
you could set a few breakpoints and try to determine at what point the
behavior of the two sparse binaries diverges.

- Josh Triplett
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
