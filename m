From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Question about Sparse Linear form and pseudos
Date: Sun, 20 Aug 2017 17:15:15 +0200
Message-ID: <20170820151513.ddoxdwo7iwd2nefh@ltop.local>
References: <CACXZuxd4iKbuvZZ5M0q=xRRDMpxc5UjXp=4+vBjvF8rjdV4-=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f169.google.com ([209.85.128.169]:34091 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753033AbdHTPPU (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 20 Aug 2017 11:15:20 -0400
Received: by mail-wr0-f169.google.com with SMTP id p14so10418909wrg.1
        for <linux-sparse@vger.kernel.org>; Sun, 20 Aug 2017 08:15:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACXZuxd4iKbuvZZ5M0q=xRRDMpxc5UjXp=4+vBjvF8rjdV4-=A@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Aug 20, 2017 at 03:54:47PM +0100, Dibyendu Majumdar wrote:
> Hi,
> 
> I am trying to get to grips with the Sparse Linear format and the use
> of pseudos.
> 
> 1) A Sparse document says that pseudos are akin to SSA variables. Is
> that a true statement - i.e. do pseudos follow the discipline that
> only one assignment to a pseudo is allowed. As pseudos have also
> different sub-types - does this statement apply to all pseudo types or
> only some sub types?
> 
> 2) In a recent conversation it was stated that the baseline Linear
> output from Sparse is already in SSA form. That implies that all
> pseudos used are in SSA form already. However we know that in the
> baseline line IR phi nodes may not be present. In LLVM the initial IR
> lacks phi nodes too - instead local stack memory and load/store
> sequences are used. However LLVM IR is still SSA at this stage. When
> it is said that the baseline Linear IR is already SSA is it in this
> sense?

One way to answer this with few words is to look at what's happening
to a variable assigned in different paths in a simple example:

	int f(void);

	int foo(int p)
	{
		int a;

		if (p) {
			a = 0;
			a++;
		} else {
			a = f();
		}

		return a;
	}


Just after linearization:
	foo:
	.L0:
		<entry-point>
		store.32    %arg1 -> 0[p]
		load.32     %r1 <- 0[p]
		cbr         %r1, .L1, .L2

	.L1:
		store.32    $0 -> 0[a]
		load.32     %r2 <- 0[a]
		add.32      %r3 <- %r2, $1
		store.32    %r3 -> 0[a]
		br          .L3

	.L2:
		call.32     %r4 <- f
		store.32    %r4 -> 0[a]
		br          .L3

	.L3:
		load.32     %r5 <- 0[a]
		ret.32      %r5


After conversion to SSA form:
	foo:
	.L0:
		<entry-point>
		cbr         %arg1, .L1, .L2

	.L1:
		add.32      %r3(a) <- $0, $1
		phisrc.32   %phi2(a) <- %r3(a)
		br          .L3

	.L2:
		call.32     %r4 <- f
		phisrc.32   %phi3(a) <- %r4
		br          .L3

	.L3:
		phi.32      %r5 <- %phi2(a), %phi3(a)
		ret.32      %r5


After simplification:
	foo:
	.L0:
		<entry-point>
		cbr         %arg1, .L1, .L2

	.L1:
		phisrc.32   %phi2(a) <- $1
		br          .L3

	.L2:
		call.32     %r4 <- f
		phisrc.32   %phi3(a) <- %r4
		br          .L3

	.L3:
		phi.32      %r5 <- %phi2(a), %phi3(a)
		ret.32      %r5


After going out of SSA (currently not used):
	foo:
	.L0
		<entry-point>
		cbr         %arg1, .L1, .L2

	.L1
		copy.32     %r7 <- $1
		br          .L3

	.L2
		call.32     %r7 <- f
		br          .L3

	.L3
		ret.32      %r7


-- Luc
