From: Josh Triplett <josh@freedesktop.org>
Subject: Re: fun with ?:
Date: Tue, 22 May 2007 18:05:39 -0700
Message-ID: <46539363.3010202@freedesktop.org>
References: <20070519025249.GZ4095@ftp.linux.org.uk> <4653633B.3000000@freedesktop.org> <20070522224619.GI4095@ftp.linux.org.uk> <46537BC1.9000808@freedesktop.org> <20070523000234.GJ4095@ftp.linux.org.uk> <20070523002506.GK4095@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigCCBAE6645D19D5A6EEF27C26"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail6.sea5.speakeasy.net ([69.17.117.8]:39064 "EHLO
	mail6.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757436AbXEWBGW (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 22 May 2007 21:06:22 -0400
In-Reply-To: <20070523002506.GK4095@ftp.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCCBAE6645D19D5A6EEF27C26
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Al Viro wrote:
> On Wed, May 23, 2007 at 01:02:34AM +0100, Al Viro wrote:
>> It would be nicer if C had __null__ as the *only* null pointer constan=
t
>> (with flexible type) and could refuse to accept anything else.  Too la=
te
>> for that, unfortunately.  As for conversions - see above.
>=20
> To clarify: all mess with null pointer constants comes from lack of
> explicit token and need to avoid massive breakage of old programs.  Tha=
t's
> what it's all about - compiler recognizing some subexpressions as
> representations of that missing token and trying to do that in a way th=
at
> would break as little as possible of existing C code.  It's an old stor=
y -
> decisions had to be made in 80s and now we are stuck with them.
>=20
> IOW, (void *)0 in contexts that allow null pointer constant is *not* a
> 0 cast to pointer to void; it's a compiler-recognized kludge for __null=
__.
> And it's not a pointer to void.  It can become a pointer to any type,
> including void.  If converted to a pointer type it gives the same value=

> you get if you convert 0 to that type ("null pointer to type").  But
> unlike null pointer to type it retains full flexibility.
>=20
> NULL is required to expand to null pointer constant and that's one of
> the reasons why sane code should be using it instead of explicitly spel=
led
> variants.  The next best thing to actually having __null__ in the langu=
age...

That makes perfect sense now.  Thanks for the explanation.

- Josh Triplett



--------------enigCCBAE6645D19D5A6EEF27C26
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGU5NjGJuZRtD+evsRArLmAJwOVIKyEuiOc+h2G99U4GaZ/UzHkgCdEja1
f/Rx8xY+yfDrYyKSWMHo+YE=
=SvPN
-----END PGP SIGNATURE-----

--------------enigCCBAE6645D19D5A6EEF27C26--
