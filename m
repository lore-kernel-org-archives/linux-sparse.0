From: Nicolai Stange <nicstange@gmail.com>
Subject: [PATCH v2 07/13] evaluate: check static storage duration objects' intializers' constness
Date: Mon, 25 Jan 2016 15:57:45 +0100
Message-ID: <87zivtemfq.fsf@gmail.com>
References: <87twm1g1go.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35582 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755517AbcAYO5s (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 25 Jan 2016 09:57:48 -0500
Received: by mail-wm0-f66.google.com with SMTP id 123so11788576wmz.2
        for <linux-sparse@vger.kernel.org>; Mon, 25 Jan 2016 06:57:47 -0800 (PST)
In-Reply-To: <87twm1g1go.fsf@gmail.com> (Nicolai Stange's message of "Mon, 25
	Jan 2016 15:47:51 +0100")
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Nicolai Stange <nicstange@gmail.com>, Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Initializers of static storage duration objects shall be constant
expressions [6.7.8(4)].

Warn if that requirement is not met and the -Wstatic-initializer-not-const
flag has been given on sparse's command line.

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
 evaluate.c                  |  26 ++++++++++-
 lib.c                       |   2 +
 lib.h                       |   2 +-
 sparse.1                    |   7 +++
 validation/constexpr-init.c | 110 ++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 145 insertions(+), 2 deletions(-)
 create mode 100644 validation/constexpr-init.c

diff --git a/evaluate.c b/evaluate.c
index 70f419f..e3b08e4 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -2468,6 +2468,7 @@ static void handle_list_initializer(struct expression *expr,
 {
 	struct expression *e, *last = NULL, *top = NULL, *next;
 	int jumped = 0;
+	unsigned long old_modifiers;
 
 	FOR_EACH_PTR(expr->expr_list, e) {
 		struct expression **v;
@@ -2522,8 +2523,21 @@ found:
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
@@ -2633,6 +2647,16 @@ static int handle_simple_initializer(struct expression **ep, int nested,
 		if (!evaluate_expression(e))
 			return 1;
 		compatible_assignment_types(e, ctype, ep, "initializer");
+		/*
+		 * Initializers for static storage duration objects
+		 * shall be constant expressions or a string literal [6.7.8(4)].
+		 */
+		if ((ctype->ctype.modifiers & (MOD_TOPLEVEL | MOD_STATIC)) &&
+			!(e->flags & (EXPR_FLAG_ARITH_CONST_EXPR
+					| EXPR_FLAG_ADDR_CONST_EXPR)) &&
+			Wstatic_initializer_not_const)
+			warning(e->pos, "initializer for static storage duration object is not a constant expression");
+
 		return 1;
 	}
 
diff --git a/lib.c b/lib.c
index 8dc5bcf..855fb3e 100644
--- a/lib.c
+++ b/lib.c
@@ -241,6 +241,7 @@ int Wtypesign = 0;
 int Wundef = 0;
 int Wuninitialized = 1;
 int Wvla = 1;
+int Wstatic_initializer_not_const = 0;
 
 int dbg_entry = 0;
 int dbg_dead = 0;
@@ -464,6 +465,7 @@ static const struct warning {
 	{ "undef", &Wundef },
 	{ "uninitialized", &Wuninitialized },
 	{ "vla", &Wvla },
+	{ "static-initializer-not-const", &Wstatic_initializer_not_const},
 };
 
 enum {
diff --git a/lib.h b/lib.h
index 15b69fa..1b38db2 100644
--- a/lib.h
+++ b/lib.h
@@ -127,7 +127,7 @@ extern int Wtypesign;
 extern int Wundef;
 extern int Wuninitialized;
 extern int Wvla;
-
+extern int Wstatic_initializer_not_const;
 extern int dbg_entry;
 extern int dbg_dead;
 
diff --git a/sparse.1 b/sparse.1
index 4adaf6c..0df27f9 100644
--- a/sparse.1
+++ b/sparse.1
@@ -308,6 +308,13 @@ C99 does not specify the sizeof a _Bool.  gcc uses 1.
 Sparse does not issue these warnings by default.
 .
 .TP
+.B \-Wstatic-initializer-not-const
+Warn when initializing an object of static storage duration with an initializer
+which is not a constant expression.
+
+Sparse does not issue these warnings by default.
+.
+.TP
 .B \-Wtransparent\-union
 Warn about any declaration using the GCC extension
 \fB__attribute__((transparent_union))\fR.
diff --git a/validation/constexpr-init.c b/validation/constexpr-init.c
new file mode 100644
index 0000000..b357de1
--- /dev/null
+++ b/validation/constexpr-init.c
@@ -0,0 +1,110 @@
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
+ * check-command: sparse -Wstatic-initializer-not-const $file
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
2.7.0

