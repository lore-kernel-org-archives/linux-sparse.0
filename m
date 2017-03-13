From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: sparse-llvm failure when comparing pointers
Date: Mon, 13 Mar 2017 23:47:04 +0000
Message-ID: <CACXZuxc=TMZyi9LPJ6KGfDeNZYBrkZ4gp2p8Z75tbPhKfCnmuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f44.google.com ([209.85.214.44]:35632 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751266AbdCMXrG (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 13 Mar 2017 19:47:06 -0400
Received: by mail-it0-f44.google.com with SMTP id m27so38358752iti.0
        for <linux-sparse@vger.kernel.org>; Mon, 13 Mar 2017 16:47:05 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Pointer comparions are failing LLVM validation if they are not the
same type. One way to resolve this is to cast the pointer to integer
before comparing. I am trying out following approach. In
output_op_compare(), I separated out the pointer case as follows:

 switch  (LLVMGetTypeKind(LLVMTypeOf(lhs))) {
 case LLVMPointerTypeKind: {
  lhs = LLVMBuildPtrToInt(fn->builder, lhs,
LLVMIntType(C->target->bits_in_pointer), "");
  if (LLVMGetTypeKind(LLVMTypeOf(rhs)) == LLVMPointerTypeKind) {
   rhs = LLVMBuildPtrToInt(fn->builder, rhs,
LLVMIntType(C->target->bits_in_pointer), "");
  }
  LLVMIntPredicate op = translate_op(insn->opcode);
  target = LLVMBuildICmp(fn->builder, op, lhs, rhs, target_name);
  break;
 }
 case LLVMIntegerTypeKind: {
  LLVMIntPredicate op = translate_op(insn->opcode);
  target = LLVMBuildICmp(fn->builder, op, lhs, rhs, target_name);
  break;
 }
