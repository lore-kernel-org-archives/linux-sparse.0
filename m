From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Subject: Re: sparse test failures on ppc32le (and other not so common archs)
Date: Thu, 31 Aug 2017 22:55:14 +0200
Message-ID: <20170831205514.vxmirle2yoc3rm44@taurus.defre.kleine-koenig.org>
References: <20170830161435.krq44m5zub4mq43x@taurus.defre.kleine-koenig.org>
 <c1cfea1b-c9e6-0df2-855e-cf66e25c9ccc@ramsayjones.plus.com>
 <20170830173652.2s26nti2s2mgupnd@taurus.defre.kleine-koenig.org>
 <CANeU7QmV0z58dGW2NTE+qH33OqW+WWCHZARF=h=XiiwhnS5jPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6iisxornfqwwwl4k"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from arcturus.kleine-koenig.org ([78.47.169.190]:37377 "EHLO
        arcturus.kleine-koenig.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750908AbdHaUzR (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 31 Aug 2017 16:55:17 -0400
Content-Disposition: inline
In-Reply-To: <CANeU7QmV0z58dGW2NTE+qH33OqW+WWCHZARF=h=XiiwhnS5jPg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, Linux-Sparse <linux-sparse@vger.kernel.org>, 873508@bugs.debian.org, Antoine Beaupre <anarcat@debian.org>


--6iisxornfqwwwl4k
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Christopher,

On Wed, Aug 30, 2017 at 08:11:49PM -0400, Christopher Li wrote:
> On Wed, Aug 30, 2017 at 1:36 PM, Uwe Kleine-K=F6nig <uwe@kleine-koenig.or=
g> wrote:
> >> >
> >> > diff --git a/validation/backend/sum.c b/validation/backend/sum.c
> >> > index 0604299..d0be8dd 100644
> >> > --- a/validation/backend/sum.c
> >> > +++ b/validation/backend/sum.c
> >> > @@ -1,3 +1,5 @@
> >> > +#define __powerpc64__
> >> > +#define _CALL_ELF 2
> >> >  #include <stdio.h>
> >> >  #include <stdlib.h>
> >> >
> >> >
> >>
> >> Yep, sparse/sparsec do not define various macros that gcc/clang define
> >> by default on a given architecture. This is a known problem (that I ha=
ve
> >> been meaning to fix ...). The 'workaround' for the time being is to use
> >> the cgcc front-end to sparse. (for example 'make CC=3Dcgcc', or perhaps
> >> 'cgcc -no-compile').
> >>
> >> [You didn't mention your usage - is this for a kernel build?]
> >
> > This problem became visible during the make check phase when creating p=
ackaged
> > on the listed archs for horst[1]. You can see a build logs at
> >
> >         https://buildd.debian.org/status/fetch.php?pkg=3Dhorst&arch=3Ds=
390x&ver=3D5.0-1&stamp=3D1503905687&raw=3D0
> >         https://buildd.debian.org/status/fetch.php?pkg=3Dhorst&arch=3Dp=
pc64el&ver=3D5.0-1&stamp=3D1503906226&raw=3D0
> >
> > The error message looks identical (I checked the ppc64el log) to the
> > problem with backend/sum.c:
> >
> >         sparse -g -O2 -fdebug-prefix-map=3D/<<PKGBUILDDIR>>=3D. -fstack=
-protector-strong -Wformat -Werror=3Dformat-security -std=3Dgnu99 -Wall -We=
xtra -g -I. -DDO_DEBUG -I/usr/include/libnl3 *.[ch]
> >         /usr/include/powerpc64le-linux-gnu/gnu/stubs.h:8:12: error: una=
ble to open 'gnu/stubs-32.h'
>=20
> That is very much like on x86_64 missing define "#weak_define __x86_64__ =
1"
>=20
> Does cgcc work for you? In the future we do want to move the archetecture
> related define from cgcc into sparse by itself. For now you can set
> "sparse" as "cgcc -no-compile"

Yes that works. So to address the Debian bug I can do:

 - move sparse to /usr/lib
 - teach cgcc about the move of sparse
 - make /usr/bin/sparse call cgcc -no-compile "$@"

or is it easier to teach sparse about the architecture stuff?

Best regards
Uwe

--6iisxornfqwwwl4k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAlmod68ACgkQwfwUeK3K
7AkZawf9GORaEVTBTx0Vy9jcufkyZUTNGS2YWWC/jZGax9MuOJ8O/rAK+3CQCEhB
iLHBgmB9D5BcaXF82QoDGK61AIDAxo7wjBS0vqwJSZZu0O2q1HXygBqN5mTVRlB8
cECz14QF57EmX7DROkZTvCVyX32jwmQUh/pHRdez16uyQto+KzoMadevDcs7khIE
B1nl0BkVkHMLO2vasjJovvFc5kwiBNMaauYV8QLBHymgtNDxTSiz4xbVjWJDFu6v
+wMzIm9ubVIRsTTqWYtk4v/wOElHG/0+vbuCuxxJ27DmGzD0atJ3kOO/JT5xAf7h
aB8gTNsyua/sVhC7VZBubFhZBJrQsA==
=qzuQ
-----END PGP SIGNATURE-----

--6iisxornfqwwwl4k--
