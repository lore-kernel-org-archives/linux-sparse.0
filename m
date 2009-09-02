From: Kamil Dudka <kdudka@redhat.com>
Subject: Re: [PATCH] add warnings enum-to-int and int-to-enum
Date: Thu, 3 Sep 2009 00:35:54 +0200
Message-ID: <200909030035.55097.kdudka@redhat.com>
References: <20090830153202.4dc5c58c@s6510> <20090902190337.GB5148@josh-work.beaverton.ibm.com> <200909022119.50213.kdudka@redhat.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_LNvnKKkx2k3i5j3"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:31394 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752540AbZIBWhh (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 2 Sep 2009 18:37:37 -0400
In-Reply-To: <200909022119.50213.kdudka@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Stephen Hemminger <shemminger@vyatta.com>, linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Al Viro <viro@zeniv.linux.org.uk>, Morten Welinder <terra@gnome.org>

--Boundary-00=_LNvnKKkx2k3i5j3
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 02 of September 2009 21:19:49 Kamil Dudka wrote:
> Nope, I think we should fix it right now. And if possible ask the original
> authors for review and/or comment at the patch I am currently preparing.
> I considered it pretty broken. Just try this example:
>
> static void f(void) {
>     enum ENUM_TYPE_A { VALUE_A } var_a;
>     enum ENUM_TYPE_B { VALUE_B } var_b;
>
>     switch (var_a) {
>         case VALUE_A:
>         case VALUE_B:
>         default:
>             break;
>     }
> }
>
> It seems like this was the original intention of the calling the
> warn_for_different_enum_types() from check_case_type(). But it has been
> either not tested, or broken in the meantime.

The second holds. It's regression!

It used to work in ca1f2e9ebf33e78c77c79eb695fe88d843b4f978 - see the log 
message for a test case. The same test case is failing to issue a warning 
now, but it works again with my patch applied.

Al, Morten, can I ask you as original authors for approval of the patch?

Details about warnings (what? when? why?) are in the tests themselves. Don't 
hesitate to ask me if something is missing there :-)

> > Either one seems fine; I don't think splitting the test case helps
> > coverage, and keeping it together lets you use the same declarations for
> > the entire test case as you did in the previously attached version.
>
> This is not necessarily dedicated to choice 1), unless you are scared from
> a construction like this:
>
>     #include "enum-common.c"

Nobody has objected, so here it is. I think it'll be much easier to maintain 
this way...

Kamil

--Boundary-00=_LNvnKKkx2k3i5j3
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="0001-add-warnings-enum-to-int-and-int-to-enum.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-add-warnings-enum-to-int-and-int-to-enum.patch"

=46rom 050663577b8832ee40f4f365bee61e2ed1bf9613 Mon Sep 17 00:00:00 2001
=46rom: Kamil Dudka <kdudka@redhat.com>
Date: Wed, 2 Sep 2009 23:49:09 +0200
Subject: [PATCH] add warnings enum-to-int and int-to-enum...

=2E.. and improve detection of the enum-mismatch warning. Add test case
for each of the warnings. For details about what triggers which warning
just look to the corresponding test case.

Signed-off-by: Kamil Dudka <kdudka@redhat.com>
=2D--
 evaluate.c                 |  122 ++++++++++++++++++++++++++++++++++------=
=2D---
 expression.h               |    1 +
 lib.c                      |    4 ++
 lib.h                      |    2 +
 parse.c                    |    1 +
 sparse.1                   |   13 +++++
 validation/enum-common.c   |  112 ++++++++++++++++++++++++++++++++++++++++
 validation/enum-from-int.c |   36 +++++++++++++
 validation/enum-mismatch.c |   48 +++++++++++++++++
 validation/enum-to-int.c   |   27 ++++++++++
 10 files changed, 339 insertions(+), 27 deletions(-)
 create mode 100644 validation/enum-common.c
 create mode 100644 validation/enum-from-int.c
 create mode 100644 validation/enum-mismatch.c
 create mode 100644 validation/enum-to-int.c

diff --git a/evaluate.c b/evaluate.c
index 805ae90..0d5e93b 100644
=2D-- a/evaluate.c
+++ b/evaluate.c
@@ -235,27 +235,105 @@ static int is_same_type(struct expression *expr, str=
uct symbol *new)
 }
=20
 static void
