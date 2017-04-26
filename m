From: Christopher Li <sparse@chrisli.org>
Subject: Re: [RFC] rationale for systematic elimination of OP_SYMADDR instructions
Date: Wed, 26 Apr 2017 07:33:46 -0400
Message-ID: <CANeU7Q=zV+MAFOA6SzANEF9_7NB0rY719bzkesPnvUS9AqR+hw@mail.gmail.com>
References: <20170309142044.96408-1-luc.vanoostenryck@gmail.com>
 <CANeU7QkhQJrGifw5zvRoN27yVEfmU23B+HG5KQy3R9G3aKWUgw@mail.gmail.com> <CAMHZB6EE93YSm0gVUr=dhNpsTZ1vU8acJ9msyh3VSdTOTVUq-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f54.google.com ([209.85.214.54]:37253 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1038634AbdDZLds (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 26 Apr 2017 07:33:48 -0400
Received: by mail-it0-f54.google.com with SMTP id x188so585132itb.0
        for <linux-sparse@vger.kernel.org>; Wed, 26 Apr 2017 04:33:47 -0700 (PDT)
In-Reply-To: <CAMHZB6EE93YSm0gVUr=dhNpsTZ1vU8acJ9msyh3VSdTOTVUq-w@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Tue, Apr 25, 2017 at 10:49 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> Roughly, once you begin to play with code generation, something like
> OP_SYMADDR is an operation that you will really do.
> Depending on the relocation, it can even be something relatively costly:
> I'm thinking static code on a 64bit machine where you can only generate
> 16bit constants, others cases may be not at all cheaper.
> So it's something that soon or later will need to be exposed and
> doing CSE on the address is good.

I see your point. Let me rephrase your claim. Sparse assume getting
the symbol address
is trivial. But on some architecture that is non trivial to generate
symbol address.
Typical case would be, the machine instruction size is smaller than
the address size.
It will take a few machine instruction to generate a symbol address.

I agree with this part.

Now the second part of the claim is that, it would be better to left
the OP_SYMADDR
untouched and let CSE to remove it. That part I disagree.

The reason is that, currently CSE operate on the same basic block. It only
eliminate instruction but it does not relocate instructions.

A very common case is that, the symbol address was referenced in different
basic blocks.

extern int a, d;

if (...)
     a = d;
else if (...)
     a = d + 2;

CSE would not be able to simply remove the OP_SYMADDR for "a",
because they are not in the same basic block. The best result should be,
for all the usage of that symbol in a function, find the closest
common parent basic
block and put the OP_SYMADDR there.

Because getting symbol address is used very often. Let CSE go through a hash
to re-discover that all symbol address can be combined is costly and
not necessary.
And CSE does not cover all the case commit 962279e8 covers.


> If we would have kept the OP_SYMADRR and doing CSE on it.
> But for now we have:
>         foo:
>         .L0:
>                 <entry-point>
>                 load.32     %r2 <- 0[a]
>                 add.32      %r3 <- %r2, $1
>                 store.32    %r3 -> 0[a]
>                 ret
>
> whose translation would be:
>                 movw    r3, #:lower16:a
>                 movt    r3, #:upper16:a
>                 ldr     r2, [r3]
>                 add     r2, r2, #1
> !               movw    r3, #:lower16:a
> !               movt    r3, #:upper16:a

That is because you assume every time "a" was referenced
you need to redo the generate of 32 bit address "a". That is
not necessary true. In sparse IR, "a" already translate into
pseudo, which has the user chain.  It is relative simple for
the back end to find the best place to insert OP_SYMADDR.
The end of the day, it is the back end knows the machine
register allocation and reorder of the instruction if necessary.

So the proper  solution shouldn't be let CSE to discover OP_SYMADDR
yet another time. It should be find the best place to insert OP_SYMADDR.

Chris
