From: Kamil Dudka <kdudka@redhat.com>
Subject: Re: Sparse crash when mixing int and enum in ternary operator
Date: Wed, 10 Mar 2010 17:05:36 +0100
Message-ID: <201003101705.36304.kdudka@redhat.com>
References: <1268097872.16227.10.camel@mj> <201003100030.50165.kdudka@redhat.com> <1268183362.2615.17.camel@mj>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_QN8lLZRWFo6uc1T"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:25724 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932329Ab0CJQHt (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 10 Mar 2010 11:07:49 -0500
In-Reply-To: <1268183362.2615.17.camel@mj>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
Cc: Josh Triplett <josh@joshtriplett.org>, Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org

--Boundary-00=_QN8lLZRWFo6uc1T
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit

On Wed March 10 2010 02:09:22 Pavel Roskin wrote:
> I wonder is the quirk handling could be skipped for EXPR_SELECT, but I'm
> fine with it if it's harmless.

That's more likely question for sparse developers.  I have no test-case which 
goes through the EXPR_SELECT path, so that I can't test it actually.

> When would expr or type be NULL?

Also no test-case here, but it's still better to skip the optional analysis 
than let it crash on invalid dereference.

> We could check type in warn_for_enum_conversions().

Sure, I've just improved it.  Thanks for the hint!  Also the order of that 
patches has been reversed, so that they are less chatty.

Kamil

--Boundary-00=_QN8lLZRWFo6uc1T
Content-Type: text/x-patch;
  charset="UTF-8";
  name="0001-Wenum-to-int-is-now-emitted-only-for-and-switch.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-Wenum-to-int-is-now-emitted-only-for-and-switch.patch"

=46rom 1f027ab5e1995b9e65955745cf2c979c24c16ccd Mon Sep 17 00:00:00 2001
=46rom: Kamil Dudka <kdudka@redhat.com>
Date: Wed, 10 Mar 2010 16:37:25 +0100
Subject: [PATCH 1/2] -Wenum-to-int is now emitted only for =3D and switch


Signed-off-by: Kamil Dudka <kdudka@redhat.com>
=2D--
 evaluate.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index d3d5e6f..8726381 100644
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
+	warn_for_enum_to_int_conversion (*rp, target);
 	*rp =3D cast_to(*rp, target);
 	return 1;
 }
@@ -3326,6 +3326,7 @@ static void check_case_type(struct expression *switch=
_expr,
 	if (!switch_type || !case_type)
 		goto Bad;
=20
+	warn_for_enum_to_int_conversion (case_expr, switch_type);
 	warn_for_enum_conversions(case_expr, switch_type);
=20
 	sclass =3D classify_type(switch_type, &switch_type);
=2D-=20
1.6.6.1


--Boundary-00=_QN8lLZRWFo6uc1T
Content-Type: text/x-patch;
  charset="UTF-8";
  name="0002-Wenum-mismatch-now-works-better-with-conditional-op.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0002-Wenum-mismatch-now-works-better-with-conditional-op.patch"

=46rom 08b7677cf6e3a10c053dc203275a254e53f11274 Mon Sep 17 00:00:00 2001
=46rom: Kamil Dudka <kdudka@redhat.com>
Date: Wed, 10 Mar 2010 16:49:30 +0100
Subject: [PATCH 2/2] -Wenum-mismatch now works better with conditional op.

It used to crash instead of reporting the warnings properly.  Reported
by Pavel Roskin.

Signed-off-by: Kamil Dudka <kdudka@redhat.com>
=2D--
 evaluate.c                 |   32 ++++++++++++++-
 validation/enum-common.c   |   15 +++++++
 validation/enum-from-int.c |   63 ++++++++++++++++------------
 validation/enum-mismatch.c |  100 +++++++++++++++++++++++++++-------------=
=2D---
 validation/enum-to-int.c   |   36 ++++++++--------
 5 files changed, 162 insertions(+), 84 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index 8726381..9e98f66 100644
=2D-- a/evaluate.c
+++ b/evaluate.c
@@ -327,12 +327,42 @@ warn_for_int_to_enum_conversion (struct expression *e=
xpr, struct symbol *typeb)
 }
=20
 static void
=2Dwarn_for_enum_conversions(struct expression *expr, struct symbol *type)
+do_warn_for_enum_conversions(struct expression *expr, struct symbol *type)
 {
+	if (expr && expr->type =3D=3D EXPR_IMPLIED_CAST)
+		/* look through the enum/int implied cast */
+		expr =3D expr->cast_expression;
+
+	if (!expr)
+		/* do not crash when there is nothing to check */
+		return;
+
 	warn_for_different_enum_types (expr, type);
 	warn_for_int_to_enum_conversion (expr, type);
 }
