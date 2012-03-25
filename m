From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Killing off __cond_lock()
Date: Sun, 25 Mar 2012 10:48:30 +0200
Message-ID: <1332665310.3840.8.camel@jlt3.sipsolutions.net>
References: <1332606216.16159.48.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:47387 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753372Ab2CYIsi (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 25 Mar 2012 04:48:38 -0400
In-Reply-To: <1332606216.16159.48.camel@twins>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@freedesktop.org>, linux-sparse@vger.kernel.org, Anton Vorontsov <anton.vorontsov@linaro.org>

Hi,

> struct anon_vma *page_lock_anon_vma(struct page *page)
> 	__cond_acquires(RCU) 
> 	__cond_acquires(page_lock_anon_vma(page)->root->lock);
> 
> Meaning that if the return value is true (non-zero), it would acquire
> that lock/context. One could of course add some shorter means of
> referring to the return value, but simply using the function in the
> expression should be simple enough.
> 
> In order to implement this I guess we need to extend the
> __attribute__((context(expr,in,out))) thing. 
> 
> Currently in,out are explicit value constants, but I guess if we make
> them expressions we could evaluate them and get dynamic behaviour.
> 
> Thus allowing something like:
> 
> int spin_trylock(spinlock_t *lock)
> 	__attribute__((context(lock, 0, !!spin_trylock(lock));
> 
> meaning that the context would be incremented by 1 if the return value
> were true.
> 
> Having only briefly looked at the sparse source, is this feasible to
> implement or do we get chicken/egg problems wrt using a function before
> its declaration is complete, and referring a return value before the
> function is part of an expression?
> 
> If this yields problems, are there better ways of solving this issue?

I once looked at all of this (which I suspect you saw, given that you're
CC'ing me) but all my changes ended up being reverted since they broke
things so maybe I'm not the right person to ask ... :-)

I played with having a "RETURN" builtin (or something like that) to use
inside here but it didn't really work out well, I don't think that was
what ended up going upstream though.

However, I don't think using the function call etc. is a good idea, to
me that makes it look too much like you could put arbitrary code there,
but since this doesn't even exist at runtime ...

However, note that today sparse doesn't evaluate anything in the
context, it doesn't even look at the first argument. So another thing
you can't really annotate well is things like this:

struct foo_object *get_locked_object(...);

This is why I used RETURN to give the return value a name, so you could
write
	__acquires(&RETURN->lock)


But I was also trying to make sparse actually evaluate the first
argument so it could tell the difference between two locks, which you
might not even care about ... (it would be nice though I think)

johannes

