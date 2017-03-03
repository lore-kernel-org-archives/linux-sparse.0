From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: sparse-llvm incorrect handling of comparison ops when pointers are involved
Date: Fri, 3 Mar 2017 07:10:56 +0000
Message-ID: <CACXZuxea+nc38a--S90ac0k1tBQwJTnTjjyJfNcofaAtVhmfOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:35773 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751332AbdCCHK6 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 3 Mar 2017 02:10:58 -0500
Received: by mail-io0-f196.google.com with SMTP id f103so5977905ioi.2
        for <linux-sparse@vger.kernel.org>; Thu, 02 Mar 2017 23:10:57 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi,

It appears that the handling of comparison operators is not correct
when pointer types are involved - the code attempts floating point
comparison. A potential fix might be:

/* Binary comparison */
case OP_SET_EQ:
case OP_SET_NE:
case OP_SET_LE:
case OP_SET_GE:
case OP_SET_LT:
case OP_SET_GT:
case OP_SET_B:
case OP_SET_A:
case OP_SET_BE:
case OP_SET_AE: {
LLVMTypeRef dst_type = insn_symbol_type(C, fn->module, insn);

if (LLVMGetTypeKind(LLVMTypeOf(lhs)) == LLVMIntegerTypeKind ||
LLVMGetTypeKind(LLVMTypeOf(lhs)) == LLVMPointerTypeKind) {
LLVMIntPredicate op = translate_op(insn->opcode);

target = LLVMBuildICmp(fn->builder, op, lhs, rhs, target_name);
} else {
LLVMRealPredicate op = translate_fop(insn->opcode);

target = LLVMBuildFCmp(fn->builder, op, lhs, rhs, target_name);
}

target = LLVMBuildZExt(fn->builder, target, dst_type, target_name);
break;
}
