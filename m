From: Michael Stefaniuc <mstefani@redhat.com>
Subject: Ignore the cdecl and stdcall attributes for now.
Date: Wed, 16 May 2007 00:05:36 +0200
Message-ID: <20070515220536.GA23923@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:41488 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751980AbXEOWFi (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 15 May 2007 18:05:38 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l4FM5b6Z003399
	for <linux-sparse@vger.kernel.org>; Tue, 15 May 2007 18:05:37 -0400
Received: from pobox.stuttgart.redhat.com (pobox.stuttgart.redhat.com [172.16.2.10])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l4FM5abS014318
	for <linux-sparse@vger.kernel.org>; Tue, 15 May 2007 18:05:37 -0400
Received: from brasov.stuttgart.redhat.com (brasov.stuttgart.redhat.com [172.16.2.246])
	by pobox.stuttgart.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id l4FM5aBc010677
	for <linux-sparse@vger.kernel.org>; Wed, 16 May 2007 00:05:36 +0200
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Wine uses the __stdcall__ attribute extensively. The effects of the
patch on a sparse run on the Wine code are:
- Removes 143000 "attribute '__stdcall__': unknown attribute" errors.
- Removes 116 "attribute '__cdecl__': unknown attribute" errors.
- Reduces the amount of "error: too many errors" from 1992 to 1459.

Signed-off-by: Michael Stefaniuc <mstefani@redhat.com>
---
 parse.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/parse.c b/parse.c
index a1410c4..eb86bf6 100644
--- a/parse.c
+++ b/parse.c
@@ -323,6 +323,10 @@ static struct init_keyword {
 	{ "__warn_unused_result__",	NS_KEYWORD,	.op =3D &ignore_attr_op },
 	{ "model",	NS_KEYWORD,	.op =3D &ignore_attr_op },
 	{ "__model__",	NS_KEYWORD,	.op =3D &ignore_attr_op },
+	{ "cdecl",	NS_KEYWORD,	.op =3D &ignore_attr_op },
+	{ "__cdecl__",	NS_KEYWORD,	.op =3D &ignore_attr_op },
+	{ "stdcall",	NS_KEYWORD,	.op =3D &ignore_attr_op },
+	{ "__stdcall__",	NS_KEYWORD,	.op =3D &ignore_attr_op },
 };
=20
 void init_parser(int stream)
--=20
1.5.0.6


--=20
Michael Stefaniuc               Tel.: +49-711-96437-199
Sr. Network Engineer            Fax.: +49-711-96437-111
Red Hat GmbH                    Email: mstefani@redhat.com
Hauptstaetterstr. 58            http://www.redhat.de/
D-70178 Stuttgart

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFGSi6v08alQ5mXm14RAgUgAJwL657mnjYM+yb3JIqYIzMeguIRTQCfXsWZ
S0UIJsGnF5T9eHNFNTNH5Eg=
=aRiV
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
