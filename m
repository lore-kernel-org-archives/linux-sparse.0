From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Bogus locking warnings
Date: Mon, 26 Feb 2007 20:19:36 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702262000460.12485@woody.linux-foundation.org>
References: <1172540552.5835.41.camel@dv>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:45727 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751477AbXB0ET0 (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 26 Feb 2007 23:19:26 -0500
In-Reply-To: <1172540552.5835.41.camel@dv>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
Cc: linux-sparse@vger.kernel.org



On Mon, 26 Feb 2007, Pavel Roskin wrote:
> 
> The current sparse issues a warning about this file:
> 
> void my_lock(void) __attribute__ ((context(lock, 0, 1)));
> void my_unlock(void) __attribute__ ((context(lock, 1, 0)));
> void foo(void);
> static void bar(const int locked)
> {
> 	if (!locked)
> 		my_lock();
> 	foo();
> 	if (!locked)
> 		my_unlock();
> }
> 
> 
> $ sparse test.c 
> test.c:10:3: warning: context imbalance in 'bar' - unexpected unlock
> 
> Commenting out foo() call eliminated the warning.  I understand that
> sparse suspects that foo() could change "locked".

Well, it's more complex than that.

Commenting out the "foo()" call actually allows sparse to do some trivial 
jump-following optimizations, so sparse will turn

	if (!locked)
		my_lock();
	if (!locked)
		my_unlock();

into just conditional branches, and notice that there is a conditional 
branch to an identical conditional, and basically just turn it into

	if (!locked) {
		mu_lock();
		my_unlock();
	}

and at that point sparse will see that there is obviously no problem.

HOWEVER. Sparse will *never* actually do any real dynamic "ahh, that lock 
depends on that conditional", and match up locks and unlocks under the 
same conditional with each other. 

> Changing "int locked" to "const int locked" makes no difference.  I
> don't see what else could be done to tell sparse that "locked" won't
> change throughout the function call.

Sparse sees perfectly well that "locked" doesn't change. There's just one 
assignment (the passing in of the argument), and that isn't the problem. 
It's simply that sparse does not do *any* dynamic analysis at all. 
Everything sparse does is purely static, and that very much includes code 
flow.

Yes, I could expand the flow graph, and make

	if (!locked)
		my_lock();
	call();
	if (!locked)
		my_unlock();

expand to

	if (!locked) {
		my_lock();
		call();
		my_unlock();
	} else {
		call();
	}

but the fact is, sparse doesn't do that (and doing it would be a disaster 
anyway, since in most real-world cases that kind of expansion thing is 
exponential in the conditionals, and you can't really do it for backwards 
jumps aka loops anyway).

So I would suggest that YOU make the code more amenable to static 
analysis. In other words, you can make locking more obvious by using 
clearer functions and doing conversions like the above explicitly. Not 
only will sparse stop complaining, because it will understand it better, 
but _people_ will usually understand conditional locking sequences better 
too if there is just _one_ conditional.

In general, doing flag-based stuff is crap. It generates worse code, and 
it's harder to debug, and we try to avoid it in the kernel. We did so even 
before sparse, but if you want to do lock analysis with sparse, it's 
doubly important.

> Something interesting happens if I change "!locked" to "locked" in both
> places:
> 
> $ sparse test.c 
> test.c:9:2: warning: context imbalance in 'bar' - different lock
> contexts for basic block
> 
> Although sparse doesn't know anything about the semantic of "locked", it
> issues different warnings whether the variable is used "positively" or
> "negatively".  No amount of paranoia about foo() can excuse this
> inconsistency.

That's a totally different thing. It just changes the order that the thing 
is linearized in, and you actually have TWO DIFFERENT BUGS as far as 
sparse is concerned:

	if (!locked)
		my_unlock();

will unlock something that HAS NOT BEEN STATICALLY SEEN TO BE LOCKED! In 
other words, as far as sparse is concerned, you are possibly unlocking 
something that isn't locked. The warning for that is "unexpected unlock".

But you have ANOTHER problem, as far as sparse can see, which is that when 
you do

	if (!locked)
		my_lock();
	call();

the basic block that contains the "call()" part will be entered either 
lockedor unlocked, and sparse tells you that you are doing something 
stupid by telling you that there is a context imbalance, and that the 
very same basic block is entered with two _different_ locking contexts. 

Which is really also true. The fact that you do so intentionally (and it 
may work out _dynamically_ correctly) doesn't matter to sparse. Sparse 
does static checking for correctness, it doesn't check that dynamic 
conditions hold true.

So depending on which basic block sparse happens to start looking at first 
(which in turn depends on what order it decided to linearize things in, 
which in turn depends on things like "was the conditional expression 
negated"), you get different warnings - but sparse will just show you one 
warning, because once it's shown one warning the others are irrelevant.

So sparse is right. If you want to check locks, do something like

 - write the "work function" to be always called with the lock held.

 - do a conditional helper function that is _statically_ seen to be ok 
   locking-wise:

	helper_function(..)
	{
		if (needs_lock) {
			int retval;
		
			my_lock();
			retval = work_function();
			my_unlock();
			return retval;
		}
		return work_function();
	}

   where now the locking is much easier to verify statically (not just for 
   sparse, either - it's more human-readable too, and quite possible will 
   even generate better code!)

and don't expect sparse to do any dynamic checking. It's expressly 
designed to *not* do that, although some of the static optimizations are 
clever enough that sometimes you are fooled into *thinking* that it 
actually understands dynamic behaviour (ie being able to statically follow 
a conditional jump to another identical conditional jump and simplify it 
to a single branch).

			Linus
