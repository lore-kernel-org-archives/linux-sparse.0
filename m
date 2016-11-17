From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/8] fix killing OP_SETVAL instructions
Date: Thu, 17 Nov 2016 15:35:01 +0100
Message-ID: <20161117143507.3598-3-luc.vanoostenryck@gmail.com>
References: <20161117143507.3598-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35309 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752673AbcKQSqq (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 17 Nov 2016 13:46:46 -0500
Received: by mail-wm0-f67.google.com with SMTP id a20so24000826wme.2
        for <linux-sparse@vger.kernel.org>; Thu, 17 Nov 2016 10:46:46 -0800 (PST)
In-Reply-To: <20161117143507.3598-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Currently, kill_instruction() ignore OP_SETVAL instructions
with the result that some instructions are not optimized away
as expected.

For example, when looking at the output of test-linearize,
the following function:

	static int kill_setval(void)
	{
	l:
		return &&l && 0;
	}

gives the following output:

	kill_setval:
		set.64      %r6 <- .L1
		ret.32      $0

The 'set' instruction is obviously unneeded but nevertheless present.

With the patch, the output is the expected:

	kill_set:
		ret.32      $0

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                      | 1 +
 validation/kill-replaced-insn.c | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/simplify.c b/simplify.c
index 85da5bec..d07ca1b1 100644
--- a/simplify.c
+++ b/simplify.c
@@ -195,6 +195,7 @@ void kill_instruction(struct instruction *insn)
 		repeat_phase |= REPEAT_CSE;
 		return;
 
+	case OP_SETVAL:
 	case OP_NOT: case OP_NEG:
 		insn->bb = NULL;
 		kill_use(&insn->src1);
diff --git a/validation/kill-replaced-insn.c b/validation/kill-replaced-insn.c
index be031b6c..92021877 100644
--- a/validation/kill-replaced-insn.c
+++ b/validation/kill-replaced-insn.c
@@ -30,6 +30,12 @@ static int kill_select(int a)
 	return (a ? 1 : 0) && 0;
 }
 
+static int kill_setval(int a)
+{
+l:
+	return &&l && 0;
+}
+
 static int kill_load(int *a)
 {
 	return *a && 0;
@@ -51,4 +57,5 @@ static int kill_store(int *a)
  * check-output-excludes: ptrcast\\.
  * check-output-excludes: fpcast\\.
  * check-output-excludes: sel\\.
+ * check-output-excludes: set\\.
  */
-- 
2.10.2

