From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH] fix handling of pointers in ?:
Date: Wed, 11 Jul 2007 23:44:45 -0700
Message-ID: <4695CDDD.9030907@freedesktop.org>
References: <20070709221306.GP21668@ftp.linux.org.uk> <20070710010733.GQ21668@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig93C96422FA2718A7DF431214"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail7.sea5.speakeasy.net ([69.17.117.9]:54899 "EHLO
	mail7.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760101AbXGLGos (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 12 Jul 2007 02:44:48 -0400
In-Reply-To: <20070710010733.GQ21668@ftp.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig93C96422FA2718A7DF431214
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Al Viro wrote:
> a) qualifiers are joined (const int * / volatile int * -> const volatil=
e int *)
> b) pointer to void / pointer to T =3D> pointer to void (with all qualif=
iers)
>=20
> testcase added

Applied (yesterday); thanks!

- Josh Triplett



--------------enig93C96422FA2718A7DF431214
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGlc3dGJuZRtD+evsRAvjGAJ4lx1G363Eex3boAxjlw0n4yM4LhQCgk/B9
ybC49hOJbBjceaa5xCrpzQg=
=i4dn
-----END PGP SIGNATURE-----

--------------enig93C96422FA2718A7DF431214--
