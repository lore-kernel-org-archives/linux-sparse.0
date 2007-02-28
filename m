From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH 4] Disable liveness "dead" instruction by default.
Date: Wed, 28 Feb 2007 11:46:36 -0800
Message-ID: <45E5DC1C.4050000@freedesktop.org>
References: <20070210001810.GC20644@chrisli.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig91BF94D50E726FF54782326C"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail8.sea5.speakeasy.net ([69.17.117.10]:59339 "EHLO
	mail8.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751877AbXB1Tqj (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 28 Feb 2007 14:46:39 -0500
In-Reply-To: <20070210001810.GC20644@chrisli.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig91BF94D50E726FF54782326C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Christopher Li wrote:
> The liveness instruction take up about 10% of the bytecode bloat file.
> It is not very useful, it is duplicate information can be obtain
> from the def/user chain.
>=20
> This change disable the liveness instruction by default.
> The caller can track_pseudo_death() if needed.
>=20
> Signed-Off-By: Christopher Li <sparse@chrisli.org>

Good idea; applied.

- Josh Triplett



--------------enig91BF94D50E726FF54782326C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD4DBQFF5dwcGJuZRtD+evsRAtPJAJj1v64DTHFxJezlLerOU9x5zGN+AJ42bjv5
bvktUlD+PdK86hX3/Gkq9g==
=fi2M
-----END PGP SIGNATURE-----

--------------enig91BF94D50E726FF54782326C--
