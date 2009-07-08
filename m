From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] kmemcheck: fix sparse warning
Date: Wed, 08 Jul 2009 21:39:41 +0200
Message-ID: <1247081981.18386.10.camel@johannes.local>
References: <1246873983.20908.0.camel@johannes.local>
	 <19f34abd0907081228p541d1cdao85f37aaa479fcfc5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-jzH9nkzRQWl0Uyh/4Zgz"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from xc.sipsolutions.net ([83.246.72.84]:43622 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753677AbZGHTkP (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 8 Jul 2009 15:40:15 -0400
In-Reply-To: <19f34abd0907081228p541d1cdao85f37aaa479fcfc5@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Vegard Nossum <vegard.nossum@gmail.com>
Cc: Pekka J Enberg <penberg@cs.helsinki.fi>, linux-kernel <linux-kernel@vger.kernel.org>, linux-sparse@vger.kernel.org


--=-jzH9nkzRQWl0Uyh/4Zgz
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2009-07-08 at 21:28 +0200, Vegard Nossum wrote:

> >  #define kmemcheck_annotate_bitfield(ptr, name)                        =
 \
> > -       do if (ptr) {                                                  =
 \
> > +       do { if (ptr) {                                                =
 \
> >                int _n =3D (long) &((ptr)->name##_end)                  =
  \
> >                        - (long) &((ptr)->name##_begin);                =
\
> >                BUILD_BUG_ON(_n < 0);                                   =
\
> >                                                                        =
\
> >                kmemcheck_mark_initialized(&((ptr)->name##_begin), _n); =
\
> > -       } while (0)
> > +       } } while (0)
> >
> >  #define kmemcheck_annotate_variable(var)                              =
 \
> >        do {                                                            =
\
> >
> >
> >
>=20
> I'll change the patch title to "kmemcheck: work around bogus sparse
> warning" and fix the indentation, sounds ok?

Well, it's debatable whether it's bogus or not, but I don't care as long
as it gets fixed.

> Meanwhile, I Cced sparse mailing list in case somebody else knows
> anything else about this warning (what it means, whether it's
> justified in this case, whether it should be fixed in sparse, etc.).

Everybody take me off the CC please then :) This has been discussed far
too many times already. In this special case, the warning probably isn't
all that useful, but ISTR Linus saying that he wanted it this way.

johannes

--=-jzH9nkzRQWl0Uyh/4Zgz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJKVPX6AAoJEODzc/N7+QmaieUP/iVV2/nB5k5wDYQXwgopAOoE
v0OG4XFYs437G1Rea0qGWq0SDjqQ6IL31k2O82HJdloTi6BWELCWGg6+EkIOcPss
u8aGYq0HcgYU0B6EkyOb+0Z8mgWvNVxCqozl8PEUweeSdmAajyAhpKH9DgZ+2M08
iQIfvk8SoDOeYi8DTXArcP6iSnGfm/edYuRv4CBSfUohLGFX63R7mFyoZlblS4Ai
uonaFJTmrDPtanjS2VeO6STsBR1GDZg5jpUS6iSnDOtvpnHMuWNP5XRRnaDzxGjx
DfvCiPPwjyPIGp1sLxe5EnYNxTinGCWh23Pv+nG8FDp14yoEFyl7lKc6oHoiNU6P
MQ1gmTaHAVAlA+ehWfh/53uXJuYZUCHJF4oWhR9uRyNyuYSputyMITuEPwcO4nop
GolH3Mdw3t0+ADdKr7WPtheGFFaWsAtK5QrhhzYO3Ycun/jDqjGx5C/Bc1AMbJhC
ZKxowHb3Rlt+Ejx7g1zhOQ03sMeh3bMbn+k/WJYp3dD0boaVmZYcHZ9rDkNE+l8G
kOkHSq9ZyBR1xdwseoe0QfMM0F53GWAb4Ts5lzMXdo6JKL7fnBaWD2urMpkZzb/q
dU47vys9UjEb+Q1bM/QH7ktOgPJvipgBOr8cAGUCGa9vW9R7JhXJJ3IhaayUmVVu
2cr9aAeaB2z2M/R4WnuU
=g/U8
-----END PGP SIGNATURE-----

--=-jzH9nkzRQWl0Uyh/4Zgz--

