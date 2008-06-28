From: David Given <dg@cowlark.com>
Subject: Re: Pointer arithmetic error
Date: Sat, 28 Jun 2008 01:23:48 +0100
Message-ID: <48658494.9040708@cowlark.com>
References: <486428D7.8080603@cowlark.com> <48643191.307@cowlark.com>	 <1214560196.20755.73.camel@tara.firmix.at>	 <4864C710.8000208@cowlark.com>	 <1214565644.20755.80.camel@tara.firmix.at>	 <4864F31C.3090606@cowlark.com>	 <1214577926.20755.98.camel@tara.firmix.at>	 <48650B35.5040505@cowlark.com>	 <70318cbf0806271101n2f9a65buc72764ee97f9ced9@mail.gmail.com>	 <486578A9.7000900@cowlark.com> <70318cbf0806271717v42f4b1e0ocbdf9498b1417878@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB0B5C28AC7A38C26DE4BF1C0"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from a.painless.aaisp.net.uk ([81.187.30.51]:44097 "EHLO
	a.painless.aaisp.net.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752626AbYF1AXy (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 27 Jun 2008 20:23:54 -0400
Received: from tiar.cowlark.co.uk ([81.187.191.218] helo=gate.cowlark.com)
	by a.painless.aaisp.net.uk with esmtp (Exim 4.69)
	(envelope-from <dg@cowlark.com>)
	id 1KCOEu-0004EY-Lv
	for linux-sparse@vger.kernel.org; Sat, 28 Jun 2008 01:24:28 +0100
Received: from [10.0.0.5] (localhost [127.0.0.1])
	by gate.cowlark.com (Postfix) with ESMTP id 915DC2008D
	for <linux-sparse@vger.kernel.org>; Sat, 28 Jun 2008 01:23:50 +0100 (BST)
In-Reply-To: <70318cbf0806271717v42f4b1e0ocbdf9498b1417878@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB0B5C28AC7A38C26DE4BF1C0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Christopher Li wrote:
> Your patch is white space damaged.
>=20
> While you are there, you might want to consider macro
>=20
> bits_to_byte(x)
> byte_to_bits(x)

Yes, that's a good idea. I'll redo it.

(What's the right way to generate the patch? I made that with 'git show
> diff', which I thought should do the right thing.)

--=20
=E2=94=8C=E2=94=80=E2=94=80=E2=94=80 =EF=BD=84=EF=BD=87=EF=BC=A0=EF=BD=83=
=EF=BD=8F=EF=BD=97=EF=BD=8C=EF=BD=81=EF=BD=92=EF=BD=8B=EF=BC=8E=EF=BD=83=EF=
=BD=8F=EF=BD=8D =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80 http://www.=
cowlark.com =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
=E2=94=82 "I have always wished for my computer to be as easy to use as m=
y
=E2=94=82 telephone; my wish has come true because I can no longer figure=
 out
=E2=94=82 how to use my telephone." --- Bjarne Stroustrup


--------------enigB0B5C28AC7A38C26DE4BF1C0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFIZYSUf9E0noFvlzgRAuxHAKDKfFZTH2fKs4MP9/GEhfOaOc2JvwCfQoc3
IziSVHTvJklDL9zoY/+PSXM=
=nlI8
-----END PGP SIGNATURE-----

--------------enigB0B5C28AC7A38C26DE4BF1C0--
