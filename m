From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/2] llvm: add support for float initializer
Date: Mon, 14 Aug 2017 21:41:51 +0200
Message-ID: <20170814194152.36289-3-luc.vanoostenryck@gmail.com>
References: <20170814194152.36289-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37864 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751042AbdHNTmG (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 14 Aug 2017 15:42:06 -0400
Received: by mail-wm0-f65.google.com with SMTP id t138so15521886wmt.4
        for <linux-sparse@vger.kernel.org>; Mon, 14 Aug 2017 12:42:05 -0700 (PDT)
In-Reply-To: <20170814194152.36289-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

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

