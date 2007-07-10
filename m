From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH] fix handling of pointers in ?:
Date: Tue, 10 Jul 2007 02:07:33 +0100
Message-ID: <20070710010733.GQ21668@ftp.linux.org.uk>
References: <20070709221306.GP21668@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:54506 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757560AbXGJBHe (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 9 Jul 2007 21:07:34 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.52 #1 (Red Hat Linux))
	id 1I84CT-0000eU-Nm
	for linux-sparse@vger.kernel.org; Tue, 10 Jul 2007 02:07:33 +0100
Content-Disposition: inline
In-Reply-To: <20070709221306.GP21668@ftp.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

a) qualifiers are joined (const int * / volatile int * -> const volatile int *)
b) pointer to void / pointer to T => pointer to void (with all qualifiers)

testcase added

Still missing: T1 * / T2 * => pointer to composite type of T1 and T2

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 evaluate.c              |   82 ++++++++++++++++++++++++++++-------------------
 validation/cond_expr2.c |   23 +++++++++++++
 2 files changed, 72 insertions(+), 33 deletions(-)
 create mode 100644 validation/cond_expr2.c

diff --git a/evaluate.c b/evaluate.c
index d505007..9f543fe 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -1070,31 +1070,6 @@ OK:
 }
 
 /*
- * FIXME!! This should do casts, array degeneration etc..
- */
-static struct symbol *compatible_ptr_type(struct expression *left, struct expression *right)
-{
-	struct symbol *ltype = left->ctype, *rtype = right->ctype;
-
-	if (ltype->type == SYM_NODE)
-		ltype = ltype->ctype.base_type;
-
-	if (rtype->type == SYM_NODE)
-		rtype = rtype->ctype.base_type;
-
-	if (ltype->type == SYM_PTR) {
-		if (rtype->ctype.base_type == &void_ctype)
-			return ltype;
-	}
-
-	if (rtype->type == SYM_PTR) {
-		if (ltype->ctype.base_type == &void_ctype)
-			return rtype;
-	}
-	return NULL;
-}
-
-/*
  * NOTE! The degenerate case of "x ? : y", where we don't
  * have a true case, this will possibly promote "x" to the
  * same type as "y", and thus _change_ the conditional
@@ -1104,9 +1079,10 @@ static struct symbol *compatible_ptr_type(struct expression *left, struct expres
 static struct symbol *evaluate_conditional_expression(struct expression *expr)
 {
 	struct expression **true;
-	struct symbol *ctype, *ltype, *rtype;
+	struct symbol *ctype, *ltype, *rtype, *lbase, *rbase;
 	int lclass, rclass;
 	const char * typediff;
+	int qual;
 
 	if (!evaluate_conditional(expr->conditional, 0))
 		return NULL;
@@ -1141,9 +1117,11 @@ static struct symbol *evaluate_conditional_expression(struct expression *expr)
 		expr->cond_false = cast_to(expr->cond_false, ctype);
 		goto out;
 	}
+
 	if ((lclass | rclass) & TYPE_PTR) {
 		int is_null1 = is_null_pointer_constant(*true);
 		int is_null2 = is_null_pointer_constant(expr->cond_false);
+
 		if (is_null1 && is_null2) {
 			*true = cast_to(*true, &ptr_ctype);
 			expr->cond_false = cast_to(expr->cond_false, &ptr_ctype);
@@ -1169,15 +1147,42 @@ static struct symbol *evaluate_conditional_expression(struct expression *expr)
 			goto Err;
 		}
 		/* OK, it's pointer on pointer */
-		/* XXX - we need to handle qualifiers */
-		ctype = compatible_ptr_type(*true, expr->cond_false);
-		if (ctype)
-			goto out;
+		if (ltype->ctype.as != rtype->ctype.as) {
+			typediff = "different address spaces";
+			goto Err;
+		}
+
+		/* need to be lazier here */
+		lbase = get_base_type(ltype);
+		rbase = get_base_type(rtype);
+		qual = ltype->ctype.modifiers | rtype->ctype.modifiers;
+		qual &= MOD_CONST | MOD_VOLATILE;
+
+		if (lbase == &void_ctype) {
+			/* XXX: pointers to function should warn here */
+			ctype = ltype;
+			goto Qual;
+
+		}
+		if (rbase == &void_ctype) {
+			/* XXX: pointers to function should warn here */
+			ctype = rtype;
+			goto Qual;
+		}
+		/* XXX: that should be pointer to composite */
+		ctype = ltype;
+		typediff = type_difference(lbase, rbase, MOD_IGN, MOD_IGN);
+		if (!typediff)
+			goto Qual;
+		goto Err;
 	}
-	ctype = ltype;
-	typediff = type_difference(ltype, rtype, MOD_IGN, MOD_IGN);
-	if (!typediff)
+
+	/* void on void, struct on same struct, union on same union */
+	if (ltype == rtype) {
+		ctype = ltype;
 		goto out;
+	}
+	typediff = "different base types";
 
 Err:
 	expression_error(expr, "incompatible types in conditional expression (%s)", typediff);
@@ -1186,6 +1191,17 @@ Err:
 out:
 	expr->ctype = ctype;
 	return ctype;
+
+Qual:
+	if (qual & ~ctype->ctype.modifiers) {
+		struct symbol *sym = alloc_symbol(ctype->pos, SYM_PTR);
+		*sym = *ctype;
+		sym->ctype.modifiers |= qual;
+		ctype = sym;
+	}
+	*true = cast_to(*true, ctype);
+	expr->cond_false = cast_to(expr->cond_false, ctype);
+	goto out;
 }
 
 /* FP assignments can not do modulo or bit operations */
diff --git a/validation/cond_expr2.c b/validation/cond_expr2.c
new file mode 100644
index 0000000..e53cd13
--- /dev/null
+++ b/validation/cond_expr2.c
@@ -0,0 +1,23 @@
+extern const int *p;
+extern volatile void *q;
+extern volatile int *r;
+static void f(void)
+{
+	q = 1 ? p : q;	// warn: const volatile void * -> const int *
+	r = 1 ? r : q;	// OK: volatile void * -> volatile int *
+	r = 1 ? r : p;	// warn: const volatile int * -> volatile int *
+}
+/*
+ * check-name: type of conditional expression
+ * check-description: Used to miss qualifier mixing and mishandle void *
+ * check-command: sparse $file
+ *
+ * check-output-start
+cond_expr2.c:6:4: warning: incorrect type in assignment (different modifiers)
+cond_expr2.c:6:4:    expected void volatile *extern [addressable] [toplevel] q
+cond_expr2.c:6:4:    got void const volatile *
+cond_expr2.c:8:4: warning: incorrect type in assignment (different modifiers)
+cond_expr2.c:8:4:    expected int volatile *extern [addressable] [toplevel] [assigned] r
+cond_expr2.c:8:4:    got int const volatile *
+ * check-output-end
+ */
-- 
1.5.0-rc2.GIT
