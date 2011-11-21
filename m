From: Pekka Enberg <penberg@kernel.org>
Subject: [PATCH 1/3] sparse, llvm: Fix symbol initializer code generation
Date: Mon, 21 Nov 2011 22:03:28 +0200
Message-ID: <1321905810-2253-1-git-send-email-penberg@kernel.org>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:54471 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753055Ab1KUUDj (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 21 Nov 2011 15:03:39 -0500
Received: by bke11 with SMTP id 11so7013808bke.19
        for <linux-sparse@vger.kernel.org>; Mon, 21 Nov 2011 12:03:37 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Pekka Enberg <penberg@kernel.org>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>

The output_data() function does not see right hand side symbols for expressions
such as this in target.c:

  struct symbol *size_t_ctype = &uint_ctype;

Therefore, call output_data() recursively if LLVMGetNamedGlobal() returns NULL
for a symbol.

Cc: Christopher Li <sparse@chrisli.org>
Cc: Jeff Garzik <jgarzik@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Pekka Enberg <penberg@kernel.org>
---
 sparse-llvm.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index c037e02..ca49a6e 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -1055,7 +1055,7 @@ static void output_fn(LLVMModuleRef module, struct entrypoint *ep)
 	END_FOR_EACH_PTR(bb);
 }
 
-static int output_data(LLVMModuleRef module, struct symbol *sym)
+static LLVMValueRef output_data(LLVMModuleRef module, struct symbol *sym)
 {
 	struct expression *initializer = sym->initializer;
 	LLVMValueRef initial_value;
@@ -1071,6 +1071,8 @@ static int output_data(LLVMModuleRef module, struct symbol *sym)
 			struct symbol *sym = initializer->symbol;
 
 			initial_value = LLVMGetNamedGlobal(module, show_ident(sym->ident));
+			if (!initial_value)
+				initial_value = output_data(module, sym);
 			break;
 		}
 		default:
@@ -1090,7 +1092,7 @@ static int output_data(LLVMModuleRef module, struct symbol *sym)
 
 	LLVMSetInitializer(data, initial_value);
 
-	return 0;
+	return data;
 }
 
 static int compile(LLVMModuleRef module, struct symbol_list *list)
-- 
1.7.6.4

