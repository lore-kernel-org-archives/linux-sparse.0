From: Kamil Dudka <kdudka@redhat.com>
Subject: Re: linearize bug?
Date: Sat, 27 Aug 2011 13:34:17 +0200
Message-ID: <201108271334.17659.kdudka@redhat.com>
References: <4E588EB8.80808@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:1029 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751114Ab1H0Lhw (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sat, 27 Aug 2011 07:37:52 -0400
In-Reply-To: <4E588EB8.80808@garzik.org>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>, Pekka J Enberg <penberg@cs.helsinki.fi>, Linus Torvalds <torvalds@linux-foundation.org>

On Saturday 27 August 2011 08:29:12 Jeff Garzik wrote:
> While trying to implement loops in LLVM, the following testcase appears
> to have some strange behavior:
>
> int foo(int x)
> {
> 	int i;
>
> 	for (i = 0; i < 10; i++)
> 		x += 42;
>
> 	return x;
> }
>
> when run through test-linearize produces
>
> foo.c:1:5: warning: symbol 'foo' was not declared. Should it be static?
> foo:
> .L0x7f4c095ae010:
> 	<entry-point>
> 	phisrc.32   %phi2(x) <- %arg1
> 	phisrc.32   %phi4(x) <- %arg1
> 	phisrc.32   %phi7(i) <- $0
> 	br          .L0x7f4c095ae150
>
> .L0x7f4c095ae150:
> 	phi.32      %r1(i) <- %phi7(i), %phi8(i)
> 	setlt.32    %r2 <- %r1(i), $10
> 	br          %r2, .L0x7f4c095ae060, .L0x7f4c095ae100
>
> .L0x7f4c095ae060:
> 	add.32      %r5 <- %r9, $42
> 	phisrc.32   %phi3(x) <- %r5
> 	phisrc.32   %phi5(x) <- %r5
> 	add.32      %r8 <- %r1(i), $1
> 	phisrc.32   %phi8(i) <- %r8
> 	br          .L0x7f4c095ae150
>
> .L0x7f4c095ae100:
> 	phi.32      %r9 <- %phi2(x), %phi3(x)
> 	ret.32      %r9
>
> So...  WTF did %r9 come from, in the third basic block?

Two years ago I proposed a patch that I believe would solve your problem:

https://patchwork.kernel.org/patch/40307/

Kamil
