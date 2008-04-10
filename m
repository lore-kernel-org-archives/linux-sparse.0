From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH 1/3] make sparse keep its promise about context tracking
Date: Thu, 10 Apr 2008 17:51:27 +0200
Message-ID: <1207842687.13354.12.camel@johannes.berg>
References: <20080410132519.049821000@sipsolutions.net>
	 <200804101724.27382.philipp.reisner@linbit.com>
	 <1207841454.13354.7.camel@johannes.berg>
	 <200804101746.14457.philipp.reisner@linbit.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-s1dvAihyHdHiAkbdztuv"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from crystal.sipsolutions.net ([195.210.38.204]:47317 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756362AbYDJPvl (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 10 Apr 2008 11:51:41 -0400
In-Reply-To: <200804101746.14457.philipp.reisner@linbit.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Josh Triplett <josh@freedesktop.org>, linux-sparse@vger.kernel.org


--=-s1dvAihyHdHiAkbdztuv
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> I also worked on that part, although I have to admitt that I did not
> got that part of the manpage. Instead I invented the require_context
> attribute.

Heh.

> Here is the second patch. It applies on top of the first one...

I don't really have time to look through it right now, sorry.

> I hope that we get the good ideas of our two works combined and
> accepted into sparse...

That would be good :)


> +# define __cond_lock(x,c)	((c) ? ({ __acquire(x); 1; }) : 0)
> +# define __protected_by(x)       __attribute__((require_context(x,1,1,"r=
dwr")))
> +# define __protected_read_by(x)  __attribute__((require_context(x,1,1,"r=
ead")))
> +# define __protected_write_by(x) __attribute__((require_context(x,1,1,"w=
rite")))
> +# define __must_hold(x)       __attribute__((context(x,1,1), require_con=
text(x,1,1,"call")))

What's this "rdwr" etc. for? And "call"? Also, how are you planning to
handle nested contexts, where 1,1 doesn't cut it any >0,>0 is really
more like what we need?

johannes

--=-s1dvAihyHdHiAkbdztuv
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUAR/43fqVg1VMiehFYAQIs9Q/8CsdM6IEoG9QdGg2qH5HeeEeE1p74QriB
rR96DiXnsDpSTcN6gNf//1F6UacB+c9xV4/PQTpkkNBaSfE8l3TJn04ElCmCwoGw
XNVNv3z7YzahII/3scm62jq4kCdMUMNi3zWU3nVELfihsckUjN3NAXvBco3RD1i2
y9ps456NyI8zZRh9XrOqkjuBMSAAx7SoD9kY2C6Q3QdjL1TJxTzt87HAfKQqS2hZ
ULLDi/rpxNjxlApk24D3Fm3XLTUSuYAlNj6x6yXOcMkIklZTEJ1YF+wjjxttsu05
+n0kzWtI2qW0YjApylYk0pUlpOgjqrl2uI0HHgG1ODo0/BtD6pu1Ah9b5TsMYWyl
B9n/F2rCrOJA6NzwusOE7J0f4k9HWO8dBroQ/DPWvcT5oUK5x0OSB8fnHMxkFD5V
tZgT4LkUTBd7EyRQwCpxvJ4NA0+LdorfU2lTE3RiwPEfpiOWkY7FTfnvkCZ+qUuk
XTsmc2kAxOSxt+1bhbHtBvKOH4+Q2Y+uAX5kQf35TGzFAyKbyRHKuHJwOMnMJFvl
Q2jIcxwoLoJOAsxYLrYVuJ0QGAoHfa8BzGv6MldyN1U4qByShs5Udh5lH7rWnMP2
cIuYGC2zE4dYYyTBVEvNx1TVfsQVWl1hv+3dBQa2GuQw2T/EAi12/I3m7Tb9pTpt
2lUFe6CLtmk=
=q96t
-----END PGP SIGNATURE-----

--=-s1dvAihyHdHiAkbdztuv--

