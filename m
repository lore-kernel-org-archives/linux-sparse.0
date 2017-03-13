From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: sparse-llvm subtraction of one pointer from another should result in
 int difference
Date: Mon, 13 Mar 2017 20:59:02 +0000
Message-ID: <CACXZuxdaVMn8gHkUWWp6opkB0CJ7WAVmEt2P_yqtT9WUO_-LVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:35256 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750902AbdCMU7E (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 13 Mar 2017 16:59:04 -0400
Received: by mail-io0-f182.google.com with SMTP id z13so92827465iof.2
        for <linux-sparse@vger.kernel.org>; Mon, 13 Mar 2017 13:59:03 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi,

I was investigating an error reported while compiling minilua (please
see my earlier post on minlua) and I found that one of the issues was
that the result of subtracting one pointer from another is not handled
correctly in sparse-llvm. I think the OP_SUB implementation should be
changed as follows:

 case OP_SUB:
  if (symbol_is_fp_type(C, insn->type))
   target = LLVMBuildFSub(fn->builder, lhs, rhs, target_name);
  else if (LLVMGetTypeKind(LLVMTypeOf(lhs)) == LLVMPointerTypeKind &&
   LLVMGetTypeKind(LLVMTypeOf(rhs)) == LLVMPointerTypeKind) {
   // Both arguments are pointer
   // Result will be integer
   lhs = LLVMBuildPtrToInt(fn->builder, lhs,
LLVMIntType(C->target->bits_in_pointer), "");
   rhs = LLVMBuildPtrToInt(fn->builder, rhs,
LLVMIntType(C->target->bits_in_pointer), "");
   target = LLVMBuildSub(fn->builder, lhs, rhs, target_name);
  }
  else
   target = LLVMBuildSub(fn->builder, lhs, rhs, target_name);
  break;

Thanks and Regards
Dibyendu
