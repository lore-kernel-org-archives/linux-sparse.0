From: Joey Pabalinas <joeypabalinas@gmail.com>
Subject: [PATCH v3] sparse: add -Wpointer-arith flag to toggle sizeof(void)
 warnings
Date: Mon, 9 Apr 2018 15:02:04 -1000
Message-ID: <20180410010204.qeudkkru4jilun3v@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5z2hkcnem3ajf6al"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>, Linus Torvalds <torvalds@linux-foundation.org>, Martin Uecker <Martin.Uecker@med.uni-goettingen.de>, Al Viro <viro@ZenIV.linux.org.uk>, Christopher Li <sparse@chrisli.org>, Joey Pabalinas <joeypabalinas@gmail.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-sparse@vger.kernel.org


--5z2hkcnem3ajf6al
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Recent changes to the min()/max() macros in include/linux/kernel.h
have added a lot of noise when compiling the kernel with Sparse checking
enabled. This mostly is due to the *huge* increase in the number of
sizeof(void) warnings, a larger number of which can safely be ignored.

Add the -Wpointer-arith flag to enable/disable these warnings (along
with the warning when applying sizeof to function types as well as
warning about pointer arithmetic on these types exactly like the
GCC -Wpointer-arith flag) on demand; the warning itself has been disabled
by default to reduce the large influx of noise which was inadvertently
added by commit 3c8ba0d61d04ced9f8 (kernel.h: Retain constant expression
output for max()/min()).

Update the manpage to document the new flag and add/update validation
cases regarding the application of sizeof to void and function types.

CC: Kees Cook <keescook@chromium.org>
CC: Linus Torvalds <torvalds@linux-foundation.org>
CC: Martin Uecker <Martin.Uecker@med.uni-goettingen.de>
CC: Al Viro <viro@ZenIV.linux.org.uk>
CC: Christopher Li <sparse@chrisli.org>
CC: Joey Pabalinas <joeypabalinas@gmail.com>
CC: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Signed-off-by: Joey Pabalinas <joeypabalinas@gmail.com>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

 evaluate.c                   |  6 ++++--
 lib.c                        |  2 ++
 lib.h                        |  1 +
 sparse.1                     | 13 ++++++++++++
 validation/sizeof-function.c |  2 +-
 validation/sizeof-void.c     | 39 ++++++++++++++++++++++++++++++++++++
 6 files changed, 60 insertions(+), 3 deletions(-)
 create mode 100644 validation/sizeof-void.c

 6 files changed, 60 insertions(+), 3 deletions(-)

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
index 88343f3170f195297a..4e1f2385fea7ec9296 100644
--- a/sparse.1
+++ b/sparse.1
@@ -288,6 +288,19 @@ Standard C syntax does not permit a parenthesized stri=
ng as an array
 initializer.  GCC allows this syntax as an extension.  With
 \fB\-Wparen\-string\fR, Sparse will warn about this syntax.
=20
+Sparse does not issue these warnings by default.
+.
+.TP
+.B \-Wpointer\-arith
+Warn about anything that depends on the \fBsizeof\fR a void or function ty=
pe.
+
+C99 does not allow the \fBsizeof\fR operator to be applied to function typ=
es
+or to incomplete types such as void. GCC allows \fBsizeof\fR to be applied=
 to
+these types as an extension and assigns these types a size of \fI1\fR. With
+\fB\-pointer\-arith\fR, Sparse will warn about pointer arithmetic on void
+or function pointers, as well as expressions which directly apply the
+\fBsizeof\fR operator to void or function types.
+
 Sparse does not issue these warnings by default.
 .
 .TP
