From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH] fix the comma handling in integer constant expressions
Date: Sun, 08 Jul 2007 18:50:35 -0700
Message-ID: <4691946B.8030709@freedesktop.org>
References: <20070701074848.GA1101@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig78822365BFA67B8C73203CE3"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail2.sea5.speakeasy.net ([69.17.117.4]:49923 "EHLO
	mail2.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756754AbXGIBuu (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 8 Jul 2007 21:50:50 -0400
In-Reply-To: <20070701074848.GA1101@ftp.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig78822365BFA67B8C73203CE3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Al Viro wrote:
> [my apologies to the folks on Cc, original mails got the list address
> buggered in To:, thus the resend of the entire series just to the list]=

>=20
> On Wed, Jun 27, 2007 at 04:54:25PM +0100, Al Viro wrote:
>> ... or it could be done simpler, if we keep the current logics for
>> Int_const_expr flag at parse time and add a 'const expression' one
>> with rules as above.  Anyway, I'm going to get some sleep before
>> dealing with that crap.
>=20
> From: Al Viro <viro@zeniv.linux.org.uk>
> Date: Sun, 1 Jul 2007 02:28:10 -0400
> Subject: [PATCH] fix the comma handling in integer constant expressions=

>=20
> Treat it as normal binary operation, taint the value, check the taint.
> We can do other kind of value tainting with the same infrastructure
> as well...
>=20
> Review and testing would be welcome; AFAICS, it works, but...

Seems to work for me.  Applied.

I did notice one thing:

$ ./sparse /dev/stdin <<<"int x; struct { unsigned int i:x; };"
/dev/stdin:1:32: error: bad constant expression
/dev/stdin:1:33: error: invalid named zero-width bitfield `i'

That seems like double-warning for the same error.  Probably a pain to
suppress the second error, though.

- Josh Triplett



--------------enig78822365BFA67B8C73203CE3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGkZRrGJuZRtD+evsRAme0AJ4o9p7ad2nIeg4ZouFLGwe8HoTASQCgiGOZ
p8m2mAzupBB/OgL2HUR+qgA=
=MIxx
-----END PGP SIGNATURE-----

--------------enig78822365BFA67B8C73203CE3--