=20
+static void
+warn_for_enum_conversions(struct expression *expr, struct symbol *type)
+{
+	if (!expr || !type)
+		/* do not crash when there is nothing to check */
+		return;
+
+	switch (expr->type) {
+	case EXPR_SELECT:
+	case EXPR_CONDITIONAL:
+		do_warn_for_enum_conversions(expr->cond_true
+					     /* handle the "?:" quirk */
+					     ?: expr->conditional,
+					     type);
+		do_warn_for_enum_conversions(expr->cond_false, type);
+		break;
+
+	default:
+		do_warn_for_enum_conversions(expr, type);
+	}
+}
+
 /*
  * This gets called for implicit casts in assignments and
  * integer promotion. We often want to try to move the
diff --git a/validation/enum-common.c b/validation/enum-common.c
index f940fef..06fedac 100644
=2D-- a/validation/enum-common.c
+++ b/validation/enum-common.c
@@ -46,6 +46,10 @@ static void always_ok(void)
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
@@ -74,6 +78,13 @@ static void trigger_enum_mismatch(void)
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
@@ -90,6 +101,10 @@ static void trigger_int_to_enum_conversion(void)
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
index 15b1e4d..92a7e94 100644
=2D-- a/validation/enum-from-int.c
+++ b/validation/enum-from-int.c
@@ -5,32 +5,41 @@
  * check-command: sparse -Wno-enum-mismatch $file
  *
  * check-error-start
=2Denum-common.c:84:45: warning: conversion of
=2Denum-common.c:84:45:     int to
=2Denum-common.c:84:45:     int enum ENUM_TYPE_A=20
=2Denum-common.c:85:45: warning: conversion of
=2Denum-common.c:85:45:     int to
=2Denum-common.c:85:45:     int enum ENUM_TYPE_A=20
=2Denum-common.c:82:22: warning: conversion of
=2Denum-common.c:82:22:     int to
=2Denum-common.c:82:22:     int enum ENUM_TYPE_A=20
=2Denum-common.c:87:17: warning: conversion of
=2Denum-common.c:87:17:     int to
=2Denum-common.c:87:17:     int enum ENUM_TYPE_A=20
=2Denum-common.c:88:17: warning: conversion of
=2Denum-common.c:88:17:     int to
=2Denum-common.c:88:17:     int enum ENUM_TYPE_B=20
=2Denum-common.c:89:25: warning: conversion of
=2Denum-common.c:89:25:     int to
=2Denum-common.c:89:25:     int enum <noident>=20
=2Denum-common.c:90:25: warning: conversion of
=2Denum-common.c:90:25:     int to
=2Denum-common.c:90:25:     int enum <noident>=20
=2Denum-common.c:91:18: warning: conversion of
=2Denum-common.c:91:18:     int to
=2Denum-common.c:91:18:     int enum ENUM_TYPE_A=20
=2Denum-common.c:92:18: warning: conversion of
=2Denum-common.c:92:18:     int to
=2Denum-common.c:92:18:     int enum ENUM_TYPE_A=20
+enum-common.c:95:45: warning: conversion of
+enum-common.c:95:45:     int to
+enum-common.c:95:45:     int enum ENUM_TYPE_A=20
+enum-common.c:96:45: warning: conversion of
+enum-common.c:96:45:     int to
+enum-common.c:96:45:     int enum ENUM_TYPE_A=20
+enum-common.c:93:22: warning: conversion of
+enum-common.c:93:22:     int to
+enum-common.c:93:22:     int enum ENUM_TYPE_A=20
+enum-common.c:98:17: warning: conversion of
+enum-common.c:98:17:     int to
+enum-common.c:98:17:     int enum ENUM_TYPE_A=20
+enum-common.c:99:17: warning: conversion of
+enum-common.c:99:17:     int to
+enum-common.c:99:17:     int enum ENUM_TYPE_B=20
+enum-common.c:100:25: warning: conversion of
+enum-common.c:100:25:     int to
+enum-common.c:100:25:     int enum <noident>=20
+enum-common.c:101:25: warning: conversion of
+enum-common.c:101:25:     int to
+enum-common.c:101:25:     int enum <noident>=20
+enum-common.c:102:18: warning: conversion of
+enum-common.c:102:18:     int to
+enum-common.c:102:18:     int enum ENUM_TYPE_A=20
+enum-common.c:103:18: warning: conversion of
+enum-common.c:103:18:     int to
+enum-common.c:103:18:     int enum ENUM_TYPE_A=20
+enum-common.c:106:38: warning: conversion of
+enum-common.c:106:38:     int to
+enum-common.c:106:38:     int enum ENUM_TYPE_A=20
+enum-common.c:107:29: warning: conversion of
+enum-common.c:107:29:     int to
+enum-common.c:107:29:     int enum ENUM_TYPE_A=20
+enum-common.c:107:29: warning: conversion of
+enum-common.c:107:29:     int to
+enum-common.c:107:29:     int enum ENUM_TYPE_A=20
  * check-error-end
  */
