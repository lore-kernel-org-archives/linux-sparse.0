From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/6] avoid useless compare with zero
Date: Wed, 12 Apr 2017 21:33:41 +0200
Message-ID: <20170412193344.95935-4-luc.vanoostenryck@gmail.com>
References: <20170412193344.95935-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35157 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755100AbdDLTd4 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 12 Apr 2017 15:33:56 -0400
Received: by mail-wm0-f67.google.com with SMTP id d79so8562697wmi.2
        for <linux-sparse@vger.kernel.org>; Wed, 12 Apr 2017 12:33:55 -0700 (PDT)
In-Reply-To: <20170412193344.95935-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The boolean operators '||' and '&&' need to have their operands
first compared against zero. However, this is not needed if the
operands is already a boolean, for example because it's already
the result of another previous such operation.

For example, the following expression:
	int a, b, c;
	... a || b || c ...
is linearized and simplified to:
        setne.1     %r2 <- %arg1, $0
        setne.1     %r4 <- %arg2, $0
        or-bool.1   %r5 <- %r2, %r4
        setne.1     %r7 <- %r5, $0
        setne.1     %r9 <- %arg3, $0
        or-bool.1   %r10 <- %r7, %r9
but the 3rd 'setne' is useless since %r5 is already a boolean value.
It can thus be further simplified to:
        setne.1     %r2 <- %arg1, $0
        setne.1     %r4 <- %arg2, $0
        or-bool.1   %r5 <- %r2, %r4
        setne.1     %r9 <- %arg3, $0
        or-bool.1   %r10 <- %r5, %r9

Change this by removing such comparisons if the operand is
already a boolean (its size is 1).

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                         |  3 ++-
 validation/optim/bool-context-fp.c |  6 ++----
 validation/optim/bool-simplify2.c  | 11 +++++++++++
 3 files changed, 15 insertions(+), 5 deletions(-)
 create mode 100644 validation/optim/bool-simplify2.c

diff --git a/simplify.c b/simplify.c
index 09d7ae056..30bbc9b99 100644
--- a/simplify.c
+++ b/simplify.c
@@ -462,7 +462,8 @@ static int simplify_seteq_setne(struct instruction *insn, long long value)
 		return REPEAT_CSE;
 
 	default:
-		break;
+		if (!inverse && def->size == 1)
+			return replace_with_pseudo(insn, old);
 	}
 	return 0;
 }
diff --git a/validation/optim/bool-context-fp.c b/validation/optim/bool-context-fp.c
index 6b3e8d181..2f15fe94d 100644
--- a/validation/optim/bool-context-fp.c
+++ b/validation/optim/bool-context-fp.c
@@ -54,8 +54,7 @@ bfior:
 	fcmpune.1   %r20 <- %arg1, %r19
 	fcmpune.1   %r23 <- %arg2, %r19
 	or-bool.1   %r24 <- %r23, %r20
-	setne.1     %r26 <- %r24, $0
-	ret.1       %r26
+	ret.1       %r24
 
 
 ifior:
@@ -76,8 +75,7 @@ bfand:
 	fcmpune.1   %r39 <- %arg1, %r38
 	fcmpune.1   %r42 <- %arg2, %r38
 	and-bool.1  %r43 <- %r42, %r39
-	setne.1     %r45 <- %r43, $0
-	ret.1       %r45
+	ret.1       %r43
 
 
 ifand:
diff --git a/validation/optim/bool-simplify2.c b/validation/optim/bool-simplify2.c
new file mode 100644
index 000000000..caa5af053
--- /dev/null
+++ b/validation/optim/bool-simplify2.c
@@ -0,0 +1,11 @@
+static int foo(int a, int b, int c)
+{
+	return a || b || c;
+}
+
+/*
+ * check-name: bool-simplify2
+ * check-command: test-linearize $file
+ * check-output-ignore
+ * check-output-pattern-3-times: setne\\.
+ */
-- 
2.12.0

