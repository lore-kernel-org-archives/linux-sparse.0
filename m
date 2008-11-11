From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Hard-coded gcc header path
Date: Tue, 11 Nov 2008 15:01:46 +0100
Message-ID: <1226412106.4478.5.camel@johannes.berg>
References: <20081111135816.GA25986@logfs.org>
	 (sfid-20081111_145831_071332_94D76BE4)
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-8LccJ1ysjvJ75Z+/3YKx"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from xc.sipsolutions.net ([83.246.72.84]:42991 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755837AbYKKOBu (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 11 Nov 2008 09:01:50 -0500
In-Reply-To: <20081111135816.GA25986@logfs.org> (sfid-20081111_145831_071332_94D76BE4)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@logfs.org>
Cc: linux-sparse@vger.kernel.org, 505177@bugs.debian.org


--=-8LccJ1ysjvJ75Z+/3YKx
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 2008-11-11 at 14:58 +0100, J=C3=B6rn Engel wrote:

> So why does sparse try 4.1.2 and not 4.1.3 or 4.3.2 or any other
> variant?
> joern@Galway:/usr/src/kernel/sparse$ cat pre-process.h
> #define GCC_INTERNAL_INCLUDE "/usr/lib/gcc/i486-linux-gnu/4.1.2/include"
>=20
> Ah, it is hard-coding the path.

Well, sort of. The patch is actually determined at sparse build time, so
right now sparse requires you to build it against the same compiler that
you are currently using. If you rebuild sparse with your shiny new
compiler you'll notice that it'll end up with a different path in
pre-process.h.

johannes

--=-8LccJ1ysjvJ75Z+/3YKx
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIcBAABAgAGBQJJGZBHAAoJEKVg1VMiehFYRKkQAJOTfLTKNR766ePFE50/CpiC
L1K7hvhzvRJYmvhZ0nKOoAB5d4Xw1yrl1O1/3Nrh4LLui3pMFyMQx9A42QSVrhuI
iXDfe9l6UIMlDQAmTlfhdRAnsTsWND0MW/4XcVkEHUGJ23iu0quvq0OsNr/jbDRA
R6AW5RlH2dEmdOk0blTueg9yt6hPH34fl5Dn8zo2Qx3SUDCl1cbxIruGGj1aQYP8
ZsXlAnyum9S305S5yNa8rE3NrnI8DJITtN/igtS/Hgc8pmVZWfYAlRvgyV6oL6OY
zMYu4ixZHD7mAUUGlWNHQMFRU0+FXd+3gXUEqfWfdrQRia9Qo3oeHaTvIZiSVsvn
otaFrAbWtgm52blaD/8jGm4rSCSnKpe8ZrWEy2cj2z6NQT4ir+yo/kvbEU5Owvlc
BK5Bjf0u05SaLdTzbZreWmKBvB+pRzjl5Iie16rcouxYSyWJ6Dx36MCKWrfPWwWI
6Y6d/WQ2zGVEiOvP0fxdBh3tjIYXcnJKIQkTyedR1/p2TywfYVGMEhQE2HKRC5JY
TG4iTnFh6OMWTxLOemQOfIAXWqgGylYI0ZZDXqjay0UI9ZWcqYbmWFhAkyjmPxLn
fBtcLRNHdR6Jb3AKU8JxRo37gDbRGQ59tQ2qDwvNb6JBwsctPFz157cUeEvIwMqj
d6QqBtXHxJ5kqJTeYIPl
=wAef
-----END PGP SIGNATURE-----

--=-8LccJ1ysjvJ75Z+/3YKx--

