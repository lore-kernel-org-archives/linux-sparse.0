From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/3] simplify casts bool -> int -> bool
Date: Wed, 12 Apr 2017 16:18:02 +0200
Message-ID: <20170412141802.81231-4-luc.vanoostenryck@gmail.com>
References: <20170412141802.81231-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35149 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752940AbdDLOUO (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 12 Apr 2017 10:20:14 -0400
Received: by mail-wr0-f194.google.com with SMTP id l44so4423334wrc.2
        for <linux-sparse@vger.kernel.org>; Wed, 12 Apr 2017 07:20:13 -0700 (PDT)
In-Reply-To: <20170412141802.81231-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Because of C's integer promotion, in code like 'a == 0',
the operand 'a' must be promoted to int, which result in
following linearization if the type of 'a' was _Bool:
	cast.32  %t <- (1) %a
	setne.32 %r <- %t, $0
While required by the standard, this promotion is unneeded
in the given situation.

Change this by simplifying away such casts.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                       | 18 +++++++++++++++++-
 validation/optim/bool-int-bool.c | 12 ++++++++++++
 2 files changed, 29 insertions(+), 1 deletion(-)
 create mode 100644 validation/optim/bool-int-bool.c

diff --git a/simplify.c b/simplify.c
index 775c1e2dd..96448a666 100644
--- a/simplify.c
+++ b/simplify.c
@@ -445,9 +445,25 @@ static int simplify_seteq_setne(struct instruction *insn, long long value)
 		remove_usage(old, &insn->src1);
 		return REPEAT_CSE;
 
+	case OP_CAST:
+		if (def->orig_type->bit_size != 1)
+			break;
+
+		// Convert:
+		//	cast.n	%t <- (1) %a
+		//	setne.m %r <- %t, $0
+		// into:
+		//	...
+		//	setne.m %r <- %a, $0
+		// and similar for setne/eq ... 0/1
+		use_pseudo(insn, def->src1, &insn->src1);
+		remove_usage(old, &insn->src1);
+		return REPEAT_CSE;
+
 	default:
-		return 0;
+		break;
 	}
+	return 0;
 }
 
 static int simplify_constant_rightside(struct instruction *insn)
diff --git a/validation/optim/bool-int-bool.c b/validation/optim/bool-int-bool.c
new file mode 100644
index 000000000..de34a68bb
--- /dev/null
+++ b/validation/optim/bool-int-bool.c
@@ -0,0 +1,12 @@
+_Bool beq0(_Bool a) { return (a == 0); }
+_Bool beq1(_Bool a) { return (a == 1); }
+_Bool bne0(_Bool a) { return (a != 0); }
+_Bool bne1(_Bool a) { return (a != 1); }
+
+/*
+ * check-name: bool - int - bool constants
+ * check-command: test-linearize -Wno-decl $file
+ *
+ * check-output-ignore
+ * check-output-excludes: cast\\.
+ */
-- 
2.12.0

