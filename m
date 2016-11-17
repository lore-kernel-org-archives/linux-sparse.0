From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 4/8] fix killing OP_CAST & friends
Date: Thu, 17 Nov 2016 15:35:03 +0100
Message-ID: <20161117143507.3598-5-luc.vanoostenryck@gmail.com>
References: <20161117143507.3598-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33952 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933790AbcKQREF (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 17 Nov 2016 12:04:05 -0500
Received: by mail-wm0-f66.google.com with SMTP id g23so23185505wme.1
        for <linux-sparse@vger.kernel.org>; Thu, 17 Nov 2016 09:04:04 -0800 (PST)
In-Reply-To: <20161117143507.3598-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Currently  kill_instruction() doesn't do anything with the
operands of casts instructions. But when theses instructions
are removed the operands 'usage' must be adjusted and this is
not done and as result the instructions producing the operands
of these casts are not optimized away as expected.

This patch fixes that by killing these casts the same way as others
unary instructions (OP_NOT & OP_NEG).

To illustrate the situation, the output of test-linearize
on the following code:
	extern void __abort(void);
	struct s {
		int elem:3;
	};
	void foo(struct s *x);
	void foo(struct s *x)
	{
		if (x->elem == 0) {
			if (x->elem != 0 && x->elem != 1)
				__abort();
		}
	}

gives this output without the patch:
	foo:
		load.32     %r2 <- 0[%arg1]
		cast.32     %r3 <- (3) %r2
		br          .L1
	.L1:
		ret

Since x->elem can't be at the same time == 0 & != 0, the inner if is never
true and the whole code should have been optimized away.
The 'cast' instruction is obviously not needed but nevertheless present.

With the patch, the output is much closer to what's expected:
	foo:
		load.32     %r2 <- 0[%arg1]
		br          .L1
	.L1:
		ret

Note 1) The 'load' instruction is also dead but it's a separate problem.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c              |  4 ++++
 validation/kill-casts.c | 22 ++++++++++++++++++++++
 2 files changed, 26 insertions(+)
 create mode 100644 validation/kill-casts.c

diff --git a/simplify.c b/simplify.c
index 421b28f2..939ba6af 100644
--- a/simplify.c
+++ b/simplify.c
@@ -195,6 +195,10 @@ void kill_instruction(struct instruction *insn)
 		repeat_phase |= REPEAT_CSE;
 		return;
 
+	case OP_CAST:
+	case OP_SCAST:
+	case OP_FPCAST:
+	case OP_PTRCAST:
 	case OP_SETVAL:
 	case OP_NOT: case OP_NEG:
 		insn->bb = NULL;
diff --git a/validation/kill-casts.c b/validation/kill-casts.c
new file mode 100644
index 00000000..cf52f246
--- /dev/null
+++ b/validation/kill-casts.c
@@ -0,0 +1,22 @@
+extern void __abort(void);
+
+struct s {
+	int elem:3;
+};
+
+void foo(struct s *x);
+void foo(struct s *x)
+{
+	if (x->elem == 0) {
+		if (x->elem != 0 && x->elem != 1)
+			__abort();
+	}
+}
+
+/*
+ * check-name: kill-casts
+ * check-command: test-linearize $file
+ *
+ * check-output-ignore
+ * check-output-excludes: cast\\.
+ */
-- 
2.10.2

