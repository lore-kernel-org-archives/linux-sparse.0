From: Josh Triplett <josh@freedesktop.org>
Subject: [RFC PATCH] Make sparse return 1 if errors occurred
Date: Sat, 14 Jul 2007 13:51:24 -0700
Message-ID: <4699374C.1030303@freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig453E37CBA0683056BF9284C7"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail5.sea5.speakeasy.net ([69.17.117.7]:50513 "EHLO
	mail5.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762119AbXGNUvd (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 14 Jul 2007 16:51:33 -0400
Received: from dsl093-040-092.pdx1.dsl.speakeasy.net (HELO [192.168.0.122]) (josh@[66.93.40.92])
          (envelope-sender <josh@freedesktop.org>)
          by mail5.sea5.speakeasy.net (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <linux-sparse@vger.kernel.org>; 14 Jul 2007 20:51:32 -0000
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig453E37CBA0683056BF9284C7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Sparse always returned 0.  Change it to return 1 if errors occurred, and
remove check-known-to-fail from tests that expected that behavior.

Also rename the misleadingly named global die_if_error to had_errors.

Signed-off-by: Josh Triplett <josh@freedesktop.org>
---
 lib.c                                         |    4 ++--
 lib.h                                         |    2 +-
 sparse.c                                      |    2 +-
 validation/bad-array-designated-initializer.c |    2 --
 validation/bad-assignment.c                   |    2 --
 validation/preprocessor/preprocessor18.c      |    2 --
 validation/preprocessor/preprocessor21.c      |    2 --
 7 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/lib.c b/lib.c
index a1442a2..be1aca4 100644
--- a/lib.c
+++ b/lib.c
@@ -29,7 +29,7 @@
 #include "target.h"
=20
 int verbose, optimize, optimize_size, preprocessing;
-int die_if_error =3D 0;
+int had_errors =3D 0;
=20
 #ifndef __GNUC__
 # define __GNUC__ 2
@@ -129,7 +129,7 @@ void warning(struct position pos, const char * fmt, .=
=2E.)
 static void do_error(struct position pos, const char * fmt, va_list args=
)
 {
 	static int errors =3D 0;
-        die_if_error =3D 1;
+	had_errors =3D 1;
 	show_info =3D 1;
 	/* Shut up warnings after an error */
 	max_warnings =3D 0;
diff --git a/lib.h b/lib.h
index aacafea..a5e9f8e 100644
--- a/lib.h
+++ b/lib.h
@@ -18,7 +18,7 @@
 #include "ptrlist.h"
=20
 extern int verbose, optimize, optimize_size, preprocessing;
-extern int die_if_error;
+extern int had_errors;
 extern int repeat_phase, merge_phi_sources;
 extern int gcc_major, gcc_minor, gcc_patchlevel;
=20
diff --git a/sparse.c b/sparse.c
index 4026ba7..2f74194 100644
--- a/sparse.c
+++ b/sparse.c
@@ -283,5 +283,5 @@ int main(int argc, char **argv)
 	FOR_EACH_PTR_NOTAG(filelist, file) {
 		check_symbols(sparse(file));
 	} END_FOR_EACH_PTR_NOTAG(file);
-	return 0;
+	return had_errors;
 }
diff --git a/validation/bad-array-designated-initializer.c b/validation/b=
ad-array-designated-initializer.c
index ecc5bd3..75e8a10 100644
--- a/validation/bad-array-designated-initializer.c
+++ b/validation/bad-array-designated-initializer.c
@@ -12,6 +12,4 @@ bad-array-designated-initializer.c:3:3: error: Expected=
 constant expression
 bad-array-designated-initializer.c:3:3: error: Expected } at end of init=
ializer
 bad-array-designated-initializer.c:3:3: error: got \
  * check-output-end
- *
- * check-known-to-fail
  */
diff --git a/validation/bad-assignment.c b/validation/bad-assignment.c
index 66f6fe8..f876076 100644
--- a/validation/bad-assignment.c
+++ b/validation/bad-assignment.c
@@ -13,6 +13,4 @@ static int foo(int a)
 bad-assignment.c:3:6: error: Expected ; at end of statement
 bad-assignment.c:3:6: error: got \
  * check-output-end
- *
- * check-known-to-fail
  */
diff --git a/validation/preprocessor/preprocessor18.c b/validation/prepro=
cessor/preprocessor18.c
index b4de1e6..b864010 100644
--- a/validation/preprocessor/preprocessor18.c
+++ b/validation/preprocessor/preprocessor18.c
@@ -12,6 +12,4 @@ preprocessor/preprocessor18.c:2:2: error: expected iden=
tifier to 'define'
 preprocessor/preprocessor18.c:3:2: error: expected identifier to 'undef'=

=20
  * check-output-end
- *
- * check-known-to-fail
  */
diff --git a/validation/preprocessor/preprocessor21.c b/validation/prepro=
cessor/preprocessor21.c
index 1719fc0..ce62dbb 100644
--- a/validation/preprocessor/preprocessor21.c
+++ b/validation/preprocessor/preprocessor21.c
@@ -11,6 +11,4 @@ preprocessor/preprocessor21.c:2:2: error: unterminated =
preprocessor conditional
=20
=20
  * check-output-end
- *
- * check-known-to-fail
  */
--=20
1.5.2.3



--------------enig453E37CBA0683056BF9284C7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGmTdMGJuZRtD+evsRAqgbAJ0RqNfRreKGNLXiHsd+9Clbf/ovbgCgsdLL
bizdbHa8aYkkxVUKBXnXDi8=
=2Tct
-----END PGP SIGNATURE-----

--------------enig453E37CBA0683056BF9284C7--
