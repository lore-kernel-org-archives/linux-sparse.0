From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Sparse-LLVM issue compiling NULL pointers
Date: Fri, 3 Mar 2017 06:35:57 +0100
Message-ID: <20170303053556.dvdbrx4pkm6jdilk@macpro.local>
References: <20170228150956.moyfiyd5zf7tbeze@macbook.local>
 <CAExDi1Sa3zDs--jht_43EmefT_nj5ThO_-QRdAFZJn=+rAw0iQ@mail.gmail.com>
 <CACXZuxeRe1Oe-Anht7hnsZgwZroP8sZdajvLBdO3oYCE1ofZ8Q@mail.gmail.com>
 <CACXZuxd2fO7-i84+nS5sC7ZHC68=_uJX3P9k75z05Y8vy2BAUA@mail.gmail.com>
 <20170302052124.fsqogvysufayy4to@macbook.local>
 <CACXZuxe_+-8H6SSA0NvpUdchWYzo_v=2KJq61QC9cVNYG3DGkQ@mail.gmail.com>
 <20170302135655.s742zcslis5r56if@macpro.local>
 <CACXZuxeiWM9zJZqtUC1YN6tFO6VsHkfTn9CZefr6P5nYUOpoRA@mail.gmail.com>
 <20170302160403.zz5efgh34jvjh5q5@macpro.local>
 <CACXZuxf8-L6hy+TOd6pfmiAhoOXc-K5YJwUjonmmOGxv_djVnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:36958 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750983AbdCCFqQ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 3 Mar 2017 00:46:16 -0500
Received: by mail-wm0-f48.google.com with SMTP id n11so7211290wma.0
        for <linux-sparse@vger.kernel.org>; Thu, 02 Mar 2017 21:45:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CACXZuxf8-L6hy+TOd6pfmiAhoOXc-K5YJwUjonmmOGxv_djVnA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Mar 02, 2017 at 06:41:35PM +0000, Dibyendu Majumdar wrote:
> This seems spot on as by making change as below, the final assertion
> failure went away. I have not yet checked the generated code but that
> is next.
> 
>  case OP_ADD:
>   if (symbol_is_fp_type(C, insn->type))
>    target = LLVMBuildFAdd(fn->builder, lhs, rhs, target_name);
>   else {
>    if (LLVMGetTypeKind(LLVMTypeOf(lhs)) == LLVMPointerTypeKind) {
>     target = LLVMBuildGEP(fn->builder, lhs, &rhs, 1, "");
>    }
>    else if (LLVMGetTypeKind(LLVMTypeOf(lhs)) == LLVMPointerTypeKind) {

Yes, this is what I meant but here you're testing twice the type of 'lhs'.
One of the test should be on 'rhs'.

Can you resend it in another thread once it's fixed?

Thanks,
Luc
