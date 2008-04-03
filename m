From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH 3/3] catch !x & y brainos
Date: Thu, 03 Apr 2008 14:26:00 -0700
Message-ID: <47F54B68.4090609@freedesktop.org>
References: <E1JSgxT-0003mf-2B@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig46B2D8D2698DCF140831D2C5"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail8.sea5.speakeasy.net ([69.17.117.10]:40836 "EHLO
	mail8.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751711AbYDCV0D (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 3 Apr 2008 17:26:03 -0400
In-Reply-To: <E1JSgxT-0003mf-2B@ZenIV.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig46B2D8D2698DCF140831D2C5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Al Viro wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Applied and pushed, along with a new test case.

Per previous discussion on this change, any reason not to emit a
similar warning for one or more of x & !y, !x | y, and x | !y, with
something like the following patch?  The discussion seemed to suggest
that some people might to use some of those variants intentionally,
but that doing so still seemed really questionable, and such code
could easily use a saner, less abbreviated style instead.

Also, I suspect that some people may want a -Wno-somethingorother for
this.  Any suggestions on naming, anyone?  I called the test case
"dubious bitwise with not", but I'd love to hear a better suggestion
that sounds slightly more like reasonable English.

=46rom 85581bf8ab9e2a103390c9dfff669b88f2c5e101 Mon Sep 17 00:00:00 2001
From: Josh Triplett <josh@freedesktop.org>
Date: Thu, 3 Apr 2008 14:12:30 -0700
Subject: [PATCH] Expand "dubious !x & y" handling to other combinations o=
f !, &, and |.

Signed-off-by: Josh Triplett <josh@freedesktop.org>
---
 evaluate.c                            |   13 ++++++++++---
 validation/dubious-bitwise-with-not.c |   19 +++++++++++++++++--
 2 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index 4928584..68211d3 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -917,9 +917,16 @@ static struct symbol *evaluate_binop(struct expressi=
on *expr)
 			rtype =3D integer_promotion(rtype);
 		} else {
 			// The rest do usual conversions
-			if (op =3D=3D '&' && expr->left->type =3D=3D EXPR_PREOP &&
-			    expr->left->op =3D=3D '!')
-				warning(expr->pos, "dubious: !x & y");
+			const unsigned left_not  =3D expr->left->type =3D=3D EXPR_PREOP
+			                           && expr->left->op =3D=3D '!';
+			const unsigned right_not =3D expr->right->type =3D=3D EXPR_PREOP
+			                           && expr->right->op =3D=3D '!';
+			if ((op =3D=3D '&' || op =3D=3D '|') && (left_not || right_not))
+				warning(expr->pos, "dubious: %sx %c %sy",
+				        left_not ? "!" : "",
+					op,
+					right_not ? "!" : "");
+
 			ltype =3D usual_conversions(op, expr->left, expr->right,
 						  lclass, rclass, ltype, rtype);
 			ctype =3D rtype =3D ltype;
diff --git a/validation/dubious-bitwise-with-not.c b/validation/dubious-b=
itwise-with-not.c
index e076899..c48bcae 100644
--- a/validation/dubious-bitwise-with-not.c
+++ b/validation/dubious-bitwise-with-not.c
@@ -1,9 +1,24 @@
-static unsigned int ok1 =3D !1 && 2;
-static unsigned int bad1 =3D !1 & 2;
+static unsigned int ok1  =3D !1 &&  2;
+static unsigned int bad1 =3D !1 &   2;
+static unsigned int ok2  =3D !1 ||  2;
+static unsigned int bad2 =3D !1 |   2;
+static unsigned int ok3  =3D  1 && !2;
+static unsigned int bad3 =3D  1 &  !2;
+static unsigned int ok4  =3D  1 || !2;
+static unsigned int bad4 =3D  1 |  !2;
+static unsigned int ok5  =3D !1 && !2;
+static unsigned int bad5 =3D !1 &  !2;
+static unsigned int ok6  =3D !1 || !2;
+static unsigned int bad6 =3D !1 |  !2;
 /*
  * check-name: Dubious bitwise operation on !x
  *
  * check-error-start
 dubious-bitwise-with-not.c:2:31: warning: dubious: !x & y
+dubious-bitwise-with-not.c:4:31: warning: dubious: !x | y
+dubious-bitwise-with-not.c:6:31: warning: dubious: x & !y
+dubious-bitwise-with-not.c:8:31: warning: dubious: x | !y
+dubious-bitwise-with-not.c:10:31: warning: dubious: !x & !y
+dubious-bitwise-with-not.c:12:31: warning: dubious: !x | !y
  * check-error-end
  */



--------------enig46B2D8D2698DCF140831D2C5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFH9UtoGJuZRtD+evsRAuOeAJ414IQwmzJLRNBDGdFFnOxTPMPRYQCfW4Vz
b2PmuuARHisUYQQHdW217KM=
=LBIE
-----END PGP SIGNATURE-----

--------------enig46B2D8D2698DCF140831D2C5--
