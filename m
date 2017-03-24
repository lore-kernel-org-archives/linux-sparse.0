From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v5 47/51] llvm: fix get value from non-anonymous symbol
Date: Sat, 25 Mar 2017 00:20:53 +0100
Message-ID: <20170324232057.15033-48-luc.vanoostenryck@gmail.com>
References: <20170324232057.15033-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33176 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936122AbdCXXYM (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 24 Mar 2017 19:24:12 -0400
Received: by mail-wr0-f193.google.com with SMTP id 20so612832wrx.0
        for <linux-sparse@vger.kernel.org>; Fri, 24 Mar 2017 16:24:11 -0700 (PDT)
In-Reply-To: <20170324232057.15033-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c                     |  9 +--------
 validation/backend/load-global.c  | 21 +++++++++++++++++++++
 validation/backend/string-value.c | 21 +++++++++++++++++++++
 3 files changed, 43 insertions(+), 8 deletions(-)
 create mode 100644 validation/backend/load-global.c
 create mode 100644 validation/backend/string-value.c

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 73ca96cce..93237b3d0 100644
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

