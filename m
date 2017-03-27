From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v6 47/52] llvm: fix get value from non-anonymous symbol
Date: Mon, 27 Mar 2017 23:24:11 +0200
Message-ID: <20170327212416.18536-48-luc.vanoostenryck@gmail.com>
References: <20170327212416.18536-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35933 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751810AbdC0V1M (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Mar 2017 17:27:12 -0400
Received: by mail-wr0-f196.google.com with SMTP id u1so17119448wra.3
        for <linux-sparse@vger.kernel.org>; Mon, 27 Mar 2017 14:27:10 -0700 (PDT)
In-Reply-To: <20170327212416.18536-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c                     | 11 ++---------
 validation/backend/load-global.c  | 21 +++++++++++++++++++++
 validation/backend/string-value.c | 21 +++++++++++++++++++++
 3 files changed, 44 insertions(+), 9 deletions(-)
 create mode 100644 validation/backend/load-global.c
 create mode 100644 validation/backend/string-value.c

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 65b859f4b..c1aefc682 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -303,7 +303,7 @@ static LLVMValueRef get_sym_value(struct function *fn, struct symbol *sym)
 	assert(sym->bb_target == NULL);
 
 	expr = sym->initializer;
-	if (expr) {
+	if (expr && !sym->ident) {
 		switch (expr->type) {
 		case EXPR_STRING: {
 			const char *s = expr->string->data;
@@ -318,13 +318,6 @@ static LLVMValueRef get_sym_value(struct function *fn, struct symbol *sym)
 			result = LLVMConstGEP(data, indices, ARRAY_SIZE(indices));
 			return result;
 		}
-		case EXPR_SYMBOL: {
-			struct symbol *sym = expr->symbol;
-
-			result = LLVMGetNamedGlobal(fn->module, show_ident(sym->ident));
-			assert(result != NULL);
-			break;
-		}
 		default:
 			break;
 		}
@@ -1212,7 +1205,7 @@ static LLVMValueRef output_data(LLVMModuleRef module, struct symbol *sym)
 		initial_value = LLVMConstNull(type);
 	}
 
-	name = show_ident(sym->ident);
+	name = sym->ident ? show_ident(sym->ident) : "" ;
 
 	data = LLVMAddGlobal(module, LLVMTypeOf(initial_value), name);
 
diff --git a/validation/backend/load-global.c b/validation/backend/load-global.c
new file mode 100644
index 000000000..dedb35f3b
--- /dev/null
+++ b/validation/backend/load-global.c
@@ -0,0 +1,21 @@
+const char *s = "abc";
+int x = 4;
+int y;
+
+int *p = &x;
+int *q;
+
+int loadn(void) { return y; }
+int loadi(void) { return x; }
+
+const char *loads(void) { return s; }
+
+int *retpn(void) { return  q; }
+int loadpn(void) { return *q; }
+int *retpi(void) { return  p; }
+int loadpi(void) { return *p; }
+
+/*
+ * check-name: use simple value from global vars
+ * check-command: ./sparsec -Wno-decl -c $file -o tmp.o
+ */
diff --git a/validation/backend/string-value.c b/validation/backend/string-value.c
new file mode 100644
index 000000000..8cdec4a2d
--- /dev/null
+++ b/validation/backend/string-value.c
@@ -0,0 +1,21 @@
+extern void use(const char *);
+
+const char *ret(void)
+{
+	return "abc";
+}
+
+const char *add(void)
+{
+	return "def" + 1;
+}
+
+void call(void)
+{
+	use("ijk");
+}
+
+/*
+ * check-name: string-value
+ * check-command: ./sparsec -Wno-decl -c $file -o tmp.o
+ */
-- 
2.12.0

