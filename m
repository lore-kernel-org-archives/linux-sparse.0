From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH 1/8] saner show_type()
Date: Sat, 14 Jul 2007 12:20:08 -0700
Message-ID: <469921E8.7070505@freedesktop.org>
References: <E1I9PBr-0000Dj-4W@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9009781F39FE64B3DFCD8A99"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail6.sea5.speakeasy.net ([69.17.117.8]:50778 "EHLO
	mail6.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760211AbXGNTUS (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 14 Jul 2007 15:20:18 -0400
In-Reply-To: <E1I9PBr-0000Dj-4W@ZenIV.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9009781F39FE64B3DFCD8A99
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Al Viro wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  show-parse.c |   62 +++++++++++++++++++++++++++++++++++++++++---------=
-------
>  1 files changed, 44 insertions(+), 18 deletions(-)

Just realized that this breaks validation/address_space.c in the test sui=
te,
because the output no longer matches.  I'll fix this as part of this patc=
h
before I push.

- Josh Triplett



--------------enig9009781F39FE64B3DFCD8A99
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGmSHoGJuZRtD+evsRAhBIAJ4o7sG9IjVKa3wWJNVl/fElRxuKggCgp/eB
WTSlN/9q9RkYQvOCDYH5ejs=
=ksLO
-----END PGP SIGNATURE-----

--------------enig9009781F39FE64B3DFCD8A99--
