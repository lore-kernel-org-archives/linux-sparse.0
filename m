From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: sparse-llvm incorrect handling of op_add when pointers are involved
Date: Fri, 3 Mar 2017 07:00:31 +0000
Message-ID: <CACXZuxeb6zt2b_imNXWJSvgQGTmDTorAgGr6BsEpQRPgPP8sKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ua0-f195.google.com ([209.85.217.195]:33704 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751610AbdCCHKw (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 3 Mar 2017 02:10:52 -0500
Received: by mail-ua0-f195.google.com with SMTP id f54so12817026uaa.0
        for <linux-sparse@vger.kernel.org>; Thu, 02 Mar 2017 23:09:59 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi

I am starting a new thread for this issue. The handling of op_add does
not work correctly when an operand is a pointer type. A potential fix
might be:

case OP_ADD:
if (symbol_is_fp_type(C, insn->type))
target = LLVMBuildFAdd(fn->builder, lhs, rhs, target_name);
else {
if (LLVMGetTypeKind(LLVMTypeOf(lhs)) == LLVMPointerTypeKind) {
target = LLVMBuildGEP(fn->builder, lhs, &rhs, 1, "");
}
else if (LLVMGetTypeKind(LLVMTypeOf(rhs)) == LLVMPointerTypeKind) {
target = LLVMBuildGEP(fn->builder, rhs, &lhs, 1, "");
}
else {
target = LLVMBuildAdd(fn->builder, lhs, rhs, target_name);
}
}
break;

Thanks and Regards
Dibyendu
