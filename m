From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [patchset] rewrite of initializer handling
Date: Mon, 18 Jun 2007 11:19:08 -0700
Message-ID: <4676CC9C.3050903@freedesktop.org>
References: <20070618101929.GE21478@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig037B7099AD4AD656171269A6"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail6.sea5.speakeasy.net ([69.17.117.8]:55067 "EHLO
	mail6.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761035AbXFRSTf (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 18 Jun 2007 14:19:35 -0400
In-Reply-To: <20070618101929.GE21478@ftp.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig037B7099AD4AD656171269A6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Al Viro wrote:
> 	Current tree handling of initializers is rather incomplete
> and in many cases broken.  Patchset rewrites that stuff pretty much
> from scratch; AFAICS it works.

Patchset applied; thanks!

The validation output changed slightly:

-validation/initializer-entry-defined-twice.c:10:12: error: Initializer e=
ntry defined twice
-validation/initializer-entry-defined-twice.c:11:12:   also defined here
-validation/initializer-entry-defined-twice.c:25:7: error: Initializer en=
try defined twice
-validation/initializer-entry-defined-twice.c:27:8:   also defined here
+validation/initializer-entry-defined-twice.c:10:3: error: Initializer en=
try defined twice
+validation/initializer-entry-defined-twice.c:11:3:   also defined here
+validation/initializer-entry-defined-twice.c:26:4: error: Initializer en=
try defined twice
+validation/initializer-entry-defined-twice.c:27:4:   also defined here

Given that this just affected the column numbers, and sparse still report=
s the
correct line numbers, I didn't worry about it.

> 	* fixed handling of gccisms (unnamed union as a member, empty struct
> as a member) to match gcc behaviour; gcc extension allowing ("a") to be=

> treated as "a" is handled, with a warning conditional on -Wparen-string=

> (default is off).  BTW, several places in the kernel have that sort of
> idiocy.

How much spew does -Wparen-string cause?  If you feel that it always
represents an error, or at least sloppy code, and that it won't drown peo=
ple
in warnings, I have no problem with turning it on by default.  Your call.=


> Areas still missing:
[...]
> 	* calculation of array size by initializer is still broken; at least
> now we get warnings about missing braces in the cases that trigger that=

> crap; struct {int a, b;} a[] =3D {1,2,3,4,5}; should give a 3-element a=
rray,
> not 5-element one.  New code warns about missing braces and puts the va=
lues
> in right places, but it still doesn't fix the array size calculation - =
it's
> done too early.  Since evaluate_initializer() can work with array of
> unknown size, perhaps the best solution would be to call it from the
> count_array_initializer() and look for maximal index in the results if
> we have EXPR_INITIALIZER / look for string size otherwise (no other
> variants are possible for arrays).  Objections?

That seems like a great approach to me; logically, an initializer should
expand an array of unspecified size to hold elements up to its maximum in=
dex.

Hopefully this would also fix the problem reported by Michael Stefaniuc i=
n
<466489FD.7010405@redhat.com>:
> Running sparse on
>         int i =3D sizeof((const char []) {'a','a','a',0});
> gives
>         zzz.c:1:9: error: cannot size expression

- Josh Triplett


--------------enig037B7099AD4AD656171269A6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGdsycGJuZRtD+evsRAiXIAJ4tl/ym5OMlfR8z2aSN3/kfiMPtvACgsouH
gG1PGYxqEVo+qP6psWqPqlM=
=4v3w
-----END PGP SIGNATURE-----

--------------enig037B7099AD4AD656171269A6--
