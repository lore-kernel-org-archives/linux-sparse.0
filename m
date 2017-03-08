From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: sparse-next assertion failures on cygwin
Date: Wed, 8 Mar 2017 08:07:12 +0100
Message-ID: <20170308070711.ke5y4kpec7455ltb@macpro.local>
References: <5227848f-5c01-c250-84ec-27f5f6e2a67c@ramsayjones.plus.com>
 <20170307063558.4itvt4mh327py6ls@macpro.local>
 <a0ec1103-5ae3-2dee-9715-1d839e11ca58@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32934 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750799AbdCHHOt (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 8 Mar 2017 02:14:49 -0500
Received: by mail-wm0-f67.google.com with SMTP id n11so4456993wma.0
        for <linux-sparse@vger.kernel.org>; Tue, 07 Mar 2017 23:13:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <a0ec1103-5ae3-2dee-9715-1d839e11ca58@ramsayjones.plus.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>

On Wed, Mar 08, 2017 at 01:38:10AM +0000, Ramsay Jones wrote:
> > That's surprising as it appears that you have linearized code that is
> > different that what we have on Linux (one of the type/symbol is NULL).
> 
> No, the linearized code is exactly the same on Linux and cygwin.
> (checked with both diff and sha1sum).
> 
> > It whould be very interesting to:
> > 1) show the result of test-linearize on the file
> 
> $ ./test-linearize validation/backend/loop.c
> foo:
> .L0:
> 	<entry-point>
> 	phisrc.32   %phi4(y) <- $0
> 	br          .L4
> 
> .L4:
> 	phi.32      %r1(y) <- %phi4(y), %phi5(y)
> 	setlt.32    %r2 <- %r1(y), $1000
> 	cbr         %r2, .L1, .L5
> 
> .L1:
> 	call.32     %r4 <- bar, %arg1
> 	add.32      %r7 <- %r1(y), %r4
> 	phisrc.32   %phi5(y) <- %r7
> 	br          .L4
> 
> .L5:
> 	ret.32      %r1(y)

Wish it would also display the type of all pseudos and symbols.
I'll add this to my todo-list.
 
> > 2) replace the assert with a check followed with a dump of the
> >    offending pseudo (show_pseudo()) and ideally the corresponding
> >    instruction (show_instruction()).
> 
> <show_pseudo>: $0
> <show_instruction>: phisrc.32   %phi4(y) <- $0     (%r1(y))

There is some logics why it crashs here.
 
> > No, nothing like that on Linux.
> 
> It seems Christopher is seeing the same thing. (He didn't say that
> he saw it on Linux, but ...).

Yes, I saw that.

> Are you sure you are running/testing the sparse-next branch (which
> is currently at commit ab8076b83d ("llvm: fix output_op_[ptr]cast()",
> 05-03-2017)?

No, I had a bit of advance ... :)
I was running on what correspong to sparse-next now:
	97ebb3459 use VOID instead of directly using &void_pseudo
plus the _whole_ llvm serie I had posted,
plus a few more patches without functional effects.

> It would come as no surprise (I guess) that 'git bisect' fingers
> commit 0c12ac32af ("llvm: fix translation of PSEUDO_VALs into a
> ValueRefs", 05-03-2017).

Sure, it must.
And the problem didn't appears on my side because another patch in the
serie solved the problems you & Chris have seen:
	33ac15536 give a type to OP_PHISOURCE

I'll reorder a few patches and this should be solved.

-- Luc
