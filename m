From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH](take II) Sparse fooled by double semicolon
Date: Thu, 22 Feb 2007 19:43:29 -0800
Message-ID: <45DE62E1.9040606@freedesktop.org>
References: <1170219027.11455.68.camel@dv> <20070131065838.GA23326@chrisli.org> <20070131071717.GA23495@chrisli.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig3A7C6254D1E2B6ECAB54A132"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from [69.17.117.8] ([69.17.117.8]:57712 "EHLO
	mail6.sea5.speakeasy.net" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1750839AbXBWDoV (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 22 Feb 2007 22:44:21 -0500
In-Reply-To: <20070131071717.GA23495@chrisli.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Pavel Roskin <proski@gnu.org>, linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3A7C6254D1E2B6ECAB54A132
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Christopher Li wrote:
> Actually, this version is better because it handle semicolon
> as the first member as well.
>=20
> Fix double semicolon in struct declare
>=20
> Pavel discover this test case:
> #include <string.h>
> void test(void)
> {
>        struct { int foo;; } val;
>        memset(&val, 0, sizeof(val));
> }
>=20
> Sparse ends up create a node with empty ctype in the member list.
> Skip that seems fix it.
>=20
> Signed-Off-By: Christopher Li<spase@chrisli.org>

Applied, along with the test case.

- Josh Triplett



--------------enig3A7C6254D1E2B6ECAB54A132
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF3mLhGJuZRtD+evsRAkLqAJ9w4tRIQuSbsv3X4clEuVYy9s2VQACeKb+M
d75LaSIJ2DNJGcdL9fdW5gI=
=MVqk
-----END PGP SIGNATURE-----

--------------enig3A7C6254D1E2B6ECAB54A132--
