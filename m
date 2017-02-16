From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] simplify float-to-float casts that doesn't change size
Date: Thu, 16 Feb 2017 03:58:31 +0100
Message-ID: <20170216025831.25449-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36457 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752797AbdBPC6j (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 15 Feb 2017 21:58:39 -0500
Received: by mail-wr0-f196.google.com with SMTP id k90so444519wrc.3
        for <linux-sparse@vger.kernel.org>; Wed, 15 Feb 2017 18:58:38 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
 simplify.c                    |  2 ++
 validation/optim/fpcast-nop.c | 15 +++++++++++++++
 2 files changed, 17 insertions(+)
 create mode 100644 validation/optim/fpcast-nop.c

diff --git a/simplify.c b/simplify.c
index 2a1f0b200..3085c39f4 100644
--- a/simplify.c
+++ b/simplify.c
@@ -895,6 +895,8 @@ static int simplify_cast(struct instruction *insn)
 		int op = (orig_type->ctype.modifiers & MOD_SIGNED) ? OP_SCAST : OP_CAST;
 		if (insn->opcode == op)
 			goto simplify;
+		if (insn->opcode == OP_FPCAST && is_float_type(orig_type))
+			goto simplify;
 	}
 
 	return 0;
diff --git a/validation/optim/fpcast-nop.c b/validation/optim/fpcast-nop.c
new file mode 100644
index 000000000..c2e7ba87f
--- /dev/null
+++ b/validation/optim/fpcast-nop.c
@@ -0,0 +1,15 @@
+static  float foof( float a) { return ( float) a; }
+static double food(double a) { return (double) a; }
+static long double fool(long double a) { return (long double) a; }
+
+/*
+ * check-name: fpcast-nop
+ * check-description:
+ *	Verify that unneeded casts between same-type
+ *	floats are also optimized away.
+ *
+ * check-command: test-linearize $file
+ * check-output-ignore
+ *
+ * check-output-excludes: fpcast\\.
+ */
-- 
2.11.0

