From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v6 24/52] llvm: fix type in comparison with an address constant
Date: Mon, 27 Mar 2017 23:23:48 +0200
Message-ID: <20170327212416.18536-25-luc.vanoostenryck@gmail.com>
References: <20170327212416.18536-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34800 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751739AbdC0V0z (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Mar 2017 17:26:55 -0400
Received: by mail-wr0-f195.google.com with SMTP id w43so14204016wrb.1
        for <linux-sparse@vger.kernel.org>; Mon, 27 Mar 2017 14:26:48 -0700 (PDT)
In-Reply-To: <20170327212416.18536-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Since sparse's constant are typeless comparing a pointer with
an address constant lack correct type information.

Fix this by casting the constant to the same type as the LHS.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c                          |  3 +--
 validation/backend/compare-with-null.c | 12 ++++++++++++
 2 files changed, 13 insertions(+), 2 deletions(-)
 create mode 100644 validation/backend/compare-with-null.c

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 86c57ab33..f81a8c657 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -586,9 +586,8 @@ static void output_op_compare(struct function *fn, struct instruction *insn)
 	char target_name[64];
 
 	lhs = pseudo_to_value(fn, insn, insn->src1);
-
 	if (insn->src2->type == PSEUDO_VAL)
-		rhs = LLVMConstInt(LLVMTypeOf(lhs), insn->src2->value, 1);
+		rhs = constant_value(insn->src2->value, LLVMTypeOf(lhs));
 	else
 		rhs = pseudo_to_value(fn, insn, insn->src2);
 
diff --git a/validation/backend/compare-with-null.c b/validation/backend/compare-with-null.c
new file mode 100644
index 000000000..e23562bc5
--- /dev/null
+++ b/validation/backend/compare-with-null.c
@@ -0,0 +1,12 @@
+int  tstv(void *p) { return !p; }
+int  cmpv(void *p) { return p == ((void*)0); }
+
+int  tsti(int  *p) { return !p; }
+int  cmpi(int  *p) { return p == ((int *)0); }
+int  cmpx(int  *p) { return p == ((void*)0); }
+
+/*
+ * check-name: compare-with-null
+ * check-command: sparsec -Wno-decl -c $file -o tmp.o
+ * check-output-ignore
+ */
-- 
2.12.0

