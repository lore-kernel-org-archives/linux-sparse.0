From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [patch] fix install perms of manpages
Date: Wed, 19 Sep 2007 13:49:36 -0700
Message-ID: <46F18B60.4060309@freedesktop.org>
References: <200709171530.18669.vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2EDC98EB4009B0B6F65E841D"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail1.sea5.speakeasy.net ([69.17.117.3]:47800 "EHLO
	mail1.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751472AbXISUtj (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 19 Sep 2007 16:49:39 -0400
In-Reply-To: <200709171530.18669.vapier@gentoo.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2EDC98EB4009B0B6F65E841D
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Mike Frysinger wrote:
> the install step for manpages currently does not use the -m option whic=
h means
> perms default to 755 which makes no sense for man pages
>=20
> Signed-off-by: Mike Frysinger <vapier@gentoo.org>

Applied; thanks.

- Josh Triplett



--------------enig2EDC98EB4009B0B6F65E841D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFG8YthGJuZRtD+evsRAir5AJ4sHxfilSL4csjmGad9H+niW6a+hACfd0eb
aXvAn2jxl+fXoO84HBv5laI=
=E1Ic
-----END PGP SIGNATURE-----

--------------enig2EDC98EB4009B0B6F65E841D--