=2Dwarn_for_different_enum_types (struct position pos,
=2D			       struct symbol *typea,
=2D			       struct symbol *typeb)
+resolve_sym_node (struct symbol **psym)
 {
+	struct symbol *sym =3D *psym;
+	if (sym->type =3D=3D SYM_NODE)
+		*psym =3D sym->ctype.base_type;
+}
+
+static void
+warn_for_different_enum_types (struct expression *expr, struct symbol *typ=
eb)
+{
+	struct position pos =3D expr->pos;
+	struct symbol *typea =3D expr->ctype;
+	struct symbol *enum_type =3D expr->enum_type;
+	enum type ttypea;
+
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
+	if (typeb->type !=3D SYM_ENUM)
+		return;
=20
=2D	if (typea->type =3D=3D SYM_ENUM && typeb->type =3D=3D SYM_ENUM) {
+	ttypea =3D typea->type;
+	if (ttypea =3D=3D SYM_ENUM || (ttypea =3D=3D SYM_BASETYPE
+					&& enum_type && enum_type !=3D typeb))
+	{
 		warning(pos, "mixing different enum types");
=2D		info(pos, "    %s versus", show_typename(typea));
+		info(pos, "    %s versus", show_typename((ttypea =3D=3D SYM_ENUM)
+					? typea
+					: enum_type));
 		info(pos, "    %s", show_typename(typeb));
 	}
 }
=20
+static void
+issue_conversion_warning(struct position pos,
+			 struct symbol *typea,
+			 struct symbol *typeb)
+{
+	warning(pos, "conversion of");
+	info(pos, "    %s to", show_typename(typea));
+	info(pos, "    %s", show_typename(typeb));
+}
+
+static void
+warn_for_enum_to_int_conversion (struct expression *expr, struct symbol *t=
ypeb)
+{
+	struct position pos =3D expr->pos;
+	struct symbol *typea =3D expr->ctype;
+	struct symbol *enum_type =3D expr->enum_type;
+
+	if (!Wenum_to_int)
+		return;
+
+	resolve_sym_node(&typea);
+	resolve_sym_node(&typeb);
+
+	if (typeb->type !=3D SYM_BASETYPE)
+		return;
+
+	if (typea->type =3D=3D SYM_ENUM && typea->ident)
+		issue_conversion_warning(pos, typea, typeb);
+
+	if (typea->type =3D=3D SYM_BASETYPE && enum_type && enum_type->ident)
+		issue_conversion_warning(pos, enum_type, typeb);
+}
+
+static void
+warn_for_int_to_enum_conversion (struct expression *expr, struct symbol *t=
ypeb)
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
+	if (!enum_type)
+		issue_conversion_warning(pos, typea, typeb);
+}
+
+static void
+warn_for_enum_conversions(struct expression *expr, struct symbol *type)
+{
+	warn_for_different_enum_types (expr, type);
+	warn_for_enum_to_int_conversion (expr, type);
+	warn_for_int_to_enum_conversion (expr, type);
+}
+
 /*
  * This gets called for implicit casts in assignments and
  * integer promotion. We often want to try to move the
@@ -267,7 +345,7 @@ static struct expression * cast_to(struct expression *o=
ld, struct symbol *type)
 {
 	struct expression *expr;
=20
=2D	warn_for_different_enum_types (old->pos, old->ctype, type);
+	warn_for_enum_conversions(old, type);
=20
 	if (old->ctype !=3D &null_ctype && is_same_type(old, type))
 		return old;
@@ -287,8 +365,6 @@ static struct expression * cast_to(struct expression *o=
ld, struct symbol *type)
 		break;
=20
 	case EXPR_IMPLIED_CAST:
=2D		warn_for_different_enum_types(old->pos, old->ctype, type);
=2D
 		if (old->ctype->bit_size >=3D type->bit_size) {
 			struct expression *orig =3D old->cast_expression;
 			if (same_cast_type(orig->ctype, type))
@@ -498,7 +574,8 @@ static struct symbol *usual_conversions(int op,
 {
 	struct symbol *ctype;
=20
=2D	warn_for_different_enum_types(right->pos, left->ctype, right->ctype);
+	/* FIXME: we should either write a test-case for it or delete it */
+	warn_for_enum_conversions(left, right->ctype);
=20
 	if ((lclass | rclass) & TYPE_RESTRICT)
 		goto Restr;
@@ -3225,8 +3302,7 @@ static void evaluate_case_statement(struct statement =
*stmt)
 }
