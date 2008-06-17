From: "Christopher Li" <sparse@chrisli.org>
Subject: Re: Writing compilers, and example.c vs compile-i386.c
Date: Mon, 16 Jun 2008 17:49:24 -0700
Message-ID: <70318cbf0806161749u543fa338sf43a2ab787297eaa@mail.gmail.com>
References: <4856F196.8020403@cowlark.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.31]:59717 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956AbYFQAtZ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 16 Jun 2008 20:49:25 -0400
Received: by yw-out-2324.google.com with SMTP id 9so3273693ywe.1
        for <linux-sparse@vger.kernel.org>; Mon, 16 Jun 2008 17:49:24 -0700 (PDT)
In-Reply-To: <4856F196.8020403@cowlark.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: David Given <dg@cowlark.com>
Cc: linux-sparse@vger.kernel.org

On Mon, Jun 16, 2008 at 4:04 PM, David Given <dg@cowlark.com> wrote:
> Some basic testing with show_statement() and show_insn() reveals that
> both approaches seem to yield similar but *different* pseudocode... with
> different SSA phi functions. What's the difference between the two, and
> do you have any suggestions as to which approach I should look at?

I would strongly recommend using the example.c rather than compile-i386.c.
If you want to do any thing interesting with the back end at all, using
the linearize byte code is the way to go.

> In addition, I'm afraid I'm going to have to use the D word... has
> anyone written down anything about how all this stuff works? I'm afraid
> it's rather a large mass of code to try and absorb in one go, and any
> overview information would help me considerably. For example: if I put
> together a noddy program that enumerates basic blocks (the example.c
> approach) I see phi functions. Calling unssa() doesn't seem to help.
> However, inserting instrumentation into example.c indicates that it
> *doesn't* see phi functions (as far as I can tell). There's something
> I'm simply not getting here --- does the removal of phis actually happen
> inside the register allocator (which seems like the intuitive place for
> it), and if so, what does unssa() actually do?

I haven't use the unssa() myself. It seems unssa() just replace the
phisrc instruction to a copy instruction. Let the source copy to a
temp register. Then on phi instruction it just copy that temp register
back to the phi node register.

The phi node is replaces with copy instruction inside unssa().
In the real machine code, the copy instruction can emit as "mov"
instruction.

As for linearize instructions. They are the internal representation
of the compiled program. In this representation, there is unlimited
pseudo register. Each pseudo is define in only one instruction. except
"OP_COPY" in the unssa().

Each function entry point has a list of basic blocks and each basic block
has a list of instructions. Most instruction is pretty straight for what
it does.

BTW, if you don't mind coding in C++, you can take a look at LLVM.

Chris
