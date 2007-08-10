From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH] libxml compile fix on Cygwin
Date: Thu, 09 Aug 2007 22:53:12 -0700
Message-ID: <46BBFD48.3030805@freedesktop.org>
References: <f9d9d1$m7o$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig3A97802D4B0C25CDB7D346E2"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail8.sea5.speakeasy.net ([69.17.117.10]:50993 "EHLO
	mail8.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753292AbXHJFx0 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 10 Aug 2007 01:53:26 -0400
In-Reply-To: <f9d9d1$m7o$1@sea.gmane.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Kovarththanan Rajaratnam <krj@rajaratnam.dk>
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3A97802D4B0C25CDB7D346E2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Kovarththanan Rajaratnam wrote:
> I needed to re-arrange the libxml-2.0 library order to make sparse=20
> compile on Cygwin. Patch attached.
>=20
> Signed-off-by: Kovarththanan Rajaratnam <krj@rajaratnam.dk>

Applied; thanks!

- Josh Triplett


--------------enig3A97802D4B0C25CDB7D346E2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGu/1IGJuZRtD+evsRAgfXAKCOd2XCA4RrehGEnv9am2iwl5RAYQCcDybO
BEGejT6zHqdVQvcHaEQWFfU=
=gdqK
-----END PGP SIGNATURE-----

--------------enig3A97802D4B0C25CDB7D346E2--
