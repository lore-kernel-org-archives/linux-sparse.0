From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: Re: [PATCH 1/2] sparse, llvm: group PHI nodes at the top of each BB
Date: Tue, 16 Oct 2012 22:14:26 +0200
Message-ID: <20121016201426.GD2932@debian.debian>
References: <1349825676-1713-1-git-send-email-j.neuschaefer@gmx.net>
 <5074BD6B.2090501@pobox.com>
 <CAOJsxLF2AqK2N_R876jOOVmkHXyhe_OjyP_xfULUF5PAfKogMw@mail.gmail.com>
 <20121010163306.GA2846@debian.debian>
 <CAOJsxLE=UsuonXVPuDxL9jPGQj_M5xdvCUrk5u+m3U-s4Ao-hA@mail.gmail.com>
 <CAOJsxLEEBYMF4qcyBSpS7kaumzpQFm0McNexRtft3UJVwp==Xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:42861 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753123Ab2JPUOa (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 16 Oct 2012 16:14:30 -0400
Content-Disposition: inline
In-Reply-To: <CAOJsxLEEBYMF4qcyBSpS7kaumzpQFm0McNexRtft3UJVwp==Xg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pekka Enberg <penberg@kernel.org>
Cc: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, Jeff Garzik <jgarzik@pobox.com>, linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>

On Tue, Oct 16, 2012 at 08:59:27PM +0300, Pekka Enberg wrote:
> On Fri, Oct 12, 2012 at 9:25 PM, Pekka Enberg <penberg@kernel.org> wrote:
> > Sounds plausible but I'm still uneasy with the idea that LLVM backend
> > needs to reshuffle instructions like this.

Actually, the situation of Phi nodes in LLVM is actually slightly more
complex: They require "one pair (of value and BB) for each predecessor
basic block of the current block"[1]. This mean that we'll sometimes
need to insert phi nodes into BBs that don't directly use a value.
Consider the following piece of C code:

	extern int done(void);
	extern void foo(int);

	static void test(void) {
		int i;
		for (i = 0; ; i++) {
			if (done())
				break;
			foo(i);
		}
	}

Running it through test-linearize exhibits the problem:
[ I renamed the basic blocks to L0-L3 to increase readability. ]

	test:
	.L0:
		<entry-point>
		phisrc.32   %phi2(i) <- $0
		br          .L1

	.L1:
		call.32     %r1 <- done
		br          %r1, .L3, .L2

	.L2:
		phi.32      %r2(i) <- %phi2(i), %phi3(i)
		call        foo, %r2(i)
		add.32      %r4 <- %r2(i), $1
		phisrc.32   %phi3(i) <- %r4
		br          .L1

	.L3:
		ret

To comply with the "LLVM rules" we'd need to move the phi intruction up
into "L1".


regards,
Jonathan
