From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: Using c2xml on kernel sources
Date: Tue, 20 Mar 2012 18:40:48 +0300
Message-ID: <20120320154048.GA7848@mwanda>
References: <CABG-yt06Kw2uFnmrshcHYjgf_cMgzKVdMPe6BXOP2nryhRjBpg@mail.gmail.com>
 <20120320103702.GN3163@mwanda>
 <CABG-yt2bs8wGUgTH9=dPgtD22vER8qd5JFZGXgPj9f+NS-OHmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:29378 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760599Ab2CTPim (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 20 Mar 2012 11:38:42 -0400
Content-Disposition: inline
In-Reply-To: <CABG-yt2bs8wGUgTH9=dPgtD22vER8qd5JFZGXgPj9f+NS-OHmQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Shakthi Kannan <shakthimaan@gmail.com>
Cc: linux-sparse@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 20, 2012 at 08:55:48PM +0530, Shakthi Kannan wrote:
> Hi Dan:
>=20
> --- On Tue, Mar 20, 2012 at 4:07 PM, Dan Carpenter
> <dan.carpenter@oracle.com> wrote:
> | make C=3D2 CHECK=3D"c2xml > foo.xml" net/ethernet/eth.o
> \--
>=20
> That worked!
>=20
> But, is it really required to generate eth.o? Is it possible to just
> parse through the sources, produce the .xml output without having to
> generate the object files?
>=20

No, I can't think of an easy way.

regards,
dan carpenter.


--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPaKT/AAoJEOnZkXI/YHqRwn4QAJU71LmmHrHRHHCbM1gxZwuz
ForB1XpZIsJJncz78Uez7fYREWEsyJ8pLpHounwZPhGLsOaQVG/Jk4yPygqznGn7
qAFjYflnoKtnUD6JQ34O2aOA2OTunXHQ71WNk+GA6O1Tczb1LyTOV31QGJ/nS6HP
ecReIa0ycOwyLKzummG/fWZKVizGAnbb51elIGWM1v8AbFtMzjxQHbAugXawcuNM
tbsIEWYxicuotf027oonHSKPDBHVERk2PkLhljoJn2hxcriA8CooY9+ipaGe8/8K
ubh+nXh0CUBwilX4m6FjVOFq+qtyYAkEOObxZezzCLZBoss23pxewB46ncweFt1x
E3PTUGsnC3doWCKOVWGtandIZMh2zPuiwpQC+ahWNy2DBadqB2bFDoWsfuKA3r9e
MgyzZ8AA/a7ozTIu8o0n+4drj2u1vvHKrU2oNLjYAKEiASztxT0O1U7WXsyatIgs
iIaw/Caqff0EZe1JLWWAzFM4B/WREDi/S8MHQ8VdU7CQFXH/TuZIXoT1+DY/YKP9
E39VYFN4dIlJF3MlHu3PL9tUbFpahuhrbZyJqzCwCm4+QggxW61UfmyvdILucdy1
Is5eRTt0eAKiMmt13ucnuumdapSEHxn53jShYnETPsarmZLoEbMkFlGA5AIG++TX
/vQJOxj87i6wXkvrUmEk
=iIri
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
