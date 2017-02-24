From: Matthew Wilcox <willy@infradead.org>
Subject: Re: Unreachable code diagnostic
Date: Fri, 24 Feb 2017 13:05:51 -0800
Message-ID: <20170224210551.GC16328@bombadil.infradead.org>
References: <20170224180759.GB16328@bombadil.infradead.org>
 <20170224185707.jll2n5634hju7vy6@x>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:52131 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751163AbdBXVFx (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 24 Feb 2017 16:05:53 -0500
Content-Disposition: inline
In-Reply-To: <20170224185707.jll2n5634hju7vy6@x>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: linux-sparse@vger.kernel.org

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

Ah, yes, thanks.  I didn't actually try to compile the patch I was
sent ... I was just bemused that the compiler didn't warn about this
"obvious" wrongness.  So I wrote a test-case, which of course didn't have
any lock annotations.  rcu_read_lock()/unlock() are correctly annotated
and applying the patch I sent produces a sparse (and not gcc) warning.
So I've asked the submitter to run sparse in future.

(of course, this means they have to ignore all the *other* pre-existing
sparse warnings, but that's not the fault of anyone on this mailing list)
