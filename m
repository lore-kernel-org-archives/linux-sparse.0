From: Kamil Dudka <kdudka@redhat.com>
Subject: [PATCH] add warnings enum-to-int and int-to-enum
Date: Tue, 1 Sep 2009 23:59:09 +0200
Message-ID: <200909012359.09678.kdudka@redhat.com>
References: <20090830153202.4dc5c58c@s6510> <200908312104.54990.kdudka@redhat.com> <20090831205353.GA6239@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_tkZnKfsVsoVtorQ"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:7191 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752527AbZIAWAH (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 1 Sep 2009 18:00:07 -0400
In-Reply-To: <20090831205353.GA6239@josh-work.beaverton.ibm.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Stephen Hemminger <shemminger@vyatta.com>, linux-sparse@vger.kernel.org

--Boundary-00=_tkZnKfsVsoVtorQ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 31 of August 2009 22:53:54 Josh Triplett wrote:
> That seems quite sensible, and it even seems like something sparse
> should warn about by default.
>
> The reverse, warning about the assignment of an enum value to int, seems
> useful as well, but sparse shouldn't issue that warning by default
> because a lot of code just uses enum to define constants.
>
> Distinguishing between anonymous and named enums seems useful as well.
> An anonymous enum just creates some named constants but doesn't create a
> type to use them with, so assigning those constants to int shouldn't
> generate a warning.  (Corner case: "enum { ... } foo;".)

Here is my first take at casting from/to enum along with a simple test case. 
Any feedback welcome...

Kamil

--Boundary-00=_tkZnKfsVsoVtorQ
Content-Type: text/x-csrc;
  charset="iso-8859-1";
  name="test-enum.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="test-enum.c"

static void foo(void) {
    enum ENUM_TYPE_A { VALUE_A } var_a;
    enum ENUM_TYPE_B { VALUE_B } var_b;
    enum /* anon. */ { VALUE_C } anon_enum_var;
    int i;

    // always OK
    var_a = VALUE_A;
    var_a = (enum ENUM_TYPE_A) VALUE_B;
    var_b = (enum ENUM_TYPE_B) i;
    i = (int) VALUE_A;
    i = VALUE_B;
    anon_enum_var = VALUE_C;
    i = VALUE_C;
    i = anon_enum_var;

    // already caught by -Wenum-mismatch (default)
    var_a = var_b;
    var_b = anon_enum_var;
    anon_enum_var = var_a;

    // caught by -Wint-to-enum (default)
    var_a = VALUE_B;
    var_b = VALUE_C;
    anon_enum_var = VALUE_A;
    var_a = 0;
    var_b = i;
    anon_enum_var = 0;
    anon_enum_var = i;

    // caught only with -Wenum-to-int
    i = var_a;
}

--Boundary-00=_tkZnKfsVsoVtorQ
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="0001-add-warnings-enum-to-int-and-int-to-enum.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-add-warnings-enum-to-int-and-int-to-enum.patch"

=46rom a5095bbdb9694effa4a771295a87b80bf84d3230 Mon Sep 17 00:00:00 2001
=46rom: Kamil Dudka <kdudka@redhat.com>
Date: Tue, 1 Sep 2009 23:51:29 +0200
Subject: [PATCH] add warnings enum-to-int and int-to-enum


Signed-off-by: Kamil Dudka <kdudka@redhat.com>
=2D--
 evaluate.c   |   65 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
=2D--
 expression.h |    1 +
 lib.c        |    4 +++
 lib.h        |    2 +
 parse.c      |    1 +
 sparse.1     |   12 ++++++++++
 6 files changed, 81 insertions(+), 4 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index 805ae90..47e50fb 100644
=2D-- a/evaluate.c
+++ b/evaluate.c
@@ -235,16 +235,23 @@ static int is_same_type(struct expression *expr, stru=
ct symbol *new)
 }
=20
 static void
+resolve_sym_node (struct symbol **psym)
+{
+	struct symbol *sym =3D *psym;
+	if (sym->type =3D=3D SYM_NODE)
+		*psym =3D sym->ctype.base_type;
+}
+
+static void
 warn_for_different_enum_types (struct position pos,
 			       struct symbol *typea,
 			       struct symbol *typeb)
 {
 	if (!Wenum_mismatch)
 		return;
=2D	if (typea->type =3D=3D SYM_NODE)
=2D		typea =3D typea->ctype.base_type;
=2D	if (typeb->type =3D=3D SYM_NODE)
=2D		typeb =3D typeb->ctype.base_type;
+
+	resolve_sym_node(&typea);
+	resolve_sym_node(&typeb);
=20
 	if (typea =3D=3D typeb)
 		return;
@@ -256,6 +263,54 @@ warn_for_different_enum_types (struct position pos,
 	}
 }
