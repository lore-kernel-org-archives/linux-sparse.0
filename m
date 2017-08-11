From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [RFC] rationale for systematic elimination of OP_SYMADDR
 instructions
Date: Fri, 11 Aug 2017 14:25:51 +0200
Message-ID: <20170811122549.3v44es54aghlrskx@ltop.local>
References: <20170309142044.96408-1-luc.vanoostenryck@gmail.com>
 <CANeU7QkhQJrGifw5zvRoN27yVEfmU23B+HG5KQy3R9G3aKWUgw@mail.gmail.com>
 <CAMHZB6EE93YSm0gVUr=dhNpsTZ1vU8acJ9msyh3VSdTOTVUq-w@mail.gmail.com>
 <CANeU7Q=zV+MAFOA6SzANEF9_7NB0rY719bzkesPnvUS9AqR+hw@mail.gmail.com>
 <CAMHZB6Gj0pS-z_tSPS+6tXhg2mAjGhDYxBLZXn0wmmAYePtZyg@mail.gmail.com>
 <CANeU7Qk7czDA+RJzxyZHRa9zJdvv19s0NYExfDoW+34HmkB4dA@mail.gmail.com>
 <CAMHZB6EvJss-53X2oyXGHTRpAjDnoK8W5dCbng2tqUmjMykORA@mail.gmail.com>
 <CANeU7QkJy-G4EXuJ94KBcmo3Bc0Pei0uQSTeYr-u4DxsSK==uQ@mail.gmail.com>
 <CAExDi1QVzkOVRxe+mdsHEi4=wirRFKrO+UFRDH2498z43oZidw@mail.gmail.com>
 <CANeU7Q=cN1z6bimq8aK_0KKxMwLvkBgA6A9r8xts67VHb2y7=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37326 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752196AbdHKMZy (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 11 Aug 2017 08:25:54 -0400
Received: by mail-wm0-f41.google.com with SMTP id i66so46093000wmg.0
        for <linux-sparse@vger.kernel.org>; Fri, 11 Aug 2017 05:25:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7Q=cN1z6bimq8aK_0KKxMwLvkBgA6A9r8xts67VHb2y7=w@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Thu, Aug 10, 2017 at 09:17:44PM -0400, Christopher Li wrote:
> First of all, I want to clarify that I ask this question is
> to satisfy my curiously why it is done this way,
> either it is the best optimal way to do it.
> 
> It is not reason to reject your patch. I trust you have good
> reason to do it, I will accept the patch even if I don't fully
> understand it. I still want to understand it after applying
> it.

OK, I'll try to explain it the best I can.
 
> Do CSE do you mean just CSE OP_SYMADDR or CSE the complicated
> instruction expand from OP_SYMADDR.

Just the OP_SYMADDR, there is no expansion for them at this level.

> Let say you have code like this, the symbol is assign in different
> scope block.
> 
> Before CSE there is 3 OP_SYMADDR "a".  After CSE where is those 3
> OP_SYMADDR "a" is likely to be combine into one? Where would the
> CSE place the OP_SYMADDR if it is not one of the beginning or dominator
> etc?

Exactly like any other expression that is CSEed.

Yes, I elude your question, on purpose, because the question
about *where* those instructions need to be is unrelated to the
question "must these instructions be present or not".

> In that case, you might just place it before load or store. You don't seem
> to need CSE to do it. Sorry I feel that I am still missing some big picture.
> I am desperately trying to fill it.

Thing is that the current linearizer already *create* them, all of them,
just before the load or store that need them.
There are also a few other situations where they are needed: when doing
address calculation for symbols. For example:
	extern int a[];
	int *ptr;
	...
	ptr = &a[i];

But in all cases, the OP_SYMADDRs are correctly *created*.

The problme is that (in most cases) these OP_SYMADDR are *directly* 
optimized away or more exactly back-folded with their symbol.
For example:
	extern int a;
	int v;
	...
	v = a;

The linearized code is something like:
	symaddr	%r1, a
	load	%r2, %r1[0]
And this is *exactly* what is needed. Among others things
the load take as operand an *address* and not a symbol
which is something that belong more to the source language.

But after the very first pass of simplify_instruction() the
symaddr is 'simplified away' and we get:
	load	%r2, a[0]

It's just this simplification that should be removed.

> I also think that you make the OP_SYMADDR a lower level IR than
> what I original have in mind writing linearizer.

I didn't create them :)

> I expect there is a separate
> phase where you translate the sparse IR into machine level code, that
> is where you can insert the equivalent of OP_SYMADDR.

Of course.
But again, look at the title of the thread: the question has never been
about the creation/insertion of these OP_SYMADDRs but about their
non-elimination.

> OK. For the sparse checker question.

I won't answer now to this question because I think, if it is still
pertinant, it needs to be reformulated taking in account the fact
that *all* needed OP_SYMADDR are already created during linearization.

-- Luc
