From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH 11] Make the ptrlist using the sparse allocator.
Date: Thu, 22 Feb 2007 19:54:12 -0800
Message-ID: <45DE6564.6040908@freedesktop.org>
References: <20070117024839.GL962@chrisli.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE0C982C100A10E0D61F9CA0B"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from [69.17.117.6] ([69.17.117.6]:48197 "EHLO
	mail4.sea5.speakeasy.net" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1750835AbXBWDzF (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 22 Feb 2007 22:55:05 -0500
In-Reply-To: <20070117024839.GL962@chrisli.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE0C982C100A10E0D61F9CA0B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Christopher Li wrote:
> We can drop the whole allocator without freeing the
> ptrlist one by one.
>=20
> Signed-off-by: Christopher Li <sparse@chrisli.org>

Applied, though I'd love to see more descriptive names for __DO_ALLOCATOR=
 and
__ALLOCATOR.

- Josh Triplett


--------------enigE0C982C100A10E0D61F9CA0B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF3mVkGJuZRtD+evsRAp1UAKCej2g/4DstdTgETeKyNUi0N4XdZgCeOCXl
cgpLN6D4sf+cS402aJlMg9w=
=zxog
-----END PGP SIGNATURE-----

--------------enigE0C982C100A10E0D61F9CA0B--
