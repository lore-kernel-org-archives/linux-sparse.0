From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: SSSA and some C pointer manipulation.
Date: Wed, 23 Aug 2017 03:03:11 +0200
Message-ID: <20170823010309.rlumcq556aueqqji@ltop.local>
References: <CANeU7Qm-k0xzRXwVx0bSg688+yFTa_PrC7EnKdyJY8HCWZT-uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:35411 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752619AbdHWBDP (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 22 Aug 2017 21:03:15 -0400
Received: by mail-wm0-f45.google.com with SMTP id r187so5007718wma.0
        for <linux-sparse@vger.kernel.org>; Tue, 22 Aug 2017 18:03:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7Qm-k0xzRXwVx0bSg688+yFTa_PrC7EnKdyJY8HCWZT-uw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

On Fri, Aug 18, 2017 at 10:46:13PM -0400, Christopher Li wrote:
> Hi Luc,
> 
> I have done the first round of reading your 29 patches.
> It is actually very nice organized. Thanks for the effort
> to make this review so easy to digest.
> 
> One thing I notices is that, if the use site is very far
> from define, there are a lot of blocks in between. That
> will cause a lot of possible phi node to be created.
> That plus the ptrmap will have some memory allocation
> over head. Might explain the 2% slow down.
> Compare to classic way to convert to SSA. The expansive
> part is doing the dominator tree. However that is mostly
> read, very few write. The SSA is doing a lot of write
> (creating phi node just in case it is needed.)
> 
> Another thing I just realized is that, this SSSA conversion
> only works for *local* variable, not C pointers?
> I want to construct some test source to verify.
> However it is not even working for the base case:
> 
> ================test 1.c=========

int a, b, c, d, e;

void foo(void)
{
	if (a)
		b = c;
	else
		b = d;
	if (c)
		a = b;
	if (b)
		e = a;
}

We should idealy have:
- loads of a, c & d
- store(s) of b
- load of c
- resue b's value
- the store of a = b
- reuse b's value
- resue a's value
- store e = a

What I have now for this is:
	foo:
	.L0:
		<entry-point>
		load.32     %r1(a) <- 0[a]
		cbr         %r1(a), .L1, .L2

	.L1:
		load.32     %r2(b) <- 0[c]
		store.32    %r2(b) -> 0[b]
		phisrc.32   %phi3 <- %r2(b)
		br          .L3

	.L2:
		load.32     %r3 <- 0[d]
		store.32    %r3 -> 0[b]
		phisrc.32   %phi4 <- %r3
		br          .L3

	.L3:
		phi.32      %r9(b) <- %phi3, %phi4
		load.32     %r4 <- 0[c]
		select.32   %r8(a) <- %r4, %r9(b), %r1(a)
		cbr         %r4, .L4, .L5

	.L4:
		store.32    %r9(b) -> 0[a]
		br          .L5

	.L5:
		cbr         %r9(b), .L6, .L8

	.L6:
		store.32    %r8(a) -> 0[e]
		br          .L8

	.L8:
		ret


For comparison, what -rc5 gives is:
	foo:
	.L0:
		<entry-point>
		load.32     %r1(a) <- 0[a]
		phisrc.32   %phi1(a) <- %r1(a)
		cbr         %r1(a), .L1, .L2

	.L1:
		load.32     %r2(b) <- 0[c]
		store.32    %r2(b) -> 0[b]
		phisrc.32   %phi3(c) <- %r2(b)
		phisrc.32   %phi4(b) <- %r2(b)
		phisrc.32   %phi7(b) <- %r2(b)
		phisrc.32   %phi9(b) <- %r2(b)
		br          .L3

	.L2:
		load.32     %r3 <- 0[d]
		store.32    %r3 -> 0[b]
		phisrc.32   %phi5(b) <- %r3
		phisrc.32   %phi8(b) <- %r3
		br          .L3

	.L3:
		load.32     %r4 <- 0[c]
		cbr         %r4, .L4, .L5

	.L4:
		phi.32      %r5 <- %phi7(b), %phi8(b)
		store.32    %r5 -> 0[a]
		phisrc.32   %phi2(a) <- %r5
		phisrc.32   %phi6(b) <- %r5
		br          .L5

	.L5:
		phi.32      %r6 <- %phi4(b), %phi5(b), %phi6(b)
		cbr         %r6, .L6, .L7

	.L6:
		phi.32      %r7 <- %phi1(a), %phi2(a)
		store.32    %r7 -> 0[e]
		br          .L7

	.L7:
		ret


-- Luc
