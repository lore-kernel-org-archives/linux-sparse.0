From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH] add __builtin_labs()
Date: Wed, 22 Aug 2007 19:19:44 -0700
Message-ID: <46CCEEC0.5040606@freedesktop.org>
References: <20070822154300.c46c1fd0.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC2FDBA43673B91AE2C4E567D"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail1.sea5.speakeasy.net ([69.17.117.3]:49705 "EHLO
	mail1.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752184AbXHWCTr (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 22 Aug 2007 22:19:47 -0400
In-Reply-To: <20070822154300.c46c1fd0.randy.dunlap@oracle.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC2FDBA43673B91AE2C4E567D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Randy Dunlap wrote:
> From: Randy Dunlap <randy.dunlap@oracle.com>
>=20
> 2.6.23-rc3-mm1 has added a user of __builtin_labs(), so add this functi=
on
> to sparse lib.c to avoid the error messages.
>=20
>   CHECK   kernel/unwind.c
> kernel/unwind.c:1016:31: error: undefined identifier '__builtin_labs'
> kernel/unwind.c:1232:25: error: undefined identifier '__builtin_labs'
>=20
> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>

Applied, thanks.

- Josh Triplett


--------------enigC2FDBA43673B91AE2C4E567D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGzO7BGJuZRtD+evsRAuC0AJwPxry+Aw9O9UhXsPGqQ4NecNeYUgCfR4Yo
oHf79ukhTMlqF41qA4JSjU8=
=2ozB
-----END PGP SIGNATURE-----

--------------enigC2FDBA43673B91AE2C4E567D--
