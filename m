From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH] fix bug in context tracking code
Date: Thu, 24 Apr 2008 19:34:39 -0700
Message-ID: <4811433F.6010306@freedesktop.org>
References: <1208946289.31429.66.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig92B770EF6F397098036D0F54"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail8.sea5.speakeasy.net ([69.17.117.10]:55432 "EHLO
	mail8.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755825AbYDYCef (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 24 Apr 2008 22:34:35 -0400
In-Reply-To: <1208946289.31429.66.camel@johannes.berg>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-sparse <linux-sparse@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig92B770EF6F397098036D0F54
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Johannes Berg wrote:
> My optimisation to avoid recursion into BBs when checking contexts
> lead to a failure in a case like this:
>=20
>     static int warn_conditional(void)
>     {
>         if (condition)
>             return 0;
>=20
>         a();
>         if (condition =3D=3D 0)
>             return 1;
>         r();
>         return 0;
>     }
>=20
> because some blocks are called with different contexts and thus
> need to be checked multiple times.
>=20
> The obvious fix would be to decrease the recursion depth at the
> end of the BB check function, but that, while correct, leads to
> extremely long sparse runtimes on somewhat complex functions.
> Thus, this patch also makes sparse cache which contexts it has
> checked a block in and avoid the re-checking in that case.
>=20
> Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

Applied and pushed; thanks!

- Josh Triplett


--------------enig92B770EF6F397098036D0F54
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFIEUM/GJuZRtD+evsRAk7KAJ4soCYu9Udp1i7hnQJF4j3suCDJcgCgntzB
JAlnlGYz4m4/aw7huV8Opuw=
=thbr
-----END PGP SIGNATURE-----

--------------enig92B770EF6F397098036D0F54--
