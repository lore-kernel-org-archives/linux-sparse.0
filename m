From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH 1/2] Fix cast instruction generation
Date: Thu, 24 Apr 2008 19:24:42 -0700
Message-ID: <481140EA.9040803@freedesktop.org>
References: <20080424193856.14737.16718.stgit@warthog.procyon.org.uk> <alpine.LFD.1.10.0804241248290.2779@woody.linux-foundation.org> <alpine.LFD.1.10.0804241443460.2779@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigAD64FE61CFD6B968AB8ED8E0"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail7.sea5.speakeasy.net ([69.17.117.9]:39469 "EHLO
	mail7.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755742AbYDYCYj (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 24 Apr 2008 22:24:39 -0400
In-Reply-To: <alpine.LFD.1.10.0804241443460.2779@woody.linux-foundation.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Howells <dhowells@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAD64FE61CFD6B968AB8ED8E0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Linus Torvalds wrote:
> From: Linus Torvalds <torvalds@woody.linux-foundation.org>
> Date: Thu, 24 Apr 2008 14:45:43 -0700
>=20
> Whether it's a sign-extending cast or not depends on the source
> of the cast, not destination. The final size of the cast depends
> on the destination, of course.
>=20
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> ---
> In thread "[PATCH] RxRPC: Fix a regression in the RXKAD security module=
"
>=20
> On Thu, 24 Apr 2008, Linus Torvalds wrote:
>> Ok, that looks stupid, and should even have had a warning (shifting a =
u16=20
>> right by 16 should warn about it being pointless, but doesn't, because=
 the=20
>> compiler quietly expands it to "int" in the meantime).
>>
>> Hmm. I could do something to sparse that warns about that too.=20
>=20
> Something along the lines of this?

Applied and pushed.

- Josh Triplett



--------------enigAD64FE61CFD6B968AB8ED8E0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFIEUDqGJuZRtD+evsRAteZAJwMj+WzOvF2ubyeUoCqnrjnIj5HdwCgvXCq
6JWxCibyBj3sOdq0XwTxJME=
=w/tO
-----END PGP SIGNATURE-----

--------------enigAD64FE61CFD6B968AB8ED8E0--
