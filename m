From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 7/8] transform (A << S) >> S into A & (-1 >> S)
Date: Mon,  7 Aug 2017 21:12:04 +0200
Message-ID: <20170807191205.86590-8-luc.vanoostenryck@gmail.com>
References: <CACXZuxd30jwczag_GHW3cmqPcBybEi7jfwfku81vW2nHzo_kyA@mail.gmail.com>
 <20170807191205.86590-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38359 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751927AbdHGTMT (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 7 Aug 2017 15:12:19 -0400
Received: by mail-wm0-f66.google.com with SMTP id y206so2036310wmd.5
        for <linux-sparse@vger.kernel.org>; Mon, 07 Aug 2017 12:12:18 -0700 (PDT)
In-Reply-To: <20170807191205.86590-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: linux-sparse@vger.kernel.org, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This is especially usefull when simplifying code
accessing bitfields.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/simplify.c b/simplify.c
index f1a898700..cdc244c17 100644
--- a/simplify.c
+++ b/simplify.c
@@ -416,6 +416,7 @@ static int simplify_lsr(struct instruction *insn, pseudo_t pseudo, long long val
 {
 	struct instruction *def;
 	unsigned long long mask;
+	pseudo_t old;
 
 	if (!value)
 		return replace_with_pseudo(insn, pseudo);
@@ -434,6 +435,20 @@ static int simplify_lsr(struct instruction *insn, pseudo_t pseudo, long long val
 		insn->opcode = OP_AND;
 		insn->src2 = value_pseudo(mask >> value);
 		return REPEAT_CSE;
+	case OP_SHL:
+		// replace (A << S) >> S
+		// by      A & (-1 >> S)
+		def = insn->src1->def;
+		if (!constant(def->src2))
+			break;
+		if (def->src2->value != value)
+			break;
+		insn->opcode = OP_AND;
+		insn->src2 = value_pseudo(-1ULL >> value);
+		old = insn->src1;
+		use_pseudo(insn, def->src1, &insn->src1);
+		remove_usage(old, &insn->src1);
+		return REPEAT_CSE;
 	}
 	return 0;
 }
-- 
2.13.2

