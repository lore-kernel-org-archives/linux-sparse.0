From: Josh Triplett <josh@freedesktop.org>
Subject: Re: Bogus sparse warning?
Date: Tue, 13 Feb 2007 00:30:58 -0800
Message-ID: <45D17742.4010809@freedesktop.org>
References: <780B1941-729E-47CB-9716-578AD8D25302@cam.ac.uk> <Pine.LNX.4.64.0702121018270.8424@woody.linux-foundation.org> <20070212191434.GA1041@chrisli.org> <Pine.LNX.4.64.0702121147170.8424@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig421489E4EFBD2689D36FCF20"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail6.sea5.speakeasy.net ([69.17.117.8]:46270 "EHLO
	mail6.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188AbXBMIbA (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 13 Feb 2007 03:31:00 -0500
In-Reply-To: <Pine.LNX.4.64.0702121147170.8424@woody.linux-foundation.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christopher Li <sparse@chrisli.org>, Anton Altaparmakov <aia21@cam.ac.uk>, linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig421489E4EFBD2689D36FCF20
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Linus Torvalds wrote:
> On Mon, 12 Feb 2007, Christopher Li wrote:
>> On Mon, Feb 12, 2007 at 10:28:19AM -0800, Linus Torvalds wrote:
>>> (It is perfectly proper to have a typedef that is actually of a funct=
ion=20
>>> type, so this looks like a sparse bug regardless, it looks just as if=
 we=20
>>> don't turn a function type into a function pointer type when we see i=
t as=20
>>> an argument in the declaration).
>> Yes, we does, in examine_fn_arguments(). But not correctly inherent th=
e attribute bits.
>=20
> Ahh.=20
>=20
>> I think this patch should fix it, I haven't try it myself on this bug =
yet.
>> It works on a different test case "function vs function ptr".
>> It has been posted to the list before. It is in my series as well.
>=20
> This looks good. Ack.  Josh?

See my response to Christopher later in the thread; his revised patch app=
ears
to solve the problem fully.

> The only thing that I reacted to is that maybe we should change the
>=20
> 	s->ctype.modifiers =3D 0;
>=20
> a few lines down into a
>=20
> 	s->ctype.modifiers &=3D ~MOD_PTRINHERIT;
>=20
> or something?

Christopher's revised patch does exactly that.

- Josh Triplett


--------------enig421489E4EFBD2689D36FCF20
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF0XdCGJuZRtD+evsRAob+AKCdiPYxElwEzacnUdjA99bxpSCFLwCffafs
KwRuOHH710o9Tw7ldHbGLi0=
=blZa
-----END PGP SIGNATURE-----

--------------enig421489E4EFBD2689D36FCF20--
