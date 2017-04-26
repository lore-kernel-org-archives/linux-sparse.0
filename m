From: Christopher Li <sparse@chrisli.org>
Subject: Re: [RFC] rationale for systematic elimination of OP_SYMADDR instructions
Date: Wed, 26 Apr 2017 17:02:21 -0400
Message-ID: <CANeU7Qk7czDA+RJzxyZHRa9zJdvv19s0NYExfDoW+34HmkB4dA@mail.gmail.com>
References: <20170309142044.96408-1-luc.vanoostenryck@gmail.com>
 <CANeU7QkhQJrGifw5zvRoN27yVEfmU23B+HG5KQy3R9G3aKWUgw@mail.gmail.com>
 <CAMHZB6EE93YSm0gVUr=dhNpsTZ1vU8acJ9msyh3VSdTOTVUq-w@mail.gmail.com>
 <CANeU7Q=zV+MAFOA6SzANEF9_7NB0rY719bzkesPnvUS9AqR+hw@mail.gmail.com> <CAMHZB6Gj0pS-z_tSPS+6tXhg2mAjGhDYxBLZXn0wmmAYePtZyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f180.google.com ([209.85.223.180]:36643 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967606AbdDZVCX (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 26 Apr 2017 17:02:23 -0400
Received: by mail-io0-f180.google.com with SMTP id p80so10946175iop.3
        for <linux-sparse@vger.kernel.org>; Wed, 26 Apr 2017 14:02:22 -0700 (PDT)
In-Reply-To: <CAMHZB6Gj0pS-z_tSPS+6tXhg2mAjGhDYxBLZXn0wmmAYePtZyg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Wed, Apr 26, 2017 at 8:17 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> Not especially. The case I showed is related to the ability for the machine
> to generate constants corresponding to an address size (like ARM here
> where instruction = addresses = 32bits but constants can only generated
> 16 bits at a time), this is a simple example you can find on static code.
> The exact same problematic is present on all architecture once you have
> less simple relocations (think -fpic, shared libraries and such).

OK. Points well taken.


>> The reason is that, currently CSE operate on the same basic block. It only
>> eliminate instruction but it does not relocate instructions.
>
> That's not true.
> The capability of CSE to move code around is limited, CSE
> doesn't only operate on the same BB. It relocates instructions in simple cases.
>
> And even if CSE would be limited to work on the same BB, it would
> already be beneficial.
>
>> A very common case is that, the symbol address was referenced in different
>> basic blocks.
>>
>> extern int a, d;
>>
>> if (...)
>>      a = d;
>> else if (...)
>>      a = d + 2;
>>
>> CSE would not be able to simply remove the OP_SYMADDR for "a",
>> because they are not in the same basic block. The best result should be,
>> for all the usage of that symbol in a function, find the closest
>> common parent basic
>> block and put the OP_SYMADDR there.
>
> I invite you to look at the output of:
>         extern int use(int);
>
>         int foo(int a)
>         {
>                 int r;
>
>                 if (a)
>                         r = a + 1;
>                 else {
>                         use(0);
>                         r = a + 1;
>                 }
>
>                 return r;
>         }

I take a look at the output:
foo:
.L0:
<entry-point>
add.32      %r3(r) <- %arg1, $1
cbr         %arg1, .L4, .L2

.L2:
call.32     %r4 <- use, $0
br          .L4

.L4:
ret.32      %r3(r)

So you are right, I am wrong about the CSE did not cross basic block
boundary.

>
> No, it's not the job of the backend to do this sort of things, nor
> is it "relatively simple". Why? because it's the exact same problem
> as CSE. If don't put this OP_SYMADDR in CSE here, you will
> need to reimplement something that is equivalent to CSE later at
> code generation, which is pretty stupid.

I notice Linus ACK the patch as well. I still have a question. Let me
ask this, may be a silly one.

Does the address of the symbol ever change inside a function?
I assume it does not change. If that is the case, can we skip the CSE
and replace all the symbol address reference to one OP_SYMADDR?

For example, for each symbol access in the function we insert OP_SYMADDR
after the entry:
foo:
<entry-point>
        %r1 <- a
        %r2 <- b
...

Then all reference of symbol address of "a" and "b" inside the function
foo will use %r1 and %r2.  Notice that we still keep the OP_SYMADDR
instruction, just move to function entry.

Is that illegal or bad?

Thanks

Chris
