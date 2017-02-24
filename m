From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Unreachable code diagnostic
Date: Fri, 24 Feb 2017 20:56:55 +0100
Message-ID: <20170224195654.3cd7bc2dz5mzhnlh@macpro.local>
References: <20170224180759.GB16328@bombadil.infradead.org>
 <20170224185707.jll2n5634hju7vy6@x>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:38722 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751219AbdBXT47 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 24 Feb 2017 14:56:59 -0500
Received: by mail-wm0-f46.google.com with SMTP id r141so22582247wmg.1
        for <linux-sparse@vger.kernel.org>; Fri, 24 Feb 2017 11:56:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20170224185707.jll2n5634hju7vy6@x>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Matthew Wilcox <willy@infradead.org>, linux-sparse@vger.kernel.org

On Fri, Feb 24, 2017 at 10:57:07AM -0800, Josh Triplett wrote:
> On Fri, Feb 24, 2017 at 10:07:59AM -0800, Matthew Wilcox wrote:
> > I was recently sent some code that looked like this:
> > 
> > int foo()
> > {
> > 	lock();
> > 	return bar();
> > 	unlock();
> > }
> > 
> > When you're restructuring code that contains locks, this is a
> > *really* easy mistake to make.  I've done it myself.  But there's no
> > compiler warning for it!  gcc doesn't have it, sparse doesn't have it.
> 
> Sparse does have a warning (via -Wcontext) for this, if you annotate
> lock() and unlock() with __acquires(somelock) and __releases(somelock),
> which expand to __attribute__((context(somelock,0,1))) and
> __attribute__((context(somelock,0,1))) respectively.  You'll get a
> warning that foo() returns with the lock held.
> 
> Not at all perfect, but it does have reasonable handling of
> conditionals, including a way to handle cond_lock().

Absolutely, -Wcontext is even enabled by default.
So with what is done in the kernel, you have something like:
	#define __acquires(x)  __attribute__((context(x,0,1)))
	#define __releases(x)  __attribute__((context(x,1,0)))
	
	void lock(void) __acquires(lock);
	void unlock(void) __releases(lock);
	
	int bar(void);
	
	static int foo(void)
	{
	        lock();
	        return bar();
	        unlock();
	}

For which sparse returns the following warning:
	zz.c:9:5: warning: context imbalance in 'foo' - wrong count at exit

But of course, that's just for code properly lock/context annotated and I'm
not sure if what you're asking, which is much more general, is only motivated
by lock/unlock problems or by others problems too.

Luc Van Oostenryck
