From: Pekka Enberg <penberg@kernel.org>
Subject: [PATCH] sparse, llvm: Add support for union types
Date: Sun, 30 Oct 2011 09:26:05 +0200
Message-ID: <1319959565-3009-1-git-send-email-penberg@kernel.org>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:59014 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751383Ab1J3H0P (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 30 Oct 2011 03:26:15 -0400
Received: by bkbzt4 with SMTP id zt4so1385013bkb.19
        for <linux-sparse@vger.kernel.org>; Sun, 30 Oct 2011 00:26:14 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Pekka Enberg <penberg@kernel.org>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>

This patch adds support for SYM_UNION in symbol_type(). The LLVM API does not
provide support for unions so we treat them as opaque structs.

Cc: Christopher Li <sparse@chrisli.org>
Cc: Jeff Garzik <jgarzik@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Pekka Enberg <penberg@kernel.org>
---
 sparse-llvm.c              |   20 ++++++++++++++++++++
 validation/backend/union.c |   12 ++++++++++++
 2 files changed, 32 insertions(+), 0 deletions(-)
 create mode 100644 validation/backend/union.c

diff --git a/sparse-llvm.c b/sparse-llvm.c
index a678d9c..7f46c8a 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -80,6 +80,23 @@ static LLVMTypeRef sym_struct_type(LLVMModuleRef module, struct symbol *sym)
 	return ret;
 }
 
+static LLVMTypeRef sym_union_type(LLVMModuleRef module, struct symbol *sym)
+{
+	LLVMTypeRef elements;
+	unsigned union_size;
+
+	/*
+	 * There's no union support in the LLVM API so we treat unions as
+	 * opaque structs. The downside is that we lose type information on the
+	 * members but as LLVM doesn't care, neither do we.
+	 */
+	union_size = sym->bit_size / 8;
+
+	elements = LLVMArrayType(LLVMInt8Type(), union_size);
+
+	return LLVMStructType(&elements, 1, 0 /* packed? */);
+}
+
 static LLVMTypeRef sym_ptr_type(LLVMModuleRef module, struct symbol *sym)
 {
 	LLVMTypeRef type = symbol_type(module, sym->ctype.base_type);
@@ -146,6 +163,9 @@ static LLVMTypeRef symbol_type(LLVMModuleRef module, struct symbol *sym)
 	case SYM_PTR:
 		ret = sym_ptr_type(module, sym);
 		break;
+	case SYM_UNION:
+		ret = sym_union_type(module, sym);
+		break;
 	case SYM_STRUCT:
 		ret = sym_struct_type(module, sym);
 		break;
diff --git a/validation/backend/union.c b/validation/backend/union.c
new file mode 100644
index 0000000..e155f6a
--- /dev/null
+++ b/validation/backend/union.c
@@ -0,0 +1,12 @@
+union foo {
+	unsigned long		x;
+	unsigned char		y;
+	char			buf[128];
+};
+
+static union foo foo;
+
+/*
+ * check-name: Union code generation
+ * check-command: ./sparsec -c $file -o tmp.o
+ */
-- 
1.7.6.4

