From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Potential incorrect simplification
Date: Tue, 28 Mar 2017 19:00:50 +0200
Message-ID: <20170328170049.2y6lwxx64yzjjwmc@macpro.local>
References: <CACXZuxeRXsYWgwihs1nmmTYaLoyhw+PDAy6jEemkZJFpySdfQA@mail.gmail.com>
 <CAExDi1TtcpZtnEV6ctyA9MacJA_9h4njmhd-MSA3KgOq8oK_gA@mail.gmail.com>
 <CACXZuxfxNNh+ThcT=7Xr98tToL2GimFi7UOTSwgNq6mfLLGNfA@mail.gmail.com>
 <20170328141113.kbrwdva6ttsrokts@macpro.local>
 <CACXZuxen9UFGNp8=-OQHoqRQJ5F__rwQoCJJ6TdkAo6HEXWOQw@mail.gmail.com>
 <CA+55aFx6g3-+6tJ_6Uqu4K1pQoDnqcXrjSGYsryLjjksEtT06A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:37566 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751882AbdC1RAz (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 28 Mar 2017 13:00:55 -0400
Received: by mail-wm0-f52.google.com with SMTP id x124so4129113wmf.0
        for <linux-sparse@vger.kernel.org>; Tue, 28 Mar 2017 10:00:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CA+55aFx6g3-+6tJ_6Uqu4K1pQoDnqcXrjSGYsryLjjksEtT06A@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Mar 28, 2017 at 09:20:58AM -0700, Linus Torvalds wrote:
> On Tue, Mar 28, 2017 at 7:19 AM, Dibyendu Majumdar
> <mobile@majumdar.org.uk> wrote:
> >
> > Well the unsimplified output is correct. The problem appears after
> > simplification.
> 
> No. The unsimplified output has the exact same bug:
> 
>   main:
>   .L0:
>         <entry-point>
>         load.32     %r1 <- 0[s3]
>         shl.32      %r2 <- $1, $6
>         and.32      %r3 <- %r1, $-65
> 
> That "load.32" loads an uninitialized value from the stack.
> 
> The simplification then just simplifies the uninitialized load to just
> be an uninitialized pseudo instead. Exact same code.
> 
> And arguably both unsimplified and simplified code is "correct" in the
> sense that it's exactly what the original source code does:
> 
>    s3.onebit = 1;
> 
> becomes
> 
>         and.32      %r3 <- %r4, $-65
>         or.32       %r4 <- %r3, $64
> 
> where that "and" is obviously pointless (well, "obviously" to a human,
> not so sparse ;), but it's basically the code sequence "leave the
> uninitialized bits alone, set bit 6 to 1". And then comes the *truly*
> stupid code that does
> 
>         lsr.32      %r6 <- %r4, $6
>         cast.32     %r7 <- (1) %r6
> 
> which is "shift bit 6 down to bit zero, and cast (aka sign-extend) the
> one-bit value to 32 bits" and then
> 
>         setne.32    %r8 <- %r7, $1
>         br          %r8, .L1, .L3
> 
> test if the result is 1, do a conditional branch on the result.
> 
> So the code is "correct". It may be confusing, because simplification
> turns a uninitialized load into just an uninitialized variable, and
> what also happens is that since SSA means that (by definition) every
> initialization dominates every use, we have this situation where the
> first assignment to the pseudo becomes the dominator of even the
> uninitialized *previous* use of the pseudo, which is why you see that
> odd sequence
> 
>         and.32      %r3 <- %r4, $-65
>         or.32       %r4 <- %r3, $64
> 
> which *initializes* the pseudo %r4 in the second instruction, but uses
> it in the first one. That's a classic pattern of uninitialized pseudos
> in sparse exactly because of the SSA logic.
> 
> But it is all internally consistent, and the simplification is
> "correct". The simplification phase very much has a "garbage in,
> garbage out" model.

I agree, of course, but I think there is a problem anyway.
The problem here with this %r4 is created by the single-store
shortcut which replace all loads with the same value as the one
used for the unique store (even loads that are not dominated
by the store). Fair enough, don't use uninitialized vars.

Now, if you remove this single-store shortcut and just let the normal
find_dominating_stores() do its job, the resulting code become
the expected:
	ret.32      $0

Not just by coincidence (I checked the intermediate steps):
sparse deduces then correctly that the value in the conditional
is always true and everything become dead after that.

But what annoys me really is that:
-) once you remove the single-store shortcut, it seems there is
   other problems (I just saw it by doing some code comparison,
   I need to create a few clear examples).
-) here the variable is always undefined, but once you have a var
   undefined in one path and defined in another one path and
   always used when defined then things become really messed up
   (misplaced phi-nodes). It happen for example with code like:
	int foo(int a, int b)
	{
		int var = 0;
		int r;
	
		if (a)
			var = 1;
		if (b)
			r = var;
	
		return r;		// undef if !b
	}
   Wich is perfectly defined when called with a non-zero b.
   I have reasons to believe it's totally unrelated issues though.

-- Luc Van Oostenryck
