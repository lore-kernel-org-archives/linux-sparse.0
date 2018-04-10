From: Joey Pabalinas <joeypabalinas@gmail.com>
Subject: [PATCH v4] sparse: add -Wpointer-arith flag to toggle sizeof(void)
 warnings
Date: Tue, 10 Apr 2018 12:46:24 -1000
Message-ID: <20180410224624.psyo7vsy4qjplh3j@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4bytdfjebyecb6md"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>, Linus Torvalds <torvalds@linux-foundation.org>, Martin Uecker <Martin.Uecker@med.uni-goettingen.de>, Al Viro <viro@ZenIV.linux.org.uk>, Christopher Li <sparse@chrisli.org>, Joey Pabalinas <joeypabalinas@gmail.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-sparse@vger.kernel.org


--4bytdfjebyecb6md
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

Update the manpage to document the new flag and add a validation case
for sizeof(void).

CC: Kees Cook <keescook@chromium.org>
CC: Linus Torvalds <torvalds@linux-foundation.org>
CC: Martin Uecker <Martin.Uecker@med.uni-goettingen.de>
CC: Al Viro <viro@ZenIV.linux.org.uk>
CC: Christopher Li <sparse@chrisli.org>
CC: Joey Pabalinas <joeypabalinas@gmail.com>
CC: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Signed-off-by: Joey Pabalinas <joeypabalinas@gmail.com>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

 5 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index b96696d3a51396800a..8f07d08cf5b494f8f0 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -2169,7 +2169,8 @@ static struct symbol *evaluate_sizeof(struct expressi=
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
@@ -2180,7 +2181,8 @@ static struct symbol *evaluate_sizeof(struct expressi=
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
index 645132a892107512a1..0caee38a996cd0fa4c 100644
--- a/lib.c
+++ b/lib.c
@@ -241,6 +241,7 @@ int Woverride_init =3D 1;
 int Woverride_init_all =3D 0;
 int Woverride_init_whole_range =3D 0;
 int Wparen_string =3D 0;
+int Wpointer_arith =3D 0;
 int Wptr_subtraction_blows =3D 0;
 int Wreturn_void =3D 0;
 int Wshadow =3D 0;
@@ -536,6 +537,7 @@ static const struct warning {
 	{ "return-void", &Wreturn_void },
 	{ "shadow", &Wshadow },
 	{ "sizeof-bool", &Wsizeof_bool },
+	{ "pointer-arith", &Wpointer_arith },
 	{ "sparse-error", &Wsparse_error },
 	{ "tautological-compare", &Wtautological_compare },
 	{ "transparent-union", &Wtransparent_union },
diff --git a/lib.h b/lib.h
index a9b70b07686801305c..98e20d3830d9059acb 100644
--- a/lib.h
+++ b/lib.h
@@ -134,6 +134,7 @@ extern int Woverride_init;
 extern int Woverride_init_all;
 extern int Woverride_init_whole_range;
 extern int Wparen_string;
+extern int Wpointer_arith;
 extern int Wptr_subtraction_blows;
 extern int Wreturn_void;
 extern int Wshadow;
diff --git a/sparse.1 b/sparse.1
index e183204de623efd022..3bd5f1cb11309e65b8 100644
--- a/sparse.1
+++ b/sparse.1
@@ -282,6 +282,19 @@ Standard C syntax does not permit a parenthesized stri=
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
diff --git a/validation/sizeof-void.c b/validation/sizeof-void.c
new file mode 100644
index 000000000000000000..0fd917a21fb296a95d
--- /dev/null
+++ b/validation/sizeof-void.c
@@ -0,0 +1,44 @@
+#define is_constexpr(x) \
+	(sizeof(int) =3D=3D sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
+
+static int test(void)
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
+	s +=3D is_constexpr(ptr++);
+	s +=3D is_constexpr((i++, 1));
+	s +=3D is_constexpr(sizeof *ptr);
+	s +=3D is_constexpr(ptr + 1);
+	s +=3D is_constexpr(&ptr + 1);
+	s +=3D is_constexpr(*(((char *)&ptr) + 1));
+
+	return s;
+}
+
+/*
+ * check-name: sizeof(void) is valid
+ * check-description: sizeof(void) was rejected because void is an incompl=
ete
+ * type
+ * check-command: sparse -Wpointer-arith $file
+ *
+ * check-error-start
+sizeof-void.c:16:14: warning: expression using sizeof(void)
+sizeof-void.c:17:14: warning: expression using sizeof(void)
+sizeof-void.c:18:14: warning: expression using sizeof(void)
+sizeof-void.c:19:14: warning: expression using sizeof(void)
+sizeof-void.c:20:14: warning: expression using sizeof(void)
+sizeof-void.c:21:14: warning: expression using sizeof(void)
+sizeof-void.c:22:14: warning: expression using sizeof(void)
+sizeof-void.c:23:14: warning: expression using sizeof(void)
+ * check-error-end
+ */
--=20
2.17.0.rc1.35.g90bbd502d54fe92035.dirty


--4bytdfjebyecb6md
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEKlZXrihdNOcUPZTNruvLfWhyVBkFAlrNPsAACgkQruvLfWhy
VBnyvg//WQiT6Tw9pBZ8DuJVTgH8OJT2M3M9fwgJPr4i3Md0Z0pLaBUpvkAaVWmL
QdWeB+BKcQKg6k+RvSUPy6L1L69qRhJqzxmAK5YNGxR44040Y92O4lDcoAczBLcv
F8cJF93/RBSxoyI73FQbIzxfss8rnzYcy1LlvCxeisL3/giHqVhL7ANqa92tS84C
4xJYzY/ulSMBNz250Fl49Xje/GC3uHiroaECjLFG9DlXYfn/tM7vPGzVshwjiH9L
JAxPoBofA3q1PR2yIJUYEx7fpAxK8x/9eNvgKIvs5GyIDUpoegLA6o/+AzMI/PAM
7V1P4uYfpHwdAFK2GiTWYrD8yU55gAIx63rlLrCmFTAMOKZZaKthaqGOkNpJvNRd
McfiNKRc1xRjwpsZdlOx972zQGlee6c58PTfluOIO6H65srhlOG7f4Hs9GzkmfUh
MJ20ozr98YMujxXR4PeI/0KdBuR6jh/3VzGyZ/JOysfF1E3Ks5utFOXPpJaC9N0G
syV54nujy7ek+a7bF8Csv84aoexoY5b04jLTuTX0yzowrvNr77kdLV2om9tNsmBj
o3Z0vLn4N9pSPa99Djv4NaLgKWZq9ugB9hsZ0DmAmYgo13GGg2Z8a1GPncy1Tci+
w8EIV+YzMcmDMh7argeiUE52ezgLMb5LQ7r0MJ7C8vgOZYSozV0=
=O1XX
-----END PGP SIGNATURE-----

--4bytdfjebyecb6md--
