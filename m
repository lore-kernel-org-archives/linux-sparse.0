From: Josh Triplett <josht@linux.vnet.ibm.com>
Subject: Re: [RFC] bloody mess with __attribute__() syntax
Date: Fri, 06 Jul 2007 12:29:27 -0700
Message-ID: <1183750167.2613.36.camel@josh-work.beaverton.ibm.com>
References: <20070705093528.GK21478@ftp.linux.org.uk>
	 <468D1003.1050901@freedesktop.org>
	 <20070705164334.GM21478@ftp.linux.org.uk>
	 <1183661456.2604.43.camel@josh-work.beaverton.ibm.com>
	 <20070706074803.GV21478@ftp.linux.org.uk>
	 <468DFE5A.8080602@freedesktop.org>
	 <20070706155245.GX21478@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:40392 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760442AbXGFT3T (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 6 Jul 2007 15:29:19 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l66JTJPS015003
	for <linux-sparse@vger.kernel.org>; Fri, 6 Jul 2007 15:29:19 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l66JTJUK249228
	for <linux-sparse@vger.kernel.org>; Fri, 6 Jul 2007 13:29:19 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l66JTICD000586
	for <linux-sparse@vger.kernel.org>; Fri, 6 Jul 2007 13:29:18 -0600
In-Reply-To: <20070706155245.GX21478@ftp.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Josh Triplett <josh@freedesktop.org>, linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

On Fri, 2007-07-06 at 16:52 +0100, Al Viro wrote:
> On Fri, Jul 06, 2007 at 01:33:30AM -0700, Josh Triplett wrote:
> > Al Viro wrote:
> > > On Thu, Jul 05, 2007 at 11:50:56AM -0700, Josh Triplett wrote:
> > >> No, I mean __attribute__((context(...))), which means something
> > >> different.  __context__() works as a statement statement changing the
> > >> context.  __attribute__((context(...))) works as an attribute modifying
> > >> a type to say that it requires a given context, and that
> > >> accessing/calling it changes the context.  Somewhat of an odd
> > >> distinction, but sparse currently works that way.
> > >  
> > > That's actually not a qualifier from the syntax point of view...
> > > It makes sense *only* on function types - we simply ignore it
> > > on anything else.
> > 
> > For now, yes.  I intend to make use of the context attribute on arbitrary
> > pointers or data.  For example, I want to specify that you must hold a given
> > lock in order to access a structure field, and enforce that context when you
> > access the field.
> 
> What kind of annotations on functions do you expect to need for that
> enforcing?

The existing context annotations should suffice for many cases.
compiler.h will need new wrappers for cases like requiring a lock.  For
a very simple example:

compiler.h:
#define require_context(x) __attribute__((context(x,1,1))

magic_device.c:
DEFINE_SPINLOCK(device_lock);
struct the_device the_device require_context(device_lock);

void f(void)
{
	spin_lock(device_lock);
	frobulate(the_device.guts);
	spin_unlock(device_lock);
}

When Sparse sees an access to the_device.guts, it will check for a
device_lock context >= 1.

The same thing will work for functions which require the context:

void g(void) require_context(device_lock)
{
	glork(the_device.fnord);
}

In this case, Sparse will enforce the context on calls to g(), and then
assume the context inside g().

For special cases like preemption and RCU, which lack a lock expression
but still represent a distinct lock, how about:

compiler.h:
#ifdef __CHECKER__
#define fake_context(x) extern const int x
#else
#define fake_context(x)
#endif

preempt.h:
fake_context(preemption);
#define preempt_disable() ... __acquire(preemption)
#define preempt_enable() ... __release(preemption)
#define might_sleep_attr() ... /* something */

In this case, the "at least this value" semantic for the precondition
makes it hard to write the assertion we want.  I *almost* wonder if we
should just change this into something more like real code:

__compile_time_assert__(__context(preemption) == 0)
__something_else__(__context(preemption)++)
__something_else__(__context(preemption)--)

That would make the hard cases much easier, and the easy cases equally
hard. :)

Issues will also arise for other cases, such as referring to another
lock in the same structure, or a lock elsewhere in the parameter list of
a function.  I think this could work fairly easily by introducing some
additional scopes for looking up symbols in a context expression.

> > For functions, yes.  In the case of pointers or data, I do want the context
> > attribute to work like a qualifier: you might want to apply it to a pointer,
> > or to the pointer target, or to a structure field, or an entire structure...
> 
> I'm not sure I like the idea of having the same qualifier mean very
> different things on functions and data objects ["gets locks" vs. "needs
> locks"]...
> 
> > If foo requires context x, and bar requires context y, then (n ? foo : bar)();
> > *might* require context x and *might* require context y.
> 
> ... the hell?  On functions it's not about "requires", it's about "changes".

Both:
__attribute__((context(x,0,1))) means "you need not hold x before, but
you will hold one more of x after".
__attribute__((context(x,1,0))) means "you must already hold x, and you
will no longer hold x after".
__attribute__((context(x,1,1))) means "you must already hold x, and you
will continue to hold x".

Sparse does not yet enforce all of these conditions.  Also, the "at
least this value" semantic for the precondition makes it hard to use
contexts for things like "this blocks" and "may not block in this
context".  As I said, it needs work.  However, I intend for it to mean
*exactly* the same thing on functions or variables, except that in the
former case it means "when called", and in the latter case it means
"when accessed".  In both cases, you can require a context and change
the context.

> > See above.  Eventually we might have advanced dataflow analysis deriving
> > attributes for us; for now, function pointers will need explicit contexts.
> 
> How do you compare two contexts for equality?

A fine question.  In the simple cases, "same symbol" will work fairly
well; certainly better than the current "always equal" comparison. :)
Ideally, however, you want "refers to the same value".  Alias analysis
could do a fairly good job of that, I think.

> > Currently ignored, yes.  I certainly hope that providing a context expression
> > proves sufficient to specify a context.  Yes, problems arise if you need to do
> > complex unification of context expressions, but I *think* that we can handle
> > the simpler cases first and the complicated cases as needed.  If you have any
> > suggestions that might improve context checking, I'd love to discuss them with
> > you.
> 
> What do you call simpler cases?  A constant being a context expression?

That definitely qualifies, but I imagined "simple" as up to and
including bare symbols with no operators.

See above regarding more complicated cases.

- Josh Triplett
