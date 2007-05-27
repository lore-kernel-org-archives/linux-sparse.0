From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [patches] misc fixes
Date: Sat, 26 May 2007 17:44:27 -0700
Message-ID: <4658D46B.7050406@freedesktop.org>
References: <E1HrQvc-00017z-Hz@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig80F14A3D315782430958AED9"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail1.sea5.speakeasy.net ([69.17.117.3]:51378 "EHLO
	mail1.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750855AbXE0Aok (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 26 May 2007 20:44:40 -0400
In-Reply-To: <E1HrQvc-00017z-Hz@ZenIV.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig80F14A3D315782430958AED9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Al Viro wrote:
> Just starting to reduce the queue; there'll be more later.  In this
> pile:
> 	handle __alignof as equivalent of __alignof__
> 	saner reporting of overlaps in initializers
> 	check for whitespace before object-like macro body
> 	fix alignment for _Bool
> 	fix interaction of typeof with bitwise types
> 	better recovery from bad operations on bitwise

All six patches applied.  Thanks!

- Josh Triplett



--------------enig80F14A3D315782430958AED9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGWNRrGJuZRtD+evsRAlfCAKCtNvteHYdNQqUD/E9Va94KxICoqQCfXua4
qju64+TYO3O0SwHz+k46g2I=
=ZYer
-----END PGP SIGNATURE-----

--------------enig80F14A3D315782430958AED9--
