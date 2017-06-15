From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] fix: add missing examine in evaluate_dereference()
Date: Thu, 15 Jun 2017 21:17:50 +0200
Message-ID: <20170615191750.71888-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:32942 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750814AbdFOTSJ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 15 Jun 2017 15:18:09 -0400
Received: by mail-wm0-f65.google.com with SMTP id f90so1367159wmh.0
        for <linux-sparse@vger.kernel.org>; Thu, 15 Jun 2017 12:18:09 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Chris Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

sparse use lazy type evaluation. This evaluation is done
via the examine_*() functions, which we must insure
to have been called when type information is needed.

However, it seems that this is not done for expressions
with multiple level of dereferencing. There is (at least)
two symptoms:
1) When the inner expression is complex and contains a
   typeof: a bogus error message is issued, either
   "error: internal error: bad type in derived(11)" or
   "error: cannot dereference this type", sometimes followed
   by another bogus "warning: unknown expression (...)".
2) This one is only visible with test-linearize but happen
   even on a plain double deref: the result of the inner
   deref is typeless.
Obviously the first symptom is a consequence of the second one.

Fix this by adding a call to examine_symbol_type() at the
beginning of evaluate_dereference().

Note: This fixes all the 17 "cannot dereference" and 19
   "internal error" present on the Linux kernel while using
   sparse on a x86-64 allyesconfig (most coming from the call
   of rcu_dereference_sched() in cpufreq_update_util()).

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c                            |  2 ++
 validation/badtype5.c                 | 18 ++++++++++++++++++
 validation/linear/missing-insn-size.c | 19 +++++++++++++++++++
 3 files changed, 39 insertions(+)
 create mode 100644 validation/badtype5.c
 create mode 100644 validation/linear/missing-insn-size.c

diff --git a/evaluate.c b/evaluate.c
index e606c2786..cf3cf244d 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -1738,6 +1738,8 @@ static struct symbol *evaluate_dereference(struct expression *expr)
 		return expr->ctype;
 	}
 
+	examine_symbol_type(ctype);
+
 	/* Dereferencing a node drops all the node information. */
 	if (ctype->type == SYM_NODE)
 		ctype = ctype->ctype.base_type;
diff --git a/validation/badtype5.c b/validation/badtype5.c
new file mode 100644
index 000000000..c3c34ab23
--- /dev/null
+++ b/validation/badtype5.c
@@ -0,0 +1,18 @@
+#define	__force		__attribute__((force))
+
+int foo(int *addr);
+int foo(int *addr)
+{
+	return *(*((typeof(addr) __force *) addr));
+}
+
+/*
+ * check-name: badtype5.c
+ * check-description:
+ *	evaluate_dereference() used to miss a call to
+ *	examine_symbol_type(). This, in the present, left
+ *	a SYM_TYPEOF as type for the last dereferencing
+ *	which produced "error: cannot dereference this type".
+ *	The presence of the __force and the typeof is needed
+ *	to create the situation.
+ */
diff --git a/validation/linear/missing-insn-size.c b/validation/linear/missing-insn-size.c
new file mode 100644
index 000000000..fe588634c
--- /dev/null
+++ b/validation/linear/missing-insn-size.c
@@ -0,0 +1,19 @@
+int foo(int **a);
+int foo(int **a)
+{
+	return **a;
+}
+
+/*
+ * check-name: missing instruction's size
+ * check-description:
+ *	sparse used to have a problem with *all*
+ *	double dereferencing due to missing a
+ *	call to examine_symbol_type(). The symptom
+ *	here is that the inner deref had no type.
+ * check-command: test-linearize $file
+ * check-output-ignore
+ *
+ * check-output-excludes: load\\s
+ * check-output-contains: load\\.
+ */
-- 
2.13.0

