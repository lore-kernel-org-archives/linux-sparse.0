From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 0/8] avoid creating orphaned OP_PHISRCs
Date: Thu, 18 May 2017 19:04:26 +0200
Message-ID: <20170518170425.ozrccywqkkglpgd6@desk.local>
References: <20170413165551.2785-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:34620 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932938AbdERREa (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 18 May 2017 13:04:30 -0400
Received: by mail-wm0-f51.google.com with SMTP id 70so12639830wmq.1
        for <linux-sparse@vger.kernel.org>; Thu, 18 May 2017 10:04:29 -0700 (PDT)
Received: from desk.local ([2a02:a03f:82d:ce00:702e:d47b:4e6:a8c8])
        by smtp.gmail.com with ESMTPSA id n55sm3003681edd.65.2017.05.18.10.04.27
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 May 2017 10:04:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170413165551.2785-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Another problem with the creation and placement of phi-nodes
is with some code like:
	#define	CHECK(t,  c, N)	\
		t = ptr[N];	\
		if (t)		\
			c++;

	int foo(int *ptr);
	int foo(int *ptr)
	{
		int c = 0;
		int t;

		CHECK(t, c, 0x000);
		CHECK(t, c, 0x001);

		return c;
	}

which will be linearized as:
	foo:
		load.32     %r2 <- 0[%arg1]
		phisrc.32   %phi2(c) <- $0
		phisrc.32   %phi5(c) <- $0
		cbr         %r2, .L1, .L2
	.L1:
		phisrc.32   %phi3(c) <- $1
		phisrc.32   %phi6(c) <- $1
		br          .L2
	.L2:
		load.32     %r7 <- 4[%arg1]
		cbr         %r7, .L3, .L4
	.L3:
		phi.32      %r9 <- %phi5(c), %phi6(c)
		add.32      %r10 <- %r9, $1
		phisrc.32   %phi4(c) <- %r10
		br          .L4
	.L4:
		phi.32      %r11 <- %phi2(c), %phi3(c), %phi4(c)
		ret.32      %r11

This is with the last phi-node and the placement of its phisrcs.
- .L4 has 2 parents, .L2 & .L3, so the phi-node should have 2 sources
- the 2 sources should be placed (at the end of) .L2 & L3
- only %phi4 is really well placed
- %phi3 is not placed at .L2 but before (which is fine too)
- the real problem is with %phi2: all paths to .L4 go where %phi3
  & %phi4 are defined, so %phi2 is in fact dead and should never
  be a source for the last phi-node.
There is worst though, here the CHECK is only two times.
If called N times, the last phi-node will have N sources
(while still having only 2 reaching paths), quadratic behaviour
thus (at N=300, the show_instruction() buffer is too small, at
N=2000 it needs 50 secs of processing).
Note that the CHECK macro is called here with the array ptr and the
problem may seem a bit artificial since it's like a manual loop
unrolling, but I can very well imagine some similar code called
not on the array elements but on a few functions (checking for
some ressources availability for example).

-- Luc
