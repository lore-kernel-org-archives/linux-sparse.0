From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH] allow ifdef in macro arguments
Date: Sun, 21 Oct 2007 17:03:52 -0700
Message-ID: <471BE8E8.3020200@freedesktop.org>
References: <70318cbf0710210207t587f8d2enf024a56e1d10a5df@mail.gmail.com> <20071021155211.GX8181@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig8E07F4C445635B06C7655F00"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail6.sea5.speakeasy.net ([69.17.117.8]:52068 "EHLO
	mail6.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750938AbXJVAEa (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 21 Oct 2007 20:04:30 -0400
In-Reply-To: <20071021155211.GX8181@ftp.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8E07F4C445635B06C7655F00
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Al Viro wrote:
> On Sun, Oct 21, 2007 at 02:07:15AM -0700, Christopher Li wrote:
>> I think some one report it long time ago.
>=20
> It should not accept those.  Undefined behaviour and if you try to actu=
ally
> define the semantics for it, you run into such a pile of corner cases t=
hat
> it's not worth even trying.

Do you think the cases handled by GCC warrant making an attempt and
warning about it, or should Sparse just throw up its hands and give
up?

If the latter, should Sparse make any attempt at all to detect
preprocessor conditionals in macro arguments so it can give a more
specific warning?

- Josh Triplett


--------------enig8E07F4C445635B06C7655F00
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHG+joGJuZRtD+evsRAugsAKC+39p7x7UydUEYj/3G/V5pKMXKjwCfS3iU
sz9IzTb7++T1snPs+UcT8jA=
=a+v5
-----END PGP SIGNATURE-----

--------------enig8E07F4C445635B06C7655F00--
