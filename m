From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/3] dereference of a function is a no-op
Date: Thu, 21 Dec 2017 01:19:15 +0100
Message-ID: <20171221001915.57047-4-luc.vanoostenryck@gmail.com>
References: <20171221001915.57047-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:43066 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755711AbdLUAV1 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 20 Dec 2017 19:21:27 -0500
Received: by mail-wm0-f66.google.com with SMTP id n138so12974732wmg.2
        for <linux-sparse@vger.kernel.org>; Wed, 20 Dec 2017 16:21:26 -0800 (PST)
In-Reply-To: <20171221001915.57047-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

For the '*' operator and functions, the C standard says:
        "If the operand points to a function, the result is a
         function designator; ... If the operand has type
         ‘pointer to type’, the result has type ‘type’".
but also (C11 6.3.2.1p4):
        "(except with 'sizeof' ...) a function designator with type
         ‘function returning type’ is converted to an expression
          that has type ‘pointer to function returning type’".

This means that in dereferencement of a function-designator is
a no-op since the resulting expression is immediately back converted
to a pointer to the function.

The change effectively drop any dereferencement of function types
during their evaluation.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c                         | 3 +++
 validation/function-pointer-type.c | 1 -
 validation/linear/call-builtin.c   | 1 -
 validation/linear/call-direct.c    | 1 -
 validation/linear/call-indirect.c  | 1 -
 validation/linear/call-inline.c    | 1 -
 validation/sizeof-function.c       | 1 -
 7 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index e6dbe3d8d..840f98d3e 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -1782,6 +1782,9 @@ static struct symbol *evaluate_dereference(struct expression *expr)
 	default:
 		expression_error(expr, "cannot dereference this type");
 		return NULL;
+	case SYM_FN:
+		*expr = *op;
+		return expr->ctype;
 	case SYM_PTR:
 		node = alloc_symbol(expr->pos, SYM_NODE);
 		node->ctype.modifiers = target->ctype.modifiers & MOD_SPECIFIER;
diff --git a/validation/function-pointer-type.c b/validation/function-pointer-type.c
index cb1f59b2a..ebc4007ba 100644
--- a/validation/function-pointer-type.c
+++ b/validation/function-pointer-type.c
@@ -9,5 +9,4 @@ void f3(void) { int (*f)(void); f = ***fun; }	// C99,C11 6.5.3.2p4
 /*
  * check-name: type of function pointers
  * check-command: sparse -Wno-decl $file
- * check-known-to-fail
  */
diff --git a/validation/linear/call-builtin.c b/validation/linear/call-builtin.c
index b0261e992..b15113593 100644
--- a/validation/linear/call-builtin.c
+++ b/validation/linear/call-builtin.c
@@ -10,7 +10,6 @@ u32 f3(u32 a) { return (***__builtin_popcount)(a); }	// C99,C11 6.5.3.2p4
 /*
  * check-name: builtin calls
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-excludes: load
diff --git a/validation/linear/call-direct.c b/validation/linear/call-direct.c
index 176bfe229..52f86306b 100644
--- a/validation/linear/call-direct.c
+++ b/validation/linear/call-direct.c
@@ -10,7 +10,6 @@ int f3(void) { return (***fun)(); }	// C99,C11 6.5.3.2p4
 /*
  * check-name: direct calls
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-excludes: load
diff --git a/validation/linear/call-indirect.c b/validation/linear/call-indirect.c
index d8797b024..1275910c4 100644
--- a/validation/linear/call-indirect.c
+++ b/validation/linear/call-indirect.c
@@ -8,7 +8,6 @@ int g3(int (*fun)(void)) { return (***fun)(); }	// C99,C11 6.5.3.2p4
 /*
  * check-name: indirect calls
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-excludes: load
diff --git a/validation/linear/call-inline.c b/validation/linear/call-inline.c
index d931a3cba..a33f0a1c8 100644
--- a/validation/linear/call-inline.c
+++ b/validation/linear/call-inline.c
@@ -10,7 +10,6 @@ int i3(void) { return (***fun)(); }		// C99,C11 6.5.3.2p4
 /*
  * check-name: inline calls
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-excludes: load
diff --git a/validation/sizeof-function.c b/validation/sizeof-function.c
index 20c795e94..27d535d4e 100644
--- a/validation/sizeof-function.c
+++ b/validation/sizeof-function.c
@@ -36,7 +36,6 @@ int test(void)
 /*
  * check-name: sizeof-function
  * check-command: sparse -Wno-decl $file
- * check-known-to-fail
  *
  * check-error-start
 sizeof-function.c:22:14: warning: expression using sizeof on a function
-- 
2.15.0

