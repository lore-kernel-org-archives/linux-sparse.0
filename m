From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH 1/3] make sparse keep its promise about context tracking
Date: Fri, 11 Apr 2008 12:53:07 -0700
Message-ID: <47FFC1A3.9090803@freedesktop.org>
References: <20080410132519.049821000@sipsolutions.net> <200804101805.31854.philipp.reisner@linbit.com> <1207843925.13354.20.camel@johannes.berg> <200804102321.31681.philipp.reisner@linbit.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig7BBA488E938C32F89655F8FE"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail3.sea5.speakeasy.net ([69.17.117.5]:54214 "EHLO
	mail3.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757756AbYDKTxF (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 11 Apr 2008 15:53:05 -0400
In-Reply-To: <200804102321.31681.philipp.reisner@linbit.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7BBA488E938C32F89655F8FE
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philipp Reisner wrote:
>> Anyhow, I don't really care which patch gets chosen.
>=20
> Nor do I really care. I just hope that there is some reaction from Josh=

> that indicates how he wishes to continue with that toppic...
> I am also ready to do further work in this area.

Definitely interested in the patches, just spoiled for choice.
However, having now reviewed the various proposals, I think I will
accept Johannes Berg's patches to support his corresponding proposed
changes in Linux's include/linux/compiler.h.

- Josh Triplett


--------------enig7BBA488E938C32F89655F8FE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFH/8GjGJuZRtD+evsRAjYPAJwIst3JmjPHdzR/jO/zu1tRR5Y/vQCgitq8
O/OGBWS4HUiSYagfDaTLMhA=
=5xbH
-----END PGP SIGNATURE-----

--------------enig7BBA488E938C32F89655F8FE--
