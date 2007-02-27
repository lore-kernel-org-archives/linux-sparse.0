From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH] Introduce expression_error
Date: Tue, 27 Feb 2007 09:45:56 -0800
Message-ID: <45E46E54.7090507@freedesktop.org>
References: <20070227085822.GA6059@chrisli.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig502065887FA76D706ED6BE5E"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail6.sea5.speakeasy.net ([69.17.117.8]:51600 "EHLO
	mail6.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751385AbXB0RqM (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 27 Feb 2007 12:46:12 -0500
In-Reply-To: <20070227085822.GA6059@chrisli.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig502065887FA76D706ED6BE5E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Christopher Li wrote:
> Adding a new function expression_error, it works just like
> sparse_error but it also install a bad_ctype on expression.
>=20
> Signed-Off-By: Christopher Li <sparse@chrisli.org>

This patch makes "sparse -Wall validation/badtype4.c" segfault.

- Josh Triplett


--------------enig502065887FA76D706ED6BE5E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF5G5dGJuZRtD+evsRAgxKAKC9giWT3VGxEVjFAk1nbJvLJYBxnwCeNxDt
ETpCyJe5heduYCoPr+Oj2kk=
=Gasg
-----END PGP SIGNATURE-----

--------------enig502065887FA76D706ED6BE5E--
