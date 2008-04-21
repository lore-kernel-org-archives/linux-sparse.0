From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH 1/3] make sparse keep its promise about context tracking
Date: Mon, 21 Apr 2008 12:22:31 -0700
Message-ID: <480CE977.5050006@freedesktop.org>
References: <20080410132519.049821000@sipsolutions.net>	 <20080410132617.720109000@sipsolutions.net>	 <200804101724.27382.philipp.reisner@linbit.com> <1207841454.13354.7.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC8084B182612E062E0C54B3C"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail3.sea5.speakeasy.net ([69.17.117.5]:45917 "EHLO
	mail3.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755998AbYDUTWQ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 21 Apr 2008 15:22:16 -0400
In-Reply-To: <1207841454.13354.7.camel@johannes.berg>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Philipp Reisner <philipp.reisner@linbit.com>, linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC8084B182612E062E0C54B3C
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Johannes Berg wrote:
>> I just have implemented nearly the same here. Hopefully Josh will
>> decide for one of these patches soon.
>=20
>> +int ident_equal(struct ident *ident1, struct ident *ident2)
>=20
>> +int expressions_equal(struct expression *expr1, struct expression *ex=
pr2)
>=20
> That code looks pretty nice, I guess I should look at getting that into=

> my version instead of just printing the identifier to a string.

I would love to see this work applied on top of the merged patches as wel=
l.

- Josh Triplett


--------------enigC8084B182612E062E0C54B3C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFIDOl3GJuZRtD+evsRApzyAJ47m2G3bN8Ogp/N7hXYwqwIK9JsnwCbB/7m
kvnks1hdzkSedKfzl2YGsR4=
=IgdX
-----END PGP SIGNATURE-----

--------------enigC8084B182612E062E0C54B3C--
