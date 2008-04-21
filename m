From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH] activate context checking when context input and output
 values in __attribute__() are the same and different of zero
Date: Mon, 21 Apr 2008 12:17:33 -0700
Message-ID: <480CE84D.3020102@freedesktop.org>
References: <b98a45740802041242h35874d1fr563b92a122d30139@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigCE5FCDDFCFF1A5BA4C842BE0"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail3.sea5.speakeasy.net ([69.17.117.5]:57454 "EHLO
	mail3.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751829AbYDUTRT (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 21 Apr 2008 15:17:19 -0400
In-Reply-To: <b98a45740802041242h35874d1fr563b92a122d30139@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: sylvain nahas <sylvain.nahas@googlemail.com>
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCE5FCDDFCFF1A5BA4C842BE0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

sylvain nahas wrote:
> the following patch activates context checking when context input and
> output values are the same and different of zero in
> __attribute__((context())), by making the parser generate a OP_CONTEXT
> pseudo instruction.
>=20
> Use case: specify that a function needs to be called in locked context.=


I have applied a patch from Johannes Berg which should also address this
problem.  Could you confirm that current Sparse from Git has the behavior=

you want?

- Josh Triplett


--------------enigCE5FCDDFCFF1A5BA4C842BE0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFIDOhNGJuZRtD+evsRAiz2AJsGBheTvA8AOuoOHDVFgJbuELEqFQCglAOA
JheHiWqLhykcFm58wzFLzAw=
=c2k2
-----END PGP SIGNATURE-----

--------------enigCE5FCDDFCFF1A5BA4C842BE0--