diff --git a/validation/enum-mismatch.c b/validation/enum-mismatch.c
index 6db016f..2fc2fea 100644
=2D-- a/validation/enum-mismatch.c
+++ b/validation/enum-mismatch.c
@@ -5,44 +5,68 @@
  * check-command: sparse -Wenum-mismatch -Wno-int-to-enum $file
  *
  * check-error-start
=2Denum-common.c:57:45: warning: mixing different enum types
=2Denum-common.c:57:45:     int enum ENUM_TYPE_B  versus
=2Denum-common.c:57:45:     int enum ENUM_TYPE_A=20
=2Denum-common.c:58:45: warning: mixing different enum types
=2Denum-common.c:58:45:     int enum ENUM_TYPE_B  versus
=2Denum-common.c:58:45:     int enum ENUM_TYPE_A=20
=2Denum-common.c:54:22: warning: mixing different enum types
=2Denum-common.c:54:22:     int enum ENUM_TYPE_B  versus
=2Denum-common.c:54:22:     int enum ENUM_TYPE_A=20
=2Denum-common.c:55:22: warning: mixing different enum types
=2Denum-common.c:55:22:     int enum <noident>  versus
=2Denum-common.c:55:22:     int enum ENUM_TYPE_A=20
=2Denum-common.c:64:45: warning: mixing different enum types
=2Denum-common.c:64:45:     int enum <noident>  versus
=2Denum-common.c:64:45:     int enum ENUM_TYPE_A=20
=2Denum-common.c:65:45: warning: mixing different enum types
=2Denum-common.c:65:45:     int enum <noident>  versus
=2Denum-common.c:65:45:     int enum ENUM_TYPE_A=20
=2Denum-common.c:62:22: warning: mixing different enum types
=2Denum-common.c:62:22:     int enum ENUM_TYPE_A  versus
=2Denum-common.c:62:22:     int enum <noident>=20
=2Denum-common.c:69:17: warning: mixing different enum types
=2Denum-common.c:69:17:     int enum ENUM_TYPE_B  versus
=2Denum-common.c:69:17:     int enum ENUM_TYPE_A=20
=2Denum-common.c:70:17: warning: mixing different enum types
=2Denum-common.c:70:17:     int enum <noident>  versus
=2Denum-common.c:70:17:     int enum ENUM_TYPE_B=20
=2Denum-common.c:71:25: warning: mixing different enum types
=2Denum-common.c:71:25:     int enum ENUM_TYPE_A  versus
=2Denum-common.c:71:25:     int enum <noident>=20
+enum-common.c:61:45: warning: mixing different enum types
+enum-common.c:61:45:     int enum ENUM_TYPE_B  versus
+enum-common.c:61:45:     int enum ENUM_TYPE_A=20
+enum-common.c:62:45: warning: mixing different enum types
+enum-common.c:62:45:     int enum ENUM_TYPE_B  versus
+enum-common.c:62:45:     int enum ENUM_TYPE_A=20
+enum-common.c:58:22: warning: mixing different enum types
+enum-common.c:58:22:     int enum ENUM_TYPE_B  versus
+enum-common.c:58:22:     int enum ENUM_TYPE_A=20
+enum-common.c:59:22: warning: mixing different enum types
+enum-common.c:59:22:     int enum <noident>  versus
+enum-common.c:59:22:     int enum ENUM_TYPE_A=20
+enum-common.c:68:45: warning: mixing different enum types
+enum-common.c:68:45:     int enum <noident>  versus
+enum-common.c:68:45:     int enum ENUM_TYPE_A=20
+enum-common.c:69:45: warning: mixing different enum types
+enum-common.c:69:45:     int enum <noident>  versus
+enum-common.c:69:45:     int enum ENUM_TYPE_A=20
+enum-common.c:66:22: warning: mixing different enum types
+enum-common.c:66:22:     int enum ENUM_TYPE_A  versus
+enum-common.c:66:22:     int enum <noident>=20
+enum-common.c:73:17: warning: mixing different enum types
+enum-common.c:73:17:     int enum ENUM_TYPE_B  versus
+enum-common.c:73:17:     int enum ENUM_TYPE_A=20
 enum-common.c:74:17: warning: mixing different enum types
