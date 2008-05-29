From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH 0/9] context tracking updates
Date: Fri, 30 May 2008 01:06:54 +0200
Message-ID: <1212102414.10109.11.camel@johannes.berg>
References: <20080529085402.814224000@sipsolutions.net>
	 <1212100516.28403.152.camel@brick>
	 (sfid-20080530_003519_648056_2583259D)  <1212101102.10109.5.camel@johannes.berg>
	 <1212101465.28403.156.camel@brick>
	 (sfid-20080530_005109_203270_E4619B0E)  <1212101645.10109.7.camel@johannes.berg>
	 <1212102199.4265.46.camel@dv>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-DXZemLaSNYkdO7mIGZUf"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from xc.sipsolutions.net ([83.246.72.84]:47975 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753860AbYE2XIE (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 29 May 2008 19:08:04 -0400
In-Reply-To: <1212102199.4265.46.camel@dv>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
Cc: Harvey Harrison <harvey.harrison@gmail.com>, Josh Triplett <josh@freedesktop.org>, Philipp Reisner <philipp.reisner@linbit.com>, linux-sparse@vger.kernel.org


--=-DXZemLaSNYkdO7mIGZUf
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2008-05-29 at 19:03 -0400, Pavel Roskin wrote:
> On Fri, 2008-05-30 at 00:54 +0200, Johannes Berg wrote:
> > > > What sort? Right now, it seems to go into a dead loop on
> > > > fs/minix/itree_v1.c for me?!
> > > >=20
> > >=20
> > > It's a problem introduced with 9/9 explicitly checking inlines.
> >=20
> > Cool, thanks, I'm just looking at it.
>=20
> You may want to look at this:
> http://marc.info/?t=3D120287346100007&r=3D1&w=3D2
> http://marc.info/?l=3Dlinux-sparse&m=3D120370800715845&w=3D2
>=20
> It was happening in ndiswrapper because a typedef was forcing an inline
> function to be linearized twice.

Ah, thanks for the pointers, that might be the case. Wonder why it's
being linearized twice, and I see it even without the linearization I
force...? will take a look tomorrow.

johannes

--=-DXZemLaSNYkdO7mIGZUf
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUASD83DaVg1VMiehFYAQKAUA//bjyQSlx/qE/5uOUiescgesIiiVr0zp4A
MNY5tjfRjjnJHTA7rJTbjautgtQ6gWnTr6c8hoex3+Er6QqfO1BK4/wioxpiuImx
jA221lEGI4p/6buz8pstjnZjmucWu7sXUfiFTb7Kj92egJ8qghTZwWV77/fEYIJe
j77GrelvmAZKiSqmFLUOxJcQA6QUix+OOIQgCJBul5pKst3qebS7lP0BxGgwEb0p
u2Kmzz3yjdG8q9f/aWIpYwVUmJE0LqeIzwATE+CLWKQKd9h+cINGgdeC+4YqSzNG
txw02Mdk8Ic/bQoF0zKAJ+o4zfPJNfmatySKhyc8cr9TJqwbzZMp+oEO6ODDPly8
44fL51qo6nEslf/atSS6KShUZE3kKooHfKcbbH+nUpBfbPx3MwCLERk6gmUf+/0E
eS3Ox7WrR1su6IF/W5b4VSfcpySQ6AlFUwhJx7jN2epn1G6xw0ixy5pDW3BSkLY+
LE9l/DqOfJz7A0aJjNZIKnfZIF2loF+qykjk3NY7T6NELTjhRGQ5Xv8139pgcj1x
RRR5G6SOoa6JkiguXS+IRQx69LLpujXkrP9SBj77Sjlbca8VdLBoQjL33ZrijlX9
QJxnWdYCEMeWq21grq53V8MGVKVdlscRmEYzd2e+NmCONrfmjW4L+oGhDnpQGk2c
q5WnjH3w4G4=
=mFJ0
-----END PGP SIGNATURE-----

--=-DXZemLaSNYkdO7mIGZUf--

