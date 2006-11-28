From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH] Fix warning on self check.
Date: Tue, 28 Nov 2006 12:42:34 -0800
Message-ID: <456C9F3A.6010507@freedesktop.org>
References: <20061114100026.1f00f29b@lucky.kitzblitz> <456332E3.6020107@freedesktop.org> <20061123074743.GB9322@chrisli.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig5A55AFC6CA5E2BEE0C5AD526"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail6.sea5.speakeasy.net ([69.17.117.8]:33463 "EHLO
	mail6.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1755138AbWK1Umf (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 28 Nov 2006 15:42:35 -0500
In-Reply-To: <20061123074743.GB9322@chrisli.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5A55AFC6CA5E2BEE0C5AD526
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Christopher Li wrote:
> Fix warning on self check
>=20
> Sparse complain about the using do while without
> compound statment in pre-process.c. This trivial patch
> fixes that.
>=20
> Signed-Off-By: Christopher Li <sparse@chrisli.org>

Good catch, thanks!  Merged.

One request for future patches: please don't duplicate the subject in the=

body.  git-am forms the commit message from both the subject and the body=
, and
thus duplicating the subject in the body will duplicate it in the commit
message.  I've manually fixed that for this patch.

- Josh Triplett


--------------enig5A55AFC6CA5E2BEE0C5AD526
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFbJ86GJuZRtD+evsRApAdAKCXDxy2CCkV6ncaJNIzRl30tCOGewCfRcMH
qQYxeVsnuXXMI1gzSNWpYDw=
=DyPB
-----END PGP SIGNATURE-----

--------------enig5A55AFC6CA5E2BEE0C5AD526--
