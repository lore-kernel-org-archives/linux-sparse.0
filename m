From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 14/27] keep OP_SYMADDR instructions
Date: Sat, 11 Mar 2017 10:06:53 +0100
Message-ID: <20170311090706.17171-15-luc.vanoostenryck@gmail.com>
References: <20170311090706.17171-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36037 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755383AbdCKJHh (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Mar 2017 04:07:37 -0500
Received: by mail-wm0-f68.google.com with SMTP id v190so2299531wme.3
        for <linux-sparse@vger.kernel.org>; Sat, 11 Mar 2017 01:07:35 -0800 (PST)
In-Reply-To: <20170311090706.17171-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Pekka Enberg <penberg@kernel.org>, Jeff Garzik <jeff@garzik.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

OP_SYMADDR instructions are systematically eliminated during
simplification phase, their target address being simply replaced
by the symbol itself.

While it's not wrong per se (as it all depends to the semantic
we want to give to pseudos and the instructions and how high-
or low-level we want the IR to be), it's not clear if this
simplification was really intentional and don't seems to have
any advantages.

OP_SYMADDRs allow to make a clear separation between a symbol
(a name with a type and info for storage & linkage) and its address
(which can be stored in memory or in a register and on which
arithmetic operations can then be done on it). Once these addresses
are replaced by the symbol itself, those symbols can appears almost
everywhere in the linearized code:
- in calls' arguments,
- in adds and subs (while doing pointer arithmetic),
- in casts,
- in load & stores,
- ...
and they complicate things considerably once you begin to be
interested concretly in things after linearization & simplification
since soon or later you will need the address anyway.

Change this by removing the 'simplification' of OP_SYMADDR.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c           |  2 +-
 validation/symaddr.c | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 1 deletion(-)
 create mode 100644 validation/symaddr.c

diff --git a/simplify.c b/simplify.c
index 5d00937f1..a84e4787f 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1159,7 +1159,7 @@ int simplify_instruction(struct instruction *insn)
 	case OP_SYMADDR:
 		if (dead_insn(insn, NULL, NULL, NULL))
 			return REPEAT_CSE | REPEAT_SYMBOL_CLEANUP;
-		return replace_with_pseudo(insn, insn->symbol);
+		return 0;
 	case OP_CAST:
 	case OP_SCAST:
 	case OP_FPCAST:
diff --git a/validation/symaddr.c b/validation/symaddr.c
new file mode 100644
index 000000000..4fe776c21
--- /dev/null
+++ b/validation/symaddr.c
@@ -0,0 +1,35 @@
+int g;
+int a[3];
+int b[3];
+
+void usep(int*);
+
+int foo(void)
+{
+	int r = 0;
+	usep(&g);
+	usep(a);
+	usep(b + 1);
+	return r;
+}
+
+/*
+ * check-name: symaddr
+ * check-command: test-linearize -Wno-decl $file
+ *
+ * check-output-start
+foo:
+.L0:
+	<entry-point>
+	symaddr.64  %r1 <- g
+	call        usep, %r1
+	symaddr.64  %r2 <- a
+	call        usep, %r2
+	symaddr.64  %r3 <- b
+	add.64      %r4 <- %r3, $4
+	call        usep, %r4
+	ret.32      $0
+
+
+ * check-output-end
+ */
-- 
2.11.1

