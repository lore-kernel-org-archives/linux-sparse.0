From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH 1/3] make sparse keep its promise about context tracking
Date: Mon, 21 Apr 2008 21:37:50 +0200
Message-ID: <1208806670.26186.138.camel@johannes.berg>
References: <20080410132519.049821000@sipsolutions.net>
	 <200804101746.14457.philipp.reisner@linbit.com>
	 <1207842687.13354.12.camel@johannes.berg>
	 <200804101805.31854.philipp.reisner@linbit.com>
	 <480CEC51.1000907@freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-pnNKTUH7tmhOFbF2TQEK"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from xc.sipsolutions.net ([83.246.72.84]:53635 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756038AbYDUTi0 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 21 Apr 2008 15:38:26 -0400
In-Reply-To: <480CEC51.1000907@freedesktop.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: Philipp Reisner <philipp.reisner@linbit.com>, linux-sparse@vger.kernel.org


--=-pnNKTUH7tmhOFbF2TQEK
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> I would *love* to see this work applied on top of the patches I
> applied from Johannes.  I really want the ability to mark a variable
> or struct field as requiring a context to access.
>=20
> I would probably call this new attribute something like
> "data_context".  Also, I'd prefer an explicit way of saying "no
> maximum context", rather than the hack of using a large number.
>=20
> I hestiate to introduce a third semantic for a pair of numbers
> describing a context.  The context attribute uses in and out contexts,
> __context__ uses a delta and a required minimum, and this proposed
> attribute uses a minimum and a maximum.

I have a fairly simple patch on top of my work for this
http://johannes.sipsolutions.net/patches/sparse/all/LATEST/001-context-on-v=
ars.patch

however, it doesn't really work with struct variables...

johannes

--=-pnNKTUH7tmhOFbF2TQEK
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUASAztDaVg1VMiehFYAQKMOBAAmSYPr/sxxDK77MbYaVR3M1nadRVhMih+
0EU2GOlmEtORtovek2lnQ6YwABH9zSV+LIh1ahV+O7wCcYCrd3fpT0QbHpXtXob5
+evzmOtCdJoTw1urKE0YwEFsoc8mehULLUPi7ZvLlLBW1AXsXy1rAXZ0Hc0Bb4GE
jCoxO8FqGzWmVM1ddiOAgi4P77L/6pD+72v9J5nIy0ZMxH6EhAA5Fg0mx1qa5tPD
3pPpQ+1a2c3Z3rdkw9PUf5/i2q2YPHVfmjNeOu4NGqiPYVuz5m8JFZ0vzhFT20XT
abseRG96MYC2vhQ4Pms86Mt6hQN+zxGA6nTJUb0TlfacM651LadvZ623jev/DMrF
Y17kXEPXVa1zbpDMfMbnM3whK/wuziibMRqdFCOahFVp1aPrKVtjRjGqCm9E2qa1
joSVenlvBs3nnxHjTQistUNEgKPUE7cZxXhd4Xg54Kp2CFbkBJVrjIuEunZsLx7M
rWVw+YM/gR7gtYVLwO03si3+4tk58puxvCP04pqTBJp4LYYx9ARD1p6+MFo9c3QA
TlokKeBggmbdITL+7ci7JgM1O/IuQ9dCLwXeW0pt3QzIi7FA2HHgworM2HfRV/UJ
9md9AHH/liRuseW24QqKkPJ4XKO+fZRTMg6+hWevjN0J4qWpXGwlcunPUXGBngre
GXTA+h+zsh4=
=GU4J
-----END PGP SIGNATURE-----

--=-pnNKTUH7tmhOFbF2TQEK--

