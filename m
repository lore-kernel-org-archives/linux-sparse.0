From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 2/2] avoid warning on explicit 'bool <- restricted' casts
Date: Fri, 19 May 2017 04:47:02 +0200
Message-ID: <20170519024702.31443-3-luc.vanoostenryck@gmail.com>
References: <20170519024702.31443-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34473 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752301AbdESCrM (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 18 May 2017 22:47:12 -0400
Received: by mail-wm0-f65.google.com with SMTP id d127so15140450wmf.1
        for <linux-sparse@vger.kernel.org>; Thu, 18 May 2017 19:47:11 -0700 (PDT)
In-Reply-To: <20170519024702.31443-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Conversion to bool is special in C since this conversion
is essentially the result of the comparison with zero.
As such, some operations which are normally unsafe to
do with restricted types, like casting to an unrestricted
type, are in fact safe to do when converting to bool
and issuing a warning in those case is useless, confusing
and causes people to add useless casts in the code in
order to shut up the warning.

Fix this by catching explicit 'bool <- restricted type' casts
and not emit a warning like for others casts of restricted
type to non-restrictes ones.

Based-on-patch-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c                        | 13 ++++++++++---
 validation/bool-cast-bad.c        |  1 -
 validation/bool-cast-explicit.c   |  4 ----
 validation/bool-cast-restricted.c | 13 +++++++++++--
 4 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index 3dc26fc09..6bcccde2a 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -2821,9 +2821,16 @@ static struct symbol *evaluate_cast(struct expression *expr)
 		if ((class1 & TYPE_RESTRICT) && restricted_value(target, t1))
 			warning(expr->pos, "cast to %s",
 				show_typename(t1));
-		if (class2 & TYPE_RESTRICT)
-			warning(expr->pos, "cast from %s",
-				show_typename(t2));
+		if (class2 & TYPE_RESTRICT) {
+			if (t1 == &bool_ctype) {
+				if (class2 & TYPE_FOULED)
+					warning(expr->pos, "%s degrades to integer",
+						show_typename(t2));
+			} else {
+				warning(expr->pos, "cast from %s",
+					show_typename(t2));
+			}
+		}
 	}
 
 	if (t1 == &ulong_ctype)
diff --git a/validation/bool-cast-bad.c b/validation/bool-cast-bad.c
index a0b091e1c..ae8b96018 100644
--- a/validation/bool-cast-bad.c
+++ b/validation/bool-cast-bad.c
@@ -15,7 +15,6 @@ static _Bool fstse(struct s a) { return (_Bool)a; }
  * check-command: sparse $file
  *
  * check-error-start
-bool-cast-bad.c:9:42: warning: cast from restricted le16
 bool-cast-bad.c:10:41: warning: incorrect type in return expression (different base types)
 bool-cast-bad.c:10:41:    expected bool
 bool-cast-bad.c:10:41:    got struct s a
diff --git a/validation/bool-cast-explicit.c b/validation/bool-cast-explicit.c
index 4e3c2b7ce..dbb67cc42 100644
--- a/validation/bool-cast-explicit.c
+++ b/validation/bool-cast-explicit.c
@@ -19,8 +19,4 @@ static _Bool fres(le16 a) { return (_Bool)a; }
  * check-command: test-linearize -m64 $file
  * check-output-ignore
  * check-output-excludes: cast\\.
- *
- * check-error-start
-bool-cast-explicit.c:15:37: warning: cast from restricted le16
- * check-error-end
  */
diff --git a/validation/bool-cast-restricted.c b/validation/bool-cast-restricted.c
index 0aa9f35b4..9985d6e32 100644
--- a/validation/bool-cast-restricted.c
+++ b/validation/bool-cast-restricted.c
@@ -3,12 +3,16 @@ typedef unsigned   int __attribute__((bitwise)) large_t;
 
 _Bool lfoo(large_t x) { return x; }
 _Bool qfoo(large_t x) { _Bool r = x; return r; }
+_Bool xfoo(large_t x) { return (_Bool)x; }
 _Bool lbar(large_t x) { return ~x; }
 _Bool qbar(large_t x) { _Bool r = ~x; return r; }
+_Bool xbar(large_t x) { return (_Bool)~x; }
 _Bool lbaz(large_t x) { return !x; }
 _Bool qbaz(large_t x) { _Bool r = !x; return r; }
+_Bool xbaz(large_t x) { return (_Bool)!x; }
 _Bool lqux(large_t x) { return x & LBIT; }
 _Bool qqux(large_t x) { _Bool r = x & LBIT; return r; }
+_Bool xqux(large_t x) { return (_Bool)(x & LBIT); }
 
 
 typedef unsigned short __attribute__((bitwise)) small_t;
@@ -16,19 +20,24 @@ typedef unsigned short __attribute__((bitwise)) small_t;
 
 _Bool sfoo(small_t x) { return x; }
 _Bool tfoo(small_t x) { _Bool r = x; return r; }
+_Bool zfoo(small_t x) { return (_Bool)x; }
 _Bool sbar(small_t x) { return ~x; }
 _Bool tbar(small_t x) { _Bool r = ~x; return r; }
+_Bool zbar(small_t x) { return (_Bool)~x; }
 _Bool sbaz(small_t x) { return !x; }
 _Bool tbaz(small_t x) { _Bool r = !x; return r; }
+_Bool zbaz(small_t x) { return (_Bool)!x; }
 _Bool squx(small_t x) { return x & SBIT; }
 _Bool tqux(small_t x) { _Bool r = x & SBIT; return r; }
+_Bool zqux(small_t x) { return (_Bool)(x & SBIT); }
 
 /*
  * check-name: bool-cast-restricted.c
  * check-command: sparse -Wno-decl $file
  *
  * check-error-start
-bool-cast-restricted.c:19:32: warning: restricted small_t degrades to integer
-bool-cast-restricted.c:20:35: warning: restricted small_t degrades to integer
+bool-cast-restricted.c:24:32: warning: restricted small_t degrades to integer
+bool-cast-restricted.c:25:35: warning: restricted small_t degrades to integer
+bool-cast-restricted.c:26:33: warning: restricted small_t degrades to integer
  * check-error-end
  */
-- 
2.13.0

