From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH] dissect: fix multidimensional array initializer
Date: Thu, 22 Feb 2007 21:27:39 -0800
Message-ID: <45DE7B4B.4080100@freedesktop.org>
References: <20061214213547.GA422@tv-sign.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9F0ED00F7E23FB8A49F277C7"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from [69.17.117.10] ([69.17.117.10]:49418 "EHLO
	mail8.sea5.speakeasy.net" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1750891AbXBWF2c (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 23 Feb 2007 00:28:32 -0500
In-Reply-To: <20061214213547.GA422@tv-sign.ru>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9F0ED00F7E23FB8A49F277C7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Oleg Nesterov wrote:
> dissect can't parse initializers like
>=20
> 	struct T { int i; } a[2][3] =3D { [0][0] =3D {123} };
>=20
> , output is:
>=20
> 	   1:8   s def  T
> 	   1:21  g def  a                                struct T [3][2]
> 	   1:21  g -w-  a                                struct T [3][2]
> 	T.c:1:37: warning: bad expr->type: 25
>=20
> with this patch applied:
>=20
> 	   1:8   s def  T
> 	   1:21  g def  a                                struct T [3][2]
> 	   1:21  g -w-  a                                struct T [3][2]
> 	   1:43  s -w-  T.i                              int
>=20
> Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

Applied.

- Josh Triplett



--------------enig9F0ED00F7E23FB8A49F277C7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF3ntLGJuZRtD+evsRAqz0AJ0cg65lrPd2R8He7cCb+vWf3sWi/QCggc/d
2LiOaGSzi8iNdn3vx5HnxFA=
=+sje
-----END PGP SIGNATURE-----

--------------enig9F0ED00F7E23FB8A49F277C7--
