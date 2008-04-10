From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH 1/3] make sparse keep its promise about context tracking
Date: Thu, 10 Apr 2008 18:12:05 +0200
Message-ID: <1207843925.13354.20.camel@johannes.berg>
References: <20080410132519.049821000@sipsolutions.net>
	 <200804101746.14457.philipp.reisner@linbit.com>
	 <1207842687.13354.12.camel@johannes.berg>
	 <200804101805.31854.philipp.reisner@linbit.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-pZGnbJjoXkYRIMNsYK9V"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from crystal.sipsolutions.net ([195.210.38.204]:58586 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757241AbYDJQMO (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 10 Apr 2008 12:12:14 -0400
In-Reply-To: <200804101805.31854.philipp.reisner@linbit.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Josh Triplett <josh@freedesktop.org>, linux-sparse@vger.kernel.org


--=-pZGnbJjoXkYRIMNsYK9V
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> I also use it to check a recusive lock mechanism.=20
>=20
> The sematics of what I implemented is:
> You simply use the __attribute__((context(ctx,in,out))) to
> annotate the context changes of functions.

Yeah, mostly because that's how the man page documents it :)

> to annotate a variable, struct/union member or a function that
> a certain locking primitive is required for accessing it, you
> do it by=20
>=20
> __attribute__((require_context(ctx,min,max,"type")))
>=20
> ctx ... the expression that describes the locking primitive
> min ... the minimum of locks required of that locking primitive
> max ... the maximum allowed of locks of that locking primitive.
> type .. read, write, rdwr or call for the access type.
>=20
> So you can express you need to hold this and that locking=20
> primitive to write to something. But an other locking
> primitive might be sufficient for reading that something.
>=20
> The annotation for a variable foo protected by a recursive lock
> bar would be:
>=20
> int foo __attribute__((require_context(bar,1,99999,"rdwr")))

Ah. Makes sense as well, though now you can't do something like "require
context count two and decrement by one", can you? Or do you just do that
by combining the various attributes?

Anyhow, I don't really care which patch gets chosen.

Though, how can you actually track multiple contexts within a single
function if you have just a "struct expression *context_expr" for each
basic block? I guess I should just try your code :)

johannes

johannes

--=-pZGnbJjoXkYRIMNsYK9V
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUAR/48VKVg1VMiehFYAQJ2cw/+PYJiUYIsqoWxJJvFGt0U0EBnNoAVJuJs
HftUkm2LW0KMoiXpmRPOqGYihKpQ1g2YpC0W5XCW2QpTK30UeEq9D7qw7XjcUMjs
/Jjl1fuZmfnuSLJ5QoklC+y1zNFSHn1787uJInIyl0dkbTN1Zh8LIQac3DILHaeL
qSTHk+xD5mnBwX4V1CG8RIvsUPtFrpsKJWu9wKFTpsq6hJtbcQ78G9KFXVEaCgd0
Jlvtsm8hKZz/5YK1kyqBOzxITk8zSclT0nu5mYfOlsc3N49DpEI6N2GsravDpKZA
An8W5lt+65OQnp28YivUpF6WhZIWloslL1AeOU65HJ6tu7VLKlzYWF636hOqFZzW
3Ym5z2i/zrf8+kzgOvoBcfbXWb3/I7j+3hwpDyNCRZStRzqdGUKgowNmCVs8amRw
jGbD086h76Wl9p4p8rpHVI0AY4Gyu6z4898Ysqyv6hOrBhnyl5nYVsC2UMdOLsFX
pFHyBr9TZ6WRNDbKpaDXHaXxIOCP247y3jlnYZfldRLEmmsbRh8xEymQZoupbwDw
tU83gsPxqc1mqkCRysxQpGPhFrg0vFk6UCZewdKITX9ocsrBeRzT+d4R9GAJuMyT
WJe0IyS2+b5ZTtSR/BdDSPyU1HL3FY2OkvkGfUb21xtQys7vJfKxz5qAMhNP3u1j
FUFx8qGLdSo=
=aES7
-----END PGP SIGNATURE-----

--=-pZGnbJjoXkYRIMNsYK9V--

