From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH 4/8] start cleaning type_difference()
Date: Fri, 13 Jul 2007 18:44:57 +0100
Message-ID: <E1I9PCL-0000EV-5G@ZenIV.linux.org.uk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:49728 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754447AbXGMRo5 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 13 Jul 2007 13:44:57 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.52 #1 (Red Hat Linux))
	id 1I9PCL-0000EV-5G
	for linux-sparse@vger.kernel.org; Fri, 13 Jul 2007 18:44:57 +0100
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


a) examine_fn_arguments() when comparing SYM_FN nodes; then
we won't need to try implementing argument adjustment as
part of the main loop.  SYM_ARRAY->SYM_PTR and SYM_FN/SYM_PTR
interactions go away (and we stop getting nonsense results
like "int * and int [1] are the same thing").  All callers
are already happy with that.

b) different structs or unions are incompatible.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 evaluate.c |   34 +++++++++-------------------------
 1 files changed, 9 insertions(+), 25 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index 88435da..91c7f74 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -619,6 +619,8 @@ static struct symbol *evaluate_ptr_add(struct expression *expr, struct symbol *c
 	return ctype;
 }
 
+static void examine_fn_arguments(struct symbol *fn);
+
 const char * type_difference(struct symbol *target, struct symbol *source,
 	unsigned long target_mod_ignore, unsigned long source_mod_ignore)
 {
@@ -687,34 +689,14 @@ const char * type_difference(struct symbol *target, struct symbol *source,
 		/*
 		 * Pointers to functions compare as the function itself
 		 */
-		if (type1 == SYM_PTR && base1) {
+		if (type1 == SYM_PTR && base1)
 			base1 = examine_symbol_type(base1);
-			switch (base1->type) {
-			case SYM_FN:
-				type1 = SYM_FN;
-				target = base1;
-				base1 = base1->ctype.base_type;
-			default:
-				/* nothing */;
-			}
-		}
-		if (type2 == SYM_PTR && base2) {
-			base2 = examine_symbol_type(base2);
-			switch (base2->type) {
-			case SYM_FN:
-				type2 = SYM_FN;
-				source = base2;
-				base2 = base2->ctype.base_type;
-			default:
-				/* nothing */;
-			}
-		}
 
-		/* Arrays degenerate to pointers for type comparisons */
-		type1 = (type1 == SYM_ARRAY) ? SYM_PTR : type1;
-		type2 = (type2 == SYM_ARRAY) ? SYM_PTR : type2;
+		if (type2 == SYM_PTR && base2)
+			base2 = examine_symbol_type(base2);
 
-		if (type1 != type2 || type1 == SYM_RESTRICT)
+		if (type1 != type2 || type1 == SYM_RESTRICT ||
+		    type1 == SYM_UNION || type1 == SYM_STRUCT)
 			return "different base types";
 
 		/* Must be same address space to be comparable */
@@ -755,6 +737,8 @@ const char * type_difference(struct symbol *target, struct symbol *source,
 			struct symbol *arg1, *arg2;
 			if (base1->variadic != base2->variadic)
 				return "incompatible variadic arguments";
+			examine_fn_arguments(target);
+			examine_fn_arguments(source);
 			PREPARE_PTR_LIST(target->arguments, arg1);
 			PREPARE_PTR_LIST(source->arguments, arg2);
 			i = 1;
-- 
1.5.0-rc2.GIT
