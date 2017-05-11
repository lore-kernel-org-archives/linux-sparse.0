From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] avoid useless warning for 'bool <- restricted type' conversion
Date: Thu, 11 May 2017 18:21:27 +0200
Message-ID: <20170511162127.15692-1-luc.vanoostenryck@gmail.com>
References: <20170511060744.GJ390@ZenIV.linux.org.uk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34264 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752770AbdEKQV6 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 11 May 2017 12:21:58 -0400
Received: by mail-wm0-f66.google.com with SMTP id d127so8116225wmf.1
        for <linux-sparse@vger.kernel.org>; Thu, 11 May 2017 09:21:58 -0700 (PDT)
In-Reply-To: <20170511060744.GJ390@ZenIV.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-sparse@vger.kernel.org, Pushkar Jambhlekar <pushkar.iit@gmail.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

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
 validation/bool-cast-restricted.c | 25 +++++++++++++++++++++++++
 2 files changed, 31 insertions(+)
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

