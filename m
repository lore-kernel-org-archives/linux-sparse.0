From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: [PATCH] saner warnings for restricted types
Date: Tue, 15 Jan 2008 16:52:36 +0000
Message-ID: <20080115165236.GS27894@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:55410 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102AbYAOQwh (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 15 Jan 2008 11:52:37 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.63 #1 (Red Hat Linux))
	id 1JEp1g-00047R-KF
	for linux-sparse@vger.kernel.org; Tue, 15 Jan 2008 16:52:36 +0000
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

* don't crap the type->ident for unsigned int just because somebody did
	typedef unsigned int x;
  only structs, unions, enums and restricted types need this logics.
* generate saner warnings for restricted, include type name(s) into them.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 evaluate.c   |   33 ++++++++++++++++++++-------------
 parse.c      |   11 +++++++++--
 show-parse.c |    4 ++++
 3 files changed, 33 insertions(+), 15 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index 54fcd3f..777f603 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -500,9 +500,10 @@ static inline void unrestrict(struct expression *expr,
 			      int class, struct symbol **ctype)
 {
 	if (class & TYPE_RESTRICT) {
-		warning(expr->pos, "restricted degrades to integer");
 		if (class & TYPE_FOULED)
 			*ctype = unfoul(*ctype);
+		warning(expr->pos, "%sdegrades to integer",
+			show_typename(*ctype));
 		*ctype = (*ctype)->ctype.base_type; /* get to arithmetic type */
 	}
 }
@@ -1235,7 +1236,9 @@ static int evaluate_assign_op(struct expression *expr)
 		}
 		if (tclass & TYPE_RESTRICT) {
 			if (!restricted_binop(op, t)) {
-				expression_error(expr, "bad restricted assignment");
+				warning(expr->pos, "bad assignment (%s) to %s",
+					show_special(op), show_typename(t));
+				expr->right = cast_to(expr->right, target);
 				return 0;
 			}
 			/* allowed assignments unfoul */
@@ -1248,7 +1251,9 @@ static int evaluate_assign_op(struct expression *expr)
 		/* source and target would better be identical restricted */
 		if (t == s)
 			return 1;
-		warning(expr->pos, "invalid restricted assignment");
+		warning(expr->pos, "invalid assignment: %s", show_special(op));
+		info(expr->pos, "   left side has type %s", show_typename(t));
+		info(expr->pos, "   right side has type %s", show_typename(s));
 		expr->right = cast_to(expr->right, target);
 		return 0;
 	}
@@ -1707,10 +1712,8 @@ static struct symbol *evaluate_postop(struct expression *expr)
 		return NULL;
 	}
 
-	if ((class & TYPE_RESTRICT) && restricted_unop(expr->op, &ctype)) {
-		expression_error(expr, "bad operation on restricted");
-		return NULL;
-	}
+	if ((class & TYPE_RESTRICT) && restricted_unop(expr->op, &ctype))
+		return bad_expr_type(expr);
 
 	if (class & TYPE_NUM) {
 		multiply = 1;
@@ -1799,7 +1802,8 @@ static struct symbol *evaluate_preop(struct expression *expr)
 			expr->right->ctype = ctype;
 			expr->right->fvalue = 0;
 		} else if (is_fouled_type(ctype)) {
-			warning(expr->pos, "restricted degrades to integer");
+			warning(expr->pos, "%sdegrades to integer",
+				show_typename(ctype->ctype.base_type));
 		}
 		ctype = &bool_ctype;
 		break;
@@ -2664,9 +2668,11 @@ static struct symbol *evaluate_cast(struct expression *expr)
 
 	if (t1 != t2) {
 		if (class1 & TYPE_RESTRICT)
-			warning(expr->pos, "cast to restricted type");
+			warning(expr->pos, "cast to %s",
+				show_typename(t1));
 		if (class2 & TYPE_RESTRICT)
-			warning(expr->pos, "cast from restricted type");
+			warning(expr->pos, "cast from %s",
+				show_typename(t2));
 	}
 
 	if (t1 == &ulong_ctype)
@@ -3246,9 +3252,10 @@ static void check_case_type(struct expression *switch_expr,
 		return;
 
 	if (!restricted_binop_type(SPECIAL_EQUAL, case_expr, switch_expr,
-				   cclass, sclass, case_type, switch_type))
-		warning(case_expr->pos, "restricted degrades to integer");
-
+				   cclass, sclass, case_type, switch_type)) {
+		unrestrict(case_expr, cclass, &case_type);
+		unrestrict(switch_expr, sclass, &switch_type);
+	}
 	return;
 
 Bad:
diff --git a/parse.c b/parse.c
index a41939d..6255737 100644
--- a/parse.c
+++ b/parse.c
@@ -2158,8 +2158,15 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
 	base_type = decl->ctype.base_type;
 
 	if (is_typedef) {
-		if (base_type && !base_type->ident)
-			base_type->ident = ident;
+		if (base_type && !base_type->ident) {
+			switch (base_type->type) {
+			case SYM_STRUCT:
+			case SYM_UNION:
+			case SYM_ENUM:
+			case SYM_RESTRICT:
+				base_type->ident = ident;
+			}
+		}
 	} else if (base_type && base_type->type == SYM_FN) {
 		/* K&R argument declaration? */
 		if (lookup_type(token))
diff --git a/show-parse.c b/show-parse.c
index 9a1f796..b9a2828 100644
--- a/show-parse.c
+++ b/show-parse.c
@@ -309,6 +309,10 @@ static void do_show_type(struct symbol *sym, struct type_name *name,
 		break;
 
 	case SYM_RESTRICT:
+		if (sym->ident) {
+			prepend(name, "restricted %s ", show_ident(sym->ident));
+			return;
+		}
 		break;
 
 	case SYM_FOULED:
-- 
1.5.3.GIT
