From: Bernd Petrovitsch <bernd@petrovitsch.priv.at>
Subject: Re: Defect in linearization of short circuit &&
Date: Wed, 17 Feb 2010 12:47:38 +0100
Message-ID: <1266407258.11294.194.camel@thorin>
References: <4B77FD0F.50401@googlemail.com>
	 <4B78655D.2080007@googlemail.com>
	 <70318cbf1002141509u4ebc4ef5x51ec41f5f1452a7a@mail.gmail.com>
	 <4B799CA6.70807@googlemail.com>
	 <70318cbf1002151141p35e49f92l73510d09452f56ee@mail.gmail.com>
	 <4B79AC03.4010608@googlemail.com>
	 <70318cbf1002151311g103dbc27q3b89ae9804747684@mail.gmail.com>
	 <1266312482.3433.33.camel@thorin>
	 <70318cbf1002161102n63995222o914299dd358f594d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from esgaroth.petrovitsch.at ([78.47.184.11]:33793 "EHLO
	esgaroth.petrovitsch.priv.at" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754028Ab0BQLrv (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 17 Feb 2010 06:47:51 -0500
In-Reply-To: <70318cbf1002161102n63995222o914299dd358f594d@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Jacek =?UTF-8?Q?=C5=9Aliwerski?= <sliwers@googlemail.com>, linux-sparse@vger.kernel.org

On Die, 2010-02-16 at 11:02 -0800, Christopher Li wrote:
> On Tue, Feb 16, 2010 at 1:28 AM, Bernd Petrovitsch
> <bernd@petrovitsch.priv.at> wrote:
> >> $ ./test-linearize parser_check.c
> >> parser_check:
> >> .L0x7f4e12de3130:
> >>       <entry-point>
> >>       br          %arg1, .L0x7f4e12de32e0, .L0x7f4e12de3250
> > I assume this means "if %arg1 == NULL goto .L0x7f4e12de32e0 else goto .L0x7f4e12de3250"
> 
> That is right.
> 
> > I assume this is the "i > 0" check.
> 
> No, this is the not the i > 0 check yet. This is setting the expression value
> of the false branch to 0.
> 
> >>       phisrc.1    %phi2 <- $0
> >>       br          .L0x7f4e12de3298
> >>
> >> .L0x7f4e12de3298:
> >>       phi.1       %r8 <- %phi1, %phi2
> >>       setgt.32    %r10 <- %arg2, $0
> 
> This is the "i > 0" check. (%arg2 is "i")
> 
> >>       and-bool.1  %r11 <- %r8, %r10
> >>       br          %r11, .L0x7f4e12de3178, .L0x7f4e12de31c0
> >>
> >> .L0x7f4e12de3178:
> >>       call        execute_a, %arg1, %arg2
> >>       br          .L0x7f4e12de3328
> >>
> >> In the fast test, the false branch is L0x7f4e12de3250.
> >> Which is doing the (i > 0) part and it is safe to do so.
> 
> > Are saying that he "i >0 " test done while "st == NULL"?
> > This is actually wrong as it shouldn't be done (independent of the used
> > variables and especially if the expression has side effects).
> 
> That is right. "i > 0" is still being tested.
> 
> Consider this example. The same source code and be compile into two
> different piece of machine code. They produce the exact same result.
> The one with this optimization runs faster than the other one. Do you still
> thing that is wrong? How about x86 CPU internally re-ordering the instruction,
No. The above is the conceptual point of view as it's the definition
(for the C programming language).
As long as the outside observed behaviour is as if the "i > 0" (in this
example) has never been executed (IOW: any side effect didn't show up),
it's correct.
"Speculative execution" works that way.
> is that wrong too?
As long as the program behaves as if it did not happen, it' correct. So
calculating all conditions in parallel is IMHO fine as long as any
"writeback operation" (which are outside relevant) happen if and only if
the conditions were "true" (in the above example).

> So I think as long as this behavior is *internal* and *correct*. It is fine.
I think we are actually in violent agreement. I got the impression that
this was a general strategy (and not where all parts of the && sequence
are side-effect free).

> Of course it'd better be faster as well. Otherwise, what is the point.
Yup.

> The goal of the this optimization is trading the branch instruction
> with cheaper arithmetic instruction.
> 
> For modern CPU, the branch instruction is likely more expensive
> than normal arithmetic instruction. In X86, branch instruction *might*
> flush the instruction pipe line while arithmetic operation can usually done
> in one cycle.
> 
> That is why this optimization is using a cost model. If the left hand
> side cost is lower than the branch instruction cost, and it is *safe* to
> do so. It turn the branch instruction into arithmetic instruction.
> 
> However, in this case, the optimization did not consider this expression
> is used in the if statement, and if statement has build-in branch instruction
> associate with it. So this optimization might not worthy while here.
> 
> But for this expression:
> 
> a = st && st->foo && st->bar && i > 0;
> 
> This optimization might be worth while.
ACK. But this example has no side effect (assuming no preprocessor
trickery, no "volatile" somewhere relevant, etc.) so it' not
"dangerous".
Above I was talking about the general case.

> If the optimization produce incorrect result. That is fatal and that
> is a serious bug.
> I just want to confirm that is no the case here.

	Bernd
-- 
Bernd Petrovitsch                  Email : bernd@petrovitsch.priv.at
                     LUGA : http://www.luga.at

