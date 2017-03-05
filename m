From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 02/13] llvm: fix translation of PSEUDO_VALs into a ValueRefs
Date: Sun,  5 Mar 2017 12:20:36 +0100
Message-ID: <20170305112047.3411-3-luc.vanoostenryck@gmail.com>
References: <20170305112047.3411-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36308 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751539AbdCEL2y (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Mar 2017 06:28:54 -0500
Received: by mail-wm0-f67.google.com with SMTP id v190so9488800wme.3
        for <linux-sparse@vger.kernel.org>; Sun, 05 Mar 2017 03:28:53 -0800 (PST)
In-Reply-To: <20170305112047.3411-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

In sparse-llvm there is the assumption that a PSEUDO_VAL is always
of integer type. But this is not always the case: constant pointers,
like NULL, are also of the PSEUDO_VAL kind.

Fix this by using the newly created helper val_to_value() and using the
instruction's type where this pseudo is used as the type of the value.

Note: while this patch improve the situation, like for example for the
test cases added here, it's still not correct because now we're making
the assumption that 'insn->type' is the type we need for the pseudo.
This is often true, but certainly not always.
For example this is not true for:
- OP_STORE/OP_LOAD's insn->src
- OP_SET{EQ,...}'s   insn->src[12]
- probably some  others ones
- in general, obviously, for any instructions where the target has
  a different type than the operands.

Reported-by: Dibyendu Majumdar <mobile@majumdar.org.uk>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c             |  2 +-
 validation/backend/null.c | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)
 create mode 100644 validation/backend/null.c

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 41ee1fa1f..d48b3b20a 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -384,7 +384,7 @@ static LLVMValueRef pseudo_to_value(struct function *fn, struct instruction *ins
 		break;
 	}
 	case PSEUDO_VAL:
-		result = LLVMConstInt(insn_symbol_type(fn->module, insn), pseudo->value, 1);
+		result = val_to_value(fn, pseudo->value, insn->type);
 		break;
 	case PSEUDO_ARG: {
 		result = LLVMGetParam(fn->fn, pseudo->nr - 1);
diff --git a/validation/backend/null.c b/validation/backend/null.c
new file mode 100644
index 000000000..5c595c70b
--- /dev/null
+++ b/validation/backend/null.c
@@ -0,0 +1,24 @@
+extern int *ip[];
+
+void foo(void);
+void foo(void)
+{
+	ip[0] = (void *)0L;
+	ip[1] = (int *)0L;
+	ip[2] = (void *)0;
+	ip[3] = (int *)0;
+	ip[4] = (void *)(long)0;
+	ip[5] = (int *)(long)0;
+	ip[6] = (void *)123;
+	ip[7] = (int *)123;
+	ip[8] = (void *)123L;
+	ip[9] = (int *)123L;
+	ip[10] = (void *)(long)123;
+	ip[11] = (int *)(long)123;
+}
+
+/*
+ * check-name: store constants to pointer
+ * check-command: sparse-llvm $file
+ * check-output-ignore
+ */
-- 
2.11.1