=2Denum-common.c:74:17:     int enum ENUM_TYPE_B  versus
=2Denum-common.c:74:17:     int enum ENUM_TYPE_A=20
=2Denum-common.c:75:17: warning: mixing different enum types
=2Denum-common.c:75:17:     int enum <noident>  versus
=2Denum-common.c:75:17:     int enum ENUM_TYPE_B=20
=2Denum-common.c:76:25: warning: mixing different enum types
=2Denum-common.c:76:25:     int enum ENUM_TYPE_A  versus
=2Denum-common.c:76:25:     int enum <noident>=20
+enum-common.c:74:17:     int enum <noident>  versus
+enum-common.c:74:17:     int enum ENUM_TYPE_B=20
+enum-common.c:75:25: warning: mixing different enum types
+enum-common.c:75:25:     int enum ENUM_TYPE_A  versus
+enum-common.c:75:25:     int enum <noident>=20
+enum-common.c:78:17: warning: mixing different enum types
+enum-common.c:78:17:     int enum ENUM_TYPE_B  versus
+enum-common.c:78:17:     int enum ENUM_TYPE_A=20
+enum-common.c:79:17: warning: mixing different enum types
+enum-common.c:79:17:     int enum <noident>  versus
+enum-common.c:79:17:     int enum ENUM_TYPE_B=20
+enum-common.c:80:25: warning: mixing different enum types
+enum-common.c:80:25:     int enum ENUM_TYPE_A  versus
+enum-common.c:80:25:     int enum <noident>=20
+enum-common.c:83:29: warning: mixing different enum types
+enum-common.c:83:29:     int enum ENUM_TYPE_A  versus
+enum-common.c:83:29:     int enum <noident>=20
+enum-common.c:83:39: warning: mixing different enum types
+enum-common.c:83:39:     int enum ENUM_TYPE_B  versus
+enum-common.c:83:39:     int enum <noident>=20
+enum-common.c:84:43: warning: mixing different enum types
+enum-common.c:84:43:     int enum ENUM_TYPE_B  versus
+enum-common.c:84:43:     int enum ENUM_TYPE_A=20
+enum-common.c:85:33: warning: mixing different enum types
+enum-common.c:85:33:     int enum ENUM_TYPE_A  versus
+enum-common.c:85:33:     int enum ENUM_TYPE_B=20
+enum-common.c:86:29: warning: mixing different enum types
+enum-common.c:86:29:     int enum ENUM_TYPE_A  versus
+enum-common.c:86:29:     int enum ENUM_TYPE_B=20
+enum-common.c:86:38: warning: mixing different enum types
+enum-common.c:86:38:     int enum ENUM_TYPE_B  versus
+enum-common.c:86:38:     int enum ENUM_TYPE_A=20
+enum-common.c:87:29: warning: mixing different enum types
+enum-common.c:87:29:     int enum ENUM_TYPE_B  versus
+enum-common.c:87:29:     int enum ENUM_TYPE_A=20
+enum-common.c:87:29: warning: mixing different enum types
+enum-common.c:87:29:     int enum ENUM_TYPE_B  versus
+enum-common.c:87:29:     int enum ENUM_TYPE_A=20
  * check-error-end
  */
diff --git a/validation/enum-to-int.c b/validation/enum-to-int.c
index a981ce5..134a34d 100644
=2D-- a/validation/enum-to-int.c
+++ b/validation/enum-to-int.c
@@ -5,23 +5,23 @@
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
+enum-common.c:112:13: warning: conversion of
+enum-common.c:112:13:     int enum ENUM_TYPE_A  to
+enum-common.c:112:13:     int
+enum-common.c:113:13: warning: conversion of
+enum-common.c:113:13:     int enum ENUM_TYPE_B  to
+enum-common.c:113:13:     int
+enum-common.c:118:34: warning: conversion of
+enum-common.c:118:34:     int enum ENUM_TYPE_A  to
+enum-common.c:118:34:     int
+enum-common.c:119:34: warning: conversion of
+enum-common.c:119:34:     int enum ENUM_TYPE_B  to
+enum-common.c:119:34:     int
+enum-common.c:115:22: warning: conversion of
+enum-common.c:115:22:     int enum ENUM_TYPE_A  to
+enum-common.c:115:22:     int
+enum-common.c:116:22: warning: conversion of
+enum-common.c:116:22:     int enum ENUM_TYPE_B  to
+enum-common.c:116:22:     int
  * check-error-end
  */
=2D-=20
1.6.6.1


--Boundary-00=_QN8lLZRWFo6uc1T--
