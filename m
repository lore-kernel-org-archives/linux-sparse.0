From: Joey Pabalinas <joeypabalinas@gmail.com>
Subject: [PATCH v2] add -Wpointer-arith sparse flag to toggle sizeof(void)
 warnings
Date: Sat, 7 Apr 2018 11:58:05 -1000
Message-ID: <20180407215805.ze5rx4v3slbjngmo@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="h2ampcaefjs7x347"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>, Linus Torvalds <torvalds@linux-foundation.org>, Martin Uecker <Martin.Uecker@med.uni-goettingen.de>, Al Viro <viro@ZenIV.linux.org.uk>, Christopher Li <sparse@chrisli.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Joey Pabalinas <joeypabalinas@gmail.com>
List-Id: linux-sparse@vger.kernel.org


--h2ampcaefjs7x347
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Recent changes to the min()/max() macros in include/linux/kernel.h
have added a lot of noise when compiling the kernel with Sparse checking
enabled. This mostly is due to the *huge* increase in the number of
sizeof(void) warnings, a larger number of which can safely be ignored.

Add the -Wpointer-arith flag to enable/disable these warnings (along
with the warning when applying sizeof to function types exactly like the
GCC -Wpointer-arith flag) on demand; the warning itself has been disabled
by default to reduce the large influx of noise which was inadvertently
added by commit 3c8ba0d61d04ced9f8 (kernel.h: Retain constant expression
output for max()/min()).

Update the manpage to document the new flag.

CC: Kees Cook <keescook@chromium.org>
CC: Linus Torvalds <torvalds@linux-foundation.org>
CC: Martin Uecker <Martin.Uecker@med.uni-goettingen.de>
CC: Al Viro <viro@ZenIV.linux.org.uk>
CC: Christopher Li <sparse@chrisli.org>
CC: Joey Pabalinas <joeypabalinas@gmail.com>
CC: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Signed-off-by: Joey Pabalinas <joeypabalinas@gmail.com>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

 4 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index 4e1dffe9c5416380df..f828da37df8e686623 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -2193,7 +2193,8 @@ static struct symbol *evaluate_sizeof(struct expressi=
on *expr)
 	size =3D type->bit_size;
=20
 	if (size < 0 && is_void_type(type)) {
-		warning(expr->pos, "expression using sizeof(void)");
+		if (Wpointer_arith)
+			warning(expr->pos, "expression using sizeof(void)");
 		size =3D bits_in_char;
 	}
=20
@@ -2204,7 +2205,8 @@ static struct symbol *evaluate_sizeof(struct expressi=
on *expr)
 	}
=20
 	if (is_function(type->ctype.base_type)) {
-		warning(expr->pos, "expression using sizeof on a function");
+		if (Wpointer_arith)
+			warning(expr->pos, "expression using sizeof on a function");
 		size =3D bits_in_char;
 	}
=20
diff --git a/lib.c b/lib.c
index 73d372c36626538bab..f7fdac96674aec4c24 100644
--- a/lib.c
+++ b/lib.c
@@ -242,6 +242,7 @@ int Woverride_init =3D 1;
 int Woverride_init_all =3D 0;
 int Woverride_init_whole_range =3D 0;
 int Wparen_string =3D 0;
+int Wpointer_arith =3D 0;
 int Wptr_subtraction_blows =3D 0;
 int Wreturn_void =3D 0;
 int Wshadow =3D 0;
@@ -654,6 +655,7 @@ static const struct flag warnings[] =3D {
 	{ "return-void", &Wreturn_void },
 	{ "shadow", &Wshadow },
 	{ "sizeof-bool", &Wsizeof_bool },
+	{ "pointer-arith", &Wpointer_arith },
 	{ "sparse-error", &Wsparse_error },
 	{ "tautological-compare", &Wtautological_compare },
 	{ "transparent-union", &Wtransparent_union },
diff --git a/lib.h b/lib.h
index 3050b5577ba4d42e97..e34bb9a02ebac03f52 100644
--- a/lib.h
+++ b/lib.h
@@ -151,6 +151,7 @@ extern int Woverride_init;
 extern int Woverride_init_all;
 extern int Woverride_init_whole_range;
 extern int Wparen_string;
+extern int Wpointer_arith;
 extern int Wptr_subtraction_blows;
 extern int Wreturn_void;
 extern int Wshadow;
diff --git a/sparse.1 b/sparse.1
index 88343f3170f195297a..4379406999c94b806e 100644
--- a/sparse.1
+++ b/sparse.1
@@ -288,6 +288,25 @@ Standard C syntax does not permit a parenthesized stri=
ng as an array
 initializer.  GCC allows this syntax as an extension.  With
 \fB\-Wparen\-string\fR, Sparse will warn about this syntax.
=20
+Sparse does not issue these warnings by default.
+.
+.TP
+.B \-Wpointer-arith
+Warn about anything that depends on the \fBsizeof\fR a function type or of=
 void.
+
+C99 does not allow the \fBsizeof\fR operator to be applied to function typ=
es or to
+incomplete types such as void. GCC allows \fBsizeof\fR to be applied to th=
ese
+types as an extension and assigns these types a size of \fI1\fR.
+
+Although non-standard (and somewhat illogical), constructs such as \fBsize=
of(void)\fR
+are often useful when the intent is to operate on an expression without ev=
aluating
+it, e.g. in the following integer constant expression predicate:
+
+.nf
+#define __is_constexpr(x) \\
+	(sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
+.fi
+
 Sparse does not issue these warnings by default.
 .
 .TP
--=20
2.17.0.rc1.35.g90bbd502d54fe92035.dirty

--h2ampcaefjs7x347
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEKlZXrihdNOcUPZTNruvLfWhyVBkFAlrJPu0ACgkQruvLfWhy
VBmEBBAAki2R+iz46YMJgP277W7FbL45lnS1CyyCGKYbKpS5l7npKobkO12q0Uuj
68frc/IH7ApxaEoUUnd44Dvz2V+C0USKrnitXPCqlyCNqXLK55RDYomSJZHdd8HB
VTcXoetEejvJHOdzOuvkVKKzAAWCsE4tMiIfXHeK7BvyBPh1fsT56w8XzIkG8DdN
oW7yccYbnWQCUId/GcfwdSkliMzH1Y4Y6rx3c+CyyZlhI0mPJQLyKAHewbactQ6v
sQ6FtlQ1LCLnuy5NmZtXCyl2CJphhabe20DiFEhPP2/e5gPbs9BkHrTnNCbaZyrv
vNo/EXLGiMCvhQtsT4gbKC6pt3Ef1McPUGoENa7tvCMedCbAKMPn0gmZTctsvPZ8
zZPoqOStQjr35psJ8u3wy/4gh070pjsgzj2ri9eoCkmm9iMauT+QspbnQYX4Iv5x
elQf3Egk5CtgiUUbunsnP8oOC3BuD9LouMpiNQtCTFjtvG5n/L7hA4pqQYxJrZHu
B5Egoll/V8/GiV5O4XR0I191bCKsKD5GX12fD7rxrUHR9Yy3aYJtKSYm8QNRFBLl
OmiwLA0+1yuIFQJ4pIsSW0HOhdr0UZHqHiJRs82eum6hB8i8QKeG+n96KYpLo/SR
RIBnlR2DkSLmMtdTWLs9aDA+aXKk+ezR0EtjnXaqN5CuXnisIEk=
=ysXp
-----END PGP SIGNATURE-----

--h2ampcaefjs7x347--
