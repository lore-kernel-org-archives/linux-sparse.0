From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] allow context attribute on variables
Date: Sat, 26 Apr 2008 17:50:05 +0200
Message-ID: <1209225005.10943.15.camel@johannes.berg>
References: <1208955351.31429.81.camel@johannes.berg>
	 <48114059.6090103@freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-2wi6MN1SGTdHqosWoNoF"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from xc.sipsolutions.net ([83.246.72.84]:49688 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753903AbYDZPwa (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 26 Apr 2008 11:52:30 -0400
In-Reply-To: <48114059.6090103@freedesktop.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: linux-sparse <linux-sparse@vger.kernel.org>, Philipp Reisner <philipp.reisner@linbit.com>


--=-2wi6MN1SGTdHqosWoNoF
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> I like the idea of matching the existing attributes as closely as
> possible.  However, RCU provides a use case for distinguishing readers
> and writers: you might have a variable that you can read if you hold
> the RCU reader "lock", but you can only write if you hold a spinlock.

Oh good point. What way would you prefer? I can add another parameter to
the attribute, as in __attribute__((context(ctx,in,out,[read|write])))
(readwrite is implied), but that adds another parsing ambiguity. I have
just sent you another patch (was offline for a few days) that probably
won't apply without this, I'll fix this one and then do the other ones
on top.

johannes

--=-2wi6MN1SGTdHqosWoNoF
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUASBNPK6Vg1VMiehFYAQJV5A//Z7jJ3Cr3arS35V6eVDMt3/iXiydIUzex
V9NhNjjkM2CbR4jVjaii3zvxbdFPj3LLQO+axecgL3H6sXQgUGf372Ot3TXwXWYx
R4kfkSJiDsmh4cmoDEA6imlF5Q/KoqoEjXeYWhwwxI2IJzDqnlDrBA3meB4FCNzj
d77pYjxHb3Dm8Yx8MasEaaLez190PIjpj8HEcrk40Yv8H7ZTOpHfGjwa3sAikRK8
p+XyqIt5Dyb6M2wVgZbkL8n3Mh7qCl8RSx9kXkFX1a1Sk7SLKYTNeTCo9nRqqyLB
01n4Tv+2Ve+ElAIs5G1PerwMqvQO1Wcvs2KChkwsNeo2wZrar1xzuFJyPlVHYh1h
mV4a9ImLjGNnsQDnTrerrfLou73BIglqMSeuzuHWCqCXzQERwF45M4ocAG9YGRrU
e9Fs0HcdzNpaOJ5pRAY1qJ8ZMqhZ3rQ81k3QxYCYC7fGFHBZb/GLGIzKbK2UqSrk
J4ia6RbnfNaOSZsbnodzeihpnNpOklXySVL71ToOdvc+Qb+goQ8xkZKREfEHlrIE
82YSfPYUfNbNxeYqGqQ5SB33NDI7hlsX/wCi2VXnu9zhPQYOde/tu7xwLrJ8UFgn
+ErdrXf3a2SlVJf1MaHBtGOilxPJPyXe/dqeC0ZqLEkL8TaSGd83DOvI88Quq+BV
JT/H+uUmySo=
=CGwK
-----END PGP SIGNATURE-----

--=-2wi6MN1SGTdHqosWoNoF--

