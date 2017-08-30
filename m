From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Subject: Re: sparse test failures on ppc32le (and other not so common archs)
Date: Wed, 30 Aug 2017 19:36:52 +0200
Message-ID: <20170830173652.2s26nti2s2mgupnd@taurus.defre.kleine-koenig.org>
References: <20170830161435.krq44m5zub4mq43x@taurus.defre.kleine-koenig.org>
 <c1cfea1b-c9e6-0df2-855e-cf66e25c9ccc@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="if7duy66bfxhs7w2"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from arcturus.kleine-koenig.org ([78.47.169.190]:36707 "EHLO
        arcturus.kleine-koenig.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752143AbdH3Rgz (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 30 Aug 2017 13:36:55 -0400
Content-Disposition: inline
In-Reply-To: <c1cfea1b-c9e6-0df2-855e-cf66e25c9ccc@ramsayjones.plus.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: linux-sparse@vger.kernel.org, 873508@bugs.debian.org, Antoine Beaupre <anarcat@debian.org>


--if7duy66bfxhs7w2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Aug 30, 2017 at 05:55:00PM +0100, Ramsay Jones wrote:
> On 30/08/17 17:14, Uwe Kleine-K=F6nig wrote:
> > 	ukleinek@plummer:~/sparse$ make check V=3D1
>=20
> It would be easier to see the results if you _didn't_ add V=3D1. ;-)

noted for the next time.

> [snip]
> > 	Out of 287 tests, 272 passed, 15 failed (10 of them are known to fail)
> > 	Makefile:232: recipe for target 'check' failed
> > 	make: *** [check] Error 1
> > 	ukleinek@plummer:~/sparse$=20
>=20
> The additional five failures are all in the llvm backend (sparsec),
> which you do not need to use sparse as a 'checker'.
>=20
> > The problem is that some cpp symbols are not defined in sparse that are
> > expected to exist. So I can "fix" backend/sum.c with the following
> > patch:
> >=20
> > diff --git a/validation/backend/sum.c b/validation/backend/sum.c
> > index 0604299..d0be8dd 100644
> > --- a/validation/backend/sum.c
> > +++ b/validation/backend/sum.c
> > @@ -1,3 +1,5 @@
> > +#define __powerpc64__
> > +#define _CALL_ELF 2
> >  #include <stdio.h>
> >  #include <stdlib.h>
> > =20
> >=20
>=20
> Yep, sparse/sparsec do not define various macros that gcc/clang define
> by default on a given architecture. This is a known problem (that I have
> been meaning to fix ...). The 'workaround' for the time being is to use
> the cgcc front-end to sparse. (for example 'make CC=3Dcgcc', or perhaps
> 'cgcc -no-compile').
>=20
> [You didn't mention your usage - is this for a kernel build?]

This problem became visible during the make check phase when creating packa=
ged
on the listed archs for horst[1]. You can see a build logs at

	https://buildd.debian.org/status/fetch.php?pkg=3Dhorst&arch=3Ds390x&ver=3D=
5.0-1&stamp=3D1503905687&raw=3D0
	https://buildd.debian.org/status/fetch.php?pkg=3Dhorst&arch=3Dppc64el&ver=
=3D5.0-1&stamp=3D1503906226&raw=3D0

The error message looks identical (I checked the ppc64el log) to the
problem with backend/sum.c:

	sparse -g -O2 -fdebug-prefix-map=3D/<<PKGBUILDDIR>>=3D. -fstack-protector-=
strong -Wformat -Werror=3Dformat-security -std=3Dgnu99 -Wall -Wextra -g -I.=
 -DDO_DEBUG -I/usr/include/libnl3 *.[ch]
	/usr/include/powerpc64le-linux-gnu/gnu/stubs.h:8:12: error: unable to open=
 'gnu/stubs-32.h'
	Makefile:113: recipe for target 'check' failed
	make[1]: *** [check] Error 1

Best regards
Uwe

[1] https://packages.debian.org/sid/horst

--if7duy66bfxhs7w2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAlmm97AACgkQwfwUeK3K
7AmqRwf8DQUa81FkhB5e+EJ2bqvWhO96MuHelcj/3RGSvXDAcaRukAOLBVv8FnLI
sSqz5UlJ0v7eiOeq6Z90whUs8mXgBDLD+z3Jo49m27lM4ypgX4A2eUSgAVphsb5g
MQR4hKC2hAF1UeUQMHT1KIoZFhhtha3W0fXcRoRKV5TN00a82/i9opeAlaENVeDU
mrw+MfuKfqFgOA1EiUzk8imYvWhEDBG9OKn01oD7ZoXn+/uED8l3L91PEedUPCMp
wbLx7IfIPIKnDZENXawKu1qwQSmx5Vaw+hfGgkjbmLhX+09TuCdkfxPLrZCxX42t
kEM/RaD3xhaG8wLhkByMj6mekGV2EA==
=+IL8
-----END PGP SIGNATURE-----

--if7duy66bfxhs7w2--
