From: David Given <dg@cowlark.com>
Subject: Re: [RFC] potential DR in handling of signed int and unholy mess
 in	our and gcc implementations
Date: Thu, 19 Mar 2009 02:33:00 +0000
Message-ID: <49C1AEDC.9030809@cowlark.com>
References: <20090319013358.GZ28946@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from b.painless.aaisp.net.uk ([81.187.30.52]:34198 "EHLO
	b.painless.aaisp.net.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751391AbZCSCzM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 18 Mar 2009 22:55:12 -0400
Received: from tiar.cowlark.co.uk ([81.187.191.218] helo=gate.cowlark.com)
	by b.painless.aaisp.net.uk with esmtp (Exim 4.69)
	(envelope-from <dg@cowlark.com>)
	id 1Lk84d-0006Y3-0i
	for linux-sparse@vger.kernel.org; Thu, 19 Mar 2009 02:33:35 +0000
Received: from [198.18.143.238] (localhost [127.0.0.1])
	by gate.cowlark.com (Postfix) with ESMTP id 66A7A2006F
	for <linux-sparse@vger.kernel.org>; Thu, 19 Mar 2009 02:33:22 +0000 (GMT)
In-Reply-To: <20090319013358.GZ28946@ZenIV.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Al Viro wrote:
[...]
> I'll probably go for gcc-like behaviour in sparse for now, unless som=
ebody
> sees a good reason not to.  At least that one is consistent and doesn=
't
> bring the shitloads of fun questions about behaviour of arithmetic co=
nversions,
> etc.
>=20
> Comments?

All I can really say to that is: ew.

I like bitfields and use them frequently, particularly for flags and
packing several small fields into a small space; luckily I've already
been pretty anally retentive about declaring them explicitly as 'signed=
'
or 'unsigned'.

- From the compiler perspective, Principle of Least Surprise would sugg=
est
doing the consistent thing, which as you say is gcc-like. OTOH from the
linter perspective I'd be *strongly* in favour of a warning if sparse
sees a problematic declaration. Bitfields are an area where signedness
suddenly becomes really important. (int i : 1, anyone?)

Are you submitting a bug report to the standards people?

- --
=E2=94=8C=E2=94=80=E2=94=80=E2=94=80 =EF=BD=84=EF=BD=87=EF=BC=A0=EF=BD=83=
=EF=BD=8F=EF=BD=97=EF=BD=8C=EF=BD=81=EF=BD=92=EF=BD=8B=EF=BC=8E=EF=BD=83=
=EF=BD=8F=EF=BD=8D =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80 http:/=
/www.cowlark.com =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
=E2=94=82
=E2=94=82 "All power corrupts, but we need electricity." --- Diana Wynn=
e Jones,
=E2=94=82 _Archer's Goon_
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFJwa7Zf9E0noFvlzgRAl6ZAKCb1Y9FNTkZRDQqvYH2URVZ7uw4uQCfeN8P
0Tif41kFR7FmUshV5PI7ogA=3D
=3DQHru
-----END PGP SIGNATURE-----
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
