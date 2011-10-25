From: Pekka Enberg <penberg@kernel.org>
Subject: [PATCH] sparse, llvm: Add support for array types
Date: Tue, 25 Oct 2011 12:18:02 +0300
Message-ID: <1319534282-7768-1-git-send-email-penberg@kernel.org>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:40675 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751864Ab1JYJSL (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 25 Oct 2011 05:18:11 -0400
Received: by eye27 with SMTP id 27so172784eye.19
        for <linux-sparse@vger.kernel.org>; Tue, 25 Oct 2011 02:18:09 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Pekka Enberg <penberg@kernel.org>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>

This patch adds support for SYM_ARRAY in symbol_type().

Cc: Christopher Li <sparse@chrisli.org>
Cc: Jeff Garzik <jgarzik@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Pekka Enberg <penberg@kernel.org>
---
 sparse-llvm.c              |   17 +++++++++++++++++
 validation/backend/array.c |    6 ++++++
 2 files changed, 23 insertions(+), 0 deletions(-)
 create mode 100644 validation/backend/array.c

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 9f4586f..52a487b 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -34,6 +34,20 @@ static inline bool symbol_is_fp_type(struct symbol *sym)
 
 static LLVMTypeRef symbol_type(LLVMModuleRef module, struct symbol *sym);
 
+static LLVMTypeRef sym_array_type(LLVMModuleRef module, struct symbol *sym)
+{
+	LLVMTypeRef elem_type, ret;
+	struct symbol *base_type;
+
+	base_type = sym->ctype.base_type;
+
+	elem_type = symbol_type(module, base_type);
+	if (!elem_type)
+		return NULL;
+
+	return LLVMArrayType(elem_type, sym->bit_size / 8);
+}
+
 #define MAX_STRUCT_MEMBERS 64
 
 static LLVMTypeRef sym_struct_type(LLVMModuleRef module, struct symbol *sym)
@@ -135,6 +149,9 @@ static LLVMTypeRef symbol_type(LLVMModuleRef module, struct symbol *sym)
 	case SYM_STRUCT:
 		ret = sym_struct_type(module, sym);
 		break;
+	case SYM_ARRAY:
+		ret = sym_array_type(module, sym);
+		break;
 	default:
 		assert(0);
 	}
diff --git a/validation/backend/array.c b/validation/backend/array.c
new file mode 100644
index 0000000..bd3ec59
--- /dev/null
+++ b/validation/backend/array.c
@@ -0,0 +1,6 @@
+static char array[128];
+
+/*
+ * check-name: Array code generation
+ * check-command: ./sparsec -c $file -o tmp.o
+ */
-- 
1.7.6.4

