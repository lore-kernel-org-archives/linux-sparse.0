From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH 1/3] saner warnings for restricted types
Date: Thu, 03 Apr 2008 13:45:02 -0700
Message-ID: <47F541CE.7020000@freedesktop.org>
References: <E1JSgx9-0003lK-3Y@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig71107FFF8D95813CE2AF01AA"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail1.sea5.speakeasy.net ([69.17.117.3]:56580 "EHLO
	mail1.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755204AbYDCUpD (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 3 Apr 2008 16:45:03 -0400
In-Reply-To: <E1JSgx9-0003lK-3Y@ZenIV.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig71107FFF8D95813CE2AF01AA
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Al Viro wrote:
> * don't crap the type->ident for unsigned int just because somebody did=

> 	typedef unsigned int x;
>   only structs, unions, enums and restricted types need it.
> * generate saner warnings for restricted, include type name(s) into the=
m.
>=20
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Applied and pushed.

- Josh Triplett



--------------enig71107FFF8D95813CE2AF01AA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFH9UHOGJuZRtD+evsRAlpYAJ91gTt1MpdIRfvNRtXgT0qA6hO3dACgsZSD
+RXBA2IEeyqVsEh0LiUW2wU=
=mtQA
-----END PGP SIGNATURE-----

--------------enig71107FFF8D95813CE2AF01AA--
