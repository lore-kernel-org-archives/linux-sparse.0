From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v5 39/51] llvm: fix mutating function pointer
Date: Sat, 25 Mar 2017 00:20:45 +0100
Message-ID: <20170324232057.15033-40-luc.vanoostenryck@gmail.com>
References: <20170324232057.15033-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33138 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936162AbdCXXYF (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 24 Mar 2017 19:24:05 -0400
Received: by mail-wr0-f196.google.com with SMTP id 20so612580wrx.0
        for <linux-sparse@vger.kernel.org>; Fri, 24 Mar 2017 16:24:04 -0700 (PDT)
In-Reply-To: <20170324232057.15033-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c                           |  5 ++++-
 validation/backend/function-ptr-xtype.c | 37 +++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 1 deletion(-)
 create mode 100644 validation/backend/function-ptr-xtype.c

diff --git a/sparse-llvm.c b/sparse-llvm.c
index ba70b0e6b..6fd33cbe9 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -829,7 +829,10 @@ static void output_op_call(struct function *fn, struct instruction *insn)
 		args[i++] = pseudo_to_rvalue(fn, arg, arg->src);
 	} END_FOR_EACH_PTR(arg);
 
-	func = pseudo_to_value(fn, NULL, insn->func);
+	if (insn->func->type == PSEUDO_REG || insn->func->type == PSEUDO_PHI)
+		func = get_operand(fn, insn->fntype, insn->func);
+	else
+		func = pseudo_to_value(fn, insn->fntype, insn->func);
 	pseudo_name(insn->target, name);
 	target = LLVMBuildCall(fn->builder, func, args, n_arg, name);
 
diff --git a/validation/backend/function-ptr-xtype.c b/validation/backend/function-ptr-xtype.c
new file mode 100644
index 000000000..9cdfab051
--- /dev/null
+++ b/validation/backend/function-ptr-xtype.c
@@ -0,0 +1,37 @@
+typedef int  (*binop_t)(int, int);
+typedef int  (*unop_t)(int);
+typedef int  (*idef_t)(void);
+typedef long (*ldef_t)(void);
+typedef void (*use_t)(int);
+
+// We want to 'fn' have several different types.
+// The goal is for the ->priv member to be used
+// with a type different from what it was first stored.
+
+int foo(void *fn, int arg1, int arg2);
+int foo(void *fn, int arg1, int arg2)
+{
+	int res = 0;
+
+	res += ((binop_t)fn)(arg1, arg2);
+	res += ((unop_t)fn)(arg1);
+	res += ((ldef_t)fn)();
+	res += ((idef_t)fn)();
+	((use_t)fn)(res);
+	return res;
+}
+
+int bar(int (*fn)(int), int arg1, int arg2);
+int bar(int (*fn)(int), int arg1, int arg2)
+{
+	int res = 0;
+
+	res += ((binop_t)fn)(arg1, arg2);
+	res += fn(arg1);
+	return res;
+}
+
+/*
+ * check-name: mutate function pointer's type
+ * check-command: ./sparsec -c $file -o tmp.o
+ */
-- 
2.12.0

