From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [RFC] bloody mess with __attribute__() syntax
Date: Sat, 7 Jul 2007 03:11:52 +0100
Message-ID: <20070707021152.GA21668@ftp.linux.org.uk>
References: <20070705093528.GK21478@ftp.linux.org.uk> <468D1003.1050901@freedesktop.org> <20070705164334.GM21478@ftp.linux.org.uk> <1183661456.2604.43.camel@josh-work.beaverton.ibm.com> <20070706074803.GV21478@ftp.linux.org.uk> <468DFE5A.8080602@freedesktop.org> <20070706155245.GX21478@ftp.linux.org.uk> <1183750167.2613.36.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:50753 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753371AbXGGCLz (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 6 Jul 2007 22:11:55 -0400
Content-Disposition: inline
In-Reply-To: <1183750167.2613.36.camel@josh-work.beaverton.ibm.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josht@linux.vnet.ibm.com>
Cc: Josh Triplett <josh@freedesktop.org>, linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

On Fri, Jul 06, 2007 at 12:29:27PM -0700, Josh Triplett wrote:
> The existing context annotations should suffice for many cases.
> compiler.h will need new wrappers for cases like requiring a lock.  For
> a very simple example:
> 
> compiler.h:
> #define require_context(x) __attribute__((context(x,1,1))
> 
> magic_device.c:
> DEFINE_SPINLOCK(device_lock);
> struct the_device the_device require_context(device_lock);

*ugh*

More ugly syntax...

> compiler.h:
> #ifdef __CHECKER__
> #define fake_context(x) extern const int x
> #else
> #define fake_context(x)
> #endif
> 
> preempt.h:
> fake_context(preemption);
> #define preempt_disable() ... __acquire(preemption)
> #define preempt_enable() ... __release(preemption)
> #define might_sleep_attr() ... /* something */
 
Still not expressive enough...  Consider e.g.

struct foo *lookup_foo(char *s); // lookup by name, return NULL if failed
				 // or pointer to struct foo with ->mutex
				 // held.  Caller should unlock.

It's legitimate, not particulary rare and AFAICS can't be expressed.

> Sparse does not yet enforce all of these conditions.  Also, the "at
> least this value" semantic for the precondition makes it hard to use
> contexts for things like "this blocks" and "may not block in this
> context".  As I said, it needs work.  However, I intend for it to mean
> *exactly* the same thing on functions or variables, except that in the
> former case it means "when called", and in the latter case it means
> "when accessed".  In both cases, you can require a context and change
> the context.

_What_ change in case of objects?

> A fine question.  In the simple cases, "same symbol" will work fairly
> well; certainly better than the current "always equal" comparison. :)
> Ideally, however, you want "refers to the same value".  Alias analysis
> could do a fairly good job of that, I think.

Not particulary useful, since for
	int foo(struct bar *p) __acquires(&p->lock);
	int bar(struct bar *p) __acquires(&p->lock);
you will get false negative in (n ? foo : bar) *and* it will persist even if
you go for
	int foo(struct bar *p) __acquires(p);
	int bar(struct bar *p) __acquires(p);
since you will have different symbols (same name, different scopes) here.
