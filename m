From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH 5] Update usage chain for dead instruction.
Date: Tue, 16 Jan 2007 21:20:32 -0800
Message-ID: <45ADB220.8020509@freedesktop.org>
References: <20070117023804.GE962@chrisli.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6B6920FCF5B859177C83F691"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail2.sea5.speakeasy.net ([69.17.117.4]:51278 "EHLO
	mail2.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752028AbXAQFUe (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 17 Jan 2007 00:20:34 -0500
In-Reply-To: <20070117023804.GE962@chrisli.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6B6920FCF5B859177C83F691
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Christopher Li wrote:
> Branch like that:
> br %c, 0x10, 0x10
>=20
> Will be simplify and removed. But the usage information is not updated.=


Merged.

- Josh Triplett



--------------enig6B6920FCF5B859177C83F691
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFrbIgGJuZRtD+evsRAi3tAJ9QvQeEqKA2QLnqnN8SfFo2HrP2lQCfezRy
sa/ASBJ4OMARl7GLR+M1/VY=
=VpVy
-----END PGP SIGNATURE-----

--------------enig6B6920FCF5B859177C83F691--
