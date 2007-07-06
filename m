From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [RFC] bloody mess with __attribute__() syntax
Date: Fri, 6 Jul 2007 16:52:45 +0100
Message-ID: <20070706155245.GX21478@ftp.linux.org.uk>
References: <20070705093528.GK21478@ftp.linux.org.uk> <468D1003.1050901@freedesktop.org> <20070705164334.GM21478@ftp.linux.org.uk> <1183661456.2604.43.camel@josh-work.beaverton.ibm.com> <20070706074803.GV21478@ftp.linux.org.uk> <468DFE5A.8080602@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:41839 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757804AbXGFPwv (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 6 Jul 2007 11:52:51 -0400
Content-Disposition: inline
In-Reply-To: <468DFE5A.8080602@freedesktop.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: Josh Triplett <josht@linux.vnet.ibm.com>, linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

On Fri, Jul 06, 2007 at 01:33:30AM -0700, Josh Triplett wrote:
> Al Viro wrote:
> > On Thu, Jul 05, 2007 at 11:50:56AM -0700, Josh Triplett wrote:
> >  
> >> No, I mean __attribute__((context(...))), which means something
> >> different.  __context__() works as a statement statement changing the
> >> context.  __attribute__((context(...))) works as an attribute modifying
> >> a type to say that it requires a given context, and that
> >> accessing/calling it changes the context.  Somewhat of an odd
> >> distinction, but sparse currently works that way.
> >  
> > That's actually not a qualifier from the syntax point of view...
> > It makes sense *only* on function types - we simply ignore it
> > on anything else.
> 
> For now, yes.  I intend to make use of the context attribute on arbitrary
> pointers or data.  For example, I want to specify that you must hold a given
> lock in order to access a structure field, and enforce that context when you
> access the field.

What kind of annotations on functions do you expect to need for that
enforcing?
 
> For functions, yes.  In the case of pointers or data, I do want the context
> attribute to work like a qualifier: you might want to apply it to a pointer,
> or to the pointer target, or to a structure field, or an entire structure...

I'm not sure I like the idea of having the same qualifier mean very
different things on functions and data objects ["gets locks" vs. "needs
locks"]...
 
> If foo requires context x, and bar requires context y, then (n ? foo : bar)();
> *might* require context x and *might* require context y.

... the hell?  On functions it's not about "requires", it's about "changes".

> See above.  Eventually we might have advanced dataflow analysis deriving
> attributes for us; for now, function pointers will need explicit contexts.

How do you compare two contexts for equality?

> Currently ignored, yes.  I certainly hope that providing a context expression
> proves sufficient to specify a context.  Yes, problems arise if you need to do
> complex unification of context expressions, but I *think* that we can handle
> the simpler cases first and the complicated cases as needed.  If you have any
> suggestions that might improve context checking, I'd love to discuss them with
> you.

What do you call simpler cases?  A constant being a context expression?
