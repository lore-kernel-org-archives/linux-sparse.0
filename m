From: terra@gnome.org (Morten Welinder)
Subject: Re: case label types
Date: Thu, 16 Mar 2006 09:55:58 -0500 (EST)
Message-ID: <20060316145558.1C383C000E2@dunnock.rentec.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from unicorn.rentec.com ([216.223.240.10]:30650 "EHLO
	unicorn.rentec.com") by vger.kernel.org with ESMTP id S1751142AbWCPO4A
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 16 Mar 2006 09:56:00 -0500
Received: from wren.rentec.com (wren [192.5.35.106])
	by unicorn.rentec.com (8.13.1/8.12.1) with ESMTP id k2GEu0R1014100
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-sparse@vger.kernel.org>; Thu, 16 Mar 2006 09:56:00 -0500 (EST)
Received: from dunnock.rentec.com (dunnock.rentec.com [172.26.132.207])
	by wren.rentec.com (8.13.1/8.12.1) with ESMTP id k2GEtwsk007648
	for <linux-sparse@vger.kernel.org>; Thu, 16 Mar 2006 09:55:58 -0500 (EST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org



Here's an improved version that catches inconsistent case labels too.

M.


=============================================================================

typedef enum { A1, A2 } enumA;
typedef enum { B1 = 10, B2 } enumB;

int
main (int argc, char **argv)
{
  enumA a = A1;

  switch (A1) {
  case A1: break;
  case A2: break;
  case B1: break;  // Warn
  case B2: break;  // Warn
  default: break;
  }

  switch (1) {
  case A1: break;
  case A2: break;
  case B1: break;  // Warn
  case B2: break;  // Warn
  default: break;
  }

  switch (1) {
  case A1 ... B2: break;  // Warn
  default: break;
  }

  (void)(1 ? a : B1);  // Warn
  (void)(A1 == B1);  // Warn

  return 0;
}

=============================================================================


Signed-off-by: Morten Welinder <terra@gnome.org>

diff --git a/evaluate.c b/evaluate.c
index 1a12b67..b099dcd 100644
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
@@ -2604,7 +2617,9 @@ static void evaluate_case_statement(stru
 	evaluate_statement(stmt->case_statement);
 }
 
-static void check_case_type(struct expression *switch_expr, struct expression *case_expr)
+static void check_case_type(struct expression *switch_expr,
+			    struct expression *case_expr,
+			    struct expression **enumcase)
 {
 	struct symbol *switch_type, *case_type;
 	if (!case_expr)
@@ -2613,11 +2628,19 @@ static void check_case_type(struct expre
 	case_type = evaluate_expression(case_expr);
 
 	if (case_type && switch_type) {
+		if (enumcase && is_enum_type(case_type)) {
+			/* Check case expressions against each other.  */
+			if (*enumcase)
+				(void)compatible_restricted_binop(SPECIAL_EQUAL, enumcase, &case_expr);
+			else
+				*enumcase = case_expr;
+		}
+
 		/* Both integer types? */
-		if (is_int_type(switch_type) && is_int_type(case_type))
-			return;
 		if (compatible_restricted_binop(SPECIAL_EQUAL, &switch_expr, &case_expr))
 			return;
+		if (is_int_type(switch_type) && is_int_type(case_type)) 
+			return;
 	}
 
 	sparse_error(case_expr->pos, "incompatible types for 'case' statement");
@@ -2626,15 +2649,21 @@ static void check_case_type(struct expre
 static void evaluate_switch_statement(struct statement *stmt)
 {
 	struct symbol *sym;
+	struct expression *enumcase = NULL;
+	struct expression **enumcase_holder;
 
 	evaluate_expression(stmt->switch_expression);
 	evaluate_statement(stmt->switch_statement);
 	if (!stmt->switch_expression)
 		return;
+	enumcase_holder = is_enum_type(stmt->switch_expression->ctype)
+		? NULL /* Only check cases against switch */
+		: &enumcase;
+
 	FOR_EACH_PTR(stmt->switch_case->symbol_list, sym) {
 		struct statement *case_stmt = sym->stmt;
-		check_case_type(stmt->switch_expression, case_stmt->case_expression);
-		check_case_type(stmt->switch_expression, case_stmt->case_to);
+		check_case_type(stmt->switch_expression, case_stmt->case_expression, enumcase_holder);
+		check_case_type(stmt->switch_expression, case_stmt->case_to, enumcase_holder);
 	} END_FOR_EACH_PTR(sym);
 }
 
diff --git a/symbol.h b/symbol.h
index 986a9cc..a773a0a 100644
--- a/symbol.h
+++ b/symbol.h
@@ -242,6 +242,13 @@ static inline int is_int_type(const stru
 	       type->ctype.base_type == &int_type;
 }
 
+static inline int is_enum_type(const struct symbol *type)
+{
+	if (type->type == SYM_NODE)
+		type = type->ctype.base_type;
+	return (type->type == SYM_ENUM);
+}
+
 static inline int get_sym_type(struct symbol *type)
 {
 	if (type->type == SYM_NODE)
