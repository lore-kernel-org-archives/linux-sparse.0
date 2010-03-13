From: Kamil Dudka <kdudka@redhat.com>
Subject: Re: Sparse crash when mixing int and enum in ternary operator
Date: Sat, 13 Mar 2010 18:22:48 +0100
Message-ID: <201003131822.49308.kdudka@redhat.com>
References: <1268097872.16227.10.camel@mj> <201003101705.36304.kdudka@redhat.com> <70318cbf1003101356u48688264na5c9d71bc1ef4300@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_pn8mLhuX/lPjn+C"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33793 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932922Ab0CMRYq (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sat, 13 Mar 2010 12:24:46 -0500
In-Reply-To: <70318cbf1003101356u48688264na5c9d71bc1ef4300@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Pavel Roskin <proski@gnu.org>, Josh Triplett <josh@joshtriplett.org>, linux-sparse@vger.kernel.org

--Boundary-00=_pn8mLhuX/lPjn+C
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 10 of March 2010 22:56:15 Christopher Li wrote:
> I feel that we shouldn't do special handling for EXPR_CONDITIONAL here.
> We should just make the warn_for_enum_conversions more robust.
> Special handing EXPR_CONDITIONAL here is just an one off thing.
> What if there is a nested EXPR_CONDITIONAL inside the expr->cond_true?
> See, your do_warn_for_enum_conversions() still need to handle
> EXPR_CONDITIONAL any way. So I argue that we don't need that
> special case for EXPR_CONDITIONAL here.

Indeed, you're right.  This flaw should be fixed in the attached patch.

I was unsuscessfully looking for an implementation of stack within sparse.
So that I used the implicit one instead.  I know it's pretty bad idea, but
I am not aware of any easy way to handle it better.

> BTW, EXPR_SELECT only appear after expand stage. So you should not
> see EXPR_SELECT in the evaluate stage.

It makes sense, so that I've inserted assert(0) there.

Thank you for the review!  A pair of the improved patches is attached.

Kamil

--Boundary-00=_pn8mLhuX/lPjn+C
Content-Type: text/x-diff;
  charset="iso 8859-15";
  name="0001-Wenum-to-int-is-now-emitted-only-when-it-makes-sense.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-Wenum-to-int-is-now-emitted-only-when-it-makes-sense.patch"

=46rom 73ff23e581cfb98b9460def7921b3c521b1a2410 Mon Sep 17 00:00:00 2001
=46rom: Kamil Dudka <kdudka@redhat.com>
Date: Sat, 13 Mar 2010 17:59:22 +0100
Subject: [PATCH 1/2] -Wenum-to-int is now emitted only when it makes sense

=2E.. namely in case of initialization, assignment and switch

Signed-off-by: Kamil Dudka <kdudka@redhat.com>
=2D--
 evaluate.c                 |    3 +-
 validation/enum-common.c   |    2 +
 validation/enum-from-int.c |   32 ++++++++++++------------
 validation/enum-mismatch.c |   58 ++++++++++++++++++++++------------------=
=2D---
 validation/enum-to-int.c   |   39 ++++++++++++++++-------------
 5 files changed, 70 insertions(+), 64 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index d3d5e6f..eb1704a 100644
=2D-- a/evaluate.c
+++ b/evaluate.c
@@ -330,7 +330,6 @@ static void
 warn_for_enum_conversions(struct expression *expr, struct symbol *type)
 {
 	warn_for_different_enum_types (expr, type);
=2D	warn_for_enum_to_int_conversion (expr, type);
 	warn_for_int_to_enum_conversion (expr, type);
 }
=20
@@ -1447,6 +1446,7 @@ Err:
 	*rp =3D cast_to(*rp, target);
 	return 0;
 Cast:
+	warn_for_enum_to_int_conversion(*rp, target);
 	*rp =3D cast_to(*rp, target);
 	return 1;
 }
