From: Nicolai Stange <nicstange@gmail.com>
Subject: [PATCH v3 09/21] evaluate: check static storage duration objects' intializers' constness
Date: Mon, 01 Feb 2016 03:37:18 +0100
Message-ID: <87io29i2ap.fsf@gmail.com>
References: <87lh75jh9l.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34023 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757541AbcBAChV (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 31 Jan 2016 21:37:21 -0500
Received: by mail-wm0-f65.google.com with SMTP id p63so7025356wmp.1
        for <linux-sparse@vger.kernel.org>; Sun, 31 Jan 2016 18:37:21 -0800 (PST)
In-Reply-To: <87lh75jh9l.fsf@gmail.com> (Nicolai Stange's message of "Mon, 01
	Feb 2016 03:28:38 +0100")
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Nicolai Stange <nicstange@gmail.com>

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
 evaluate.c                  | 26 +++++++++++++++++++-
 lib.c                       |  2 ++
 lib.h                       |  1 +
 sparse.1                    |  9 +++++++
 validation/constexpr-init.c | 60 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 97 insertions(+), 1 deletion(-)
 create mode 100644 validation/constexpr-init.c

diff --git a/evaluate.c b/evaluate.c
index dd44cd5..300bfbe 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -2455,6 +2455,7 @@ static void handle_list_initializer(struct expression *expr,
 {
 	struct expression *e, *last = NULL, *top = NULL, *next;
 	int jumped = 0;
+	unsigned long old_modifiers;
 
 	FOR_EACH_PTR(expr->expr_list, e) {
 		struct expression **v;
@@ -2509,8 +2510,21 @@ found:
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
@@ -2620,6 +2634,16 @@ static int handle_simple_initializer(struct expression **ep, int nested,
 		if (!evaluate_expression(e))
 			return 1;
 		compatible_assignment_types(e, ctype, ep, "initializer");
+		/*
+		 * Initializers for static storage duration objects
+		 * shall be constant expressions or a string literal [6.7.8(4)].
+		 */
+		if ((ctype->ctype.modifiers & (MOD_TOPLEVEL | MOD_STATIC)) &&
+			!(e->constexpr_flags & (CONSTEXPR_FLAG_ARITH_CONST_EXPR
+					| CONSTEXPR_FLAG_ADDR_CONST)) &&
+			Wconstexpr_not_const)
+			warning(e->pos, "non-constant initializer for static object");
+
 		return 1;
 	}
 
diff --git a/lib.c b/lib.c
index 8dc5bcf..75cea42 100644
--- a/lib.c
+++ b/lib.c
@@ -219,6 +219,7 @@ int Waddress_space = 1;
 int Wbitwise = 0;
 int Wcast_to_as = 0;
 int Wcast_truncate = 1;
+int Wconstexpr_not_const = 0;
 int Wcontext = 1;
 int Wdecl = 1;
 int Wdeclarationafterstatement = -1;
@@ -442,6 +443,7 @@ static const struct warning {
 	{ "bitwise", &Wbitwise },
 	{ "cast-to-as", &Wcast_to_as },
 	{ "cast-truncate", &Wcast_truncate },
+	{ "constexpr-not-const", &Wconstexpr_not_const},
 	{ "context", &Wcontext },
 	{ "decl", &Wdecl },
 	{ "declaration-after-statement", &Wdeclarationafterstatement },
diff --git a/lib.h b/lib.h
index 15b69fa..916eb31 100644
--- a/lib.h
+++ b/lib.h
@@ -105,6 +105,7 @@ extern int Waddress_space;
 extern int Wbitwise;
 extern int Wcast_to_as;
 extern int Wcast_truncate;
+extern int Wconstexpr_not_const;
 extern int Wcontext;
 extern int Wdecl;
 extern int Wdeclarationafterstatement;
diff --git a/sparse.1 b/sparse.1
index 4adaf6c..7117bdf 100644
--- a/sparse.1
+++ b/sparse.1
@@ -86,6 +86,15 @@ Sparse issues these warnings by default.  To turn them off, use
 \fB\-Wno\-cast\-truncate\fR.
 .
 .TP
+.B \-Wconstexpr-not-const
+Warn if a non-constant expression is encountered when really expecting a
+constant expression instead.
+Currently, this warns when initializing an object of static storage duration
+with an initializer which is not a constant expression.
+
+Sparse does not issue these warnings by default.
+.
+.TP
 .B \-Wcontext
 Warn about potential errors in synchronization or other delimited contexts.
 
diff --git a/validation/constexpr-init.c b/validation/constexpr-init.c
new file mode 100644
index 0000000..d7e7a45
--- /dev/null
+++ b/validation/constexpr-init.c
@@ -0,0 +1,60 @@
+static int a = 1;					// OK
+static int b[2] = {1, 1};				// OK
+static void c(void) {}
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
+static struct B d= {1, {1, {1, 1}}};				// OK
+static struct B e= {a, {1, {1, 1}}};				// KO
+static struct B f= {1, {a, {1, 1}}};				// KO
+static struct B g= {1, {1, {a, 1}}};				// KO
+static struct B h= {1, {1, {1, a}}};				// KO
+static struct B i= {.c = 1, .d = {.a = 1, .b = {1, 1}}};	// OK
+static struct B j= {.c = a, .d = {.a = 1, .b = {1, 1}}};	// KO
+static struct B k= {.c = 1, .d = {.a = a, .b = {1, 1}}};	// KO
+static struct B l= {.c = 1, .d = {.a = 1, .b = {a, 1}}};	// KO
+static struct B m= {.c = 1, .d = {.a = 1, .b = {1, a}}};	// KO
+
+static int n[] = {a, 1};				// KO
+static int o[] = {1, a};				// KO
+static int p[] = {[0] = a, [1] = 1};			// KO
+static int q[] = {[0] = 1, [1] = a};			// KO
+
+static void r(void) {
+	int a = 0;
+	int b = a;		// OK
+}
+
+static void s(void) {
+	int a = 1;
+	static int b = a;	// KO
+}
+
+/*
+ * check-name: static storage object initializer constness verification.
+ * check-command: sparse -Wconstexpr-not-const $file
+ *
+ * check-error-start
+constexpr-init.c:16:21: warning: non-constant initializer for static object
+constexpr-init.c:17:25: warning: non-constant initializer for static object
+constexpr-init.c:18:29: warning: non-constant initializer for static object
+constexpr-init.c:19:32: warning: non-constant initializer for static object
+constexpr-init.c:21:26: warning: non-constant initializer for static object
+constexpr-init.c:22:40: warning: non-constant initializer for static object
+constexpr-init.c:23:49: warning: non-constant initializer for static object
+constexpr-init.c:24:52: warning: non-constant initializer for static object
+constexpr-init.c:26:19: warning: non-constant initializer for static object
+constexpr-init.c:27:22: warning: non-constant initializer for static object
+constexpr-init.c:28:25: warning: non-constant initializer for static object
+constexpr-init.c:29:34: warning: non-constant initializer for static object
+constexpr-init.c:38:24: warning: non-constant initializer for static object
+ * check-error-end
+ */
-- 
2.7.0

