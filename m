From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: linearize bug?
Date: Sun, 12 Nov 2006 20:43:42 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611122032340.22714@g5.osdl.org>
References: <45569E7C.4030706@garzik.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:58847 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1753885AbWKMEoA (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 12 Nov 2006 23:44:00 -0500
In-Reply-To: <45569E7C.4030706@garzik.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-sparse@vger.kernel.org



On Sat, 11 Nov 2006, Jeff Garzik wrote:
> Given the following C code:
>
> #include <stdlib.h>
> 
> int foo(void)
> {
>         int i;
> 
>         i = 42;
>         i += rand();
> 
>         return i;
> }
> 
> test-linearize seems to give me the following output, which indicates that
> pseudo %r1 is "dead" immediately before it is used:

That is normal.

"dead X" means that X is dead after the _next_ (non-deathnote) 
instruction.

So every single death-note should always show up _before_ an instruction 
that uses that register, or something is wrong.

This is actually very useful. It means that for a code generator that 
keeps track of hardware registers, it knows that a register content can be 
re-used as the _destination_ of a code sequence when it sees the 
death-note.

So for example:

> foo:
> .L0x2b52beecd010:
>         <entry-point>
>         call.32     %r1 <- rand
>         dead        %r1
>         add.32      %r4 <- %r1, $42
>         dead        %r4
>         ret.32      %r4

Here, the compiler back-end might, for example, look at

	call.32 %r1 <- rand

and decide to use register %eax for %r1.

Now, the "dead %r1" that follows will tell the back-end that the value in 
%r1 will be used _only_ by the following instruction, and never again, so 
when it sees the

	add.32 %r4 <- r1, $42

the back-end can trivially decide to _reuse_ %eax for %r4 too, and 
generate just a simple

	addl $42,%eax

for that instruction, without worrying at all about the fact that it 
over-writes the register that contains %r1.

The same thing foes for the next two instructions: "dead %r4" means that 
r4 (which we hold in %eax) will be dead after the next instruction (the 
return), so again it knows that it can re-use %eax for the result. Of 
course, for a return that's trivial anyway, but..

My "example" back-end actually does all this. It's buggy as hell, but try

	./example file.c

on your input file, and at least I get:

	.globl foo
	foo:
	        call rand               # generate_call
	        add.32 $42,%eax         # do_binop
	        ret             # generate_ret

which actually is correct (and re-uses %eax all the time). It even gets a 
few more complicated cases right, but there are certainly trivial ways to 
confuse it too (it doesn't really do any stack slot allocation, so 
anything that generates a spill - which it _will_ try to do - will 
actually generate completely broken code that just overwrites the stack).

			Linus
