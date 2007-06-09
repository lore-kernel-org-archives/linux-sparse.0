From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH] Improve error message if using a member of an incomplete
 struct or union
Date: Sat, 09 Jun 2007 00:26:07 -0700
Message-ID: <466A560F.1000108@freedesktop.org>
References: <20070605220145.5683.71073.stgit@dv.roinet.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig4B9246A78F03D2A06B23D4E5"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail1.sea5.speakeasy.net ([69.17.117.3]:50182 "EHLO
	mail1.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753148AbXFIH0N (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 9 Jun 2007 03:26:13 -0400
In-Reply-To: <20070605220145.5683.71073.stgit@dv.roinet.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4B9246A78F03D2A06B23D4E5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Pavel Roskin wrote:
> sparse should distinguish two cases.  One is when the structure or unio=
n
> is declared and the member is not found.  Another is when the structure=

> or union is not yet declared.  In the later case, the message should
> indicate that the type is incomplete, rather than complain that the
> particular member is not found.
>=20
> Mention the incomplete type like gcc does, but provide the member name
> too, it may be useful.

Applied; thanks.

- Josh Triplett



--------------enig4B9246A78F03D2A06B23D4E5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGalYPGJuZRtD+evsRAvCzAJ9/ZzB2L/AQYADmYOXhoNK/UViKfACgicJP
1NFwvq5JySr9aJ0ZVI+jyvc=
=rVDW
-----END PGP SIGNATURE-----

--------------enig4B9246A78F03D2A06B23D4E5--
