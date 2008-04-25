From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH 2/2] Simplify (and warn about) right shifts that result
 in zero
Date: Thu, 24 Apr 2008 19:29:56 -0700
Message-ID: <48114224.2020806@freedesktop.org>
References: <20080424193856.14737.16718.stgit@warthog.procyon.org.uk> <alpine.LFD.1.10.0804241248290.2779@woody.linux-foundation.org> <alpine.LFD.1.10.0804241443460.2779@woody.linux-foundation.org> <alpine.LFD.1.10.0804241452250.2779@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA1609648F5693276AE411DDC"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail3.sea5.speakeasy.net ([69.17.117.5]:41182 "EHLO
	mail3.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755699AbYDYC3x (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 24 Apr 2008 22:29:53 -0400
In-Reply-To: <alpine.LFD.1.10.0804241452250.2779@woody.linux-foundation.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Howells <dhowells@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA1609648F5693276AE411DDC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Linus Torvalds wrote:
> From: Linus Torvalds <torvalds@woody.linux-foundation.org>
> Date: Thu, 24 Apr 2008 14:47:04 -0700
>=20
> ..due to limited source sizes.
>=20
> Yeah, should do this for left shifts too.
>=20
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> ---
>=20
> Again, not a lot of testing, but it _looks_ fairly sane.
>=20
> The constant value case of "operand_size()" is not actually ever used=20
> (because a totally constant right shift will be optimized in other=20
> places), but I wrote the code so that perhaps other cases could use thi=
s.=20
> Whatever.=20
>=20
> The "do the same for left shifts" could do a similar check, but based=20
> purely on the size of the operation, not the size of the operand value.=
=20
> Which makes it not very interesting.

Applied and pushed.

- Josh Triplett



--------------enigA1609648F5693276AE411DDC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFIEUIkGJuZRtD+evsRAj3kAJ9xI4gTGLBt4DO3CsoDD16HiVy37gCfTqNw
P0OIQmoBr9nZfd/nxtAVVck=
=20Ze
-----END PGP SIGNATURE-----

--------------enigA1609648F5693276AE411DDC--
