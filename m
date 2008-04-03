From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH 2/3] fix show_typename()
Date: Thu, 03 Apr 2008 13:46:09 -0700
Message-ID: <47F54211.5050600@freedesktop.org>
References: <E1JSgxJ-0003m5-1z@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigEB538CB24C15A0F9B1A0564D"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail8.sea5.speakeasy.net ([69.17.117.10]:54616 "EHLO
	mail8.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755548AbYDCUqL (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 3 Apr 2008 16:46:11 -0400
In-Reply-To: <E1JSgxJ-0003m5-1z@ZenIV.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEB538CB24C15A0F9B1A0564D
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Al Viro wrote:
> * postfix stuff had been applied in wrong order (e.g. int a[2][3] gener=
ated
> int [addressable][toplevel] a[3][2])
> * after fixing that, we've no need for recursion anymore, a bunch of ar=
guments
> go away and turn into local variables and we get an easy way to get rid=
 of
> bogus space in the show_typename() result.
>=20
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Applied, along with corresponding changes to the test suite, and pushed.

- Josh Triplett


--------------enigEB538CB24C15A0F9B1A0564D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFH9UIRGJuZRtD+evsRAil1AJ9uFZOYY8XcU6kB150SWF991RXL3ACePxnF
7KmexgN7+HQi7r+TV+k5zAo=
=PFKQ
-----END PGP SIGNATURE-----

--------------enigEB538CB24C15A0F9B1A0564D--
