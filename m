From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH 1/3] make sparse keep its promise about context tracking
Date: Fri, 18 Apr 2008 14:35:10 +0200
Message-ID: <1208522110.4848.19.camel@johannes.berg>
References: <20080410132519.049821000@sipsolutions.net>
	 <200804101805.31854.philipp.reisner@linbit.com>
	 <1207843925.13354.20.camel@johannes.berg>
	 <200804102321.31681.philipp.reisner@linbit.com>
	 <47FFC1A3.9090803@freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-DBMktwqnn75NBF85Zsyh"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from crystal.sipsolutions.net ([195.210.38.204]:54145 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756871AbYDRMf1 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 18 Apr 2008 08:35:27 -0400
In-Reply-To: <47FFC1A3.9090803@freedesktop.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: Philipp Reisner <philipp.reisner@linbit.com>, linux-sparse@vger.kernel.org


--=-DBMktwqnn75NBF85Zsyh
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2008-04-11 at 12:53 -0700, Josh Triplett wrote:
> Philipp Reisner wrote:
> >> Anyhow, I don't really care which patch gets chosen.
> >=20
> > Nor do I really care. I just hope that there is some reaction from Josh
> > that indicates how he wishes to continue with that toppic...
> > I am also ready to do further work in this area.
>=20
> Definitely interested in the patches, just spoiled for choice.
> However, having now reviewed the various proposals, I think I will
> accept Johannes Berg's patches to support his corresponding proposed
> changes in Linux's include/linux/compiler.h.

Do you want me to fold the later cleanup patches into the first
two/three?

johannes

--=-DBMktwqnn75NBF85Zsyh
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUASAiVfaVg1VMiehFYAQKhEA/9ETC47CQKioAZtoTc1QeuW6VjyCM20hDe
oLgCOst1wYmb/dqZPo6LxGxdlDFdHicckTFZB9m41MHnT1HK2ZBWNLJpHNWBVm/F
xac2ykpJafXOGRuHYLJEHt3eEs/aZI5527WNYKqfzruLJjGO32Nuol4Y/nV3tOh7
MZCTeChpK4tSeLsD1ROMo/f3X4IJU3He4eMlu7Yq5P/KXsQMWF83wXyE55XOaCFJ
R5p27B1Pk5tIV6rJ+3j+UD6S46QXjGjbX8PKotonE1RndZrlg6q8+9dkTBPj8Yjw
khE7OXytAoXM60FQhKoFNfrlIwa4JaiFYHm2JTMlqD7gmR4Q5SMZJodh6Op3gMRx
quvIH6LXQ25pnmo9xa50Ee4vvvYxyv/YIbmo+UZUeK8aN8NtNYt+OM07whGd/gfu
LDNXF5sL+k9KF2ejgYwn4CozUTXYFQe6dtsEz53OU4WB2bBNoaYtHmfha7DW+w18
SpL+cUUcMSraOvd8GyQ5wGkS5BycW2IM76CjGjJBek0Hoj2DII0K+FUauEyZQbSi
D72MZ00hnRN2xBs7X4T6pLQm/nAKWRHpXZrBk55jEfmbLTeYeK3k8w1wcX6l/AO2
0uWgwAjIv+SSdlkNnS4+BWdAPk6a/sw+PzlqCFmxfpkH7UbYe0eu8M+0mR2YOfR0
nper2URk1Ck=
=UH2S
-----END PGP SIGNATURE-----

--=-DBMktwqnn75NBF85Zsyh--

