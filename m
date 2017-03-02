From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Sparse-LLVM issue compiling NULL pointers
Date: Thu, 2 Mar 2017 17:04:04 +0100
Message-ID: <20170302160403.zz5efgh34jvjh5q5@macpro.local>
References: <CACXZuxdav6y9uRC9mavNkVZS173k0ftw-8FpPanKLsoF-ws0Sw@mail.gmail.com>
 <20170228150956.moyfiyd5zf7tbeze@macbook.local>
 <CAExDi1Sa3zDs--jht_43EmefT_nj5ThO_-QRdAFZJn=+rAw0iQ@mail.gmail.com>
 <CACXZuxeRe1Oe-Anht7hnsZgwZroP8sZdajvLBdO3oYCE1ofZ8Q@mail.gmail.com>
 <CACXZuxd2fO7-i84+nS5sC7ZHC68=_uJX3P9k75z05Y8vy2BAUA@mail.gmail.com>
 <20170302052124.fsqogvysufayy4to@macbook.local>
 <CACXZuxe_+-8H6SSA0NvpUdchWYzo_v=2KJq61QC9cVNYG3DGkQ@mail.gmail.com>
 <20170302135655.s742zcslis5r56if@macpro.local>
 <CACXZuxeiWM9zJZqtUC1YN6tFO6VsHkfTn9CZefr6P5nYUOpoRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f175.google.com ([209.85.128.175]:34651 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750771AbdCBRJg (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 2 Mar 2017 12:09:36 -0500
Received: by mail-wr0-f175.google.com with SMTP id l37so57213953wrc.1
        for <linux-sparse@vger.kernel.org>; Thu, 02 Mar 2017 09:08:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CACXZuxeiWM9zJZqtUC1YN6tFO6VsHkfTn9CZefr6P5nYUOpoRA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Mar 02, 2017 at 02:33:09PM +0000, Dibyendu Majumdar wrote:
> This occurs in calc_memop_addr() function when it tries to do following:
> 
>  as = LLVMGetPointerAddressSpace(LLVMTypeOf(src));
> 
> If I dump insn, insn->src, and the LLVM value and type before this line, I get:
> 
> 1) insn load.64     %r18 <- 8[%r2]
> 2) pseudo %r2
> 3) store %struct.buffer_type_st* %R2, %struct.buffer_type_st** %26
> 4) void
> 
> The type of the LLVM store instruction is 'void'.
> 
> My guess is that something is going horribly wrong in the way member
> access is handled.
> 
> If you are able to reproduce this and have any suggestions then please
> let me know.

Why I try your code (without LLVM assertions), I got indeed several
problems:
	Call parameter type does not match function signature!
	i0 16
	 i64  %1 = call i8* @malloc(i0 16)
	Invalid bitcast
	  %27 = bitcast void <badref> to i8**
	Both operands to a binary operator are not of the same type!
	  %R31 = add void <badref>, i64 %R30
	Stored value type does not match pointer operand type!
	  store void %R31, i8** %46

The first one is really weird but I think you don't see it.
The next two I have no idea.
The fourth have something obviously wrong with the type of its 'target'.
None of these seems to correspond to the problem you're seeing.

However, while running sparse-llvm on some code sample I use to test
the linearization, I see that most errors are type errors and are
related to pointer arithmetic, exactly where LLVM's getelemptr is used.
Most offending instructions are OP_ADD (but since I have tests for 
bitfields I see also errors for OP_AND, OP_OR & OP_LSR).
I guess that if you test OP_ADD instruction with pointer on one side
and integer on tne other side and issue an appropriate LLVMBuildGEP(),
things will already be much better.

Luc
