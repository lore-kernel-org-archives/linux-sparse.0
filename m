From: Michael Stefaniuc <mstefani@redhat.com>
Subject: [PATCH] '\?' is a valid escape character defined by ANSI C. Its value is '?'.
Date: Tue, 5 Jun 2007 10:02:55 +0200
Message-ID: <20070605080255.GA22131@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:37776 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751924AbXFEIC6 (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 5 Jun 2007 04:02:58 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l5582vMA004616
	for <linux-sparse@vger.kernel.org>; Tue, 5 Jun 2007 04:02:57 -0400
Received: from brasov.str.redhat.com (brasov.str.redhat.com [10.32.0.1])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l5582t4U001091
	for <linux-sparse@vger.kernel.org>; Tue, 5 Jun 2007 04:02:56 -0400
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Signed-off-by: Michael Stefaniuc <mstefani@redhat.com>
---
 tokenize.c           |    2 ++
 validation/escapes.c |    3 +++
 2 files changed, 5 insertions(+), 0 deletions(-)
 create mode 100644 validation/escapes.c

diff --git a/tokenize.c b/tokenize.c
index 5474512..fbe4c5a 100644
--- a/tokenize.c
+++ b/tokenize.c
@@ -470,6 +470,8 @@ static int escapechar(int first, int type, stream_t *st=
ream, int *valp)
 				break;
 			case '\\':
 				break;
+			case '?':
+				break;
 			case '\'':
 				break;
 			case '"':
diff --git a/validation/escapes.c b/validation/escapes.c
new file mode 100644
index 0000000..2d7d278
--- /dev/null
+++ b/validation/escapes.c
@@ -0,0 +1,3 @@
+int e[] =3D { '\'', '\"', '\?', '\\',
+            '\a', '\b', '\f', '\n', '\r', '\t', '\v', };
+char *s =3D "\'\"\?\\ \a\b\f\n\r\t\v";
--=20
1.5.0.6


--=20
Michael Stefaniuc               Tel.: +49-711-96437-199
Sr. Network Engineer            Fax.: +49-711-96437-111
Red Hat GmbH                    Email: mstefani@redhat.com
Hauptstaetterstr. 58            http://www.redhat.de/
D-70178 Stuttgart

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFGZRiv08alQ5mXm14RAj9/AJ4kgyVpkbmT2GzZwEv5QVQShZIGDACaA9bJ
ABrtz3GEvb6g947PkR1aAWE=
=n9rx
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
