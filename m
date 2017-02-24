From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: Unreachable code diagnostic
Date: Fri, 24 Feb 2017 10:57:07 -0800
Message-ID: <20170224185707.jll2n5634hju7vy6@x>
References: <20170224180759.GB16328@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:53194 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750995AbdBXS5Q (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 24 Feb 2017 13:57:16 -0500
Content-Disposition: inline
In-Reply-To: <20170224180759.GB16328@bombadil.infradead.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-sparse@vger.kernel.org

On Fri, Feb 24, 2017 at 10:07:59AM -0800, Matthew Wilcox wrote:
> I was recently sent some code that looked like this:
> 
> int foo()
> {
> 	lock();
> 	return bar();
> 	unlock();
> }
> 
> When you're restructuring code that contains locks, this is a
> *really* easy mistake to make.  I've done it myself.  But there's no
> compiler warning for it!  gcc doesn't have it, sparse doesn't have it.

Sparse does have a warning (via -Wcontext) for this, if you annotate
lock() and unlock() with __acquires(somelock) and __releases(somelock),
which expand to __attribute__((context(somelock,0,1))) and
__attribute__((context(somelock,0,1))) respectively.  You'll get a
warning that foo() returns with the lock held.

Not at all perfect, but it does have reasonable handling of
conditionals, including a way to handle cond_lock().
