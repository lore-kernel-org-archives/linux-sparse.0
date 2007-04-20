From: Josh Triplett <josh@freedesktop.org>
Subject: Re: Feature request - allow boolean operations of undefined cpp symbols
Date: Fri, 20 Apr 2007 03:02:10 -0700
Message-ID: <46288FA2.4040700@freedesktop.org>
References: <1170437836.2272.22.camel@dv> <Pine.LNX.4.64.0702021021570.15057@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig80FC4F69DB5135C6DC099D17"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail7.sea5.speakeasy.net ([69.17.117.9]:45744 "EHLO
	mail7.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754167AbXDTKCQ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 20 Apr 2007 06:02:16 -0400
In-Reply-To: <Pine.LNX.4.64.0702021021570.15057@woody.linux-foundation.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Pavel Roskin <proski@gnu.org>, linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig80FC4F69DB5135C6DC099D17
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Linus Torvalds wrote:
> On Fri, 2 Feb 2007, Pavel Roskin wrote:
>> I think sparse should distinguish between safe and unsafe preprocessor=

>> operations on undefined symbols.
[...]
>> For instance, "#if SYMBOL" has a very specific meaning
>=20
> No.
>=20
> 	#if SYMBOL
>=20
> has a very specific *problem* - it very possibly is a typo.
>=20
> So this is a warning I absolutely *want* for the kernel. If some other =

> projects don't want it, fine, but it should be on by default as a warni=
gn=20
> for potentially dangerous use of preprocessor symbols.

I looked this behavior up in the C99 standard, and found the following te=
xt in
section 6.10.1:
> Prior to evaluation, macro invocations in the list of preprocessing tok=
ens
> that will become the controlling constant expression are replaced (exce=
pt
> for those macro names modi=EF=AC=81ed by the defined unary operator), j=
ust as in
> normal text. If the token defined is generated as a result of this
> replacement process or use of the defined unary operator does not match=
 one
> of the two speci=EF=AC=81ed forms prior to macro replacement, the behav=
ior is
> unde=EF=AC=81ned. After all replacements due to macro expansion and the=
 defined
> unary operator have been performed, all remaining identi=EF=AC=81ers ar=
e replaced
> with the pp-number 0, and then each preprocessing token is converted in=
to a
> token. The resulting tokens compose the controlling constant expression=

> which is evaluated according to the rules of 6.6.

This states that we must substitute 0 for any undefined preprocessor symb=
ol
in a #if or #elif condition, no matter what kind of expression they show =
up
in.  I confirmed this behavior via both GCC and Sparse; in an #if, "-1 <
SOMESYMBOL" evaluates true, and "1 < SOMESYMBOL" evaluates false.  Sparse=

follows this spec precisely with respect to actual preprocessor behavior;=
 it
simply has the ability to warn.

GCC has an equivalent option, also named -Wundef, that also generates a
warning.  Like Sparse, GCC does not issue this warning by default; GCC do=
es
not include it in -Wall either.  For both Sparse and GCC, you have to tur=
n it
on the warning for it to occur.

All of this makes me disinclined to turn -Wundef on by default.  However,=
 I
also see no reason to change the current behavior of -Wundef.  GCC will a=
lso
give you a warning if you give -Wundef.  Just don't pass -Wundef if you h=
ave
valid conditionals in your project that generate warnings about undefined=

preprocessor symbols.

However, Pavel, if you feel you could make part of -Wundef suitable to jo=
in
the default set of warnings, feel free.

- Josh Triplett


--------------enig80FC4F69DB5135C6DC099D17
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGKI+iGJuZRtD+evsRAopBAJ4uHMb2AmtrCJPBPiqcjMwGQv4uugCgv4xn
7fag31gqB16PwOebYfMWtXU=
=yFef
-----END PGP SIGNATURE-----

--------------enig80FC4F69DB5135C6DC099D17--
