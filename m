From: David Given <dg@cowlark.com>
Subject: Unused arg_count field
Date: Sat, 06 Sep 2008 17:01:50 +0100
Message-ID: <48C2A96E.5020802@cowlark.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig8DB91045EDD561471FBE6293"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from b.painless.aaisp.net.uk ([81.187.30.52]:50133 "EHLO
	b.painless.aaisp.net.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751790AbYIFQ0B (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 6 Sep 2008 12:26:01 -0400
Received: from tiar.cowlark.co.uk ([81.187.191.218] helo=gate.cowlark.com)
	by b.painless.aaisp.net.uk with esmtp (Exim 4.69)
	(envelope-from <dg@cowlark.com>)
	id 1Kc0EU-0007py-3y
	for linux-sparse@vger.kernel.org; Sat, 06 Sep 2008 17:01:54 +0100
Received: from [10.0.0.5] (localhost [127.0.0.1])
	by gate.cowlark.com (Postfix) with ESMTP id DDF852006F
	for <linux-sparse@vger.kernel.org>; Sat,  6 Sep 2008 17:01:51 +0100 (BST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8DB91045EDD561471FBE6293
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

I notice that struct symbol::arg_count doesn't appear to be used,
anywhere. Is this obsolete?

--=20
=E2=94=8C=E2=94=80=E2=94=80=E2=94=80 =EF=BD=84=EF=BD=87=EF=BC=A0=EF=BD=83=
=EF=BD=8F=EF=BD=97=EF=BD=8C=EF=BD=81=EF=BD=92=EF=BD=8B=EF=BC=8E=EF=BD=83=EF=
=BD=8F=EF=BD=8D =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80 http://www.=
cowlark.com =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
=E2=94=82
=E2=94=82 "All power corrupts, but we need electricity." --- Diana Wynne =
Jones,
=E2=94=82 _Archer's Goon_


--------------enig8DB91045EDD561471FBE6293
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFIwqluf9E0noFvlzgRAlXdAJ9KNbh0W8B1Bk6qrgLz08qivQnQmgCgiQp3
GNjmVE4YFvDT08DADo5/O8s=
=tUoI
-----END PGP SIGNATURE-----

--------------enig8DB91045EDD561471FBE6293--
