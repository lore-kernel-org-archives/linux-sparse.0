From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH 9] Another attempt to fix the attribute parsing.
Date: Sat, 27 Jan 2007 01:31:47 -0800
Message-ID: <45BB1C03.4040700@freedesktop.org>
References: <20070117024357.GJ962@chrisli.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigDCCCE7BB668EE02E6FA8D744"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail6.sea5.speakeasy.net ([69.17.117.8]:52919 "EHLO
	mail6.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994AbXA0Jbv (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 27 Jan 2007 04:31:51 -0500
In-Reply-To: <20070117024357.GJ962@chrisli.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDCCCE7BB668EE02E6FA8D744
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Christopher Li wrote:
> This patch delay the finalized of the abstract int type so it
> can take the __attribute__ in the end of declaration.=20
>=20
> It complicate the bit field parsing because abstract type can
> show up in the base type of bit field.

Applied; thanks.

- Josh Triplett



--------------enigDCCCE7BB668EE02E6FA8D744
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFuxwDGJuZRtD+evsRAneQAJ9DwOnEC7A9nlPi/c61R0fMtcgoLgCgl6GY
ftwIiANUV2OD1v3gbEvPmyU=
=l8LO
-----END PGP SIGNATURE-----

--------------enigDCCCE7BB668EE02E6FA8D744--
