From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] avoid useless warning for 'bool <- restricted type' conversion
Date: Thu, 11 May 2017 22:20:10 +0200
Message-ID: <20170511202010.40266-1-luc.vanoostenryck@gmail.com>
References: <CANeU7Qn1_FpuU2+n6x6Sh=kuERwdGA952VbOwfdpRMQR3WkaxQ@mail.gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36625 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755898AbdEKUWP (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 11 May 2017 16:22:15 -0400
Received: by mail-wr0-f195.google.com with SMTP id v42so5069617wrc.3
        for <linux-sparse@vger.kernel.org>; Thu, 11 May 2017 13:22:14 -0700 (PDT)
In-Reply-To: <CANeU7Qn1_FpuU2+n6x6Sh=kuERwdGA952VbOwfdpRMQR3WkaxQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>

Conversion to bool is special in C since this conversion
is essentially the result of the comparison with zero.
As such, some operations which are normally unsafe to
do with restricted types, like casting to an unrestricted
type, are in fact safe to do when converting to bool
and issuing a warning in those case is useless, confusing
and causes people to add useless casts in the code in
order to shut up the warning.

Fix this by catching such 'bool <- restricted type' conversion
and avoid such warnings.

CC: Al Viro <viro@zeniv.linux.org.uk>
Originally-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c                        |  6 ++++++
 validation/bool-cast-bad.c        |  3 ---
 validation/bool-cast-implicit.c   |  3 ---
 validation/bool-cast-restricted.c | 25 +++++++++++++++++++++++++
 4 files changed, 31 insertions(+), 6 deletions(-)
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
index 000000000..f6776b050
--- /dev/null
+++ b/validation/bool-cast-restricted.c
@@ -0,0 +1,25 @@
+typedef unsigned   int __attribute__((bitwise)) large_t;
+#define	LBIT	((__attribute__((force)) large_t) 1)
+
+_Bool lfoo(large_t x) { return x; }
+_Bool lbar(large_t x) { return ~x; }
+_Bool lbaz(large_t x) { return !x; }
+_Bool lqux(large_t x) { return x & LBIT; }
+
+
+typedef unsigned short __attribute__((bitwise)) small_t;
+#define	SBIT	((__attribute__((force)) small_t) 1)
+
+_Bool sfoo(small_t x) { return x; }
+_Bool sbar(small_t x) { return ~x; }
+_Bool sbaz(small_t x) { return !x; }
+_Bool squx(small_t x) { return x & SBIT; }
+
+/*
+ * check-name: bool-cast-restricted.c
+ * check-command: sparse -Wno-decl $file
+ *
+ * check-error-start
+bool-cast-restricted.c:14:32: warning: restricted small_t degrades to integer
+ * check-error-end
+ */
-- 
2.12.2

