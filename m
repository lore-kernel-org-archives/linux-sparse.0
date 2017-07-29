From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Infinite loop with OOM while testing Sparse on Wine code
Date: Sat, 29 Jul 2017 16:39:15 +0200
Message-ID: <20170729143914.amo3vkoiqv7rkvmz@ltop.local>
References: <a4d23510-5bd4-9d88-f7a8-731882744043@mykolab.com>
 <CANeU7QnEui=yTjf+=TYU89mEhOrOj3b3X_W0csxJJ-eLRokWcg@mail.gmail.com>
 <CANeU7Qk37weXva_-_M4bXeTTAT-DYGcccy+6jYv8pO6gzZNLcA@mail.gmail.com>
 <CANeU7Qkm_V8cYW3yKKBHo6PY9r0CA+XoTfJCVZbcOS14Am_PiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:37007 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753728AbdG2OjT (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 29 Jul 2017 10:39:19 -0400
Received: by mail-wm0-f52.google.com with SMTP id t201so16558740wmt.0
        for <linux-sparse@vger.kernel.org>; Sat, 29 Jul 2017 07:39:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7Qkm_V8cYW3yKKBHo6PY9r0CA+XoTfJCVZbcOS14Am_PiA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Michael Stefaniuc <mstefani@mykolab.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Wed, Jul 19, 2017 at 09:26:29AM -0400, Christopher Li wrote:

OK I finally had the time to look at this closely.

> On Tue, Jul 18, 2017 at 8:07 PM, Christopher Li <sparse@chrisli.org> wrote:
> > ======================
> > test_menu_iteminfo:
> > .L0:
> >         <entry-point>
> >         phisrc.32   %phi3(ansi) <- $1
> >         br          .L1
> >
> > .L1:
> >         phi.32      %r1(ansi) <- %phi3(ansi), %phi4(ansi)
> >         cbr         %r1(ansi), .L4, .L5
> >
> > .L4:
> >         cast.64     %r3 <- (64) stringA
> >         br          .L5
> >
> > .L5:
> >         cbr         %r1(ansi), .L6, .L2
> >
> > .L6:
> >         ptrcast.64  %r6 <- (64) %r3
> >         ptrcast.64  %r8 <- (64) VOID
> >         call.64     %r9 <- strcpy, %r6, %r8
> >         br          .L2   <=============== L2 merge with L7
> >
> > .L2:
> >         seteq.32    %r11 <- %r1(ansi), $0
> >         phisrc.32   %phi4(ansi) <- %r11
> >         cbr         %r1(ansi), .L1, .L3
> >
> > .L3:
> >         ret
> > ======================
> > test_menu_iteminfo:
> > .L0:
> >         <entry-point>
> >         br          .L4 <========= phisrc3 get optimize away. This seems wrong
> 
> I see more what is going on there now.
> Basically we have %phi3 = 1, a constant.
> There for when control flow go from L0->L1, %r1 = %phi3 = 1.
> It will go to L4 for sure.
> 
> So L0 modify to goto L4 directly. That is fine.

Indeed, it's fine.
 
> >
> > .L1:
> >         phi.32      %r1(ansi) <- VOID, %phi4(ansi) <======= this seems wrong.
> >         cbr         %r1(ansi), .L4, .L5
> 
> phisrc3 has only one usage on L1. phisrc3 can be optimize away
> and replace it with value 1. Showing VOID there is wrong.

No it's fine. It's the way of displaying that the element have been removed.

> it should be:
> 
> phi.32 %r1(ansi) <- 1, %phi4(ansi)

No, not really.
L1 has now only a single parent, the phi-node is now a trivial one,
not really a join anymore.
An explicit way of displaying it should simply be:
	phi.32      %r1(ansi) <- %phi4(ansi)
 
Everything is correct until:
	test_menu_iteminfo:
	.L0:
		<entry-point>
		br          .L4
	.L1:
		phi.32      %r1(ansi) <- VOID, %phi4(ansi)
		cbr         %r1(ansi), .L4, .L5
	.L4:
		cast.64     %r3 <- (64) stringA
		br          .L5
	.L5:
		cbr         %r1(ansi), .L6, .L3
	.L6:
		ptrcast.64  %r6 <- (64) %r3
		ptrcast.64  %r8 <- (64) VOID			<== wrong but unrelated
		call.64     %r9 <- strcpy, %r6, %r8
		br          .L2
	.L2:
		seteq.32    %r11 <- %r1(ansi), $0
		phisrc.32   %phi4(ansi) <- %r11
		cbr         %r1(ansi), .L1, .L3
	.L3:
		ret

Then simplify_branch_branch() is called on L2 -> L1
and wrongly succeed giving:
	.L0:
	        <entry-point>
	        br          .L4
	.L1:
	        phi.32      %r1(ansi) <- VOID, %phi4(ansi)	<== now dead
	        cbr         %r1(ansi), .L4, .L5
	.L4:
	        cast.64     %r3 <- (64) stringA
	        br          .L5
	.L5:
	        cbr         %r1(ansi), .L6, .L3
	.L6:
	        ptrcast.64  %r6 <- (64) %r3
		ptrcast.64  %r8 <- (64) VOID			<== wrong but unrelated
	        call.64     %r9 <- strcpy, %r6, %r8
	        br          .L2
	.L2:
	        seteq.32    %r11 <- %r1(ansi), $0
	        phisrc.32   %phi4(ansi) <- %r11
	        cbr         %r1(ansi), .L4, .L3			<== bad change
	.L3:
	        ret

This will then trigger the wrong simplifications:
	%phi4 <- %r11
and
	%r1   <- %r11
giving finally:
	        setne.32    %r11 <- %r11, $0

As far as I can see, simplify_branch_branch() needs something
like the bb_defines_phi() I had to add to try_to_simplify_bb()
(basically it's bb_depends_on() which is not 'strong' enough).

I'll need a bit more time to see exactly what is needed, for
example if we can simply reuse bb_defines_phi() or not, and
to test all this.

At this point I don't think anymore that the revert is the most
appropriate thing to do.

-- Luc
