From: Kamal Mostafa <kamal@canonical.com>
Subject: Re: [PATCH] recognize binary constants
Date: Thu, 08 Sep 2011 10:47:30 -0700
Message-ID: <1315504050.2011.16.camel@marconi>
References: <1315434714.1892.7.camel@marconi>
	 <20110908170734.GB17041@mwanda>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256"; protocol="application/pgp-signature"; boundary="=-vgG7aYFYh08E3Ust3OCa"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:36976 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756514Ab1IIAr7 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 8 Sep 2011 20:47:59 -0400
In-Reply-To: <20110908170734.GB17041@mwanda>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dan Carpenter <error27@gmail.com>
Cc: linux-sparse@vger.kernel.org, smatch@vger.kernel.org


--=-vgG7aYFYh08E3Ust3OCa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

A small change to your patch, Dan:  I added a call to tolower(), since
"0B11" is also a valid syntax.

 -Kamal

---------------------------------------------------------------------------

=46rom a9273391fe5f410321a0668e18beaebce086e23d Mon Sep 17 00:00:00 2001
From: Kamal Mostafa <kamal@canonical.com>
Date: Thu, 8 Sep 2011 10:34:27 -0700
Subject: [PATCH] recognize binary constants

Sparse doesn't parse binary constants properly so the following code
generates an error:

	x =3D 0b11;

test.c:5:17: error: constant 0b11 is not a valid number

Reported-by: Kamal Mostafa <kamal@canonical.com>
Signed-off-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 expression.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/expression.c b/expression.c
index 7e06e60..07d6846 100644
--- a/expression.c
+++ b/expression.c
@@ -268,6 +268,13 @@ static struct token *string_expression(struct token *t=
oken, struct expression *e
 #define ULLONG_MAX (~0ULL)
 #endif
=20
+static unsigned long long parse_num(const char *nptr, char **end)
+{
+	if (nptr[0] =3D=3D '0' && tolower(nptr[1]) =3D=3D 'b')
+		return strtoull(&nptr[2], end, 2);
+	return strtoull(nptr, end, 0);
+}
+
 static void get_number_value(struct expression *expr, struct token *token)
 {
 	const char *str =3D token->number;
@@ -279,7 +286,7 @@ static void get_number_value(struct expression *expr, s=
truct token *token)
 	int bits;
=20
 	errno =3D 0;
-	value =3D strtoull(str, &end, 0);
+	value =3D parse_num(str, &end);
 	if (end =3D=3D str)
 		goto Float;
 	if (value =3D=3D ULLONG_MAX && errno =3D=3D ERANGE)
--=20
1.7.4.1



--=-vgG7aYFYh08E3Ust3OCa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCAAGBQJOaP+vAAoJEOf3EFVUCeQiO+EP/0KZC8K7aPgluOt1pHUxuKqL
yiTyO1UtCsMvwyLVCPRYYS9thQvLME1YyQ1XKd33X2tPlR/uD4UDmIpNgyoAhDJE
UVVYbfIn+TYA97TpZ7PvZJ5tHKvSQSBHKnMEytLVK9pf+2hbQk4PTr3eH+IZMJbK
FcGjTsp6Bads71ziWtyKBmrQqa7CQC2vZiH0FCdj/H6lNYywrMrpc8Vyp7j9k4Yt
LRs9gy/MrJtGk7aWg8d275P5LBMZrAeDD6bDfqZ+BeOTGTMKx32wKkxrHL/4ZfjS
e3ekpkvYFCOpFi+xUCp172+6fs7gDQA+iNcHZLOmsFgmep0Bb5syRhHFIFHm2uAn
1C6znSiOWqTnpGZx73av/26wAhgY/Lm5NT2636rPPwSYBLvDsppSNzgrgFK9ie6W
2jL1FToouaqJEXLjFgqmaMmrrUED4FFVxYCjIHOIq2KheCzQRh490qyq9apdaBMY
U2bzFy9OMirdycmmToLGDkOxz/2MXCSMSvA8KzFSK0y39d/6pv+S7M4qKtVh/GCt
oAbBBll/ZCdshUSY7fCkhGm+L7eAopqEAnuillG7E/QJ7EnSD2RzsM7mtbWG87zY
li68fudZFEk3bVauQYc8X83sHTDXnZ98LEFm91FMrvu0iTwmqstxNLyIJULDL2M+
03Qkmzx0vyow27cK7nA0
=9j+n
-----END PGP SIGNATURE-----

--=-vgG7aYFYh08E3Ust3OCa--

