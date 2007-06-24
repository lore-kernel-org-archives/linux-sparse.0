From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH 11/16] fix default argument promotion
Date: Sun, 24 Jun 2007 09:05:01 +0100
Message-ID: <E1I2N5h-0003e0-7I@ZenIV.linux.org.uk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:34706 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752970AbXFXIFC (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 24 Jun 2007 04:05:02 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.52 #1 (Red Hat Linux))
	id 1I2N5h-0003e0-7I
	for linux-sparse@vger.kernel.org; Sun, 24 Jun 2007 09:05:01 +0100
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


It should do integer_promotion() for integer types, turn float into
double and degenerate() the functions/arrays.  We do *not* want
compatible_assignment_type() in any case, though.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 evaluate.c |   19 ++++++++++++++-----
 1 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index 6cb29ff..1d34cdf 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -1897,15 +1897,24 @@ static int evaluate_arguments(struct symbol *f, struct symbol *fn, struct expres
 		if (!ctype)
 			return 0;
 
-		ctype = degenerate(expr);
-
 		target = argtype;
-		if (!target && ctype->bit_size < bits_in_int)
-			target = &int_ctype;
-		if (target) {
+		if (!target) {
+			struct symbol *type;
+			int class = classify_type(ctype, &type);
+			if (is_int(class)) {
+				*p = cast_to(expr, integer_promotion(type));
+			} else if (class & TYPE_FLOAT) {
+				unsigned long mod = type->ctype.modifiers;
+				if (!(mod & (MOD_LONG|MOD_LONGLONG)))
+					*p = cast_to(expr, &double_ctype);
+			} else if (class & TYPE_PTR) {
+				degenerate(expr);
+			}
+		} else {
 			static char where[30];
 			examine_symbol_type(target);
 			sprintf(where, "argument %d", i);
+			ctype = degenerate(expr);
 			compatible_assignment_types(expr, target, p, ctype, where);
 		}
 
-- 
1.5.0-rc2.GIT
