From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Sparse-LLVM issue compiling NULL pointers
Date: Thu, 2 Mar 2017 18:50:00 +0100
Message-ID: <20170302174959.kh7x5bmwccl7fpig@macpro.local>
References: <CAExDi1Sa3zDs--jht_43EmefT_nj5ThO_-QRdAFZJn=+rAw0iQ@mail.gmail.com>
 <CACXZuxeRe1Oe-Anht7hnsZgwZroP8sZdajvLBdO3oYCE1ofZ8Q@mail.gmail.com>
 <CACXZuxd2fO7-i84+nS5sC7ZHC68=_uJX3P9k75z05Y8vy2BAUA@mail.gmail.com>
 <20170302052124.fsqogvysufayy4to@macbook.local>
 <CACXZuxe_+-8H6SSA0NvpUdchWYzo_v=2KJq61QC9cVNYG3DGkQ@mail.gmail.com>
 <20170302135655.s742zcslis5r56if@macpro.local>
 <CACXZuxeiWM9zJZqtUC1YN6tFO6VsHkfTn9CZefr6P5nYUOpoRA@mail.gmail.com>
 <20170302160403.zz5efgh34jvjh5q5@macpro.local>
 <CACXZuxefWw7VT8VJPXuYZ2kBLK-N=eYGc6BF5Lnbg9vP-RqLWw@mail.gmail.com>
 <CACXZuxeayh3PUdypas6Ww_1mT23ZOuJiZZA_NWDkSQbfes9Xzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:32829 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753100AbdCBRuR (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 2 Mar 2017 12:50:17 -0500
Received: by mail-wm0-f45.google.com with SMTP id i17so4226001wmf.0
        for <linux-sparse@vger.kernel.org>; Thu, 02 Mar 2017 09:50:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CACXZuxeayh3PUdypas6Ww_1mT23ZOuJiZZA_NWDkSQbfes9Xzw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Mar 02, 2017 at 05:03:06PM +0000, Dibyendu Majumdar wrote:
> On 2 March 2017 at 16:29, Dibyendu Majumdar <mobile@majumdar.org.uk> wrote:
> > Here is the output from linearize. I think the way stores and loads
> > are handled is broken. It appears that the last store / load
> > instruction is stored in insn->target->priv, and then used later on
> > ... I do not understand what the code is trying to do. Is it trying to
> > optimize away stores and loads?
> >
> > grow_allocator:
> > .L0000022DAFA94A88:
> >         <entry-point>
> >         call.64     %r1 <- malloc, $16
> >         ptrcast.64  %r2 <- (64) %r1
> >         load.64     %r4 <- 32[%arg1]
> >         load.64     %r6 <- 40[%arg1]
> >         mulu.64     %r7 <- %r4, %r6
> >         call.64     %r8 <- malloc, %r7
> >         ptrcast.64  %r9 <- (64) %r8
> >         store.64    %r9 -> 8[%r2]
> >         load.64     %r12 <- 0[%arg1]
> >         store.64    %r12 -> 0[%r2]
> 
> It appears that the sparse-llvm code is storing the LLVM instruction
> for '%r2' in pseudo->priv.
> 
> >         store.64    %r2 -> 0[%arg1]

Ah yes, it overwrite the correct value previously stored there (the
LLVMValueRef corresponding to %r2) with the return value of LLVMBuildStore().

> And then it using the value of the store instruction whenever it sees '%r2'?
> 
> >         load.64     %r18 <- 8[%r2]
> 
> But here it fails because it needs to cast the LLVM store instruction
> to be a pointer to access 8[]?

Yes, now anything using %r2 will go wrong.

Removing the last line of output_op_store() (insn->target->priv = target;)
should fix this.


Luc
