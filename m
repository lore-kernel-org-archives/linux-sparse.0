From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH] tokenize.c: Simplify drop_stream_eoln().
Date: Sun, 29 Jul 2007 01:13:55 -0700
Message-ID: <46AC4C43.8090202@freedesktop.org>
References: <1184803288.469ea9d82a143@portal.student.luth.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA9EC5D2A036F47DDDD25B960"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail5.sea5.speakeasy.net ([69.17.117.7]:40437 "EHLO
	mail5.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760788AbXG2IN5 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 29 Jul 2007 04:13:57 -0400
In-Reply-To: <1184803288.469ea9d82a143@portal.student.luth.se>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: ricknu-0@student.ltu.se
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA9EC5D2A036F47DDDD25B960
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

ricknu-0@student.ltu.se wrote:
> Simplifying function drop_stream_eoln().
>=20
> Signed-off-by: Richard Knutsson <ricknu-0@student.ltu.se>
> ---
> Is there a reason to call nextchar() before drop_token()?

None that I know of, and your patch doesn't break the test suite.  Applie=
d;
thanks!

- Josh Triplett



--------------enigA9EC5D2A036F47DDDD25B960
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGrExDGJuZRtD+evsRAhEQAKCJ504HYm2eyxLoGutvNcmcj0JxVACguAh3
vrZWz0CxRiDJvnUGVAbolK4=
=Dg8c
-----END PGP SIGNATURE-----

--------------enigA9EC5D2A036F47DDDD25B960--
