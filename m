From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH 1/3] make sparse keep its promise about context tracking
Date: Mon, 21 Apr 2008 20:30:34 +0200
Message-ID: <1208802634.26186.135.camel@johannes.berg>
References: <20080410132519.049821000@sipsolutions.net>
	 <20080410132617.720109000@sipsolutions.net> <480CD736.601@freedesktop.org>
	 <1208801485.26186.131.camel@johannes.berg>
	 <480CDC3C.4040808@freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-28u/U74aIIqCj1KUAjcE"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from xc.sipsolutions.net ([83.246.72.84]:54296 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751359AbYDUSbJ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 21 Apr 2008 14:31:09 -0400
In-Reply-To: <480CDC3C.4040808@freedesktop.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: linux-sparse@vger.kernel.org


--=-28u/U74aIIqCj1KUAjcE
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> > and you'd end up with one context named "dbl" and another one named
> > "&dev_base_lock".
>=20
> That might still work, depending on how consistently kernel code uses
> the same argument.  If you suggest explicitly changing calls to
> read_lock to call __acquire__ with the appropriate context, it might
> prove equally easy to make the argument of read_lock that context.

True.

> That doesn't make sense to me; after preprocessing, x no longer
> exists, so I don't see how you could pick up the identifier "x".  I
> can understand that you might pick up two different expressions in
> place of x which you can't easily compare, though.

Oops, yes, preprocessing will remove it, of course. But yeah, you can
end up with two different expressions.

> And as for how to solve it: I think alias analysis might work.

How would I do that?

johannes

--=-28u/U74aIIqCj1KUAjcE
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUASAzdSKVg1VMiehFYAQIa9RAAxBmmWQkdOLfR8YkqtwM05PKPWFUYC3Tu
c/gwxNxS5ZKTVX7LOr2XvfL9ripZaVILbvCnRWK1UquuO4CpzujucpylFWBkcMFV
5X+jNLNL48PYDTcHuaphDtVneMPnbHgBBXDIdlnEbJlGoNiKssKPVN2wUM8bZDNm
yIlEQJL6kseJLCWZUg0uOJZClN7n2IUR0CH+6hOGEjjqN8nWboAugWbxDqktuANn
n3UwXJAZMLR/mAKBefeWOJHl/gekyPVJppwDK38MyS3w0ejJHiB0oFzpyTBk64hW
FfzeUvg8LorYdlq7vkpyc2qJOmlhUIwlgoYAU1CnLHzFduWLTVcCNUt5BtzMqyn0
XGeOdpJfLb/yUxWLZul736GwBBO/tgQuWbf1sRbJX14jV1pzGa6bKyWtwAHtOzqm
DkVgA+wZFoDnAZqpvQzeT/T9LvWuGGUUfnZFCXZPkeDvx03Q42EA8wN1d2xC/iYc
tTkyB1AjKfb/zqsweiLIh4lwJ7Or7moQciY4h/bFWUYoCf18yyt5diqZh1dinT8H
jp/mcx0hDaB+HZIAMHNVvoNq75sR3WnPlclSkV3yIl8PK9kOGwG/h8Y5ws7+QAJD
kYXIQy6S6HvhqQfX6L/mNv1Vo45DqNal2HGqvpvjVSP37X3IT1J3zPwsJpoatL32
demSJ2dJw+Y=
=LrQ+
-----END PGP SIGNATURE-----

--=-28u/U74aIIqCj1KUAjcE--

