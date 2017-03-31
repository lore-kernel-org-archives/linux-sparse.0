From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 11/25] constexpr: check static storage duration objects' intializers' constness
Date: Fri, 31 Mar 2017 03:44:45 +0200
Message-ID: <20170331014459.9351-12-luc.vanoostenryck@gmail.com>
References: <20170331014459.9351-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34219 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934889AbdCaBqk (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 30 Mar 2017 21:46:40 -0400
Received: by mail-wr0-f193.google.com with SMTP id w43so16583021wrb.1
        for <linux-sparse@vger.kernel.org>; Thu, 30 Mar 2017 18:46:39 -0700 (PDT)
In-Reply-To: <20170331014459.9351-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Nicolai Stange <nicstange@gmail.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

From: Nicolai Stange <nicstange@gmail.com>

Initializers of static storage duration objects shall be constant
expressions [6.7.8(4)].

Warn if that requirement is not met and the -Wstatic-initializer-not-const
flag has been given on sparse's command line.

Identify static storage duration objects by having either of
MOD_TOPLEVEL or MOD_STATIC set.

Check an initializer's constness at the lowest possible subobject
level, i.e. at the level of the "assignment-expression" production
in [6.7.8].

Signed-off-by: Nicolai Stange <nicstange@gmail.com>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c                  | 10 ++++++++
 lib.c                       |  2 ++
 lib.h                       |  1 +
 sparse.1                    |  9 +++++++
 validation/constexpr-init.c | 60 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 82 insertions(+)
 create mode 100644 validation/constexpr-init.c

diff --git a/evaluate.c b/evaluate.c
index 138ee1dd6..726ec15d3 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -2627,6 +2627,16 @@ static int handle_initializer(struct expression **ep, int nested,
 		if (!evaluate_expression(e))
 			return 1;
 		compatible_assignment_types(e, ctype, ep, "initializer");
+		/*
+		 * Initializers for static storage duration objects
+		 * shall be constant expressions or a string literal [6.7.8(4)].
+		 */
+		mods |= ctype->ctype.modifiers;
+		mods &= (MOD_TOPLEVEL | MOD_STATIC);
+		if (mods && !(e->flags & (CEF_ACE | CEF_ADDR)))
+			if (Wconstexpr_not_const)
+				warning(e->pos, "non-constant initializer for static object");
+
 		return 1;
 	}
 
diff --git a/lib.c b/lib.c
index cf6bea645..04b270dcb 100644
--- a/lib.c
+++ b/lib.c
@@ -219,6 +219,7 @@ int Waddress_space = 1;
 int Wbitwise = 1;
 int Wcast_to_as = 0;
 int Wcast_truncate = 1;
+int Wconstexpr_not_const = 0;
 int Wcontext = 1;
 int Wdecl = 1;
 int Wdeclarationafterstatement = -1;
@@ -471,6 +472,7 @@ static const struct warning {
 	{ "bitwise", &Wbitwise },
 	{ "cast-to-as", &Wcast_to_as },
 	{ "cast-truncate", &Wcast_truncate },
+	{ "constexpr-not-const", &Wconstexpr_not_const},
 	{ "context", &Wcontext },
 	{ "decl", &Wdecl },
 	{ "declaration-after-statement", &Wdeclarationafterstatement },
diff --git a/lib.h b/lib.h
index 134e56040..003016ce2 100644
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
index 85d6e646b..721b5cfc7 100644
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
index 000000000..d7e7a450f
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
2.12.0

