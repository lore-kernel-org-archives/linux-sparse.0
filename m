From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH 1/3] make sparse keep its promise about context tracking
Date: Mon, 21 Apr 2008 12:34:41 -0700
Message-ID: <480CEC51.1000907@freedesktop.org>
References: <20080410132519.049821000@sipsolutions.net> <200804101746.14457.philipp.reisner@linbit.com> <1207842687.13354.12.camel@johannes.berg> <200804101805.31854.philipp.reisner@linbit.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig3297E7362F5691A1B15E8F70"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail1.sea5.speakeasy.net ([69.17.117.3]:37679 "EHLO
	mail1.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754677AbYDUTe0 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 21 Apr 2008 15:34:26 -0400
In-Reply-To: <200804101805.31854.philipp.reisner@linbit.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3297E7362F5691A1B15E8F70
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philipp Reisner wrote:
> The sematics of what I implemented is:
> You simply use the __attribute__((context(ctx,in,out))) to
> annotate the context changes of functions.
>=20
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

I would *love* to see this work applied on top of the patches I
applied from Johannes.  I really want the ability to mark a variable
or struct field as requiring a context to access.

I would probably call this new attribute something like
"data_context".  Also, I'd prefer an explicit way of saying "no
maximum context", rather than the hack of using a large number.

I hestiate to introduce a third semantic for a pair of numbers
describing a context.  The context attribute uses in and out contexts,
__context__ uses a delta and a required minimum, and this proposed
attribute uses a minimum and a maximum.

Similar to GCC's format attribute using the identifier printf rather
than the string "printf", I think I'd prefer the last argument as an
identifier.  Also, a minor nit: could you please use "readwrite"
rather than "rdwr"?

- Josh Triplett


--------------enig3297E7362F5691A1B15E8F70
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFIDOxRGJuZRtD+evsRAiODAJ9zbhKuRZzrMZxMWLn2CL/3ckjgXACgtgTu
/xESlJaRWV7QPt1T3s5vklg=
=GKfH
-----END PGP SIGNATURE-----

--------------enig3297E7362F5691A1B15E8F70--
