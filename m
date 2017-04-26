From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [RFC] rationale for systematic elimination of OP_SYMADDR instructions
Date: Wed, 26 Apr 2017 04:49:02 +0200
Message-ID: <CAMHZB6EE93YSm0gVUr=dhNpsTZ1vU8acJ9msyh3VSdTOTVUq-w@mail.gmail.com>
References: <20170309142044.96408-1-luc.vanoostenryck@gmail.com> <CANeU7QkhQJrGifw5zvRoN27yVEfmU23B+HG5KQy3R9G3aKWUgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qt0-f174.google.com ([209.85.216.174]:33640 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1951433AbdDZCtD (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 25 Apr 2017 22:49:03 -0400
Received: by mail-qt0-f174.google.com with SMTP id m36so155952134qtb.0
        for <linux-sparse@vger.kernel.org>; Tue, 25 Apr 2017 19:49:03 -0700 (PDT)
In-Reply-To: <CANeU7QkhQJrGifw5zvRoN27yVEfmU23B+HG5KQy3R9G3aKWUgw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Tue, Apr 25, 2017 at 9:20 PM, Christopher Li <sparse@chrisli.org> wrote:
> On Thu, Mar 9, 2017 at 10:20 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>> While investigating some problems related to code generation
>> I realized that OP_SYMADDR are systematically eliminated,
>> the target address are simply replaced by the symbol itself.
>>
>> While it's not wrong per se as it all depends to the semantic
>> we want to give to pseudos and the instructions and how high-
>> or low-level we want to IR, I don't think it was the intention
>> to remove them and more importantly I don't think it's desirable.
>>
>> Those OP_SYMADDR allowed to make a clear separation between a symbol
>> (a name with a type and info for storage & linkage) and its address
>> (which can be stored in memory or in a register and on which
>> arithmetic operations can then be done on it). Once these addresses
>> are replaced by the symbol itself, those symbols can appears almost
>> everywhere in the linearized code:
>> - in calls' arguments,
>> - in adds and subs (while doing pointer arithmetic),
>> - in casts,
>> - in load & stores,
>> - ...
>> and they complicate things considerably once you begin to be
>> interested concretly in things after linearization & simplification
>> since soon or later you will need the address anyway.
>>
>> So my question is:
>>         "is there a good reason to eliminate those instructions?",
>
> This change is introduce in 962279e8 by Linus:
>
>     Remove OP_SETVAL after symbol-pseudo simplification.
>
>     We can just replace all users with the symbol pseudo
>     directly.
>
>     This means that we can no longer re-do symbol simplification
>     after CSE, and we need to rely on the generic memop simplification.
>
> I can see the reason to do that is simplify the CSE. Before this change,
> every reference to the symbol will do a OP_SETVAL (or OP_SYMADDR now
> days) to get the address into a new pseudo. That is extra work for the
> CSE to discover that:  "Oh,  all those different pseudo are actually the same
> address for the same symbol. Let's replace it with the same pseudo."
>
> I haven't understand why things are more complicate after linearization
> if we replace all the symbol pseudo into one? Even if we don't do it here,
> wouldn't the CSE should do that any way?
>
> The way I see it, the pseudo of the symbol *is* the address of the symbol,
> I don't see a problem using the address of the symbol.
>
> Maybe you have some specific usage case in mind. Can you give some
> example?

Roughly, once you begin to play with code generation, something like
OP_SYMADDR is an operation that you will really do.
Depending on the relocation, it can even be something relatively costly:
I'm thinking static code on a 64bit machine where you can only generate
16bit constants, others cases may be not at all cheaper.
So it's something that soon or later will need to be exposed and
doing CSE on the address is good.
For example, with code as simple as
	extern int a;
	
	void foo(void)
	{
		a = a + 1;
	}

compiled for ARM with GCC:
	foo:
	        movw    r3, #:lower16:a
	        movt    r3, #:upper16:a
	        ldr     r2, [r3]
	        add     r2, r2, #1
	        str     r2, [r3]
	        bx      lr

The first 2 instructions correspond at taking the address of 'a',
it would be the very direct translation of sparse's:
	foo:
	.L0:
		<entry-point>
		symaddr     %r1
		load.32     %r2 <- 0[%r1]
		add.32      %r3 <- %r2, $1
		store.32    %r3 -> 0[%r1]
		ret

If we would have kept the OP_SYMADRR and doing CSE on it.
But for now we have:
	foo:
	.L0:
		<entry-point>
		load.32     %r2 <- 0[a]
		add.32      %r3 <- %r2, $1
		store.32    %r3 -> 0[a]
		ret

whose translation would be:
	        movw    r3, #:lower16:a
	        movt    r3, #:upper16:a
	        ldr     r2, [r3]
	        add     r2, r2, #1
!	        movw    r3, #:lower16:a
!	        movt    r3, #:upper16:a
	        str     r2, [r3]
	        bx      lr
