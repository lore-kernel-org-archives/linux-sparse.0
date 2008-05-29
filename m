From: David Brownell <david-b@pacbell.net>
Subject: Re: sparse context warning problem ...
Date: Thu, 29 May 2008 02:39:13 -0700
Message-ID: <200805290239.13436.david-b@pacbell.net>
References: <200805101724.04014.david-b@pacbell.net> <200805140658.04018.david-b@pacbell.net> <1212050823.16917.37.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp117.sbc.mail.sp1.yahoo.com ([69.147.64.90]:30877 "HELO
	smtp117.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752379AbYE2JjP (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 29 May 2008 05:39:15 -0400
In-Reply-To: <1212050823.16917.37.camel@johannes.berg>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-sparse@vger.kernel.org, Josh Triplett <josh@freedesktop.org>

On Thursday 29 May 2008, Johannes Berg wrote:
> 
> > > means to lock "&ohci->lock" when doing "spin_lock(&ohci->lock);" but
> > > will treat it as locking the abstractly-named "lock" context, while on
> > > UP/no-preempt the "spin_lock" macro is expanded by the preprocessor and
> > > you will get "&ohci->lock" as the expression.
> > 
> > Yeah, well the lock being acquired or released *IS* "ohci->lock",
> > but the spinlock calls don't take the lock, they take pointers
> > to it!
> > 
> > If you were to argue that understanding pointers like that is a
> > lot to demand of "sparse", I might agree.  But that won't change
> > the fact that locks themselves are not pointers to locks.  ;)
> 
> Yeah, I agree the locks aren't pointers, but really, it is a lot easier
> for you to do that annotation than for sparse to figure it out.

I was fairly sure you'd argue that!


> I blame these problems on whoever implemented sparse context tracking in
> the first place, documented the optional first expression parameter and
> then didn't write any code for looking at the expression at all.

Yeah, that Torvalds clown is always leaving stuff unfinished.  ;)


> static inline void netif_tx_lock_bh(struct net_device *dev)
> 	__acquires(&dev->_xmit_lock)
> {
>         spin_lock_bh(&dev->_xmit_lock);
>         dev->xmit_lock_owner = smp_processor_id();
> }
> 
> Conceptually, I think this is cleaner because inlines are treated more
> like real functions then, but you may disagree.

I disagree.  They *are* real functions, so treating them
as such is the only reasonable option!

(Note by the way a convenience there:  the lock is easily
described using just the function parameters.  I suspect
that will be common, but not always true ...)


Will it be possible to put annotations on methods declared
in ops vectors?  Just today I was cleaning up some locking
issues and had to start using a lock.  But I couldn't find
any clear statement about the call contexts for some of the
new lock/unlock calls ... I had to go look at other drivers
to see an answer (and hope they weren't buggy).  It would
have been nicer to just have "sparse" tell me the answers.

(If right now that seems more like a research problem, I'd
not be too surprised.  But I'd like to think that someday
it should be practical to have kernel lockdep tools tell
us about such things, and have such constraints verified
during builds.)

 
> The status quo, however, has turned out to be unacceptable to users
> because of the spinlock problem I mentioned above. Can we, based on an
> evaluation of the problems I just outlined, either apply the patches I'm
> about to send, or revert them to go back to the completely unchecked
> contexts?

Haven't seen the patches, but in principle I have no objection
to finishing the lock context code.  Fixing all the kernel code
to get better lock annotations will take time, but that's OK.

What's probably more important right now is to make sure the
annotations are simple and correct, so they can be built on
over time.

- Dave


