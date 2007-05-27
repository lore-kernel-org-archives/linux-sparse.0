From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [RFC] infinite loop in free_preprocessor_line()
Date: Sat, 26 May 2007 17:35:26 -0700
Message-ID: <4658D24E.30607@freedesktop.org>
References: <20070526002437.GB5786@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig4A941C9349B3E0232D29B103"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail4.sea5.speakeasy.net ([69.17.117.6]:35402 "EHLO
	mail4.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750910AbXE0Afy (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 26 May 2007 20:35:54 -0400
In-Reply-To: <20070526002437.GB5786@martell.zuzino.mipt.ru>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4A941C9349B3E0232D29B103
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Alexey Dobriyan wrote:
> While running if-2.c from gcc testsuite sparse goes into infinite loop =
in
> free_preprocessor_line().
>=20
> Trimmed down test-case is
>=20
> 	#if 1
> 	#if
>=20
> (two lines)

Thanks for this fix.

Can I get a Signed-off-by for this patch, please?

- Josh Triplett



--------------enig4A941C9349B3E0232D29B103
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGWNJdGJuZRtD+evsRAl9qAJ9GXRiGsx0ST9hUXdTPv7NUdz8isgCbBLue
8WeHsXl21/z0eEGU5xZB3fQ=
=BgMK
-----END PGP SIGNATURE-----

--------------enig4A941C9349B3E0232D29B103--
