From: Christopher Li <sparse@chrisli.org>
Subject: [PATCH] temporary revert commit 11b1a83b d7985338 cause deadloop
Date: Wed, 19 Jul 2017 07:43:24 -0400
Message-ID: <CANeU7Q=DKhxVrVab8VwQczFuJ4UK7ucu08JBXseQtjYH729ZsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36438 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753465AbdGSLn0 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 19 Jul 2017 07:43:26 -0400
Received: by mail-pg0-f65.google.com with SMTP id y129so6606550pgy.3
        for <linux-sparse@vger.kernel.org>; Wed, 19 Jul 2017 04:43:25 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Michael Stefaniuc <mstefani@mykolab.com>

Michael Stefaniuc report that sparse deadloop on one of the
wine source file. The minimal test case to reproduced the
deadloop has been add to validation as "kill-unreachable-phi.c".

The change that introduce the deadloop can be trace back to
11b1a83b "fix OP_PHI usage in try_to_simplify_bb()" and later
d7985338 "fix OP_PHI usage in try_to_simplify_bb() only when non-bogus"

Temporary revert the change to avoid the deadloop.

The revert cause one of the test case fail because some phi
related optimization was not done. I set that test case to
known to fail.

Reported-by: Michael Stefaniuc <mstefani@mykolab.com>
Signed-off-by: Christopher Li <sparse@chrisli.org>
---
 flow.c                            | 16 +++++++---------
 validation/kill-phi-ttsbb.c       |  1 +
 validation/kill-unreachable-phi.c | 27 +++++++++++++++++++++++++++
 3 files changed, 35 insertions(+), 9 deletions(-)
 create mode 100644 validation/kill-unreachable-phi.c

diff --git a/flow.c b/flow.c
index bfe54f7..4ff6745 100644
--- a/flow.c
+++ b/flow.c
@@ -119,14 +119,6 @@ static int try_to_simplify_bb(struct basic_block
*bb, struct instruction *first,
 {
  int changed = 0;
  pseudo_t phi;
- int bogus;
-
- /*
- * This a due to improper dominance tracking during
- * simplify_symbol_usage()/conversion to SSA form.
- * No sane simplification can be done when we have this.
- */
- bogus = bb_list_size(bb->parents) != pseudo_list_size(first->phi_list);

  FOR_EACH_PTR(first->phi_list, phi) {
  struct instruction *def = phi->def;
@@ -156,8 +148,14 @@ static int try_to_simplify_bb(struct basic_block
*bb, struct instruction *first,
  continue;
  changed |= rewrite_branch(source, &br->bb_true, bb, target);
  changed |= rewrite_branch(source, &br->bb_false, bb, target);
- if (changed && !bogus)
+ /*
+ * FIXME: change 11b1a83 cause deadloop on wine compile,
+ * disable for now.
+ */
+#if 0
+ if (changed)
  kill_use(THIS_ADDRESS(phi));
+#endif
  } END_FOR_EACH_PTR(phi);
  return changed;
 }
diff --git a/validation/kill-phi-ttsbb.c b/validation/kill-phi-ttsbb.c
index 178a65d..b05c4c2 100644
--- a/validation/kill-phi-ttsbb.c
+++ b/validation/kill-phi-ttsbb.c
@@ -22,6 +22,7 @@ static int foo(int a, int b)
  * Verify if OP_PHI usage is adjusted after successful try_to_simplify_bb()
  * check-command: test-linearize $file
  * check-output-ignore
+ * check-known-to-fail
  *
  * check-output-excludes: phi\\.
  * check-output-excludes: phisrc\\.
diff --git a/validation/kill-unreachable-phi.c
b/validation/kill-unreachable-phi.c
new file mode 100644
index 0000000..4c7e249
--- /dev/null
+++ b/validation/kill-unreachable-phi.c
@@ -0,0 +1,27 @@
+extern char *strcpy (char *__dest, const char *__src);
+
+static void test_menu_iteminfo( void )
+{
+ int ansi = 1;
+ void *init, *string;
+ char initA[]="XYZ";
+ char stringA[0x80];
+ do {
+ if(ansi) {
+ string=stringA;
+ init = initA;
+ }
+ if(ansi)
+ strcpy( string, init );
+ } while( !(ansi = !ansi) );
+}
+/*
+ * check-name: kill-unreachable-phi
+ * check-description:
+ * In wine source tests/menu.c
+ * Improper killing a phi instruction inside not reachable BB cause
+ * dead loop on sparse.
+ *
+ * check-output-ignore
+ *
+ */
-- 
2.13.3
