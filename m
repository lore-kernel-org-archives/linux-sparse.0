From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/2] llvm: warn instead of assert on global inits
Date: Mon, 14 Aug 2017 21:41:50 +0200
Message-ID: <20170814194152.36289-2-luc.vanoostenryck@gmail.com>
References: <20170814194152.36289-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37847 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751000AbdHNTmD (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 14 Aug 2017 15:42:03 -0400
Received: by mail-wm0-f65.google.com with SMTP id t138so15521728wmt.4
        for <linux-sparse@vger.kernel.org>; Mon, 14 Aug 2017 12:42:02 -0700 (PDT)
In-Reply-To: <20170814194152.36289-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Currently, sparse-llvm can't emit the needed code for
all initializers and when it's the case it stop abruptly
with an assert(0).

This is kinda useless.

Somehow fix this by issuing a warning instead and try to
continue gracefully.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 3a68d09d9..9a32efe36 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -1212,7 +1212,9 @@ static LLVMValueRef output_data(LLVMModuleRef module, struct symbol *sym)
 			break;
 		}
 		default:
-			assert(0);
+			warning(initializer->pos, "can't initialize type: %s", show_typename(sym));
+			initial_value = NULL;
+			break;
 		}
 	} else {
 		LLVMTypeRef type = symbol_type(sym);
@@ -1220,6 +1222,9 @@ static LLVMValueRef output_data(LLVMModuleRef module, struct symbol *sym)
 		initial_value = LLVMConstNull(type);
 	}
 
+	if (!initial_value)
+		return NULL;
+
 	name = sym->ident ? show_ident(sym->ident) : "" ;
 
 	data = LLVMAddGlobal(module, LLVMTypeOf(initial_value), name);
-- 
2.14.0

