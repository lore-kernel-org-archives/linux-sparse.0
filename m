From: Uwe =?UTF-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Subject: Bug#873508: sparse test failures on ppc32le (and other not so common archs)
Date: Fri, 27 Apr 2018 07:56:38 +0200
Message-ID: <779a85fe-0691-0f8b-c70a-85df449003bc@kleine-koenig.org>
References: <20170830161435.krq44m5zub4mq43x@taurus.defre.kleine-koenig.org> <150392922734.24087.13050909898214597041.reportbug@curie.anarc.at>
Reply-To: Uwe =?UTF-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, 873508@bugs.debian.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="WLXmqMhZeba6Qul5ZUkRV91CafJW6Xy3r"
Return-path: <bounce-debian-bugs-dist=glddb-debian-bugs-dist2=m.gmane.org@lists.debian.org>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.873508.B873508.15248090707116@bugs.debian.org>
In-Reply-To: <20170830161435.krq44m5zub4mq43x@taurus.defre.kleine-koenig.org>
List-URL: <https://lists.debian.org/debian-bugs-dist/>
List-Post: <mailto:debian-bugs-dist@lists.debian.org>
List-Help: <mailto:debian-bugs-dist-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=unsubscribe>
To: linux-sparse@vger.kernel.org
Cc: 873508@bugs.debian.org, Antoine Beaupre <anarcat@debian.org>
List-Id: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WLXmqMhZeba6Qul5ZUkRV91CafJW6Xy3r
Content-Type: multipart/mixed; boundary="tsP6BUa2VIKFdNzk4p3BcdmG7zdZL89V8";
 protected-headers="v1"
From: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
To: linux-sparse@vger.kernel.org
Cc: 873508@bugs.debian.org, Antoine Beaupre <anarcat@debian.org>
Message-ID: <779a85fe-0691-0f8b-c70a-85df449003bc@kleine-koenig.org>
Subject: Re: sparse test failures on ppc32le (and other not so common archs)
References: <20170830161435.krq44m5zub4mq43x@taurus.defre.kleine-koenig.org>
In-Reply-To: <20170830161435.krq44m5zub4mq43x@taurus.defre.kleine-koenig.org>

--tsP6BUa2VIKFdNzk4p3BcdmG7zdZL89V8
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hello,

On 08/30/2017 06:14 PM, Uwe Kleine-K=F6nig wrote:
> Antoine Beaupre (on Cc:) noticed that sparse doesn't work on some not s=
o
> common architectures like ppc32le, s390x, ppc64 and sparc64[1]. This is=

> nicely catched by the testsuite, e.g.:
>
> [..]

Just a heads up: I uploaded 0.5.2 to Debian and there are problems left
on hurd-i386 (where PATH_MAX isn't defined[1]) and x32 where I get:

	env CHECK=3D./sparse ./cgcc -no-compile memops.c
	/usr/include/x86_64-linux-gnux32/gnu/stubs.h:10:12: error: unable to
open 'gnu/stubs-64.h'

The stubs.h file looks as follows:

#if !defined __x86_64__
# include <gnu/stubs-32.h>
#endif
#if defined __x86_64__ && defined __LP64__
# include <gnu/stubs-64.h>
#endif
#if defined __x86_64__ && defined __ILP32__
# include <gnu/stubs-x32.h>
#endif

Given that libc6-dev only provides stubs-x32.h from these three, I guess
we must not define __LP64__ in this case. I don't have a x32 machine
handy, but the complete build log of the auto builder can be found at

	https://buildd.debian.org/status/fetch.php?pkg=3Dsparse&arch=3Dx32&ver=3D=
0.5.2-1&stamp=3D1524169455&raw=3D0

Best regards
Uwe

[1]
https://buildd.debian.org/status/fetch.php?pkg=3Dsparse&arch=3Dhurd-i386&=
ver=3D0.5.2-1&stamp=3D1524168405&raw=3D0


--tsP6BUa2VIKFdNzk4p3BcdmG7zdZL89V8--

--WLXmqMhZeba6Qul5ZUkRV91CafJW6Xy3r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAlriu5oACgkQwfwUeK3K
7AmZbQgAj3Lz4vAS4R0U3MOcnssT2J7L5ILB8oNGusTKFCZ9FnsB5T1nSRaEYRcp
3VlnvBCwaZHYvTQrJzrgzSldz+8hCH2pq2jFMPzRn4UpISDeDRnCGwa4mT3kkedB
ad6T/uqO/fLaSmaulzreorNXBBZjj4TQjWvmrE5ouYOL8TxGUDy3vqTbL8AmofhW
bollSehIo02bWhRahgO6dw9rsQvjUM/NHsVI5rHT6NxDVk0aaqufqJJv6rZR1bI6
KZbz6Oh7kWTzCGsiN5ewzUk5dCfuiNSQzSlfUkgQYrksb8fNGtqzXD5Wd/tYfCG6
irh3NsQHWKnZTy051DKAI1QUfiCGFg==
=izKD
-----END PGP SIGNATURE-----

--WLXmqMhZeba6Qul5ZUkRV91CafJW6Xy3r--
