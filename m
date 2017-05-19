From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 1/2] avoid warning on implicit 'bool <- restricted' casts
Date: Fri, 19 May 2017 04:47:01 +0200
Message-ID: <20170519024702.31443-2-luc.vanoostenryck@gmail.com>
References: <20170519024702.31443-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34438 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755562AbdESCrL (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 18 May 2017 22:47:11 -0400
Received: by mail-wm0-f65.google.com with SMTP id d127so15140382wmf.1
        for <linux-sparse@vger.kernel.org>; Thu, 18 May 2017 19:47:10 -0700 (PDT)
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

Fix this by catching implicit 'bool <- restricted type' casts
and not emit a warning like for others casts of restricted
type to non-restrictes ones.

Originally-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c                        |  6 ++++++
 validation/bool-cast-bad.c        |  3 ---
 validation/bool-cast-implicit.c   |  3 ---
 validation/bool-cast-restricted.c | 34 ++++++++++++++++++++++++++++++++++
 4 files changed, 40 insertions(+), 6 deletions(-)
 create mode 100644 validation/bool-cast-restricted.c

diff --git a/evaluate.c b/evaluate.c
index 976857915..3dc26fc09 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -1345,6 +1345,12 @@ static int check_assignment_types(struct symbol *target, struct expression **rp,
 				return 1;
 		} else if (!(sclass & TYPE_RESTRICT))
 			goto Cast;
+                if (t == &bool_ctype) {
+                        if (is_fouled_type(s))
+                                warning((*rp)->pos, "%s degrades to integer",
+                                        show_typename(s->ctype.base_type));
+                        goto Cast;
+                }
 		*typediff = "different base types";
 		return 0;
 	}
diff --git a/validation/bool-cast-bad.c b/validation/bool-cast-bad.c
index b7e7c058d..a0b091e1c 100644
--- a/validation/bool-cast-bad.c
+++ b/validation/bool-cast-bad.c
@@ -15,9 +15,6 @@ static _Bool fstse(struct s a) { return (_Bool)a; }
  * check-command: sparse $file
  *
  * check-error-start
-bool-cast-bad.c:8:41: warning: incorrect type in return expression (different base types)
-bool-cast-bad.c:8:41:    expected bool
-bool-cast-bad.c:8:41:    got restricted le16 [usertype] a
 bool-cast-bad.c:9:42: warning: cast from restricted le16
 bool-cast-bad.c:10:41: warning: incorrect type in return expression (different base types)
 bool-cast-bad.c:10:41:    expected bool
diff --git a/validation/bool-cast-implicit.c b/validation/bool-cast-implicit.c
index ee8b705b9..9d89443b1 100644
--- a/validation/bool-cast-implicit.c
+++ b/validation/bool-cast-implicit.c
@@ -21,8 +21,5 @@ static _Bool fres(le16 a) { return a; }
  * check-output-excludes: cast\\.
  *
  * check-error-start
-bool-cast-implicit.c:15:36: warning: incorrect type in return expression (different base types)
-bool-cast-implicit.c:15:36:    expected bool
-bool-cast-implicit.c:15:36:    got restricted le16 [usertype] a
  * check-error-end
  */
diff --git a/validation/bool-cast-restricted.c b/validation/bool-cast-restricted.c
new file mode 100644
index 000000000..0aa9f35b4
--- /dev/null
+++ b/validation/bool-cast-restricted.c
@@ -0,0 +1,34 @@
+typedef unsigned   int __attribute__((bitwise)) large_t;
+#define	LBIT	((__attribute__((force)) large_t) 1)
+
+_Bool lfoo(large_t x) { return x; }
+_Bool qfoo(large_t x) { _Bool r = x; return r; }
+_Bool lbar(large_t x) { return ~x; }
+_Bool qbar(large_t x) { _Bool r = ~x; return r; }
+_Bool lbaz(large_t x) { return !x; }
+_Bool qbaz(large_t x) { _Bool r = !x; return r; }
+_Bool lqux(large_t x) { return x & LBIT; }
+_Bool qqux(large_t x) { _Bool r = x & LBIT; return r; }
+
+
+typedef unsigned short __attribute__((bitwise)) small_t;
+#define	SBIT	((__attribute__((force)) small_t) 1)
+
+_Bool sfoo(small_t x) { return x; }
+_Bool tfoo(small_t x) { _Bool r = x; return r; }
+_Bool sbar(small_t x) { return ~x; }
+_Bool tbar(small_t x) { _Bool r = ~x; return r; }
+_Bool sbaz(small_t x) { return !x; }
+_Bool tbaz(small_t x) { _Bool r = !x; return r; }
+_Bool squx(small_t x) { return x & SBIT; }
+_Bool tqux(small_t x) { _Bool r = x & SBIT; return r; }
+
+/*
+ * check-name: bool-cast-restricted.c
+ * check-command: sparse -Wno-decl $file
+ *
+ * check-error-start
+bool-cast-restricted.c:19:32: warning: restricted small_t degrades to integer
+bool-cast-restricted.c:20:35: warning: restricted small_t degrades to integer
+ * check-error-end
+ */
-- 
2.13.0

