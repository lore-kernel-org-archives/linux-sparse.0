From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] Remove unneeded variable in integer_promotion()
Date: Wed,  2 Nov 2016 23:11:13 +0100
Message-ID: <20161102221113.37124-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35600 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932969AbcKBWL0 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 2 Nov 2016 18:11:26 -0400
Received: by mail-wm0-f66.google.com with SMTP id 68so5101409wmz.2
        for <linux-sparse@vger.kernel.org>; Wed, 02 Nov 2016 15:11:26 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Following some previous simplification done on the function,
the variable 'orig_type' is now always the same as 'type'.

To avoid possible confusion, only use 'type' and remove
the declaration of 'orig_type'.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index e350c0c0..14a02038 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -117,7 +117,6 @@ static struct symbol *evaluate_string(struct expression *expr)
 /* type has come from classify_type and is an integer type */
 static inline struct symbol *integer_promotion(struct symbol *type)
 {
-	struct symbol *orig_type = type;
 	unsigned long mod =  type->ctype.modifiers;
 	int width = type->bit_size;
 
@@ -128,7 +127,6 @@ static inline struct symbol *integer_promotion(struct symbol *type)
 	 */
 	if (type->type == SYM_BITFIELD) {
 		type = type->ctype.base_type;
-		orig_type = type;
 	}
 	mod = type->ctype.modifiers;
 	if (width < bits_in_int)
@@ -140,7 +138,7 @@ static inline struct symbol *integer_promotion(struct symbol *type)
 			return &uint_ctype;
 		return &int_ctype;
 	}
-	return orig_type;
+	return type;
 }
 
 /*
-- 
2.10.1

