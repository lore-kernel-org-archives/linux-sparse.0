From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Sparse-LLVM issue compiling NULL pointers
Date: Thu, 2 Mar 2017 16:29:13 +0000
Message-ID: <CACXZuxefWw7VT8VJPXuYZ2kBLK-N=eYGc6BF5Lnbg9vP-RqLWw@mail.gmail.com>
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
Received: from mail-it0-f48.google.com ([209.85.214.48]:37651 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753475AbdCBTO1 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 2 Mar 2017 14:14:27 -0500
Received: by mail-it0-f48.google.com with SMTP id 203so58114703ith.0
        for <linux-sparse@vger.kernel.org>; Thu, 02 Mar 2017 11:14:27 -0800 (PST)
In-Reply-To: <20170302160403.zz5efgh34jvjh5q5@macpro.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Luc,

On 2 March 2017 at 16:04, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Thu, Mar 02, 2017 at 02:33:09PM +0000, Dibyendu Majumdar wrote:
>> This occurs in calc_memop_addr() function when it tries to do following:
>>
>>  as = LLVMGetPointerAddressSpace(LLVMTypeOf(src));
>>
>> If I dump insn, insn->src, and the LLVM value and type before this line, I get:
>>
>> 1) insn load.64     %r18 <- 8[%r2]
>> 2) pseudo %r2
>> 3) store %struct.buffer_type_st* %R2, %struct.buffer_type_st** %26
>> 4) void
>>
>> The type of the LLVM store instruction is 'void'.
>>
>> My guess is that something is going horribly wrong in the way member
>> access is handled.
>>
>> If you are able to reproduce this and have any suggestions then please
>> let me know.
>
> Why I try your code (without LLVM assertions), I got indeed several
> problems:
>         Call parameter type does not match function signature!
>         i0 16
>          i64  %1 = call i8* @malloc(i0 16)

I have the function argument fix so I don't get the malloc error.

>         Invalid bitcast
>           %27 = bitcast void <badref> to i8**
>         Both operands to a binary operator are not of the same type!

I think this corresponds to the code that fails - the type of the LLVM
instruction is 'void' and the code is trying to cast to it or
something.

>           %R31 = add void <badref>, i64 %R30
>         Stored value type does not match pointer operand type!
>           store void %R31, i8** %46
>

The code aborts at previous step

> The first one is really weird but I think you don't see it.

It is the function call issue, for which I have a fix I described.

> The next two I have no idea.
> The fourth have something obviously wrong with the type of its 'target'.

> However, while running sparse-llvm on some code sample I use to test
> the linearization, I see that most errors are type errors and are
> related to pointer arithmetic, exactly where LLVM's getelemptr is used.
> Most offending instructions are OP_ADD (but since I have tests for
> bitfields I see also errors for OP_AND, OP_OR & OP_LSR).
> I guess that if you test OP_ADD instruction with pointer on one side
> and integer on tne other side and issue an appropriate LLVMBuildGEP(),
> things will already be much better.
>

Here is the output from linearize. I think the way stores and loads
are handled is broken. It appears that the last store / load
instruction is stored in insn->target->priv, and then used later on
... I do not understand what the code is trying to do. Is it trying to
optimize away stores and loads?

grow_allocator:
.L0000022DAFA94A88:
        <entry-point>
        call.64     %r1 <- malloc, $16
        ptrcast.64  %r2 <- (64) %r1
        load.64     %r4 <- 32[%arg1]
        load.64     %r6 <- 40[%arg1]
        mulu.64     %r7 <- %r4, %r6
        call.64     %r8 <- malloc, %r7
        ptrcast.64  %r9 <- (64) %r8
        store.64    %r9 -> 8[%r2]
        load.64     %r12 <- 0[%arg1]
        store.64    %r12 -> 0[%r2]
        store.64    %r2 -> 0[%arg1]
        load.64     %r18 <- 8[%r2]
        store.64    %r18 -> 16[%arg1]
        load.64     %r23 <- 32[%arg1]
        load.64     %r25 <- 40[%arg1]
        mulu.64     %r26 <- %r23, %r25
        add.64      %r27 <- %r18, %r26
        store.64    %r27 -> 24[%arg1]
        ret
