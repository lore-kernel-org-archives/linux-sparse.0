From: terra@gnome.org (Morten Welinder)
Subject: Re: case label types
Date: Wed, 15 Mar 2006 22:33:03 -0500 (EST)
Message-ID: <200603160333.k2G3X3H08808@troll.rentec.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from unicorn.rentec.com ([216.223.240.10]:10484 "EHLO
	unicorn.rentec.com") by vger.kernel.org with ESMTP id S932270AbWCPDdQ
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 15 Mar 2006 22:33:16 -0500
Received: from wren.rentec.com (wren [192.5.35.106])
	by unicorn.rentec.com (8.13.1/8.12.1) with ESMTP id k2G3XFXq005783
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-sparse@vger.kernel.org>; Wed, 15 Mar 2006 22:33:16 -0500 (EST)
Received: from troll.rentec.com (IDENT:1@troll.rentec.com [192.5.35.34])
	by wren.rentec.com (8.13.1/8.12.1) with ESMTP id k2G3X3eH002725
	for <linux-sparse@vger.kernel.org>; Wed, 15 Mar 2006 22:33:03 -0500 (EST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


In the great tradition of monkey-see-monkey-do, I propose this
patch.  It does all the cases I listed except compare the case
labels against each other.

Morten

Signed-off-by: Morten Welinder <terra@gnome.org>


diff --git a/evaluate.c b/evaluate.c
index 1a12b67..3a47dcc 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -386,6 +386,12 @@ static struct symbol *compatible_integer
 		ltype = ltype->ctype.base_type;
 	if (rtype->type == SYM_NODE)
 		rtype = rtype->ctype.base_type;
+
+	if (ltype->type == SYM_ENUM && rtype->type == SYM_ENUM &&
+	    ltype != rtype) {
+		warning(right->pos, "mixing different enum types");
+	}
+
 	if (is_int_type(ltype) && is_int_type(rtype)) {
 		struct symbol *ctype = bigger_int_type(ltype, rtype);
 
@@ -441,12 +447,19 @@ static struct symbol *compatible_restric
 
 	if (ltype->type == SYM_NODE)
 		ltype = ltype->ctype.base_type;
-	if (ltype->type == SYM_ENUM)
-		ltype = ltype->ctype.base_type;
 	if (rtype->type == SYM_NODE)
 		rtype = rtype->ctype.base_type;
+
+	if (ltype->type == SYM_ENUM && rtype->type == SYM_ENUM &&
+	    ltype != rtype) {
+		warning(right->pos, "mixing different enum types");
+	}
+
+	if (ltype->type == SYM_ENUM)
+		ltype = ltype->ctype.base_type;
 	if (rtype->type == SYM_ENUM)
 		rtype = rtype->ctype.base_type;
+
 	if (is_restricted_type(ltype)) {
 		if (is_restricted_type(rtype)) {
 			if (ltype == rtype)
@@ -2614,10 +2627,10 @@ static void check_case_type(struct expre
 
 	if (case_type && switch_type) {
 		/* Both integer types? */
-		if (is_int_type(switch_type) && is_int_type(case_type))
-			return;
 		if (compatible_restricted_binop(SPECIAL_EQUAL, &switch_expr, &case_expr))
 			return;
+		if (is_int_type(switch_type) && is_int_type(case_type)) 
+			return;
 	}
 
 	sparse_error(case_expr->pos, "incompatible types for 'case' statement");