=20
+static void
+warn_for_enum_to_int_cast (struct expression *expr, struct symbol *typeb)
+{
+	struct position pos =3D expr->pos;
+	struct symbol *typea =3D expr->ctype;
+
+	if (!Wenum_to_int)
+		return;
+
+	resolve_sym_node(&typea);
+	resolve_sym_node(&typeb);
+
+	if (typea->type !=3D SYM_ENUM || typeb->type !=3D SYM_BASETYPE)
+		return;
+
+	if (typea->ident) {
+		warning(pos, "cast from");
+		info(pos, "    %s to", show_typename(typea));
+		info(pos, "    %s", show_typename(typeb));
+		return;
+	}
+}
+
+static void
+warn_for_int_to_enum_cast (struct expression *expr, struct symbol *typeb)
+{
+	struct position pos =3D expr->pos;
+	struct symbol *typea =3D expr->ctype;
+	struct symbol *enum_type =3D expr->enum_type;
+
+	if (!Wint_to_enum)
+		return;
+
+	resolve_sym_node(&typea);
+	resolve_sym_node(&typeb);
+
+	if (typea->type !=3D SYM_BASETYPE || typeb->type !=3D SYM_ENUM)
+		return;
+
+	if (!enum_type || (enum_type !=3D typeb)) {
+		warning(pos, "cast from");
+		info(pos, "    %s to", show_typename((enum_type)
+					? enum_type
+					: typea));
+		info(pos, "    %s", show_typename(typeb));
+	}
+}
+
 /*
  * This gets called for implicit casts in assignments and
  * integer promotion. We often want to try to move the
@@ -268,6 +323,8 @@ static struct expression * cast_to(struct expression *o=
ld, struct symbol *type)
 	struct expression *expr;
=20
 	warn_for_different_enum_types (old->pos, old->ctype, type);
+	warn_for_enum_to_int_cast (old, type);
+	warn_for_int_to_enum_cast (old, type);
=20
 	if (old->ctype !=3D &null_ctype && is_same_type(old, type))
 		return old;
diff --git a/expression.h b/expression.h
index 631224f..81f70ad 100644
=2D-- a/expression.h
+++ b/expression.h
@@ -70,6 +70,7 @@ struct expression {
 		struct {
 			unsigned long long value;
 			unsigned taint;
+			struct symbol *enum_type;
 		};
=20
 		// EXPR_FVALUE
diff --git a/lib.c b/lib.c
index 600939b..2f78bd5 100644
=2D-- a/lib.c
+++ b/lib.c
@@ -199,6 +199,8 @@ int Wdecl =3D 1;
 int Wdefault_bitfield_sign =3D 0;
 int Wdo_while =3D 0;
 int Wenum_mismatch =3D 1;
+int Wenum_to_int =3D 0;
+int Wint_to_enum =3D 1;
 int Wnon_pointer_null =3D 1;
 int Wold_initializer =3D 1;
 int Wone_bit_signed_bitfield =3D 1;
@@ -380,6 +382,8 @@ static const struct warning {
 	{ "default-bitfield-sign", &Wdefault_bitfield_sign },
 	{ "do-while", &Wdo_while },
 	{ "enum-mismatch", &Wenum_mismatch },
+	{ "enum-to-int", &Wenum_to_int },
+	{ "int-to-enum", &Wint_to_enum },
 	{ "non-pointer-null", &Wnon_pointer_null },
 	{ "old-initializer", &Wold_initializer },
 	{ "one-bit-signed-bitfield", &Wone_bit_signed_bitfield },
diff --git a/lib.h b/lib.h
index b22fa93..962d49d 100644
=2D-- a/lib.h
+++ b/lib.h
@@ -96,6 +96,8 @@ extern int Wdecl;
 extern int Wdefault_bitfield_sign;
 extern int Wdo_while;
 extern int Wenum_mismatch;
+extern int Wenum_to_int;
+extern int Wint_to_enum;
 extern int Wnon_pointer_null;
 extern int Wold_initializer;
 extern int Wone_bit_signed_bitfield;
diff --git a/parse.c b/parse.c
index 5e75242..76d4c58 100644
=2D-- a/parse.c
+++ b/parse.c
@@ -791,6 +791,7 @@ static void cast_enum_list(struct symbol_list *list, st=
ruct symbol *base_type)
 		if (expr->type !=3D EXPR_VALUE)
 			continue;
 		ctype =3D expr->ctype;
+		expr->enum_type =3D sym->ctype.base_type;
 		if (ctype->bit_size =3D=3D base_type->bit_size)
 			continue;
 		cast_value(expr, base_type, expr, ctype);
diff --git a/sparse.1 b/sparse.1
index d7fe444..7eb0cda 100644
=2D-- a/sparse.1
+++ b/sparse.1
@@ -149,6 +149,18 @@ Sparse issues these warnings by default.  To turn them=
 off, use
 \fB\-Wno\-enum\-mismatch\fR.
 .
 .TP
+.B \-Wenum\-to\-int
+Warn about casting of an \fBenum\fR type to int and thus possible lost of
+information about the type.
+.
+.TP
+.B \-Wint\-to\-enum
+Warn about casting of int (or incompatible enumeration constant) to \fBenu=
m\fR.
+
+Sparse issues these warnings by default.  To turn them off, use
+\fB\-Wno\-int\-to\-enum\fR.
+.
+.TP
 .B \-Wnon\-pointer\-null
 Warn about the use of 0 as a NULL pointer.
=20
=2D-=20
1.6.4.1


--Boundary-00=_tkZnKfsVsoVtorQ--
