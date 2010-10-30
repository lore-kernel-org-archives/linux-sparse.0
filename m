From: Sven Eckelmann <sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] "wrong count at exit" after spin_lock/_unlock pair
Date: Sat, 30 Oct 2010 21:05:18 +0200
Message-ID: <201010302105.19912.sven.eckelmann@gmx.de>
References: <201010281203.46522.sven.eckelmann@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1708996.RN1acd3PlT";
  protocol="application/pgp-signature";
  micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:33006 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1751931Ab0J3TDt (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sat, 30 Oct 2010 15:03:49 -0400
In-Reply-To: <201010281203.46522.sven.eckelmann@gmx.de>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

--nextPart1708996.RN1acd3PlT
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Sven Eckelmann wrote:
> Hi,
>=20
> I use sparse (cgcc) with different kernel versions to do some quick checks
> on the batman-adv kernel module. I noticed that my change from UP to SMP
> kernel generated some 'weird' warnings regarding a 'context imbalance'
> which I couldn't find, but went away when switching from spin_(un)lock to
> spin_(un)lock_bh - something which doesn't make sense in my mind.
>=20
> I am not quite sure if this is linux-headers or sparse related - so I try
> to post it here first. I choose 2.6.32 because it is the latest long
> stable kernel and will be used in by Debian Squeeze.

I looked a little more at the problem and it is not a real sparse problem. =
The=20
problem came with bb7bed082500179519c7caf0678ba3bed9752658 and and was=20
corrected with b97c4bc16734a2e597dac7f91ee9eb78f4aeef9a. So patching 2.6.32=
=20
and v2.6.33 by reverting bb7bed082500179519c7caf0678ba3bed9752658 is enough=
=20
for me.

Best regards,
	Sven

--nextPart1708996.RN1acd3PlT
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJMzGxvAAoJEF2HCgfBJntGNe0P/iugfHRd+2lwEQBHaKZZ/fio
8pQHeaVzLm+ZLfE2syhdRsBRZBVpb0Q7L1pQ9CnDULaIRcwDZbhLRiMp0vO7iVDx
/6myO9xonOykeOAd03z0IID2gLkrGxdkOui3UDic3P6nbEo2DdnSgLc7ZlK3WnJk
33hphLCNiNfBC/rmB7ljpLoJomtyAQSXGCAdVrasi+E8tZOGHXAu13ycBA6Ph6Ln
EbnYfYBec3hblXa9zOP/XE3lEhkV3AfFGwoY4IObEc514eBrcpDdvfkaF+He5KGh
PdS1Y0jsABEEPHADZjXaxFwdM9SQAf2y/dN0SmnzLczpf0sAqtCfFUg3N/qgDbEa
ut4T3h2gljUbN9nOWipXMoWOOBGLM98iaTdvIG2tqWjgk4UzxQzkJe/17l8RYwSl
uwst5PaPkbSnt7m60d02NNaVtiNNYK8BGJPXfW+EqB1x3WN8V9obyqViD+1+Z77T
ZBaea961mtXikFqrNMAgKXjX44IeJxk1EJXdSzyCgcbmNbE6T74g7dLo0ByzyPKY
SGecdPwKZn8mwE9FOnsiw16YvRAIM7EVz4SFhI0xDg3myNVfAddqT5naniEyuQ+J
IJ8LK9V/8ZjqMQCQ7w9Fg5KuqLu20Mvwtg/VyVC7RU2E2BE5xqV64MKXxjrcq/CE
DTWYdK5vpWnjgfPKAOp8
=xJ5J
-----END PGP SIGNATURE-----

--nextPart1708996.RN1acd3PlT--
