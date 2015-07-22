From: Nicolai Stange <nicstange@gmail.com>
Subject: [PATCH RFC 07/13] evaluate: check static storage duration objects' intializers' constness
Date: Thu, 23 Jul 2015 01:19:09 +0200
Message-ID: <871tfzkcgi.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:38770 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752125AbbGVXTM (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 22 Jul 2015 19:19:12 -0400
Received: by wibxm9 with SMTP id xm9so124281401wib.1
        for <linux-sparse@vger.kernel.org>; Wed, 22 Jul 2015 16:19:11 -0700 (PDT)
Received: from localhost.localdomain (x55b1cac6.dyn.telefonica.de. [85.177.202.198])
        by smtp.gmail.com with ESMTPSA id ju2sm5613497wid.12.2015.07.22.16.19.10
        for <linux-sparse@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Jul 2015 16:19:10 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Initializers of static storage duration objects shall be constant
expressions [6.7.8(4)].

Warn if that requirement is not met.

Identify static storage duration objects by having either of
MOD_TOPLEVEL or MOD_STATIC set.

Check an initializer's constness at the lowest possible subobject
level, i.e. at the level of the "assignment-expression" production
in [6.7.8].

For compound objects, make handle_list_initializer() pass the
surrounding object's storage duration modifiers down to
handle_simple_initializer() at subobject initializer evaluation.

Signed-off-by: Nicolai Stange <nicstange@gmail.com>
---
 evaluate.c                  |  25 +++++++++-
 validation/constexpr-init.c | 109 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 133 insertions(+), 1 deletion(-)
 create mode 100644 validation/constexpr-init.c

diff --git a/evaluate.c b/evaluate.c
index c38b893..a65cc0c 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -2466,6 +2466,7 @@ static void handle_list_initializer(struct expression *expr,
 {
 	struct expression *e, *last = NULL, *top = NULL, *next;
 	int jumped = 0;
+	unsigned long old_modifiers;
 
 	FOR_EACH_PTR(expr->expr_list, e) {
 		struct expression **v;
@@ -2520,8 +2521,21 @@ found:
 		else
 			v = &top->ident_expression;
 
-		if (handle_simple_initializer(v, 1, lclass, top->ctype))
+		/*
+		 * Temporarily copy storage modifiers down from
+		 * surrounding type such that
+		 * handle_simple_initializer() can check
+		 * initializations of subobjects with static storage
+		 * duration.
+		 */
+		old_modifiers = top->ctype->ctype.modifiers;
+		top->ctype->ctype.modifiers =
+			old_modifiers | (ctype->ctype.modifiers & MOD_STORAGE);
+		if (handle_simple_initializer(v, 1, lclass, top->ctype)) {
+			top->ctype->ctype.modifiers = old_modifiers;
 			continue;
+		}
+		top->ctype->ctype.modifiers = old_modifiers;
 
 		if (!(lclass & TYPE_COMPOUND)) {
 			warning(e->pos, "bogus scalar initializer");
@@ -2631,6 +2645,15 @@ static int handle_simple_initializer(struct expression **ep, int nested,
 		if (!evaluate_expression(e))
 			return 1;
 		compatible_assignment_types(e, ctype, ep, "initializer");
+		/*
+		 * Initializers for static storage duration objects
+		 * shall be constant expressions or a string literal [6.7.8(4)].
+		 */
+		if ((ctype->ctype.modifiers & (MOD_TOPLEVEL | MOD_STATIC)) &&
+			!(e->flags & (EXPR_FLAG_ARITH_CONST_EXPR
+					| EXPR_FLAG_ADDR_CONST_EXPR)))
+			warning(e->pos, "initializer for static storage duration object is not a constant expression");
+
 		return 1;
 	}
 
diff --git a/validation/constexpr-init.c b/validation/constexpr-init.c
new file mode 100644
index 0000000..6c412b8
--- /dev/null
+++ b/validation/constexpr-init.c
@@ -0,0 +1,109 @@
+static int a = 1;					// OK
+static int b[2] = {1, 1};				// OK
+static void c(void) {}
+
+static int *d = &a;					// OK
+static int *e = &b[1];					// OK
+static int *f = b;					// OK
+static void (*g)(void) = c;				// OK
+static void (*h)(void) = &c;				// OK
+static int *i = (int*)0;				// OK
+static int *j = d;					// KO
+static int *k = (int*)0 + 1;				// OK
+
+static int *l = &a + 1;				// OK
+static int *m = &b[1] + 1;				// OK
+static int *n = b + 1;					// OK
+static int *o = d + 1;					// KO
+
+static int *p = &*&a;					// OK
+static int *q = &*&b[1];				// OK
+static int *r = &*b;					// OK
+static int *s = &*d;					// KO
+
+static int *t = &*(&a + 1);				// OK
+static int *u = &*(&b[1] + 1);				// OK
+static int *v = &*(b + 1);				// OK
+static int *w = &*(d + 1);				// KO
+
+
+struct A {
+	int a;
+	int b[2];
+};
+
+struct B {
+	int c;
+	struct A d;
+};
+
+static struct B x= {1, {1, {1, 1}}};				// OK
+static struct B y= {a, {1, {1, 1}}};				// KO
+static struct B z= {1, {a, {1, 1}}};				// KO
+static struct B aa= {1, {1, {a, 1}}};				// KO
+static struct B ab= {1, {1, {1, a}}};				// KO
+static struct B ac= {.c = 1, .d = {.a = 1, .b = {1, 1}}};	// OK
+static struct B ad= {.c = a, .d = {.a = 1, .b = {1, 1}}};	// KO
+static struct B ae= {.c = 1, .d = {.a = a, .b = {1, 1}}};	// KO
+static struct B af= {.c = 1, .d = {.a = 1, .b = {a, 1}}};	// KO
+static struct B ag= {.c = 1, .d = {.a = 1, .b = {1, a}}};	// KO
+
+static int *ah = &x.d.a;		// OK
+static int *ai = &(&x.d)->a;		// OK
+static int *aj = x.d.b;		// OK
+static int *ak = (&x.d)->b;		// OK
+static int *al = &x.d.b[1];		// OK
+static int *am = &(&x.d)->b[1];	// OK
+
+static int an[] = {a, 1};				// KO
+static int ao[] = {1, a};				// KO
+static int ap[] = {[0] = a, [1] = 1};			// KO
+static int aq[] = {[0] = 1, [1] = a};			// KO
+
+static char *ar = "foobar";				// OK
+
+static void as(void) {
+	int a = 0;
+	int b = a;		// OK
+}
+
+static void at(void) {
+	int a = 1;
+	static int b = a;	// KO
+}
+
+static void au(void) {
+	int a = 1;
+	static int *b = &a;	// KO
+}
+
+static void av(void) {
+	static int a = 1;
+	static int *b = &a;	// OK
+}
+
+
+/*
+ * check-name: Static storage object initializer constness verification.
+ *
+ * check-error-start
+constexpr-init.c:11:17: warning: initializer for static storage duration object is not a constant expression
+constexpr-init.c:17:19: warning: initializer for static storage duration object is not a constant expression
+constexpr-init.c:22:19: warning: initializer for static storage duration object is not a constant expression
+constexpr-init.c:27:22: warning: initializer for static storage duration object is not a constant expression
+constexpr-init.c:41:21: warning: initializer for static storage duration object is not a constant expression
+constexpr-init.c:42:25: warning: initializer for static storage duration object is not a constant expression
+constexpr-init.c:43:30: warning: initializer for static storage duration object is not a constant expression
+constexpr-init.c:44:33: warning: initializer for static storage duration object is not a constant expression
+constexpr-init.c:46:27: warning: initializer for static storage duration object is not a constant expression
+constexpr-init.c:47:41: warning: initializer for static storage duration object is not a constant expression
+constexpr-init.c:48:50: warning: initializer for static storage duration object is not a constant expression
+constexpr-init.c:49:53: warning: initializer for static storage duration object is not a constant expression
+constexpr-init.c:58:20: warning: initializer for static storage duration object is not a constant expression
+constexpr-init.c:59:23: warning: initializer for static storage duration object is not a constant expression
+constexpr-init.c:60:26: warning: initializer for static storage duration object is not a constant expression
+constexpr-init.c:61:35: warning: initializer for static storage duration object is not a constant expression
+constexpr-init.c:72:24: warning: initializer for static storage duration object is not a constant expression
+constexpr-init.c:77:26: warning: initializer for static storage duration object is not a constant expression
+ * check-error-end
+ */
-- 
2.4.5

