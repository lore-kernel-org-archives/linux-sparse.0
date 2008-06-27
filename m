From: David Given <dg@cowlark.com>
Subject: Re: Pointer arithmetic error
Date: Fri, 27 Jun 2008 01:17:21 +0100
Message-ID: <48643191.307@cowlark.com>
References: <486428D7.8080603@cowlark.com> <70318cbf0806261651u7a163d54m4d100012bce5db49@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig3CEFBE9EBC08461C290E6C57"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from c.painless.aaisp.net.uk ([81.187.30.53]:58626 "EHLO
	c.painless.aaisp.net.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755041AbYF0ARb (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 26 Jun 2008 20:17:31 -0400
Received: from tiar.cowlark.co.uk ([81.187.191.218] helo=gate.cowlark.com)
	by c.painless.aaisp.net.uk with esmtp (Exim 4.69)
	(envelope-from <dg@cowlark.com>)
	id 1KC1eZ-00015x-NP
	for linux-sparse@vger.kernel.org; Fri, 27 Jun 2008 01:17:27 +0100
Received: from [10.0.0.5] (localhost [127.0.0.1])
	by gate.cowlark.com (Postfix) with ESMTP id CAE232008D
	for <linux-sparse@vger.kernel.org>; Fri, 27 Jun 2008 01:17:26 +0100 (BST)
In-Reply-To: <70318cbf0806261651u7a163d54m4d100012bce5db49@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3CEFBE9EBC08461C290E6C57
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Chris Li wrote:
[...]
> I don't think so. The offset part of the ptr_add op is mean to be the
> absolute offset, not how many element of the pointer index. In other
> words, it is how many address number it need to add.

Hmm. True. But even so, it's still not right on my system, which doesn't
use 8-bit bytes. (It's word addressable where each word can contain any
value, so sizeof(int) =3D=3D sizeof(double) =3D=3D sizeof(char) =3D=3D 1.=
)

Should there, then, be another symbol to define the number of bits in a
byte, distinct from the number of bits in a char?

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


--------------enig3CEFBE9EBC08461C290E6C57
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFIZDGVf9E0noFvlzgRAgzsAKCAD3FpJ3waNY4MvlSZ6ck5VFhtcACg2USx
4hZOEFKXhPd53X0Ogy0q48s=
=/WMu
-----END PGP SIGNATURE-----

--------------enig3CEFBE9EBC08461C290E6C57--
