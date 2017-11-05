From: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
Subject: Re: [PATCH 29/36] build: use git-clean
Date: Sun, 5 Nov 2017 21:50:17 +0100
Message-ID: <00d1e1c1-c35b-85e6-0a91-c3302e14dd14@kleine-koenig.org>
References: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
 <20171105162544.72960-29-luc.vanoostenryck@gmail.com>
 <20171105174100.r3y4o4m2i47d25o5@s>
 <20171105201629.qwitgngzeb7jzr6n@ltop.local>
 <20171105203845.inkp5mcrm634lmov@s>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="mR8tdSdX1Kx8H1G0thQ7FLBwwRRHtA8U1"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from antares.kleine-koenig.org ([94.130.110.236]:60616 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750724AbdKEUuW (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Nov 2017 15:50:22 -0500
In-Reply-To: <20171105203845.inkp5mcrm634lmov@s>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mR8tdSdX1Kx8H1G0thQ7FLBwwRRHtA8U1
Content-Type: multipart/mixed; boundary="FcLSM4JSA47NxQjldmJE6oQLaaiqNla1k";
 protected-headers="v1"
From: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
To: Josh Triplett <josh@joshtriplett.org>,
 Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-sparse@vger.kernel.org
Message-ID: <00d1e1c1-c35b-85e6-0a91-c3302e14dd14@kleine-koenig.org>
Subject: Re: [PATCH 29/36] build: use git-clean
References: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
 <20171105162544.72960-29-luc.vanoostenryck@gmail.com>
 <20171105174100.r3y4o4m2i47d25o5@s>
 <20171105201629.qwitgngzeb7jzr6n@ltop.local>
 <20171105203845.inkp5mcrm634lmov@s>
In-Reply-To: <20171105203845.inkp5mcrm634lmov@s>

--FcLSM4JSA47NxQjldmJE6oQLaaiqNla1k
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/05/2017 09:38 PM, Josh Triplett wrote:
> On Sun, Nov 05, 2017 at 09:16:31PM +0100, Luc Van Oostenryck wrote:
>> The real question would be: "is there anybody, doing some kind of
>> development on sparse and who won't use git?"
>=20
> Sure: anyone doing packaging. If someone wants to package Sparse for a
> distribution, they'll likely do so in a way that does not include .git
> in the source package. And if that package wants to "make clean" for an=
y
> reason, or if someone grabs the source from that distribution for
> development and happens to run "make clean", that would be *bad*.

Ack with my sparse Debian package maintainer hat on. If you check the
Debian build logs (e.g.
https://buildd.debian.org/status/fetch.php?pkg=3Dsparse&arch=3Darm64&ver=3D=
0.5.1-2&stamp=3D1506419417&raw=3D0)
you can see that the first relevant step after extracting the source tar
and applying patches is to run make clean.

Best regards
Uwe


--FcLSM4JSA47NxQjldmJE6oQLaaiqNla1k--

--mR8tdSdX1Kx8H1G0thQ7FLBwwRRHtA8U1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAln/eYkACgkQwfwUeK3K
7AlHTgf+LSoyTdXE+94N8a+dE8GwoEEScvU7v7TRHXS3H9VJIyQlP0BOldMKeJ31
GvU/e9CdcSvCdU5AljRyqYT5o+Haok6qAUEMJ3k/WTIF3pZ7XVyTIv3GzY2K2ieX
IaMz7A+g+Z8dzA49aEEAZufxvI2+gr7AAav7zPmWsCgfNCHgJgo7XAOV2yeR7WdU
wPciEMZmJzY8C01t7nQ+v+2Pwzc5bsG/jI47ZIdtWO9M8Qx3DOHljbKJv8jXyrLI
Ez4M1IfXznrCYl5vx/Rai35RI+8dWucVihxIkqGz7r19yMQ0FBFHHMJlvMZi3gix
BHs7rQPF398oefwq7sdPiQ2xn8sgBQ==
=xVrJ
-----END PGP SIGNATURE-----

--mR8tdSdX1Kx8H1G0thQ7FLBwwRRHtA8U1--
