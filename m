From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [RFC] rationale for systematic elimination of OP_SYMADDR instructions
Date: Wed, 26 Apr 2017 14:17:00 +0200
Message-ID: <CAMHZB6Gj0pS-z_tSPS+6tXhg2mAjGhDYxBLZXn0wmmAYePtZyg@mail.gmail.com>
References: <20170309142044.96408-1-luc.vanoostenryck@gmail.com>
 <CANeU7QkhQJrGifw5zvRoN27yVEfmU23B+HG5KQy3R9G3aKWUgw@mail.gmail.com>
 <CAMHZB6EE93YSm0gVUr=dhNpsTZ1vU8acJ9msyh3VSdTOTVUq-w@mail.gmail.com> <CANeU7Q=zV+MAFOA6SzANEF9_7NB0rY719bzkesPnvUS9AqR+hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qt0-f173.google.com ([209.85.216.173]:36109 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S944011AbdDZMRB (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 26 Apr 2017 08:17:01 -0400
Received: by mail-qt0-f173.google.com with SMTP id g60so164266034qtd.3
        for <linux-sparse@vger.kernel.org>; Wed, 26 Apr 2017 05:17:01 -0700 (PDT)
In-Reply-To: <CANeU7Q=zV+MAFOA6SzANEF9_7NB0rY719bzkesPnvUS9AqR+hw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Wed, Apr 26, 2017 at 1:33 PM, Christopher Li <sparse@chrisli.org> wrote:
> On Tue, Apr 25, 2017 at 10:49 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>> Roughly, once you begin to play with code generation, something like
>> OP_SYMADDR is an operation that you will really do.
>> Depending on the relocation, it can even be something relatively costly:
>> I'm thinking static code on a 64bit machine where you can only generate
>> 16bit constants, others cases may be not at all cheaper.
>> So it's something that soon or later will need to be exposed and
>> doing CSE on the address is good.
>
> I see your point. Let me rephrase your claim. Sparse assume getting
> the symbol address
> is trivial. But on some architecture that is non trivial to generate
> symbol address.
> Typical case would be, the machine instruction size is smaller than
> the address size.
Not especially. The case I showed is related to the ability for the machine
to generate constants corresponding to an address size (like ARM here
where instruction = addresses = 32bits but constants can only generated
16 bits at a time), this is a simple example you can find on static code.
The exact same problematic is present on all architecture once you have
less simple relocations (think -fpic, shared libraries and such).

> It will take a few machine instruction to generate a symbol address.
>
> I agree with this part.
>
> Now the second part of the claim is that, it would be better to left
> the OP_SYMADDR
> untouched and let CSE to remove it. That part I disagree.
>
> The reason is that, currently CSE operate on the same basic block. It only
> eliminate instruction but it does not relocate instructions.

That's not true.
The capability of CSE to move code around is limited, CSE
doesn't only operate on the same BB. It relocates instructions in simple cases.

And even if CSE would be limited to work on the same BB, it would
already be beneficial.

> A very common case is that, the symbol address was referenced in different
> basic blocks.
>
> extern int a, d;
>
> if (...)
>      a = d;
> else if (...)
>      a = d + 2;
>
> CSE would not be able to simply remove the OP_SYMADDR for "a",
> because they are not in the same basic block. The best result should be,
> for all the usage of that symbol in a function, find the closest
> common parent basic
> block and put the OP_SYMADDR there.

I invite you to look at the output of:
        extern int use(int);

        int foo(int a)
        {
                int r;

                if (a)
                        r = a + 1;
                else {
                        use(0);
                        r = a + 1;
                }

                return r;
        }

> Because getting symbol address is used very often. Let CSE go through a hash
> to re-discover that all symbol address can be combined is costly and
> not necessary.
> And CSE does not cover all the case commit 962279e8 covers.
>
>
>> If we would have kept the OP_SYMADRR and doing CSE on it.
>> But for now we have:
>>         foo:
>>         .L0:
>>                 <entry-point>
>>                 load.32     %r2 <- 0[a]
>>                 add.32      %r3 <- %r2, $1
>>                 store.32    %r3 -> 0[a]
>>                 ret
>>
>> whose translation would be:
>>                 movw    r3, #:lower16:a
>>                 movt    r3, #:upper16:a
>>                 ldr     r2, [r3]
>>                 add     r2, r2, #1
>> !               movw    r3, #:lower16:a
>> !               movt    r3, #:upper16:a
>
> That is because you assume every time "a" was referenced
> you need to redo the generate of 32 bit address "a". That is
> not necessary true. In sparse IR, "a" already translate into
> pseudo, which has the user chain.  It is relative simple for
> the back end to find the best place to insert OP_SYMADDR.
> The end of the day, it is the back end knows the machine
> register allocation and reorder of the instruction if necessary.

No, it's not the job of the backend to do this sort of things, nor
is it "relatively simple". Why? because it's the exact same problem
as CSE. If don't put this OP_SYMADDR in CSE here, you will
need to reimplement something that is equivalent to CSE later at
code generation, which is pretty stupid.
What is done, at codegen & register allocation is exactly the opposite:
when you're short on registers and need to spill some you will (maybe)
first chose the ones that were used for this sort of values because
you can recalculate/regenerate them easily (mainly because very often
getting the address will simply be a load itself).

-- Luc
