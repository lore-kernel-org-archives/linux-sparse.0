From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH] expression.c: Adding va_end().
Date: Tue, 24 Jul 2007 21:48:29 -0700
Message-ID: <46A6D61D.70503@freedesktop.org>
References: <1184803375.469eaa2f8bff0@portal.student.luth.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig25851DC81387F38BF684729A"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail2.sea5.speakeasy.net ([69.17.117.4]:58154 "EHLO
	mail2.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750794AbXGYEsb (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 25 Jul 2007 00:48:31 -0400
In-Reply-To: <1184803375.469eaa2f8bff0@portal.student.luth.se>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: ricknu-0@student.ltu.se
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig25851DC81387F38BF684729A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

ricknu-0@student.ltu.se wrote:
> Signed-off-by: Richard Knutsson <ricknu-0@student.ltu.se>
> ---
> According to the manual, it needs a va_end() in the same function.

It does indeed; good catch.  Applied.

- Josh Triplett



--------------enig25851DC81387F38BF684729A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGptYdGJuZRtD+evsRAmKVAJ9WYmVAKvwPn98j7tfv3G5pU/qQwQCdFhZy
ldnz5es8Yk/TvixNSbA50/Y=
=mhdB
-----END PGP SIGNATURE-----

--------------enig25851DC81387F38BF684729A--
