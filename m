From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] Fix type checking of variadic functions
Date: Wed,  2 Nov 2016 18:13:49 +0100
Message-ID: <20161102171349.17666-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34206 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932325AbcKBROM (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 2 Nov 2016 13:14:12 -0400
Received: by mail-wm0-f66.google.com with SMTP id p190so4045409wmp.1
        for <linux-sparse@vger.kernel.org>; Wed, 02 Nov 2016 10:14:11 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>

When doing a type comparison between functions, in the varidicity part,
the base type of these functions (= their return type) is
wrongly used intead of their own type.

Fix this and add some tests showing this and others cases are
now OK

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
CC: Al Viro <viro@zeniv.linux.org.uk>
---
 evaluate.c                   |  2 +-
 validation/function-redecl.c | 62 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 1 deletion(-)
 create mode 100644 validation/function-redecl.c

diff --git a/evaluate.c b/evaluate.c
index e350c0c0..012fa861 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -729,7 +729,7 @@ const char *type_difference(struct ctype *c1, struct ctype *c2,
 			mod2 = t2->ctype.modifiers;
 			as2 = t2->ctype.as;
 
-			if (base1->variadic != base2->variadic)
+			if (t1->variadic != t2->variadic)
 				return "incompatible variadic arguments";
 			examine_fn_arguments(t1);
 			examine_fn_arguments(t2);
diff --git a/validation/function-redecl.c b/validation/function-redecl.c
new file mode 100644
index 00000000..7fbceb43
--- /dev/null
+++ b/validation/function-redecl.c
@@ -0,0 +1,62 @@
+#define __user	__attribute__((address_space(1)))
+
+
+int ret_type(void);
+void ret_type(void) { }				/* check-should-fail */
+
+
+int ret_const(void);
+int const ret_const(void) { return 0; }		/* check-should-fail */
+
+
+void *ret_as(void);
+void __user *ret_as(void) { return 0; }		/* check-should-fail */
+
+
+void *ret_mod(void);
+void const *ret_mod(void) { return 0; }		/* check-should-fail */
+
+
+void arg_type(int a);
+void arg_type(void *a) { }			/* check-should-fail */
+
+
+void arg_const(int a);
+void arg_const(const int a) { }			/* OK */
+
+
+void arg_as(void *a);
+void arg_as(void __user *a) { }			/* check-should-fail */
+
+
+void arg_mod(void *);
+void arg_mod(void const *a) { }			/* check-should-fail */
+
+
+void arg_more_arg(int a);
+void arg_more_arg(int a, int b) { }		/* check-should-fail */
+
+
+void arg_less_arg(int a, int b);
+void arg_less_arg(int a) { }			/* check-should-fail */
+
+
+void arg_vararg(int a);
+void arg_vararg(int a, ...) { }			/* check-should-fail */
+
+/*
+ * check-name: function-redecl
+ *
+ * check-error-start
+function-redecl.c:5:6: error: symbol 'ret_type' redeclared with different type (originally declared at function-redecl.c:4) - different base types
+function-redecl.c:9:11: error: symbol 'ret_const' redeclared with different type (originally declared at function-redecl.c:8) - different modifiers
+function-redecl.c:13:13: error: symbol 'ret_as' redeclared with different type (originally declared at function-redecl.c:12) - different address spaces
+function-redecl.c:17:12: error: symbol 'ret_mod' redeclared with different type (originally declared at function-redecl.c:16) - different modifiers
+function-redecl.c:21:6: error: symbol 'arg_type' redeclared with different type (originally declared at function-redecl.c:20) - incompatible argument 1 (different base types)
+function-redecl.c:29:6: error: symbol 'arg_as' redeclared with different type (originally declared at function-redecl.c:28) - incompatible argument 1 (different address spaces)
+function-redecl.c:33:6: error: symbol 'arg_mod' redeclared with different type (originally declared at function-redecl.c:32) - incompatible argument 1 (different modifiers)
+function-redecl.c:37:6: error: symbol 'arg_more_arg' redeclared with different type (originally declared at function-redecl.c:36) - different argument counts
+function-redecl.c:41:6: error: symbol 'arg_less_arg' redeclared with different type (originally declared at function-redecl.c:40) - different argument counts
+function-redecl.c:45:6: error: symbol 'arg_vararg' redeclared with different type (originally declared at function-redecl.c:44) - incompatible variadic arguments
+ * check-error-end
+ */
-- 
2.10.1

