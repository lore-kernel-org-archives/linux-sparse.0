From: Josh Triplett <josht@linux.vnet.ibm.com>
Subject: Re: Odd sparse behaviour
Date: Mon, 07 Jul 2008 10:48:32 -0700
Message-ID: <1215452912.3003.27.camel@josh-work.beaverton.ibm.com>
References: <48713A18.7050103@cowlark.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e4.ny.us.ibm.com ([32.97.182.144]:58175 "EHLO e4.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754036AbYGGRsc (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 7 Jul 2008 13:48:32 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m67HmV0F025821
	for <linux-sparse@vger.kernel.org>; Mon, 7 Jul 2008 13:48:31 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id m67HmVhP240956
	for <linux-sparse@vger.kernel.org>; Mon, 7 Jul 2008 13:48:31 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m67HmUZX025289
	for <linux-sparse@vger.kernel.org>; Mon, 7 Jul 2008 13:48:31 -0400
In-Reply-To: <48713A18.7050103@cowlark.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: David Given <dg@cowlark.com>
Cc: linux-sparse@vger.kernel.org, Alexey Zaytsev <alexey.zaytsev@gmail.com>

On Sun, 2008-07-06 at 22:33 +0100, David Given wrote:
> I've found a couple of places where sparse behaves rather oddly.
> 
> Firstly, if you declare something static, and then try to define it
> later, sparse appears to get confused:
> 
> ---snip---
> static int i;
> int i = 0;
> ---snip---
> 
> $ ./test-parsing test.c
> test.c:2:5: warning: symbol 'i' was not declared. Should it be static?
> 
> .align 4
> int static [signed] [toplevel] i,
> .align 4
> int [signed] [addressable] [toplevel] i =
> 	movi.32		v1,$0
> 
> Enumeration of the list of defined symbols shows two different symbols
> with the name 'i'. This isn't entirely obvious when using the test tools
> as, of course, two strings with the same value look the same! This is
> causing me issues with forward declarations of static functions:
> 
> static void foo();
> { ... foo(); ... }  // calls static foo
> 
> foo() {}            // defines extern foo
> { ... foo(); ... }  // calls extern foo
> 
> This then leads to link errors as static foo hasn't been found.

I've observed this problem before.  Alexey Zaytsev reported this as
well.  I think he may have a fix in the works.  Alexey?

> The second issue is with the following piece of C99 code:
> 
> ---snip---
> extern void nop(void)
> void bar(void)
> { for (int i=0; i<10; i++) nop(); }
> ---snip---
> 
> $ ./test-linearise test.c
> test.c:3:6: warning: symbol 'bar' was not declared. Should it be static?
> bar:
> .L0xb7d7600c:
> 	<entry-point>
> 	br          .L0xb7d76038
> 
> .L0xb7d76038:
> 	call        nop
> 	br          .L0xb7d76038
> 
> The for loop seems to silently turn into an infinite loop. Which did
> cause one of my benchmarks to, um, produce rather poor results...

No kidding.  An interesting bug.  Does this go away if you declare "int
i" at the top of the function?

> (You may be interested to know that my compiler is now producing
> working, running code for non-trivial apps. Big chunks of it do need
> throwing away and rewriting, but it's actually *working*!)

Awesome!

- Josh Triplett