diff --git a/validation/sizeof-function.c b/validation/sizeof-function.c
index 27d535d4ebda79ef0c..8ff67f2149981de7a9 100644
--- a/validation/sizeof-function.c
+++ b/validation/sizeof-function.c
@@ -35,7 +35,7 @@ int test(void)
=20
 /*
  * check-name: sizeof-function
- * check-command: sparse -Wno-decl $file
+ * check-command: sparse -Wpointer-arith -Wno-decl $file
  *
  * check-error-start
 sizeof-function.c:22:14: warning: expression using sizeof on a function
diff --git a/validation/sizeof-void.c b/validation/sizeof-void.c
new file mode 100644
index 000000000000000000..bc58c98d18d5fa3cda
--- /dev/null
+++ b/validation/sizeof-void.c
@@ -0,0 +1,39 @@
+#define is_constexpr(x) \
+	(sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
+
+int test(void)
+{
+	unsigned int s =3D 0, i =3D 0;
+	void *ptr =3D &i;
+
+	// OK
+	s +=3D sizeof i;
+	s +=3D sizeof &i;
+	s +=3D sizeof ptr;
+	s +=3D sizeof &ptr;
+
+	// KO
+	s +=3D sizeof(void);
+	s +=3D sizeof *ptr;
+	s +=3D is_constexpr(1 + 1);
+	s +=3D is_constexpr((1, 1));
+	s +=3D is_constexpr(ptr + 1);
+	s +=3D is_constexpr(&ptr + 1);
+	s +=3D is_constexpr(*(((char *)&ptr) + 1));
+
+	return s;
+}
+
+/*
+ * check-name: sizeof-void
+ * check-command: sparse -Wpointer-arith -Wno-decl -Wno-unused-value $file
+ *
+ * check-error-start
+sizeof-void.c:16:14: warning: expression using sizeof(void)
+sizeof-void.c:17:14: warning: expression using sizeof(void)
+sizeof-void.c:19:14: warning: expression using sizeof(void)
+sizeof-void.c:20:14: warning: expression using sizeof(void)
+sizeof-void.c:21:14: warning: expression using sizeof(void)
+sizeof-void.c:22:14: warning: expression using sizeof(void)
+ * check-error-end
+ */
--=20
2.17.0.rc1.35.g90bbd502d54fe92035.dirty

--5z2hkcnem3ajf6al
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEKlZXrihdNOcUPZTNruvLfWhyVBkFAlrMDQwACgkQruvLfWhy
VBkjlw//Q2vHw5AW/OhezEQHQwgbRKBd8DoFL6ndthOhEYwG5cY2zG1djJq/jB+I
xz10Wt7NcRmLDEh0GiDd7PZc0+lZz4oYG6Bcu9sKw8oLpC/PNnlGME2NRpcMIAM0
+xWyrbHkIG9M0YJXAX9I3RMAyAd3rC+eET3AcwLaiklPeiLmsYbfPf79KNyEmrGN
aAzCHC0E4ZfxYgh9K6ezjVuOfVub4YPJk2/Q8B4D8c2Ao76DkWjx+QQ03a+Mrh34
tva0s4BDOwpQdKQgaU07KGQ+j8SRgenoNPfX9q48LssN6DnuLaDtSc0nFLAFeI4r
Yg2aSDDdbhuY2O2J+W6NN4k0urmvihnwWeCXRWd8Y4zx2cyDAZ24z4R77FGt5/jr
901XChEPPDqqWP6KdepcbZsk4gCLOZPVM0DnKDC4l/urGMt62hFw88q/Eu4f9Q/n
HBEW19p/JOqK2AoEctBu/5syXO51pCb1FhqhhnUj4FFmgLhbZqtppxEWJ86eoXPw
bamfD+7ySl9cN4wQOSYOOI6t6w76wGL+5X6FuJ65w/8JgG2TDj+2rCNQirAZUOSH
Ulyvf+6FN5VFwG0NGQK13MZpYsWd3mCKcXYHe6MVDa+ErWvWpB3xXgr7HfbRO4M7
QZ+5DXIl2z4kiuAnxaFNj11R/6LfFJ6kH9NTjyIlFqBJUIm8cGs=
=gkhN
-----END PGP SIGNATURE-----

--5z2hkcnem3ajf6al--
