From: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
Subject: no more tar balls?
Date: Wed, 6 Sep 2017 20:15:08 +0200
Message-ID: <b0a98c64-48a8-aaf9-a410-ffe83b12aea6@kleine-koenig.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="n1LOH9plmxLDbOUwbpStCO1Vb3OlXAlrp"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from arcturus.kleine-koenig.org ([78.47.169.190]:40832 "EHLO
        arcturus.kleine-koenig.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750836AbdIFSPP (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 6 Sep 2017 14:15:15 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--n1LOH9plmxLDbOUwbpStCO1Vb3OlXAlrp
Content-Type: multipart/mixed; boundary="2iWqWPbwEGRGwCSJ0fXpWUxIwnTWPi2ba";
 protected-headers="v1"
From: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org
Message-ID: <b0a98c64-48a8-aaf9-a410-ffe83b12aea6@kleine-koenig.org>
Subject: no more tar balls?

--2iWqWPbwEGRGwCSJ0fXpWUxIwnTWPi2ba
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hello,

for Debian packages there is a tool that checks if for a given software
there is a new upstream version to automatically alert the packager. Up
to now the location being checked is

	https://www.kernel.org/pub/software/devel/sparse/dist/

for sparse. There however the newest release (0.5.1) is missing. Was it
just forgotten to upload a tar ball there, or did you stop explicitly
distributing tar balls?

Best regards
Uwe


--2iWqWPbwEGRGwCSJ0fXpWUxIwnTWPi2ba--

--n1LOH9plmxLDbOUwbpStCO1Vb3OlXAlrp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAlmwOywACgkQwfwUeK3K
7Am7Jgf+OTe8NK9kJPrwUj8ei+AreSqoirqWkwi+nb3Pieu51kyvMLfOC2J2FrMx
glzQ6fOcE7QntlR32kOSN0ZjXD48rhJkBbMpkn39s4x2VPBTNw8dnuCDQrWEVHhA
YQ3ohOxqtcHzKCjx91YRbXXSfPvViRM6LLJv+Ihe3jAoirQsEybNXYVxiK1WPw5A
OQcSup2TC7FCVrs+yZNh4Zbzlh4Hzuk1f21GcwcOlDP/0TTWJxCNja8unX6edtEF
rUSMc17IRe/T4/FyojHAdtZD2sEweWJ3sP8K1GuKk0hbC1hu06F2Kn9kmBnhbDgE
if6w2OyjOkRqseeOFkcI4wIkZaf6mQ==
=u1lB
-----END PGP SIGNATURE-----

--n1LOH9plmxLDbOUwbpStCO1Vb3OlXAlrp--
