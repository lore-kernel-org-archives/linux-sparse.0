From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH 5/8] get compatible_assignment_types() deal with all cases
Date: Fri, 13 Jul 2007 18:45:07 +0100
Message-ID: <E1I9PCV-0000Eq-5T@ZenIV.linux.org.uk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:49735 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755291AbXGMRpH (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 13 Jul 2007 13:45:07 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.52 #1 (Red Hat Linux))
	id 1I9PCV-0000Eq-5T
	for linux-sparse@vger.kernel.org; Fri, 13 Jul 2007 18:45:07 +0100
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


a) pointer to _Bool is OK
b) struct to same struct or union to same union is OK; void to void etc. are not
c) to/from void * with loss of qualifiers or with different address space
   should give the right warning itself instead of "different base types"
   it would get from fallback to type_difference()

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 evaluate.c |   57 +++++++++++++++++++++++++++++++++++++++++++--------------
 1 files changed, 43 insertions(+), 14 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index 91c7f74..44a4da4 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -1259,11 +1259,17 @@ static int compatible_assignment_types(struct expression *expr, struct symbol *t
 				goto Cast;
 			if (!restricted_value(*rp, target))
 				return 1;
+			if (s == t)
+				return 1;
 		} else if (!(sclass & TYPE_RESTRICT))
 			goto Cast;
+		typediff = "different base types";
+		goto Err;
 	}
 
-	if (tclass & TYPE_PTR) {
+	if (tclass == TYPE_PTR) {
+		unsigned long mod1, mod2;
+		struct symbol *b1, *b2;
 		// NULL pointer is always OK
 		int is_null = is_null_pointer_constant(*rp);
 		if (is_null) {
@@ -1271,29 +1277,52 @@ static int compatible_assignment_types(struct expression *expr, struct symbol *t
 				bad_null(*rp);
 			goto Cast;
 		}
-		if (sclass & TYPE_PTR && t->ctype.as == s->ctype.as) {
-			/* we should be more lazy here */
-			int mod1 = t->ctype.modifiers;
-			int mod2 = s->ctype.modifiers;
-			s = get_base_type(s);
-			t = get_base_type(t);
-
+		if (!(sclass & TYPE_PTR)) {
+			typediff = "different base types";
+			goto Err;
+		}
+		/* we should be more lazy here */
+		mod1 = t->ctype.modifiers;
+		mod2 = s->ctype.modifiers;
+		b1 = get_base_type(t);
+		b2 = get_base_type(s);
+		if (b1 == &void_ctype || b2 == &void_ctype) {
 			/*
 			 * assignments to/from void * are OK, provided that
 			 * we do not remove qualifiers from pointed to [C]
 			 * or mix address spaces [sparse].
 			 */
-			if (!(mod2 & ~mod1 & (MOD_VOLATILE | MOD_CONST)))
-				if (s == &void_ctype || t == &void_ctype)
-					goto Cast;
+			if (t->ctype.as != s->ctype.as) {
+				typediff = "different address spaces";
+				goto Err;
+			}
+			if (mod2 & ~mod1 & MOD_IGN) {
+				typediff = "different modifiers";
+				goto Err;
+			}
+			goto Cast;
 		}
+		/* It's OK if the target is more volatile or const than the source */
+		typediff = type_difference(target, source,
+					   MOD_VOLATILE | MOD_CONST, 0);
+		if (typediff)
+			goto Err;
+		return 1;
 	}
 
-	/* It's OK if the target is more volatile or const than the source */
-	typediff = type_difference(target, source, MOD_VOLATILE | MOD_CONST, 0);
-	if (!typediff)
+	if ((tclass & TYPE_COMPOUND) && s == t)
 		return 1;
 
+	if (tclass & TYPE_NUM) {
+		/* XXX: need to turn into comparison with NULL */
+		if (t == &bool_ctype && (sclass & TYPE_PTR))
+			goto Cast;
+		typediff = "different base types";
+		goto Err;
+	}
+	typediff = "invalid types";
+
+Err:
 	warning(expr->pos, "incorrect type in %s (%s)", where, typediff);
 	info(expr->pos, "   expected %s", show_typename(target));
 	info(expr->pos, "   got %s", show_typename(source));
-- 
1.5.0-rc2.GIT
