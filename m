From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] fix killing OP_SETVAL instructions
Date: Wed,  8 Feb 2017 22:07:52 +0100
Message-ID: <20170208210752.16227-1-luc.vanoostenryck@gmail.com>
References: <CANeU7Qkc1qShbgresJbRZbORuzzcMR28vPvv38kwFxHiE15ZLQ@mail.gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:33175 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751011AbdBHVIB (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 8 Feb 2017 16:08:01 -0500
Received: by mail-wm0-f50.google.com with SMTP id t18so53277067wmt.0
        for <linux-sparse@vger.kernel.org>; Wed, 08 Feb 2017 13:08:01 -0800 (PST)
In-Reply-To: <CANeU7Qkc1qShbgresJbRZbORuzzcMR28vPvv38kwFxHiE15ZLQ@mail.gmail.com>
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
index cbb1844e2..a7e74ae0e 100644
--- a/simplify.c
+++ b/simplify.c
@@ -201,6 +201,7 @@ void kill_instruction(struct instruction *insn)
 	case OP_SCAST:
 	case OP_FPCAST:
 	case OP_PTRCAST:
+	case OP_SETVAL:
 	case OP_NOT: case OP_NEG:
 		kill_use(&insn->src1);
 		break;
diff --git a/validation/kill-replaced-insn.c b/validation/kill-replaced-insn.c
index be031b6c1..920218778 100644
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
2.11.0

