From: Christopher Li <sparse@chrisli.org>
Subject: [PATCH 2/2] V2 sparse-llvm: use pseudo->size to select llvm integer type
Date: Mon, 13 Nov 2017 23:28:20 +0800
Message-ID: <CANeU7Q=Rnm1XxCRvU_fm1TPy1U3EBMQH+63kpMirpXLecbGrqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f196.google.com ([209.85.161.196]:55970 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753210AbdKMP2W (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 13 Nov 2017 10:28:22 -0500
Received: by mail-yw0-f196.google.com with SMTP id t11so13689828ywg.12
        for <linux-sparse@vger.kernel.org>; Mon, 13 Nov 2017 07:28:22 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>

Now constant pseudo has size saved in pseudo->size.
Use that size to select proper integer type for sparse-llvm.

Reported-by: Dibyendu Majumdar <mobile@majumdar.org.uk>
Signed-off-by: Christopher Li <sparse@chrisli.org>
---
 sparse-llvm.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 29fb65f1..31f87f0b 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -242,25 +242,30 @@ static LLVMTypeRef symbol_type(LLVMModuleRef
module, struct symbol *sym)
  return ret;
 }

-static LLVMTypeRef insn_symbol_type(LLVMModuleRef module, struct
instruction *insn)
+static LLVMTypeRef int_type_by_size(int size)
 {
- if (insn->type)
- return symbol_type(module, insn->type);
-
- switch (insn->size) {
+ switch (size) {
+ case 1: return LLVMInt1Type();
  case 8: return LLVMInt8Type();
  case 16: return LLVMInt16Type();
  case 32: return LLVMInt32Type();
  case 64: return LLVMInt64Type();

  default:
- die("invalid bit size %d", insn->size);
+ die("invalid bit size %d", size);
  break;
  }
-
  return NULL; /* not reached */
 }

+static LLVMTypeRef insn_symbol_type(LLVMModuleRef module, struct
instruction *insn)
+{
+ if (insn->type)
+ return symbol_type(module, insn->type);
+
+ return int_type_by_size(insn->size);
+}
+
 static LLVMLinkage data_linkage(struct symbol *sym)
 {
  if (sym->ctype.modifiers & MOD_STATIC)
@@ -360,7 +365,7 @@ static LLVMValueRef pseudo_to_value(struct
function *fn, struct instruction *ins
  break;
  }
  case PSEUDO_VAL:
- result = LLVMConstInt(insn_symbol_type(fn->module, insn), pseudo->value, 1);
+ result = LLVMConstInt(int_type_by_size(pseudo->size), pseudo->value, 1);
  break;
  case PSEUDO_ARG: {
  result = LLVMGetParam(fn->fn, pseudo->nr - 1);
-- 
2.13.6
