From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH] dissect: cleanup report_implicit()
Date: Thu, 22 Feb 2007 20:01:36 -0800
Message-ID: <45DE6720.3040005@freedesktop.org>
References: <20061214213740.GC422@tv-sign.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE6BFF7B7A1ADA34C01447EED"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from [69.17.117.4] ([69.17.117.4]:35780 "EHLO
	mail2.sea5.speakeasy.net" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1750817AbXBWEC2 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 22 Feb 2007 23:02:28 -0500
In-Reply-To: <20061214213740.GC422@tv-sign.ru>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE6BFF7B7A1ADA34C01447EED
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Oleg Nesterov wrote:
> It doesn't make sense to do report_implicit() for the anonymous structu=
res,
> check "type->ident !=3D NULL".
>=20
> Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

Applied.

- Josh Triplett



--------------enigE6BFF7B7A1ADA34C01447EED
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF3mcgGJuZRtD+evsRAkO6AKC3sfUJAFrItd7kMlSqxR+JQjpUFACgllh6
l9meqqrctR1Y8yrDbW/dFjg=
=Im4+
-----END PGP SIGNATURE-----

--------------enigE6BFF7B7A1ADA34C01447EED--