@@ -3326,6 +3326,7 @@ static void check_case_type(struct expression *switch=
_expr,
 	if (!switch_type || !case_type)
 		goto Bad;
=20
+	warn_for_enum_to_int_conversion(case_expr, switch_type);
 	warn_for_enum_conversions(case_expr, switch_type);
=20
 	sclass =3D classify_type(switch_type, &switch_type);
diff --git a/validation/enum-common.c b/validation/enum-common.c
index f940fef..4685cdf 100644
=2D-- a/validation/enum-common.c
+++ b/validation/enum-common.c
@@ -27,6 +27,7 @@ static void always_ok(void)
 	var_a =3D (enum ENUM_TYPE_A) 0;
 	anon_enum_var =3D (__typeof__(anon_enum_var)) 0;
 	anon_enum_var =3D (__typeof__(anon_enum_var)) VALUE_A;
+	i =3D (var_a =3D=3D VALUE_A);
=20
 	switch (var_a) {
 		case VALUE_A:
@@ -94,6 +95,7 @@ static void trigger_int_to_enum_conversion(void)
=20
 static void trigger_enum_to_int_conversion(void)
 {
+	int other =3D var_a;
 	i =3D var_a;
 	i =3D VALUE_B;
 	switch (i) {
diff --git a/validation/enum-from-int.c b/validation/enum-from-int.c
index 15b1e4d..4dc63a8 100644
=2D-- a/validation/enum-from-int.c
+++ b/validation/enum-from-int.c
@@ -5,32 +5,32 @@
  * check-command: sparse -Wno-enum-mismatch $file
  *
  * check-error-start
=2Denum-common.c:84:45: warning: conversion of
=2Denum-common.c:84:45:     int to
=2Denum-common.c:84:45:     int enum ENUM_TYPE_A=20
 enum-common.c:85:45: warning: conversion of
 enum-common.c:85:45:     int to
 enum-common.c:85:45:     int enum ENUM_TYPE_A=20
=2Denum-common.c:82:22: warning: conversion of
=2Denum-common.c:82:22:     int to
=2Denum-common.c:82:22:     int enum ENUM_TYPE_A=20
=2Denum-common.c:87:17: warning: conversion of
=2Denum-common.c:87:17:     int to
=2Denum-common.c:87:17:     int enum ENUM_TYPE_A=20
+enum-common.c:86:45: warning: conversion of
+enum-common.c:86:45:     int to
+enum-common.c:86:45:     int enum ENUM_TYPE_A=20
+enum-common.c:83:22: warning: conversion of
+enum-common.c:83:22:     int to
+enum-common.c:83:22:     int enum ENUM_TYPE_A=20
 enum-common.c:88:17: warning: conversion of
 enum-common.c:88:17:     int to
=2Denum-common.c:88:17:     int enum ENUM_TYPE_B=20
=2Denum-common.c:89:25: warning: conversion of
=2Denum-common.c:89:25:     int to
=2Denum-common.c:89:25:     int enum <noident>=20
+enum-common.c:88:17:     int enum ENUM_TYPE_A=20
+enum-common.c:89:17: warning: conversion of
+enum-common.c:89:17:     int to
+enum-common.c:89:17:     int enum ENUM_TYPE_B=20
 enum-common.c:90:25: warning: conversion of
 enum-common.c:90:25:     int to
 enum-common.c:90:25:     int enum <noident>=20
=2Denum-common.c:91:18: warning: conversion of
=2Denum-common.c:91:18:     int to
=2Denum-common.c:91:18:     int enum ENUM_TYPE_A=20
+enum-common.c:91:25: warning: conversion of
+enum-common.c:91:25:     int to
+enum-common.c:91:25:     int enum <noident>=20
 enum-common.c:92:18: warning: conversion of
 enum-common.c:92:18:     int to
 enum-common.c:92:18:     int enum ENUM_TYPE_A=20
+enum-common.c:93:18: warning: conversion of
+enum-common.c:93:18:     int to
+enum-common.c:93:18:     int enum ENUM_TYPE_A=20
  * check-error-end
  */
diff --git a/validation/enum-mismatch.c b/validation/enum-mismatch.c
index 6db016f..b1a4369 100644
=2D-- a/validation/enum-mismatch.c
+++ b/validation/enum-mismatch.c
@@ -5,44 +5,44 @@
  * check-command: sparse -Wenum-mismatch -Wno-int-to-enum $file
  *
  * check-error-start
=2Denum-common.c:57:45: warning: mixing different enum types
=2Denum-common.c:57:45:     int enum ENUM_TYPE_B  versus
=2Denum-common.c:57:45:     int enum ENUM_TYPE_A=20
 enum-common.c:58:45: warning: mixing different enum types
 enum-common.c:58:45:     int enum ENUM_TYPE_B  versus
 enum-common.c:58:45:     int enum ENUM_TYPE_A=20
=2Denum-common.c:54:22: warning: mixing different enum types
=2Denum-common.c:54:22:     int enum ENUM_TYPE_B  versus
=2Denum-common.c:54:22:     int enum ENUM_TYPE_A=20
+enum-common.c:59:45: warning: mixing different enum types
+enum-common.c:59:45:     int enum ENUM_TYPE_B  versus
+enum-common.c:59:45:     int enum ENUM_TYPE_A=20
 enum-common.c:55:22: warning: mixing different enum types
=2Denum-common.c:55:22:     int enum <noident>  versus
+enum-common.c:55:22:     int enum ENUM_TYPE_B  versus
 enum-common.c:55:22:     int enum ENUM_TYPE_A=20
=2Denum-common.c:64:45: warning: mixing different enum types
=2Denum-common.c:64:45:     int enum <noident>  versus
=2Denum-common.c:64:45:     int enum ENUM_TYPE_A=20
+enum-common.c:56:22: warning: mixing different enum types
+enum-common.c:56:22:     int enum <noident>  versus
+enum-common.c:56:22:     int enum ENUM_TYPE_A=20
 enum-common.c:65:45: warning: mixing different enum types
 enum-common.c:65:45:     int enum <noident>  versus
 enum-common.c:65:45:     int enum ENUM_TYPE_A=20
=2Denum-common.c:62:22: warning: mixing different enum types
=2Denum-common.c:62:22:     int enum ENUM_TYPE_A  versus
=2Denum-common.c:62:22:     int enum <noident>=20
=2Denum-common.c:69:17: warning: mixing different enum types
=2Denum-common.c:69:17:     int enum ENUM_TYPE_B  versus
=2Denum-common.c:69:17:     int enum ENUM_TYPE_A=20
+enum-common.c:66:45: warning: mixing different enum types
+enum-common.c:66:45:     int enum <noident>  versus
+enum-common.c:66:45:     int enum ENUM_TYPE_A=20
+enum-common.c:63:22: warning: mixing different enum types
+enum-common.c:63:22:     int enum ENUM_TYPE_A  versus
+enum-common.c:63:22:     int enum <noident>=20
 enum-common.c:70:17: warning: mixing different enum types
=2Denum-common.c:70:17:     int enum <noident>  versus
=2Denum-common.c:70:17:     int enum ENUM_TYPE_B=20
=2Denum-common.c:71:25: warning: mixing different enum types
=2Denum-common.c:71:25:     int enum ENUM_TYPE_A  versus
=2Denum-common.c:71:25:     int enum <noident>=20
=2Denum-common.c:74:17: warning: mixing different enum types
=2Denum-common.c:74:17:     int enum ENUM_TYPE_B  versus
=2Denum-common.c:74:17:     int enum ENUM_TYPE_A=20
+enum-common.c:70:17:     int enum ENUM_TYPE_B  versus
+enum-common.c:70:17:     int enum ENUM_TYPE_A=20
+enum-common.c:71:17: warning: mixing different enum types
+enum-common.c:71:17:     int enum <noident>  versus
+enum-common.c:71:17:     int enum ENUM_TYPE_B=20
+enum-common.c:72:25: warning: mixing different enum types
+enum-common.c:72:25:     int enum ENUM_TYPE_A  versus
+enum-common.c:72:25:     int enum <noident>=20
 enum-common.c:75:17: warning: mixing different enum types
=2Denum-common.c:75:17:     int enum <noident>  versus
=2Denum-common.c:75:17:     int enum ENUM_TYPE_B=20
=2Denum-common.c:76:25: warning: mixing different enum types
=2Denum-common.c:76:25:     int enum ENUM_TYPE_A  versus
=2Denum-common.c:76:25:     int enum <noident>=20
+enum-common.c:75:17:     int enum ENUM_TYPE_B  versus
+enum-common.c:75:17:     int enum ENUM_TYPE_A=20
+enum-common.c:76:17: warning: mixing different enum types
+enum-common.c:76:17:     int enum <noident>  versus
+enum-common.c:76:17:     int enum ENUM_TYPE_B=20
+enum-common.c:77:25: warning: mixing different enum types
+enum-common.c:77:25:     int enum ENUM_TYPE_A  versus
+enum-common.c:77:25:     int enum <noident>=20
  * check-error-end
  */
diff --git a/validation/enum-to-int.c b/validation/enum-to-int.c
index a981ce5..78a31e9 100644
=2D-- a/validation/enum-to-int.c
+++ b/validation/enum-to-int.c
@@ -5,23 +5,26 @@
  * check-command: sparse -Wenum-to-int -Wno-enum-mismatch -Wno-int-to-enum=
 $file
  *
  * check-error-start
=2Denum-common.c:97:13: warning: conversion of
=2Denum-common.c:97:13:     int enum ENUM_TYPE_A  to
=2Denum-common.c:97:13:     int
=2Denum-common.c:98:13: warning: conversion of
=2Denum-common.c:98:13:     int enum ENUM_TYPE_B  to
=2Denum-common.c:98:13:     int
=2Denum-common.c:103:34: warning: conversion of
=2Denum-common.c:103:34:     int enum ENUM_TYPE_A  to
=2Denum-common.c:103:34:     int
=2Denum-common.c:104:34: warning: conversion of
=2Denum-common.c:104:34:     int enum ENUM_TYPE_B  to
=2Denum-common.c:104:34:     int
=2Denum-common.c:100:22: warning: conversion of
=2Denum-common.c:100:22:     int enum ENUM_TYPE_A  to
=2Denum-common.c:100:22:     int
=2Denum-common.c:101:22: warning: conversion of
=2Denum-common.c:101:22:     int enum ENUM_TYPE_B  to
=2Denum-common.c:101:22:     int
+enum-common.c:98:21: warning: conversion of
+enum-common.c:98:21:     int enum ENUM_TYPE_A  to
+enum-common.c:98:21:     int
+enum-common.c:99:13: warning: conversion of
+enum-common.c:99:13:     int enum ENUM_TYPE_A  to
+enum-common.c:99:13:     int
+enum-common.c:100:13: warning: conversion of
+enum-common.c:100:13:     int enum ENUM_TYPE_B  to
+enum-common.c:100:13:     int
+enum-common.c:105:34: warning: conversion of
+enum-common.c:105:34:     int enum ENUM_TYPE_A  to
+enum-common.c:105:34:     int
+enum-common.c:106:34: warning: conversion of
+enum-common.c:106:34:     int enum ENUM_TYPE_B  to
+enum-common.c:106:34:     int
+enum-common.c:102:22: warning: conversion of
+enum-common.c:102:22:     int enum ENUM_TYPE_A  to
+enum-common.c:102:22:     int
+enum-common.c:103:22: warning: conversion of
+enum-common.c:103:22:     int enum ENUM_TYPE_B  to
+enum-common.c:103:22:     int
  * check-error-end
  */
=2D-=20
1.7.0.2


--Boundary-00=_pn8mLhuX/lPjn+C
Content-Type: text/x-diff;
  charset="iso 8859-15";
  name="0002-Wenum-mismatch-now-works-better-with-conditional-op.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0002-Wenum-mismatch-now-works-better-with-conditional-op.patch"

=46rom 9dd4013046ef64d4ac7d09c336e69a3edf504ded Mon Sep 17 00:00:00 2001
=46rom: Kamil Dudka <kdudka@redhat.com>
Date: Sat, 13 Mar 2010 18:07:51 +0100
Subject: [PATCH 2/2] -Wenum-mismatch now works better with conditional op.

It used to crash instead of reporting the warnings properly.  Reported
by Pavel Roskin.

Signed-off-by: Kamil Dudka <kdudka@redhat.com>
=2D--
 evaluate.c                 |   35 +++++++++++++---
 validation/enum-common.c   |   15 +++++++
 validation/enum-from-int.c |   63 ++++++++++++++++------------
 validation/enum-mismatch.c |  100 +++++++++++++++++++++++++++-------------=
=2D---
 validation/enum-to-int.c   |   42 +++++++++---------
 5 files changed, 163 insertions(+), 92 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index eb1704a..ec96a71 100644
=2D-- a/evaluate.c
+++ b/evaluate.c
@@ -8,6 +8,7 @@
  *
  * Evaluate constant expressions.
  */
+#include <assert.h>
 #include <stdlib.h>
 #include <stdarg.h>
 #include <stddef.h>
@@ -235,7 +236,7 @@ static int is_same_type(struct expression *expr, struct=
 symbol *new)
 }
=20
 static void
=2Dresolve_sym_node (struct symbol **psym)
+resolve_sym_node(struct symbol **psym)
 {
 	struct symbol *sym =3D *psym;
 	if (sym->type =3D=3D SYM_NODE)
@@ -243,7 +244,7 @@ resolve_sym_node (struct symbol **psym)
 }
=20
 static void
=2Dwarn_for_different_enum_types (struct expression *expr, struct symbol *t=
ypeb)
+warn_for_different_enum_types(struct expression *expr, struct symbol *type=
b)
 {
 	struct position pos =3D expr->pos;
 	struct symbol *typea =3D expr->ctype;
@@ -284,7 +285,7 @@ issue_conversion_warning(struct position pos,
 }
=20
 static void
=2Dwarn_for_enum_to_int_conversion (struct expression *expr, struct symbol =
*typeb)
+warn_for_enum_to_int_conversion(struct expression *expr, struct symbol *ty=
peb)
 {
 	struct position pos =3D expr->pos;
 	struct symbol *typea =3D expr->ctype;
@@ -307,7 +308,7 @@ warn_for_enum_to_int_conversion (struct expression *exp=
r, struct symbol *typeb)
 }
=20
 static void
=2Dwarn_for_int_to_enum_conversion (struct expression *expr, struct symbol =
*typeb)
+warn_for_int_to_enum_conversion(struct expression *expr, struct symbol *ty=
peb)
 {
 	struct position pos =3D expr->pos;
 	struct symbol *typea =3D expr->ctype;
@@ -329,8 +330,30 @@ warn_for_int_to_enum_conversion (struct expression *ex=
pr, struct symbol *typeb)
 static void
 warn_for_enum_conversions(struct expression *expr, struct symbol *type)
 {
=2D	warn_for_different_enum_types (expr, type);
=2D	warn_for_int_to_enum_conversion (expr, type);
+	assert(expr);
+	assert(type);
+
+	/* look through implied cast(s) */
+	while (expr->type =3D=3D EXPR_IMPLIED_CAST)
+		expr =3D expr->cast_expression;
+
+	switch (expr->type) {
+	case EXPR_SELECT:
+		/* EXPR_SELECT should not appear in the evaluate stage */
+		assert(0);
+
+	case EXPR_CONDITIONAL:
+		warn_for_enum_conversions(expr->cond_true
+					  /* handle the "?:" quirk */
+					  ?: expr->conditional,
+					  type);
+		warn_for_enum_conversions(expr->cond_false, type);
+		break;
+
+	default:
+		warn_for_different_enum_types(expr, type);
+		warn_for_int_to_enum_conversion(expr, type);
+	}
 }
=20
 /*
diff --git a/validation/enum-common.c b/validation/enum-common.c
index 4685cdf..24fef59 100644
=2D-- a/validation/enum-common.c
+++ b/validation/enum-common.c
@@ -47,6 +47,10 @@ static void always_ok(void)
 		default:
 			take_int(VALUE_C);
 	}
+
+	var_a =3D var_b ? var_a : VALUE_A;
+	var_b =3D VALUE_A ? VALUE_B : var_b;
+	take_enum_of_type_a(var_a ?: var_a);
 }
=20
 static void trigger_enum_mismatch(void)
@@ -75,6 +79,13 @@ static void trigger_enum_mismatch(void)
 	var_a =3D VALUE_B;
 	var_b =3D VALUE_C;
 	anon_enum_var =3D VALUE_A;
+
+	// conditional operator
+	anon_enum_var =3D i ? VALUE_A : VALUE_B;
+	var_a =3D anon_enum_var ? VALUE_A : VALUE_B;
+	var_b =3D anon_enum_var ? VALUE_A : VALUE_B;
+	take_enum_of_type_a(var_a ?: var_b);
+	take_enum_of_type_a(var_b ?: var_a);
 }
=20
 static void trigger_int_to_enum_conversion(void)
@@ -91,6 +102,10 @@ static void trigger_int_to_enum_conversion(void)
 	anon_enum_var =3D i;
 	var_a =3D (int) VALUE_A;
 	var_a =3D (int) VALUE_B;
+
+	// conditional operator
+	take_enum_of_type_a(var_a ?: i);
+	take_enum_of_type_a(i ?: var_a);
 }
=20
 static void trigger_enum_to_int_conversion(void)
diff --git a/validation/enum-from-int.c b/validation/enum-from-int.c
index 4dc63a8..6465235 100644
=2D-- a/validation/enum-from-int.c
+++ b/validation/enum-from-int.c
@@ -5,32 +5,41 @@
  * check-command: sparse -Wno-enum-mismatch $file
  *
  * check-error-start
=2Denum-common.c:85:45: warning: conversion of
=2Denum-common.c:85:45:     int to
=2Denum-common.c:85:45:     int enum ENUM_TYPE_A=20
=2Denum-common.c:86:45: warning: conversion of
=2Denum-common.c:86:45:     int to
=2Denum-common.c:86:45:     int enum ENUM_TYPE_A=20
=2Denum-common.c:83:22: warning: conversion of
=2Denum-common.c:83:22:     int to
=2Denum-common.c:83:22:     int enum ENUM_TYPE_A=20
=2Denum-common.c:88:17: warning: conversion of
=2Denum-common.c:88:17:     int to
=2Denum-common.c:88:17:     int enum ENUM_TYPE_A=20
=2Denum-common.c:89:17: warning: conversion of
=2Denum-common.c:89:17:     int to
=2Denum-common.c:89:17:     int enum ENUM_TYPE_B=20
=2Denum-common.c:90:25: warning: conversion of
=2Denum-common.c:90:25:     int to
=2Denum-common.c:90:25:     int enum <noident>=20
=2Denum-common.c:91:25: warning: conversion of
=2Denum-common.c:91:25:     int to
=2Denum-common.c:91:25:     int enum <noident>=20
=2Denum-common.c:92:18: warning: conversion of
=2Denum-common.c:92:18:     int to
=2Denum-common.c:92:18:     int enum ENUM_TYPE_A=20
=2Denum-common.c:93:18: warning: conversion of
=2Denum-common.c:93:18:     int to
=2Denum-common.c:93:18:     int enum ENUM_TYPE_A=20
+enum-common.c:96:45: warning: conversion of
+enum-common.c:96:45:     int to
+enum-common.c:96:45:     int enum ENUM_TYPE_A=20
+enum-common.c:97:45: warning: conversion of
+enum-common.c:97:45:     int to
+enum-common.c:97:45:     int enum ENUM_TYPE_A=20
+enum-common.c:94:22: warning: conversion of
+enum-common.c:94:22:     int to
+enum-common.c:94:22:     int enum ENUM_TYPE_A=20
+enum-common.c:99:17: warning: conversion of
+enum-common.c:99:17:     int to
+enum-common.c:99:17:     int enum ENUM_TYPE_A=20
+enum-common.c:100:17: warning: conversion of
+enum-common.c:100:17:     int to
+enum-common.c:100:17:     int enum ENUM_TYPE_B=20
+enum-common.c:101:25: warning: conversion of
+enum-common.c:101:25:     int to
+enum-common.c:101:25:     int enum <noident>=20
+enum-common.c:102:25: warning: conversion of
+enum-common.c:102:25:     int to
+enum-common.c:102:25:     int enum <noident>=20
+enum-common.c:103:18: warning: conversion of
+enum-common.c:103:18:     int to
+enum-common.c:103:18:     int enum ENUM_TYPE_A=20
+enum-common.c:104:18: warning: conversion of
+enum-common.c:104:18:     int to
+enum-common.c:104:18:     int enum ENUM_TYPE_A=20
+enum-common.c:107:38: warning: conversion of
+enum-common.c:107:38:     int to
+enum-common.c:107:38:     int enum ENUM_TYPE_A=20
+enum-common.c:108:29: warning: conversion of
+enum-common.c:108:29:     int to
+enum-common.c:108:29:     int enum ENUM_TYPE_A=20
+enum-common.c:108:29: warning: conversion of
+enum-common.c:108:29:     int to
+enum-common.c:108:29:     int enum ENUM_TYPE_A=20
  * check-error-end
  */
diff --git a/validation/enum-mismatch.c b/validation/enum-mismatch.c
index b1a4369..d8d34dc 100644
=2D-- a/validation/enum-mismatch.c
+++ b/validation/enum-mismatch.c
@@ -5,44 +5,68 @@
  * check-command: sparse -Wenum-mismatch -Wno-int-to-enum $file
  *
  * check-error-start
=2Denum-common.c:58:45: warning: mixing different enum types
=2Denum-common.c:58:45:     int enum ENUM_TYPE_B  versus
=2Denum-common.c:58:45:     int enum ENUM_TYPE_A=20
=2Denum-common.c:59:45: warning: mixing different enum types
=2Denum-common.c:59:45:     int enum ENUM_TYPE_B  versus
=2Denum-common.c:59:45:     int enum ENUM_TYPE_A=20
=2Denum-common.c:55:22: warning: mixing different enum types
=2Denum-common.c:55:22:     int enum ENUM_TYPE_B  versus
=2Denum-common.c:55:22:     int enum ENUM_TYPE_A=20
=2Denum-common.c:56:22: warning: mixing different enum types
=2Denum-common.c:56:22:     int enum <noident>  versus
=2Denum-common.c:56:22:     int enum ENUM_TYPE_A=20
=2Denum-common.c:65:45: warning: mixing different enum types
=2Denum-common.c:65:45:     int enum <noident>  versus
=2Denum-common.c:65:45:     int enum ENUM_TYPE_A=20
=2Denum-common.c:66:45: warning: mixing different enum types
=2Denum-common.c:66:45:     int enum <noident>  versus
=2Denum-common.c:66:45:     int enum ENUM_TYPE_A=20
=2Denum-common.c:63:22: warning: mixing different enum types
=2Denum-common.c:63:22:     int enum ENUM_TYPE_A  versus
=2Denum-common.c:63:22:     int enum <noident>=20
=2Denum-common.c:70:17: warning: mixing different enum types
=2Denum-common.c:70:17:     int enum ENUM_TYPE_B  versus
=2Denum-common.c:70:17:     int enum ENUM_TYPE_A=20
=2Denum-common.c:71:17: warning: mixing different enum types
=2Denum-common.c:71:17:     int enum <noident>  versus
=2Denum-common.c:71:17:     int enum ENUM_TYPE_B=20
=2Denum-common.c:72:25: warning: mixing different enum types
=2Denum-common.c:72:25:     int enum ENUM_TYPE_A  versus
=2Denum-common.c:72:25:     int enum <noident>=20
+enum-common.c:62:45: warning: mixing different enum types
+enum-common.c:62:45:     int enum ENUM_TYPE_B  versus
+enum-common.c:62:45:     int enum ENUM_TYPE_A=20
+enum-common.c:63:45: warning: mixing different enum types
+enum-common.c:63:45:     int enum ENUM_TYPE_B  versus
+enum-common.c:63:45:     int enum ENUM_TYPE_A=20
+enum-common.c:59:22: warning: mixing different enum types
+enum-common.c:59:22:     int enum ENUM_TYPE_B  versus
+enum-common.c:59:22:     int enum ENUM_TYPE_A=20
+enum-common.c:60:22: warning: mixing different enum types
+enum-common.c:60:22:     int enum <noident>  versus
+enum-common.c:60:22:     int enum ENUM_TYPE_A=20
+enum-common.c:69:45: warning: mixing different enum types
+enum-common.c:69:45:     int enum <noident>  versus
+enum-common.c:69:45:     int enum ENUM_TYPE_A=20
+enum-common.c:70:45: warning: mixing different enum types
+enum-common.c:70:45:     int enum <noident>  versus
+enum-common.c:70:45:     int enum ENUM_TYPE_A=20
+enum-common.c:67:22: warning: mixing different enum types
+enum-common.c:67:22:     int enum ENUM_TYPE_A  versus
+enum-common.c:67:22:     int enum <noident>=20
+enum-common.c:74:17: warning: mixing different enum types
+enum-common.c:74:17:     int enum ENUM_TYPE_B  versus
+enum-common.c:74:17:     int enum ENUM_TYPE_A=20
 enum-common.c:75:17: warning: mixing different enum types
=2Denum-common.c:75:17:     int enum ENUM_TYPE_B  versus
=2Denum-common.c:75:17:     int enum ENUM_TYPE_A=20
=2Denum-common.c:76:17: warning: mixing different enum types
=2Denum-common.c:76:17:     int enum <noident>  versus
=2Denum-common.c:76:17:     int enum ENUM_TYPE_B=20
=2Denum-common.c:77:25: warning: mixing different enum types
=2Denum-common.c:77:25:     int enum ENUM_TYPE_A  versus
=2Denum-common.c:77:25:     int enum <noident>=20
+enum-common.c:75:17:     int enum <noident>  versus
+enum-common.c:75:17:     int enum ENUM_TYPE_B=20
+enum-common.c:76:25: warning: mixing different enum types
+enum-common.c:76:25:     int enum ENUM_TYPE_A  versus
+enum-common.c:76:25:     int enum <noident>=20
+enum-common.c:79:17: warning: mixing different enum types
+enum-common.c:79:17:     int enum ENUM_TYPE_B  versus
+enum-common.c:79:17:     int enum ENUM_TYPE_A=20
+enum-common.c:80:17: warning: mixing different enum types
+enum-common.c:80:17:     int enum <noident>  versus
+enum-common.c:80:17:     int enum ENUM_TYPE_B=20
+enum-common.c:81:25: warning: mixing different enum types
+enum-common.c:81:25:     int enum ENUM_TYPE_A  versus
+enum-common.c:81:25:     int enum <noident>=20
+enum-common.c:84:29: warning: mixing different enum types
+enum-common.c:84:29:     int enum ENUM_TYPE_A  versus
+enum-common.c:84:29:     int enum <noident>=20
+enum-common.c:84:39: warning: mixing different enum types
+enum-common.c:84:39:     int enum ENUM_TYPE_B  versus
+enum-common.c:84:39:     int enum <noident>=20
+enum-common.c:85:43: warning: mixing different enum types
+enum-common.c:85:43:     int enum ENUM_TYPE_B  versus
+enum-common.c:85:43:     int enum ENUM_TYPE_A=20
+enum-common.c:86:33: warning: mixing different enum types
+enum-common.c:86:33:     int enum ENUM_TYPE_A  versus
+enum-common.c:86:33:     int enum ENUM_TYPE_B=20
+enum-common.c:87:29: warning: mixing different enum types
+enum-common.c:87:29:     int enum ENUM_TYPE_A  versus
+enum-common.c:87:29:     int enum ENUM_TYPE_B=20
+enum-common.c:87:38: warning: mixing different enum types
+enum-common.c:87:38:     int enum ENUM_TYPE_B  versus
+enum-common.c:87:38:     int enum ENUM_TYPE_A=20
+enum-common.c:88:29: warning: mixing different enum types
+enum-common.c:88:29:     int enum ENUM_TYPE_B  versus
+enum-common.c:88:29:     int enum ENUM_TYPE_A=20
+enum-common.c:88:29: warning: mixing different enum types
+enum-common.c:88:29:     int enum ENUM_TYPE_B  versus
+enum-common.c:88:29:     int enum ENUM_TYPE_A=20
  * check-error-end
  */
diff --git a/validation/enum-to-int.c b/validation/enum-to-int.c
index 78a31e9..68c43fd 100644
=2D-- a/validation/enum-to-int.c
+++ b/validation/enum-to-int.c
@@ -5,26 +5,26 @@
  * check-command: sparse -Wenum-to-int -Wno-enum-mismatch -Wno-int-to-enum=
 $file
  *
  * check-error-start
=2Denum-common.c:98:21: warning: conversion of
=2Denum-common.c:98:21:     int enum ENUM_TYPE_A  to
=2Denum-common.c:98:21:     int
=2Denum-common.c:99:13: warning: conversion of
=2Denum-common.c:99:13:     int enum ENUM_TYPE_A  to
=2Denum-common.c:99:13:     int
=2Denum-common.c:100:13: warning: conversion of
=2Denum-common.c:100:13:     int enum ENUM_TYPE_B  to
=2Denum-common.c:100:13:     int
=2Denum-common.c:105:34: warning: conversion of
=2Denum-common.c:105:34:     int enum ENUM_TYPE_A  to
=2Denum-common.c:105:34:     int
=2Denum-common.c:106:34: warning: conversion of
=2Denum-common.c:106:34:     int enum ENUM_TYPE_B  to
=2Denum-common.c:106:34:     int
=2Denum-common.c:102:22: warning: conversion of
=2Denum-common.c:102:22:     int enum ENUM_TYPE_A  to
=2Denum-common.c:102:22:     int
=2Denum-common.c:103:22: warning: conversion of
=2Denum-common.c:103:22:     int enum ENUM_TYPE_B  to
=2Denum-common.c:103:22:     int
+enum-common.c:113:21: warning: conversion of
+enum-common.c:113:21:     int enum ENUM_TYPE_A  to
+enum-common.c:113:21:     int
+enum-common.c:114:13: warning: conversion of
+enum-common.c:114:13:     int enum ENUM_TYPE_A  to
+enum-common.c:114:13:     int
+enum-common.c:115:13: warning: conversion of
+enum-common.c:115:13:     int enum ENUM_TYPE_B  to
+enum-common.c:115:13:     int
+enum-common.c:120:34: warning: conversion of
+enum-common.c:120:34:     int enum ENUM_TYPE_A  to
+enum-common.c:120:34:     int
+enum-common.c:121:34: warning: conversion of
+enum-common.c:121:34:     int enum ENUM_TYPE_B  to
+enum-common.c:121:34:     int
+enum-common.c:117:22: warning: conversion of
+enum-common.c:117:22:     int enum ENUM_TYPE_A  to
+enum-common.c:117:22:     int
+enum-common.c:118:22: warning: conversion of
+enum-common.c:118:22:     int enum ENUM_TYPE_B  to
+enum-common.c:118:22:     int
  * check-error-end
  */
=2D-=20
1.7.0.2


--Boundary-00=_pn8mLhuX/lPjn+C--
