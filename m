From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] ignore __cold__ attribute
Date: Tue, 22 Apr 2008 15:25:06 +0200
Message-ID: <1208870706.31429.23.camel@johannes.berg>
References: <1208860883.31429.8.camel@johannes.berg>
	 <20080422090739.2izftuclwocs80o4-cebfxv@fcnzpbc.arg@webmail.spamcop.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-BSKhGHYnZVVfgwfOxaaU"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from xc.sipsolutions.net ([83.246.72.84]:49397 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753757AbYDVNZp (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 22 Apr 2008 09:25:45 -0400
In-Reply-To: <20080422090739.2izftuclwocs80o4-cebfxv@fcnzpbc.arg@webmail.spamcop.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
Cc: Josh Triplett <josh@freedesktop.org>, linux-sparse <linux-sparse@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Woodhouse <dwmw2@infradead.org>


--=-BSKhGHYnZVVfgwfOxaaU
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2008-04-22 at 09:07 -0400, Pavel Roskin wrote:
> Quoting Johannes Berg <johannes@sipsolutions.net>:
>=20
> > This is a new attribute in gcc 4.3, which when used and sparse is
> > compiled with gcc 4.3 leads to unknown attribute errors. Ignore it.
>=20
> According to =20
> http://gcc.gnu.org/onlinedocs/gcc/Function-Attributes.html, the new =20
> attributes are "cold" and "hot".  I think we need them ignored both =20
> with and without underscores.
>=20
> The attributes indicate whether the function is likely to be executed, =20
> and thus affect optimization.  There is nothing useful for sparse in =20
> that information.

*Shrug*. I just wanted the kernel to work again and failed (in about 20
minutes of searching) to find a changelog for gcc mentioning this so
gave up and just added the one that the kernel uses. Want to amend the
patch?

johannes

--=-BSKhGHYnZVVfgwfOxaaU
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUASA3nMaVg1VMiehFYAQKIpQ//eAfFup/N1KwrYea5bKqXWTLTIFevDhWF
vCBVsrWEzhKaTrIfBGMA79WQzBQsz8NG3pJAJw0/nsfjYHIyT+WrL7dhmSWwxP1m
ZiO13Elw51aA4HBxS7H/zy5blyTmHf+TBF6z7saPBAYVht6To07SKRX3bhBk9eeb
3WUYTNwujyFpaP8pgI67oqHsRWdKTCV5j/u7uQ9rcMwgV2jIqj7uS9A+m6bwtEHf
JfY8Sbp1kVd6n9ctRgym5zDgBFjCk9wNGGMeY9N/jy5KzzOg5suWKxF42HJp4g+2
RIU9KqmRfTFpWBX2dQC1REmA4VU212/OPOX8fZ+Yqr8dtrU+FdHyHy/9/vuWjVA1
99fAlt14eisuUpW/VwUZMApDRyF9SbuVVgyeo9hrqrBtiyZflmSX5+ygj6o2kkyP
e36ksCBq0284v5/kAeSRN94DCo7U5RaldHab2C/rsCZ5tbFcy/94OWDt/SQNb37o
VmXVwH3ZZwXyFc8sd9ozz7EPyRV4/FHfF6Up85oJAqWozR9g0HmugULoZQv6yJiy
YxPpRGDx3bcLBW1hbAW9EW382voS+gvJGoTr5XzgndrIG6MRUhmHy6/EJHZsCytd
QLqOFNI8ewnNct1AX6Ds/tLzz4sNmb6UVfA2vKM1+IiN2DMpsX5F3D6sJ3VoW5LX
mNtFakewgOE=
=wTM1
-----END PGP SIGNATURE-----

--=-BSKhGHYnZVVfgwfOxaaU--

