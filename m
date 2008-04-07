From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH] cgcc: handle ppc arch
Date: Mon, 07 Apr 2008 05:11:26 -0700
Message-ID: <47FA0F6E.1030001@freedesktop.org>
References: <1207152034.3957.15.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA42DC90CC654AB2D6EF0BA7F"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail7.sea5.speakeasy.net ([69.17.117.9]:37850 "EHLO
	mail7.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753842AbYDGMLP (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 7 Apr 2008 08:11:15 -0400
In-Reply-To: <1207152034.3957.15.camel@johannes.berg>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-sparse <linux-sparse@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA42DC90CC654AB2D6EF0BA7F
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Johannes Berg wrote:
> I'm not sure this is exactly the right thing to do because I'm
> unfamiliar with the default CFLAGS, but it seems to at least make it
> mostly work on powerpc.
>=20
> Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
> ---
> In particular, I don't know what that _STRING_ARCH_unaligned thing is
> and whether I should define it to 0 or 1 (and why I need it at all.)

"mostly work" seems like an improvement on "doesn't work"; I can always
apply another patch later to make it more correct.  Applied and pushed.

- Josh Triplett



--------------enigA42DC90CC654AB2D6EF0BA7F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFH+g9uGJuZRtD+evsRAlvPAJ40UrDUrpLk5UbzpeQISZl0wkX/MQCfY0ie
Zc+Nt+FQiTASAQCS2keLaw4=
=6258
-----END PGP SIGNATURE-----

--------------enigA42DC90CC654AB2D6EF0BA7F--