=20
 static void check_case_type(struct expression *switch_expr,
=2D			    struct expression *case_expr,
=2D			    struct expression **enumcase)
+			    struct expression *case_expr)
 {
 	struct symbol *switch_type, *case_type;
 	int sclass, cclass;
@@ -3239,12 +3315,8 @@ static void check_case_type(struct expression *switc=
h_expr,
=20
 	if (!switch_type || !case_type)
 		goto Bad;
=2D	if (enumcase) {
=2D		if (*enumcase)
=2D			warn_for_different_enum_types(case_expr->pos, case_type, (*enumcase)-=
>ctype);
=2D		else if (is_enum_type(case_type))
=2D			*enumcase =3D case_expr;
=2D	}
+
+	warn_for_enum_conversions(case_expr, switch_type);
=20
 	sclass =3D classify_type(switch_type, &switch_type);
 	cclass =3D classify_type(case_type, &case_type);
@@ -3275,21 +3347,17 @@ Bad:
 static void evaluate_switch_statement(struct statement *stmt)
 {
 	struct symbol *sym;
=2D	struct expression *enumcase =3D NULL;
=2D	struct expression **enumcase_holder =3D &enumcase;
 	struct expression *sel =3D stmt->switch_expression;
=20
 	evaluate_expression(sel);
 	evaluate_statement(stmt->switch_statement);
 	if (!sel)
 		return;
=2D	if (sel->ctype && is_enum_type(sel->ctype))
=2D		enumcase_holder =3D NULL; /* Only check cases against switch */
=20
 	FOR_EACH_PTR(stmt->switch_case->symbol_list, sym) {
 		struct statement *case_stmt =3D sym->stmt;
=2D		check_case_type(sel, case_stmt->case_expression, enumcase_holder);
=2D		check_case_type(sel, case_stmt->case_to, enumcase_holder);
+		check_case_type(sel, case_stmt->case_expression);
+		check_case_type(sel, case_stmt->case_to);
 	} END_FOR_EACH_PTR(sym);
 }
=20
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
index d7fe444..288b3a8 100644
=2D-- a/sparse.1
+++ b/sparse.1
@@ -149,6 +149,19 @@ Sparse issues these warnings by default.  To turn them=
 off, use
 \fB\-Wno\-enum\-mismatch\fR.
 .
 .TP
+.B \-Wenum\-to\-int
+Warn about converting an \fBenum\fR type to int. An explicit cast to int w=
ill
+suppress this warning.
+.
+.TP
+.B \-Wint\-to\-enum
+Warn about converting int to \fBenum\fR type. An explicit cast to the right
+\fBenum\fR type will suppress this warning.
+
+Sparse issues these warnings by default.  To turn them off, use
+\fB\-Wno\-int\-to\-enum\fR.
+.
+.TP
 .B \-Wnon\-pointer\-null
 Warn about the use of 0 as a NULL pointer.
=20
diff --git a/validation/enum-common.c b/validation/enum-common.c
new file mode 100644
index 0000000..f940fef
=2D-- /dev/null
+++ b/validation/enum-common.c
@@ -0,0 +1,112 @@
+static enum ENUM_TYPE_A { VALUE_A } var_a;
+static enum ENUM_TYPE_B { VALUE_B } var_b;
+static enum /* anon. */ { VALUE_C } anon_enum_var;
+static int i;
+
+static void take_enum_of_type_a(enum ENUM_TYPE_A arg_enum)
+{
+	(void) arg_enum;
+}
+
+static void take_int(int arg_int)
+{
+	(void) arg_int;
+}
+
+static void always_ok(void)
+{
+	var_a ++;
+	var_a =3D VALUE_A;
+	var_a =3D (enum ENUM_TYPE_A) VALUE_B;
+	var_b =3D (enum ENUM_TYPE_B) i;
+	i =3D (int) VALUE_A;
+	anon_enum_var =3D VALUE_C;
+	i =3D VALUE_C;
+	i =3D anon_enum_var;
+	i =3D 7;
+	var_a =3D (enum ENUM_TYPE_A) 0;
+	anon_enum_var =3D (__typeof__(anon_enum_var)) 0;
+	anon_enum_var =3D (__typeof__(anon_enum_var)) VALUE_A;
+
+	switch (var_a) {
+		case VALUE_A:
+		default:
+			take_enum_of_type_a(var_a);
+			take_enum_of_type_a(VALUE_A);
+	}
+
+	switch (anon_enum_var) {
+		case VALUE_C:
+		default:
+			take_int(anon_enum_var);
+	}
+
+	switch (i) {
+		case VALUE_C:
+		default:
+			take_int(VALUE_C);
+	}
+}
+
+static void trigger_enum_mismatch(void)
+{
+	switch (var_a) {
+		case VALUE_B:
+		case VALUE_C:
+		default:
+			take_enum_of_type_a(var_b);
+			take_enum_of_type_a(VALUE_B);
+	}
+
+	switch (anon_enum_var) {
+		case VALUE_A:
+		default:
+			take_enum_of_type_a(anon_enum_var);
+			take_enum_of_type_a(VALUE_C);
+	}
+
+	// this has been already working in sparse 0.4.1
+	var_a =3D var_b;
+	var_b =3D anon_enum_var;
+	anon_enum_var =3D var_a;
+
+	// implemented after sparse 0.4.1
+	var_a =3D VALUE_B;
+	var_b =3D VALUE_C;
+	anon_enum_var =3D VALUE_A;
+}
+
+static void trigger_int_to_enum_conversion(void)
+{
+	switch (var_a) {
+		case 0:
+		default:
+			take_enum_of_type_a(i);
+			take_enum_of_type_a(7);
+	}
+	var_a =3D 0;
+	var_b =3D i;
+	anon_enum_var =3D 0;
+	anon_enum_var =3D i;
+	var_a =3D (int) VALUE_A;
+	var_a =3D (int) VALUE_B;
+}
+
+static void trigger_enum_to_int_conversion(void)
+{
+	i =3D var_a;
+	i =3D VALUE_B;
+	switch (i) {
+		case VALUE_A:
+		case VALUE_B:
+		default:
+			take_int(var_a);
+			take_int(VALUE_B);
+	}
+}
+
+/*
+ * check-name: enum-common
+ * check-description: common part of the test for -Wenum-mismatch, -Wenum-=
to-int and -Wint-to-enum
+ * check-command: sparse -Wno-enum-mismatch -Wno-int-to-enum $file
+ */
diff --git a/validation/enum-from-int.c b/validation/enum-from-int.c
new file mode 100644
index 0000000..15b1e4d
=2D-- /dev/null
+++ b/validation/enum-from-int.c
@@ -0,0 +1,36 @@
+#include "enum-common.c"
+
+/*
+ * check-name: -Wint-to-enum
+ * check-command: sparse -Wno-enum-mismatch $file
+ *
+ * check-error-start
+enum-common.c:84:45: warning: conversion of
+enum-common.c:84:45:     int to
+enum-common.c:84:45:     int enum ENUM_TYPE_A=20
+enum-common.c:85:45: warning: conversion of
+enum-common.c:85:45:     int to
+enum-common.c:85:45:     int enum ENUM_TYPE_A=20
+enum-common.c:82:22: warning: conversion of
+enum-common.c:82:22:     int to
+enum-common.c:82:22:     int enum ENUM_TYPE_A=20
+enum-common.c:87:17: warning: conversion of
+enum-common.c:87:17:     int to
+enum-common.c:87:17:     int enum ENUM_TYPE_A=20
+enum-common.c:88:17: warning: conversion of
+enum-common.c:88:17:     int to
+enum-common.c:88:17:     int enum ENUM_TYPE_B=20
+enum-common.c:89:25: warning: conversion of
+enum-common.c:89:25:     int to
+enum-common.c:89:25:     int enum <noident>=20
+enum-common.c:90:25: warning: conversion of
+enum-common.c:90:25:     int to
+enum-common.c:90:25:     int enum <noident>=20
+enum-common.c:91:18: warning: conversion of
+enum-common.c:91:18:     int to
+enum-common.c:91:18:     int enum ENUM_TYPE_A=20
+enum-common.c:92:18: warning: conversion of
+enum-common.c:92:18:     int to
+enum-common.c:92:18:     int enum ENUM_TYPE_A=20
+ * check-error-end
+ */
diff --git a/validation/enum-mismatch.c b/validation/enum-mismatch.c
new file mode 100644
index 0000000..6db016f
=2D-- /dev/null
+++ b/validation/enum-mismatch.c
@@ -0,0 +1,48 @@
+#include "enum-common.c"
+
+/*
+ * check-name: -Wenum-mismatch
+ * check-command: sparse -Wenum-mismatch -Wno-int-to-enum $file
+ *
+ * check-error-start
+enum-common.c:57:45: warning: mixing different enum types
+enum-common.c:57:45:     int enum ENUM_TYPE_B  versus
+enum-common.c:57:45:     int enum ENUM_TYPE_A=20
+enum-common.c:58:45: warning: mixing different enum types
+enum-common.c:58:45:     int enum ENUM_TYPE_B  versus
+enum-common.c:58:45:     int enum ENUM_TYPE_A=20
+enum-common.c:54:22: warning: mixing different enum types
+enum-common.c:54:22:     int enum ENUM_TYPE_B  versus
+enum-common.c:54:22:     int enum ENUM_TYPE_A=20
+enum-common.c:55:22: warning: mixing different enum types
+enum-common.c:55:22:     int enum <noident>  versus
+enum-common.c:55:22:     int enum ENUM_TYPE_A=20
+enum-common.c:64:45: warning: mixing different enum types
+enum-common.c:64:45:     int enum <noident>  versus
+enum-common.c:64:45:     int enum ENUM_TYPE_A=20
+enum-common.c:65:45: warning: mixing different enum types
+enum-common.c:65:45:     int enum <noident>  versus
+enum-common.c:65:45:     int enum ENUM_TYPE_A=20
+enum-common.c:62:22: warning: mixing different enum types
+enum-common.c:62:22:     int enum ENUM_TYPE_A  versus
+enum-common.c:62:22:     int enum <noident>=20
+enum-common.c:69:17: warning: mixing different enum types
+enum-common.c:69:17:     int enum ENUM_TYPE_B  versus
+enum-common.c:69:17:     int enum ENUM_TYPE_A=20
+enum-common.c:70:17: warning: mixing different enum types
+enum-common.c:70:17:     int enum <noident>  versus
+enum-common.c:70:17:     int enum ENUM_TYPE_B=20
+enum-common.c:71:25: warning: mixing different enum types
+enum-common.c:71:25:     int enum ENUM_TYPE_A  versus
+enum-common.c:71:25:     int enum <noident>=20
+enum-common.c:74:17: warning: mixing different enum types
+enum-common.c:74:17:     int enum ENUM_TYPE_B  versus
+enum-common.c:74:17:     int enum ENUM_TYPE_A=20
+enum-common.c:75:17: warning: mixing different enum types
+enum-common.c:75:17:     int enum <noident>  versus
+enum-common.c:75:17:     int enum ENUM_TYPE_B=20
+enum-common.c:76:25: warning: mixing different enum types
+enum-common.c:76:25:     int enum ENUM_TYPE_A  versus
+enum-common.c:76:25:     int enum <noident>=20
+ * check-error-end
+ */
diff --git a/validation/enum-to-int.c b/validation/enum-to-int.c
new file mode 100644
index 0000000..a981ce5
=2D-- /dev/null
+++ b/validation/enum-to-int.c
@@ -0,0 +1,27 @@
+#include "enum-common.c"
+
+/*
+ * check-name: -Wenum-to-int
+ * check-command: sparse -Wenum-to-int -Wno-enum-mismatch -Wno-int-to-enum=
 $file
+ *
+ * check-error-start
+enum-common.c:97:13: warning: conversion of
+enum-common.c:97:13:     int enum ENUM_TYPE_A  to
+enum-common.c:97:13:     int
+enum-common.c:98:13: warning: conversion of
+enum-common.c:98:13:     int enum ENUM_TYPE_B  to
+enum-common.c:98:13:     int
+enum-common.c:103:34: warning: conversion of
+enum-common.c:103:34:     int enum ENUM_TYPE_A  to
+enum-common.c:103:34:     int
+enum-common.c:104:34: warning: conversion of
+enum-common.c:104:34:     int enum ENUM_TYPE_B  to
+enum-common.c:104:34:     int
+enum-common.c:100:22: warning: conversion of
+enum-common.c:100:22:     int enum ENUM_TYPE_A  to
+enum-common.c:100:22:     int
+enum-common.c:101:22: warning: conversion of
+enum-common.c:101:22:     int enum ENUM_TYPE_B  to
+enum-common.c:101:22:     int
+ * check-error-end
+ */
=2D-=20
1.6.4.1


--Boundary-00=_LNvnKKkx2k3i5j3--
