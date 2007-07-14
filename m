From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [patches] more type cleanups and fixes
Date: Sat, 14 Jul 2007 13:33:54 -0700
Message-ID: <46993332.8070103@freedesktop.org>
References: <E1I9PBh-0000DU-3s@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig07B3D2CDF8FA9288040AA83D"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail3.sea5.speakeasy.net ([69.17.117.5]:38180 "EHLO
	mail3.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763574AbXGNUeF (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 14 Jul 2007 16:34:05 -0400
In-Reply-To: <E1I9PBh-0000DU-3s@ZenIV.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig07B3D2CDF8FA9288040AA83D
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Al Viro wrote:
> 	Getting the handling of qualifiers/address spaces right on the
> pointer operations, type_difference sanitized and taken closer to sanit=
y
> (in particular, kernel ARRAY_SIZE() works now), SYM_BASENAME and SYM_TY=
PEOF
> handling sanitized.
>=20
> 	That takes us about halfway to getting rid of very brittle
> dependencies between evaluate.c and type-handling details in symbol.c.
>=20
> 	The series can be pulled from branch type_difference2 in
> git://git.kernel.org/pub/scm/linux/kernel/git/viro/sparse.git/
> individual patches follow in next postings...

Patch series applied and pushed, together with the fixes noted in the thr=
ead:

* Fix test suite breakage caused by patch 1.
* Expand commit message in patch 3.
* Fix type_difference prototype in patch 7.

Thanks!

- Josh Triplett



--------------enig07B3D2CDF8FA9288040AA83D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGmTMyGJuZRtD+evsRApQxAJ46iW5zi6+1HoMLnTOi2INWbBScSwCfdSO/
vHfTc5TA4X2mrD1kRXbutQo=
=0ub0
-----END PGP SIGNATURE-----

--------------enig07B3D2CDF8FA9288040AA83D--
