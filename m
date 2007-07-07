From: Josh Triplett <josht@linux.vnet.ibm.com>
Subject: Re: [RFC] bloody mess with __attribute__() syntax
Date: Fri, 06 Jul 2007 19:28:03 -0700
Message-ID: <1183775283.2613.168.camel@josh-work.beaverton.ibm.com>
References: <20070705093528.GK21478@ftp.linux.org.uk>
	 <468D1003.1050901@freedesktop.org>
	 <20070705164334.GM21478@ftp.linux.org.uk>
	 <1183661456.2604.43.camel@josh-work.beaverton.ibm.com>
	 <20070706074803.GV21478@ftp.linux.org.uk>
	 <468DFE5A.8080602@freedesktop.org>
	 <20070706155245.GX21478@ftp.linux.org.uk>
	 <1183750167.2613.36.camel@josh-work.beaverton.ibm.com>
	 <20070707021152.GA21668@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:37653 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753519AbXGGC16 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 6 Jul 2007 22:27:58 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l672RthU023149
	for <linux-sparse@vger.kernel.org>; Fri, 6 Jul 2007 22:27:55 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l672Rt5K177110
	for <linux-sparse@vger.kernel.org>; Fri, 6 Jul 2007 20:27:55 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l672Rsak010581
	for <linux-sparse@vger.kernel.org>; Fri, 6 Jul 2007 20:27:55 -0600
In-Reply-To: <20070707021152.GA21668@ftp.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Josh Triplett <josh@freedesktop.org>, linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

On Sat, 2007-07-07 at 03:11 +0100, Al Viro wrote:
> On Fri, Jul 06, 2007 at 12:29:27PM -0700, Josh Triplett wrote:
> > The existing context annotations should suffice for many cases.
> > compiler.h will need new wrappers for cases like requiring a lock.  For
> > a very simple example:
> > 
> > compiler.h:
> > #define require_context(x) __attribute__((context(x,1,1))
> > 
> > magic_device.c:
> > DEFINE_SPINLOCK(device_lock);
> > struct the_device the_device require_context(device_lock);
> 
> *ugh*
> 
> More ugly syntax...

Open to suggestions; just basing it on the existing syntax defined by
compiler.h.

> > compiler.h:
> > #ifdef __CHECKER__
> > #define fake_context(x) extern const int x
> > #else
> > #define fake_context(x)
> > #endif
> > 
> > preempt.h:
> > fake_context(preemption);
> > #define preempt_disable() ... __acquire(preemption)
> > #define preempt_enable() ... __release(preemption)
> > #define might_sleep_attr() ... /* something */
> 
> Still not expressive enough...  Consider e.g.
> 
> struct foo *lookup_foo(char *s); // lookup by name, return NULL if failed
> 				 // or pointer to struct foo with ->mutex
> 				 // held.  Caller should unlock.
> 
> It's legitimate, not particulary rare and AFAICS can't be expressed.

Very true; conditional locking doesn't work so well with Sparse.
Currently, you *can* express it with a bit of a hack; see the cond_lock
macro, used for spin_trylock.  Sparse will then correctly handle this:
if(spin_trylock(...)) {
	...
	spin_unlock(...);
}

That got me thinking about the idea I suggested of just using
compile-time asserts and increments/decrements.  I dunno whether that
has any hope of working or not, but it would certainly give you
expressiveness.  You might need some magic syntax to say "the return
value".

> > Sparse does not yet enforce all of these conditions.  Also, the "at
> > least this value" semantic for the precondition makes it hard to use
> > contexts for things like "this blocks" and "may not block in this
> > context".  As I said, it needs work.  However, I intend for it to mean
> > *exactly* the same thing on functions or variables, except that in the
> > former case it means "when called", and in the latter case it means
> > "when accessed".  In both cases, you can require a context and change
> > the context.
> 
> _What_ change in case of objects?

I don't immediately see the use case for changing the context when you
access an object.  I can vaguely imagine some case like "if you change
this field, you must later call this function", or vice versa.

> > A fine question.  In the simple cases, "same symbol" will work fairly
> > well; certainly better than the current "always equal" comparison. :)
> > Ideally, however, you want "refers to the same value".  Alias analysis
> > could do a fairly good job of that, I think.
> 
> Not particulary useful, since for
> 	int foo(struct bar *p) __acquires(&p->lock);
> 	int bar(struct bar *p) __acquires(&p->lock);
> you will get false negative in (n ? foo : bar) *and* it will persist even if
> you go for
> 	int foo(struct bar *p) __acquires(p);
> 	int bar(struct bar *p) __acquires(p);
> since you will have different symbols (same name, different scopes) here.

Not necessarily.  You need to substitute the actual arguments for the
formal arguments when you look at the context expression.  Given
sufficiently good analysis, you could figure this case out; in
(n ? foo : bar)(p), both cases want to acquire &p->lock, or p in the
latter case.

- Josh Triplett
