From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Sparse-LLVM issue compiling NULL pointers
Date: Thu, 2 Mar 2017 18:41:35 +0000
Message-ID: <CACXZuxf8-L6hy+TOd6pfmiAhoOXc-K5YJwUjonmmOGxv_djVnA@mail.gmail.com>
References: <CACXZuxdav6y9uRC9mavNkVZS173k0ftw-8FpPanKLsoF-ws0Sw@mail.gmail.com>
 <20170228150956.moyfiyd5zf7tbeze@macbook.local> <CAExDi1Sa3zDs--jht_43EmefT_nj5ThO_-QRdAFZJn=+rAw0iQ@mail.gmail.com>
 <CACXZuxeRe1Oe-Anht7hnsZgwZroP8sZdajvLBdO3oYCE1ofZ8Q@mail.gmail.com>
 <CACXZuxd2fO7-i84+nS5sC7ZHC68=_uJX3P9k75z05Y8vy2BAUA@mail.gmail.com>
 <20170302052124.fsqogvysufayy4to@macbook.local> <CACXZuxe_+-8H6SSA0NvpUdchWYzo_v=2KJq61QC9cVNYG3DGkQ@mail.gmail.com>
 <20170302135655.s742zcslis5r56if@macpro.local> <CACXZuxeiWM9zJZqtUC1YN6tFO6VsHkfTn9CZefr6P5nYUOpoRA@mail.gmail.com>
 <20170302160403.zz5efgh34jvjh5q5@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f169.google.com ([209.85.223.169]:36109 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750787AbdCBTNl (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 2 Mar 2017 14:13:41 -0500
Received: by mail-io0-f169.google.com with SMTP id l7so60234683ioe.3
        for <linux-sparse@vger.kernel.org>; Thu, 02 Mar 2017 11:12:44 -0800 (PST)
In-Reply-To: <20170302160403.zz5efgh34jvjh5q5@macpro.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Luc,

On 2 March 2017 at 16:04, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> However, while running sparse-llvm on some code sample I use to test
> the linearization, I see that most errors are type errors and are
> related to pointer arithmetic, exactly where LLVM's getelemptr is used.
> Most offending instructions are OP_ADD (but since I have tests for
> bitfields I see also errors for OP_AND, OP_OR & OP_LSR).
> I guess that if you test OP_ADD instruction with pointer on one side
> and integer on tne other side and issue an appropriate LLVMBuildGEP(),
> things will already be much better.
>

This seems spot on as by making change as below, the final assertion
failure went away. I have not yet checked the generated code but that
is next.

 case OP_ADD:
  if (symbol_is_fp_type(C, insn->type))
   target = LLVMBuildFAdd(fn->builder, lhs, rhs, target_name);
  else {
   if (LLVMGetTypeKind(LLVMTypeOf(lhs)) == LLVMPointerTypeKind) {
    target = LLVMBuildGEP(fn->builder, lhs, &rhs, 1, "");
   }
   else if (LLVMGetTypeKind(LLVMTypeOf(lhs)) == LLVMPointerTypeKind) {
    target = LLVMBuildGEP(fn->builder, rhs, &lhs, 1, "");
   }
   else {
    target = LLVMBuildAdd(fn->builder, lhs, rhs, target_name);
   }
  }
  break;

Thanks and Regards
