From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH] Handle ignored attribute malloc
Date: Tue, 13 Nov 2007 04:13:39 -0800
Message-ID: <473994F3.1000505@freedesktop.org>
References: <1193346769-18030-1-git-send-email-Emilian.Medve@Freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig7B57743BE2E2354D65EF85FE"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail6.sea5.speakeasy.net ([69.17.117.8]:42035 "EHLO
	mail6.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753906AbXKMMNu (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 13 Nov 2007 07:13:50 -0500
In-Reply-To: <1193346769-18030-1-git-send-email-Emilian.Medve@Freescale.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Emil Medve <Emilian.Medve@Freescale.com>
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7B57743BE2E2354D65EF85FE
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Emil Medve wrote:
> This avoids error messages like this:
>=20
> error: attribute 'malloc': unknown attribute
>=20
> Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>

Patch applied; thanks!

I decided to ignore the issue of the extra ident, for now;
the rest of the idents need a cleanup pass anyway.

- Josh Triplett



--------------enig7B57743BE2E2354D65EF85FE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHOZTzGJuZRtD+evsRAmYbAJ4tyFJzej8Y+QCY1YSlOGHwLsO/PgCghyRk
97oF0o4jDODmTj9J7P8pm1Q=
=NnPb
-----END PGP SIGNATURE-----

--------------enig7B57743BE2E2354D65EF85FE--
