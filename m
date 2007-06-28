From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH 4/6] Avoid use of libc headers in the validation suite
Date: Wed, 27 Jun 2007 23:14:20 -0700
Message-ID: <468351BC.4030505@freedesktop.org>
References: <20070628053954.30704.66440.stgit@dv.roinet.com> <20070628054009.30704.18718.stgit@dv.roinet.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigFAD3A30B49DC99157D5D5ABB"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail5.sea5.speakeasy.net ([69.17.117.7]:54954 "EHLO
	mail5.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754809AbXF1GOW (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 28 Jun 2007 02:14:22 -0400
In-Reply-To: <20070628054009.30704.18718.stgit@dv.roinet.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFAD3A30B49DC99157D5D5ABB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Pavel Roskin wrote:
> We don't want libc to affect the validation suite.  Compatibility with
> libc headers can be checked by other means, e.g. by compiling some
> significant program (even sparse itself) using cgcc as the compiler.

Agreed.  Applied; thanks!

- Josh Triplett



--------------enigFAD3A30B49DC99157D5D5ABB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGg1G8GJuZRtD+evsRAscyAKCqctwBiBzOSjSVOt1Oe9JyBJObLACfUdsz
WOZzt+4m0AT0olC2oRTzLGU=
=7c+8
-----END PGP SIGNATURE-----

--------------enigFAD3A30B49DC99157D5D5ABB--
