From: Mathias Hasselmann <mathias.hasselmann@gmx.de>
Subject: License Questions
Date: Fri, 07 Sep 2007 07:53:23 +0200
Message-ID: <1189144403.7105.13.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-HEx89TIYr6fO5LID5BYT"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:35578 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758265AbXIGFxd (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Fri, 7 Sep 2007 01:53:33 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: torvalds@linux-foundation.org


--=-HEx89TIYr6fO5LID5BYT
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hello,

Sparse uses The Open Software License v. 1.1 which contains this clause:

        9) Acceptance and Termination. If You distribute copies of the
        Original Work or a Derivative Work, You must make a reasonable
        effort under the circumstances to obtain the express and
        volitional assent of recipients to the terms of this License.

What does this mean for hosting a public git repository[1] to organize
sparse patches? Do I have to put some "Accept License" page in front=20
of it? How do I force git to show that "Accept License" page when
downloading from that repository?=20

What does this clause mean for sending patches to the mailing list.=20
Shouldn't the patches be attached as password protected source archive
and the message contain something like "By extracting that archive you
declare to obey the terms of The Open Software License"?

Maybe that password thing is a solution for making git repositories=20
OSL compliant?

Thank you,
Mathias

[1] http://taschenorakel.de/git/sparse
--=20
Mathias Hasselmann <mathias.hasselmann@gmx.de>
http://taschenorakel.de/

--=-HEx89TIYr6fO5LID5BYT
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG4OdT73AS0G6kpDQRAiKWAJ4jH1MPohO7rH4d07lBgrY2PhiwMACfVq5C
SSLj2HM2TCjCDijtpKlF16w=
=CnuG
-----END PGP SIGNATURE-----

--=-HEx89TIYr6fO5LID5BYT--
