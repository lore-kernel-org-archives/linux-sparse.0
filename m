From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH] fix handling of address_space in casts and assignments
Date: Wed, 11 Jul 2007 23:44:05 -0700
Message-ID: <4695CDB5.5080605@freedesktop.org>
References: <20070709221306.GP21668@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig0D4A85A1BCF35F7EFF0B437E"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail8.sea5.speakeasy.net ([69.17.117.10]:33874 "EHLO
	mail8.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751245AbXGLGoT (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 12 Jul 2007 02:44:19 -0400
In-Reply-To: <20070709221306.GP21668@ftp.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0D4A85A1BCF35F7EFF0B437E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Al Viro wrote:
> Turn FORCE_MOD into storage class specifier (that's how it's
> actually used and that makes for much simpler logics).
>=20
> Introduce explicit EXPR_FORCE_CAST for forced casts; handle it
> properly.
>=20
> Kill the idiocy in get_as() (we end up picking the oddest things
> for address space - e.g. if we have int __attribute__((address_space(1)=
)) *p,
> we'll get warnings about removal of address space when we do things lik=
e
> (unsigned short)*p.  Fixed.  BTW, that had caught a bunch of very odd
> bogosities in the kernel and eliminated several false positives in ther=
e.
>=20
> As the result, get_as() is gone now and evaluate_cast() got simpler.
>=20
> Kill the similar idiocy in handling pointer assignments; while we are a=
t it,
> fix the qualifiers check for assignments to/from void * (you can't assi=
gn
> const int * to void * - qualifiers on the left side should be no less t=
han
> on the right one; for normal codepath we get that checked, but the spec=
ial
> case of void * skips these checks).

Applied (yesterday); thanks!

- Josh Triplett



--------------enig0D4A85A1BCF35F7EFF0B437E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGlc3AGJuZRtD+evsRAlREAKC/aXcIo2mYNOb6nG6tfwhxHM+Z4QCgm3kO
qXuoWeh3LGGJM8E/0wlnnZ0=
=wCQp
-----END PGP SIGNATURE-----

--------------enig0D4A85A1BCF35F7EFF0B437E--
