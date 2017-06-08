From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/2] ret-void: warn for implicit type
Date: Thu,  8 Jun 2017 04:47:36 +0200
Message-ID: <20170608024736.49780-3-luc.vanoostenryck@gmail.com>
References: <20170608024736.49780-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34107 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751853AbdFHCr4 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 7 Jun 2017 22:47:56 -0400
Received: by mail-wm0-f67.google.com with SMTP id 70so5113994wme.1
        for <linux-sparse@vger.kernel.org>; Wed, 07 Jun 2017 19:47:55 -0700 (PDT)
In-Reply-To: <20170608024736.49780-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Chris Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Currently, no warning is given for symbols for which no
type is explicitely given. But for functions we received
a pointless warning like here under if the returned type
is effectively an int:
	warning: incorrect type in return expression (invalid types)
	    expected incomplete type
	    got int

Fix this by issuing the warning.
Also give an implicit type of int, as required by C89, to
avoid pointless warning about the expected incomplete type.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 parse.c                        |  9 +++++++++
 validation/alias-mixed.c       |  2 +-
 validation/badtype2.c          |  1 +
 validation/implicit-ret-type.c | 15 +++++++++++++++
 validation/implicit-type.c     | 14 ++++++++++++++
 validation/typedef_shadow.c    |  1 +
 6 files changed, 41 insertions(+), 1 deletion(-)
 create mode 100644 validation/implicit-ret-type.c
 create mode 100644 validation/implicit-type.c

diff --git a/parse.c b/parse.c
index b08d4acef..214547904 100644
--- a/parse.c
+++ b/parse.c
@@ -2920,6 +2920,11 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
 			}
 		}
 	} else if (base_type && base_type->type == SYM_FN) {
+		if (base_type->ctype.base_type == &incomplete_ctype) {
+			warning(decl->pos, "'%s()' has implicit return type",
+				show_ident(decl->ident));
+			base_type->ctype.base_type = &int_ctype;
+		}
 		/* K&R argument declaration? */
 		if (lookup_type(token))
 			return parse_k_r_arguments(token, decl, list);
@@ -2931,6 +2936,10 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
 	} else if (base_type == &void_ctype && !(decl->ctype.modifiers & MOD_EXTERN)) {
 		sparse_error(token->pos, "void declaration");
 	}
+	if (base_type == &incomplete_ctype) {
+		warning(decl->pos, "'%s' has implicit type", show_ident(decl->ident));
+		decl->ctype.base_type = &int_ctype;;
+	}
 
 	for (;;) {
 		if (!is_typedef && match_op(token, '=')) {
diff --git a/validation/alias-mixed.c b/validation/alias-mixed.c
index 429304774..0cfbe36b8 100644
--- a/validation/alias-mixed.c
+++ b/validation/alias-mixed.c
@@ -15,7 +15,7 @@ static int bar(int *p)
 	return g == 1;
 }
 
-static test(void)
+static void test(void)
 {
 	foo(&g);
 	bar(&g);
diff --git a/validation/badtype2.c b/validation/badtype2.c
index 90a5fa1e4..49fec87ce 100644
--- a/validation/badtype2.c
+++ b/validation/badtype2.c
@@ -12,6 +12,7 @@ static undef foo(char *c)
 /*
  * check-name: missing type
  * check-error-start
+badtype2.c:2:8: warning: 'undef' has implicit type
 badtype2.c:2:14: error: Expected ; at end of declaration
 badtype2.c:2:14: error: got bar
 badtype2.c:3:14: error: Expected ; at end of declaration
diff --git a/validation/implicit-ret-type.c b/validation/implicit-ret-type.c
new file mode 100644
index 000000000..784a28531
--- /dev/null
+++ b/validation/implicit-ret-type.c
@@ -0,0 +1,15 @@
+fun(void);
+
+foo(void) { return 1; }
+static bar(void) { return 1; }
+
+/*
+ * check-name: implicit-ret-type.c
+ * check-command: sparse -Wno-decl $file
+ *
+ * check-error-start
+implicit-ret-type.c:1:1: warning: 'fun()' has implicit return type
+implicit-ret-type.c:3:1: warning: 'foo()' has implicit return type
+implicit-ret-type.c:4:8: warning: 'bar()' has implicit return type
+ * check-error-end
+ */
diff --git a/validation/implicit-type.c b/validation/implicit-type.c
new file mode 100644
index 000000000..724bab71e
--- /dev/null
+++ b/validation/implicit-type.c
@@ -0,0 +1,14 @@
+extern a;
+static b;
+c;
+
+/*
+ * check-name: implicit-type.c
+ * check-command: sparse -Wno-decl $file
+ *
+ * check-error-start
+implicit-type.c:1:8: warning: 'a' has implicit type
+implicit-type.c:2:8: warning: 'b' has implicit type
+implicit-type.c:3:1: warning: 'c' has implicit type
+ * check-error-end
+ */
diff --git a/validation/typedef_shadow.c b/validation/typedef_shadow.c
index c72cec72d..e52de80f2 100644
--- a/validation/typedef_shadow.c
+++ b/validation/typedef_shadow.c
@@ -6,6 +6,7 @@ static void f(int T)
 /*
  * check-name: typedef shadowing
  * check-error-start:
+typedef_shadow.c:4:16: warning: 'T' has implicit type
 typedef_shadow.c:4:18: error: Expected ; at end of declaration
 typedef_shadow.c:4:18: error: got a
  * check-error-end:
-- 
2.13.0

