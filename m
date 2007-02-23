From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH 2] Fix core dump on anonymous symbol.
Date: Thu, 22 Feb 2007 20:33:04 -0800
Message-ID: <45DE6E80.7040805@freedesktop.org>
References: <20070210001540.GA20644@chrisli.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig05AD06A65BAAF25CEE704AF0"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from [69.17.117.8] ([69.17.117.8]:47806 "EHLO
	mail6.sea5.speakeasy.net" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1750862AbXBWEd4 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 22 Feb 2007 23:33:56 -0500
In-Reply-To: <20070210001540.GA20644@chrisli.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig05AD06A65BAAF25CEE704AF0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Christopher Li wrote:
> Using the following can generate anonymous symbol without
> initializer expression.
>=20
> 	return (struct foo) {};
>=20
> It would be nice if sparse does not crash on it.
>=20
> Signed-Off-By: Christopher Li <sparse@chrisli.org>

I tried several variants of the code you suggest, but I couldn't seem to
reproduce the problem this solves.  Could you supply a full .c file for a=
 test
case?

In any case, applied.

- Josh Triplett


--------------enig05AD06A65BAAF25CEE704AF0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF3m6AGJuZRtD+evsRAm+IAKCQC3wWnL9awpNX6xz/Ypno9Nn2CQCffLZZ
wryidlf9FjVxPr52MJn1lTU=
=Lx6h
-----END PGP SIGNATURE-----

--------------enig05AD06A65BAAF25CEE704AF0--
