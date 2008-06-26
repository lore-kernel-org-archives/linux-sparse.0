From: David Given <dg@cowlark.com>
Subject: Pointer arithmetic error
Date: Fri, 27 Jun 2008 00:40:07 +0100
Message-ID: <486428D7.8080603@cowlark.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig52139C2B8048953F500DCC2F"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from a.painless.aaisp.net.uk ([81.187.30.51]:39143 "EHLO
	a.painless.aaisp.net.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754638AbYFZXkO (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 26 Jun 2008 19:40:14 -0400
Received: from tiar.cowlark.co.uk ([81.187.191.218] helo=gate.cowlark.com)
	by a.painless.aaisp.net.uk with esmtp (Exim 4.69)
	(envelope-from <dg@cowlark.com>)
	id 1KC155-0002GD-Cx
	for linux-sparse@vger.kernel.org; Fri, 27 Jun 2008 00:40:47 +0100
Received: from [10.0.0.5] (localhost [127.0.0.1])
	by gate.cowlark.com (Postfix) with ESMTP id 1287E2008D
	for <linux-sparse@vger.kernel.org>; Fri, 27 Jun 2008 00:40:10 +0100 (BST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig52139C2B8048953F500DCC2F
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

I've just found what I think is a bug. In evaluate_ptr_add(), in
evaluate.c, are the following lines:

	/* Get the size of whatever the pointer points to */
	multiply =3D base->bit_size >> 3;

This divides the bit size by 8 to get the size in bytes. However, this
doesn't take into account that bits_in_char might not be 8. I think this
should actually be:

	/* Get the size of whatever the pointer points to */
	multiply =3D base->bit_size / bits_in_char;

(This now produces the right result on my non-8-bit-char 'platform'.)

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


--------------enig52139C2B8048953F500DCC2F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFIZCjXf9E0noFvlzgRAhLHAJ0U8EEwtfMqBdnUnmq0IttZlogL8wCgih1p
x+2+lcgMrBo12XI9fYIlIXM=
=12Uc
-----END PGP SIGNATURE-----

--------------enig52139C2B8048953F500DCC2F--
