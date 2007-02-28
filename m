From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH] Introduce expression_error
Date: Tue, 27 Feb 2007 16:27:25 -0800
Message-ID: <45E4CC6D.9000808@freedesktop.org>
References: <20070227085822.GA6059@chrisli.org> <45E46E54.7090507@freedesktop.org> <20070227211559.GB6059@chrisli.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigAB3D245DABD86B69A11AE839"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail6.sea5.speakeasy.net ([69.17.117.8]:59091 "EHLO
	mail6.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932098AbXB1A13 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 27 Feb 2007 19:27:29 -0500
In-Reply-To: <20070227211559.GB6059@chrisli.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAB3D245DABD86B69A11AE839
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Christopher Li wrote:
> On Tue, Feb 27, 2007 at 09:45:56AM -0800, Josh Triplett wrote:
>> Christopher Li wrote:
>> This patch makes "sparse -Wall validation/badtype4.c" segfault.
>=20
> This version should fix it. But I am still not brave enough to
> remove the test for !expr->ctype yet.
>=20
> Chris
>=20
> Adding a new function expression_error, it works just like
> sparse_error but it also install a bad_ctype on expression.
>=20
> Signed-Off-By: Christopher Li <sparse@chrisli.org>

Applied.

- Josh Triplett



--------------enigAB3D245DABD86B69A11AE839
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF5MxtGJuZRtD+evsRAntTAJ401DLsVdvVxOnZWyJlqH8sZmpC3ACaA6ZT
/zenEeASqG7xyHiWeIMxbPg=
=E2PK
-----END PGP SIGNATURE-----

--------------enigAB3D245DABD86B69A11AE839--
