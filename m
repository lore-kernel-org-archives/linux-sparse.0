From: Josh Triplett <josh@freedesktop.org>
Subject: Re: sparse -Wptr-subtraction-blows: still needed?
Date: Tue, 01 May 2007 16:59:57 -0700
Message-ID: <4637D47D.7040203@freedesktop.org>
References: <4637AC3D.6000008@freedesktop.org> <alpine.LFD.0.98.0705011442320.3808@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig1DDFF69AC76DD886BBFEB42B"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail4.sea5.speakeasy.net ([69.17.117.6]:35194 "EHLO
	mail4.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946096AbXEBAAN (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 1 May 2007 20:00:13 -0400
In-Reply-To: <alpine.LFD.0.98.0705011442320.3808@woody.linux-foundation.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org, Al Viro <viro@ftp.linux.org.uk>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1DDFF69AC76DD886BBFEB42B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Linus Torvalds wrote:
>=20
> On Tue, 1 May 2007, Josh Triplett wrote:
>> Does this still apply?  Do current versions of GCC still have this pro=
blem?
>> If not, can the option and warning go away?
>=20
> Even if current versions of gcc don't triple the build time (and for th=
e=20
> kernel, I suspect it doesn't, because we've tried to clean up our heade=
r=20
> files), the generated _code_ will invariably suck.

"invariably"?

Do you know whether the current version of GCC generates poor code for po=
inter
subtraction?

If so, does anything in particular make this an unfixable problem?

Has anyone reported this poor code generation to the GCC bugzilla?  If so=
, I
can add a reference to the bug in any (hypothetical) documentation for
-Wptr-subtraction-blows.

> So I'd not want to remove the warning.

Regardless of whether it addresses a current GCC issue or not, I have no
problem leaving the warning in if people want it, given that it requires =
an
explicit switch.

- Josh Triplett



--------------enig1DDFF69AC76DD886BBFEB42B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGN9SKGJuZRtD+evsRAgDxAKCSNT7Fxdpx5oe21LTUmkoCXbcMXQCgphQQ
NvlU4NQQIMljommyj/tf03g=
=MH41
-----END PGP SIGNATURE-----

--------------enig1DDFF69AC76DD886BBFEB42B--
