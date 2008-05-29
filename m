From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH 0/9] context tracking updates
Date: Fri, 30 May 2008 01:04:14 +0200
Message-ID: <1212102254.10109.9.camel@johannes.berg>
References: <20080529085402.814224000@sipsolutions.net>
	 <1212100516.28403.152.camel@brick>
	 (sfid-20080530_003519_648056_2583259D)  <1212101102.10109.5.camel@johannes.berg>
	 <1212101465.28403.156.camel@brick> (sfid-20080530_005109_203270_E4619B0E)
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-2h0ovbndYsioVcvy8vMI"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from xc.sipsolutions.net ([83.246.72.84]:50805 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753846AbYE2XFc (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 29 May 2008 19:05:32 -0400
In-Reply-To: <1212101465.28403.156.camel@brick> (sfid-20080530_005109_203270_E4619B0E)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Harvey Harrison <harvey.harrison@gmail.com>
Cc: Josh Triplett <josh@freedesktop.org>, Philipp Reisner <philipp.reisner@linbit.com>, linux-sparse@vger.kernel.org


--=-2h0ovbndYsioVcvy8vMI
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> > What sort? Right now, it seems to go into a dead loop on
> > fs/minix/itree_v1.c for me?!
> >=20
>=20
> It's a problem introduced with 9/9 explicitly checking inlines.

It is, indeed, very odd. I don't see it right now though.

johannes

--=-2h0ovbndYsioVcvy8vMI
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUASD82baVg1VMiehFYAQKhHhAAorYJRu5xS1lz3gimwWTW5/MUtuu0MJRm
PRsec1zy3oBLJFqOiqydkAaEA7rTHLQUPbqmgyWTxYbYJoIBDV5Vos4R1vo2E56v
dorC4MTRQleBkYupVaaRWQvRgZ5A4IXcRZe5+RdFDRfBZbYGsFsqk/Bj/6nmogtn
MUjwK53DnAUirc0ghB2Uf45vY7sID8enscY/Hto/y3lWcxZnP+FaWYR34QxgDlfB
Lq/1wASCNrUN0i7IYdLV5ILNeJVCTUrCXyLldZ7VgIlOEhY735smSTu6ORw5XR+I
vI2/Ig2x6UmPZZY9HOseOuINR33QoZNUtRr+IMLcW6GFsYgrWvSySblGjek8vyuw
1mSPk78daDWYHhV0PgHxZ6FhICDHIzJAqobb/ehksrbw9PCWdqnnw6SyWR2t6bkR
S8BxDqIP1fpKrDVHVtBAOgH/LBPV4hZhz9x28apbb+H2B4V9ne14lnw/qqF7l4qe
1DlQbSs4OPOpJw3CIkjTblq34uSSQyuP/adfceDFlY+7k+UQfpdKkLZ9PcXRNaTd
GmVc0WxFiGV7bgNSJKxfh5yk0nLQk9qg8hvez7E0QFmVZk+MXYrZf8ElqnDJbKf7
gMB+BRBidjO+dx8tOQPJIFtaLNfmyUTxE8kwh3ebKz2OVVX/dL/HXXrBwr1Ka90M
qOHZXKy8rGI=
=hafZ
-----END PGP SIGNATURE-----

--=-2h0ovbndYsioVcvy8vMI--

