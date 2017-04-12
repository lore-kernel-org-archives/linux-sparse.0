From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/6] simplify intermediate casts in boolean expressions
Date: Wed, 12 Apr 2017 21:33:40 +0200
Message-ID: <20170412193344.95935-3-luc.vanoostenryck@gmail.com>
References: <20170412193344.95935-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36058 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755081AbdDLTdz (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 12 Apr 2017 15:33:55 -0400
Received: by mail-wm0-f67.google.com with SMTP id q125so8531379wmd.3
        for <linux-sparse@vger.kernel.org>; Wed, 12 Apr 2017 12:33:54 -0700 (PDT)
In-Reply-To: <20170412193344.95935-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

For example:
	int ibior(bool a) { return a || a; }

before simplification gives:
	<entry-point>
	setne.1   %r40 <- %arg1
	setne.1   %r42 <- %arg2
	or.1      %r43 <- %r40, %r42
        cast.32   %r44 <- (1) %r43
	ret.32    %r44

after simplification of the 'or', it used to give:
        setne.1     %r40 <- %arg1, $0
        cast.32     %r44 <- (1) %r40
        ret.32      %r44

and now give:
        setne.32    %r44 <- %arg1, $0
        ret.32      %r44

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                       | 17 +++++++++++++++++
 validation/optim/bool-simplify.c |  6 ++----
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/simplify.c b/simplify.c
index b46acd9c2..09d7ae056 100644
--- a/simplify.c
+++ b/simplify.c
@@ -982,6 +982,23 @@ static int simplify_cast(struct instruction *insn)
 			goto simplify;
 	}
 
+	if (insn->opcode == OP_CAST) {
+		struct instruction *def = src->def;
+		if (!def)
+			return 0;
+		switch (def->opcode) {
+		case OP_BINCMP ... OP_BINCMP_END:
+			insn->opcode = def->opcode;
+			use_pseudo(insn, def->src1, &insn->src1);
+			use_pseudo(insn, def->src2, &insn->src2);
+			remove_usage(src, &insn->src);
+			return REPEAT_CSE;
+
+		default:
+			break;
+		}
+	}
+
 	return 0;
 
 simplify:
diff --git a/validation/optim/bool-simplify.c b/validation/optim/bool-simplify.c
index 05be11497..2014d344c 100644
--- a/validation/optim/bool-simplify.c
+++ b/validation/optim/bool-simplify.c
@@ -32,16 +32,14 @@ and_0:
 and_1:
 .L2:
 	<entry-point>
-	setne.1     %r8 <- %arg1, $0
-	cast.32     %r11 <- (1) %r8
+	setne.32    %r11 <- %arg1, $0
 	ret.32      %r11
 
 
 or_0:
 .L4:
 	<entry-point>
-	setne.1     %r14 <- %arg1, $0
-	cast.32     %r17 <- (1) %r14
+	setne.32    %r17 <- %arg1, $0
 	ret.32      %r17
 
 
-- 
2.12.0

