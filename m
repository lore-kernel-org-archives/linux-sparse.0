From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/4] volatile loads must not be simplified
Date: Wed,  4 Jan 2017 04:03:18 +0100
Message-ID: <20170104030321.28019-2-luc.vanoostenryck@gmail.com>
References: <20170104030321.28019-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wj0-f194.google.com ([209.85.210.194]:33704 "EHLO
        mail-wj0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752779AbdADDEM (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 3 Jan 2017 22:04:12 -0500
Received: by mail-wj0-f194.google.com with SMTP id kp2so73908462wjc.0
        for <linux-sparse@vger.kernel.org>; Tue, 03 Jan 2017 19:03:35 -0800 (PST)
In-Reply-To: <20170104030321.28019-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

memops.c:simplify_loads() tries to simplify all loads,
even volatile ones.
For example, on the following code:
	static int foo(volatile int *a, int v)
	{
		*a = v;
		return *a;
	}

test-linearize returns something like:
	foo:
		store.32    %arg2 -> 0[%arg1]
		ret.32      %arg2

while the correct output is more like:
	foo:
		store.32    %arg2 -> 0[%arg1]
		load.32     %r5 <- 0[%arg1]
		ret.32      %r5

The fix is to simply ignore loads with the 'volatile' modifier.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 memops.c                     |  3 +++
 validation/memops-volatile.c | 21 +++++++++++++++++++++
 2 files changed, 24 insertions(+)
 create mode 100644 validation/memops-volatile.c

diff --git a/memops.c b/memops.c
index 45bd3401..6dac1f57 100644
--- a/memops.c
+++ b/memops.c
@@ -99,6 +99,9 @@ static void simplify_loads(struct basic_block *bb)
 			/* Check for illegal offsets.. */
 			check_access(insn);
 
+			if (insn->type->ctype.modifiers & MOD_VOLATILE)
+				continue;
+
 			RECURSE_PTR_REVERSE(insn, dom) {
 				int dominance;
 				if (!dom->bb)
diff --git a/validation/memops-volatile.c b/validation/memops-volatile.c
new file mode 100644
index 00000000..0f3e12ad
--- /dev/null
+++ b/validation/memops-volatile.c
@@ -0,0 +1,21 @@
+static int foo(volatile int *a, int v)
+{
+	*a = v;
+	return *a;
+}
+
+/*
+ * check-name: memops-volatile
+ * check-command: test-linearize $file
+ *
+ * check-output-start
+foo:
+.L0:
+	<entry-point>
+	store.32    %arg2 -> 0[%arg1]
+	load.32     %r5 <- 0[%arg1]
+	ret.32      %r5
+
+
+ * check-output-end
+ */
-- 
2.11.0

