From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: sparse-llvm op_cast should support casting floating type values to integer
Date: Mon, 13 Mar 2017 21:04:40 +0000
Message-ID: <CACXZuxey0_qVqijpzZf=nReuF_s3psN1O4jNf+vOW-64bHhOsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f52.google.com ([209.85.214.52]:34877 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751566AbdCMVEm (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 13 Mar 2017 17:04:42 -0400
Received: by mail-it0-f52.google.com with SMTP id m27so36512200iti.0
        for <linux-sparse@vger.kernel.org>; Mon, 13 Mar 2017 14:04:41 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi,

While investigating an assertion failure when compiling minilua I
found that op_cast implementation in sparse-llvm doesn't handle the
scenario where the input is a floating point number. I think the
following change is needed:

 switch (LLVMGetTypeKind(LLVMTypeOf(src))) {
  case LLVMPointerTypeKind:
   op = LLVMPtrToInt;
   break;
  case LLVMIntegerTypeKind:
   width = LLVMGetIntTypeWidth(LLVMTypeOf(src));
   if (insn->size < width)
    op = LLVMTrunc;
   else if (insn->size == width)
    op = LLVMBitCast;
   break;
  case LLVMFloatTypeKind:
  case LLVMDoubleTypeKind:
   op = LLVMFPToSI;
   break;

Thanks and Regards
Dibyendu
