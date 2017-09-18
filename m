From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/5] llvm: add support for float initializer
Date: Mon, 18 Sep 2017 11:30:12 +0200
Message-ID: <20170918093014.11878-4-luc.vanoostenryck@gmail.com>
References: <20170918093014.11878-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35424 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932576AbdIRJa1 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 18 Sep 2017 05:30:27 -0400
Received: by mail-wm0-f66.google.com with SMTP id e64so287359wmi.2
        for <linux-sparse@vger.kernel.org>; Mon, 18 Sep 2017 02:30:27 -0700 (PDT)
In-Reply-To: <20170918093014.11878-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 9a32efe36..206fac227 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -1197,6 +1197,9 @@ static LLVMValueRef output_data(LLVMModuleRef module, struct symbol *sym)
 		case EXPR_VALUE:
 			initial_value = LLVMConstInt(symbol_type(sym), initializer->value, 1);
 			break;
+		case EXPR_FVALUE:
+			initial_value = LLVMConstReal(symbol_type(sym), initializer->fvalue);
+			break;
 		case EXPR_SYMBOL: {
 			struct symbol *sym = initializer->symbol;
 
-- 
2.14.0

