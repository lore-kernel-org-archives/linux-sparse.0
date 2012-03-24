From: Peter Zijlstra <peterz@infradead.org>
Subject: Killing off __cond_lock()
Date: Sat, 24 Mar 2012 17:23:36 +0100
Message-ID: <1332606216.16159.48.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:41429 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752956Ab2CXQXt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 24 Mar 2012 12:23:49 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Johannes Berg <johannes@sipsolutions.net>, Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@freedesktop.org>
Cc: linux-sparse@vger.kernel.org, Anton Vorontsov <anton.vorontsov@linaro.org>

Hi all,

So the kernel has this __cond_lock() crap pile, which is implemented
like:

#define __acquire(x)       __context__(x,1)
#define __cond_lock(x,c)   ((c) ? ({ __acquire(x); 1; }) : 0)

Now the problem with this is that people send ugly patches like:

https://lkml.org/lkml/2012/3/24/57
http://www.spinics.net/lists/mm-commits/msg80386.html

That basically wrap an existing function in an inline function just to
use __cond_lock() on the return value.

It would be ever so much nicer if we could declare such functions like:

struct anon_vma *page_lock_anon_vma(struct page *page)
	__cond_acquires(RCU) 
	__cond_acquires(page_lock_anon_vma(page)->root->lock);

Meaning that if the return value is true (non-zero), it would acquire
that lock/context. One could of course add some shorter means of
referring to the return value, but simply using the function in the
expression should be simple enough.

In order to implement this I guess we need to extend the
__attribute__((context(expr,in,out))) thing. 

Currently in,out are explicit value constants, but I guess if we make
them expressions we could evaluate them and get dynamic behaviour.

Thus allowing something like:

int spin_trylock(spinlock_t *lock)
	__attribute__((context(lock, 0, !!spin_trylock(lock));

meaning that the context would be incremented by 1 if the return value
were true.

Having only briefly looked at the sparse source, is this feasible to
implement or do we get chicken/egg problems wrt using a function before
its declaration is complete, and referring a return value before the
function is part of an expression?

If this yields problems, are there better ways of solving this issue?
