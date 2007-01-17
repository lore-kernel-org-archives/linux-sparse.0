From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH 3] Add instruction to pseudo user tracking.
Date: Tue, 16 Jan 2007 20:48:21 -0800
Message-ID: <45ADAA95.4010202@freedesktop.org>
References: <20070117023616.GC962@chrisli.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig27B1237A61A6E700918B985C"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail6.sea5.speakeasy.net ([69.17.117.8]:48932 "EHLO
	mail6.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751786AbXAQEsX (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 16 Jan 2007 23:48:23 -0500
In-Reply-To: <20070117023616.GC962@chrisli.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig27B1237A61A6E700918B985C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Christopher Li wrote:
> The current way of tracking pseudo register user is by
> keeping a list of the address of the pseudo_t member.
> This address can be in part of the instruction member, the
> worse case is in the argument list of the call instruction.
>=20
> As the comment for address_taken() said, using the container
> to get instruction pointer is wrong. It use to work with instruction
> that relate to symbol address. But that is not true any more. Even
> worse, it is very hard to track the pseudo usage other than symbol
> address. The only reason symbol address used to works for call instruct=
ion
> is because call instruction did not directly use the symbol address.
>=20
> I bit the bullet and just add the instruction pointer to pair with
> the pseudo user pointer. So it will work with the case that the
> user instruction is call as well.

Good call; merged.  Thanks.

- Josh Triplett



--------------enig27B1237A61A6E700918B985C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFraqVGJuZRtD+evsRAlh0AJ9Un+x/psiHx4lDXdtvxjeM80DDSACeIG7X
kGoOPIJ1IUZ5TVPtmqAVO8Q=
=ydMI
-----END PGP SIGNATURE-----

--------------enig27B1237A61A6E700918B985C--
