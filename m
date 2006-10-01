From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCHSET] fouled-bitwise handling
Date: Sun, 1 Oct 2006 17:45:13 +0100
Message-ID: <20061001164513.GW29920@ftp.linux.org.uk>
References: <E1GU1od-0006tu-Oo@ZenIV.linux.org.uk> <Pine.LNX.4.64.0610010906030.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:18146 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751263AbWJAQpO
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sun, 1 Oct 2006 12:45:14 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610010906030.3952@g5.osdl.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-sparse@vger.kernel.org

On Sun, Oct 01, 2006 at 09:21:21AM -0700, Linus Torvalds wrote:
> The only reason I think you're doing it wrong is that you're using this 
> totally new separate mechanism for it (which is not a bad mechanism, but 
> it's very much a special case), and you should not need to!
 
> The fact is, regardless of any bitwise issues, the
> 
> 	(cast) narrower-type <op> (wider-type "&" (cast) narrower-type)
> 
> should _always_ be simplified to a small-type.
 
Sure.  Now try to carry that to more complex expressions.
 
> And I _think_ we should be able to do exactly the same for this one, by 
> simply noticing that doing a
> 
> 	(widening-cast) a == b & (widening-cast) c
> 
> is by definition throwing away the higher bits on both sides, and we can 
> just turn it into the simpler
> 
> 	a == c & (narrowing-cast) b
> 
> instead. Of course, we can only do this with ops that don't have overflow 
> from the narrower type (but comparisons and bitops are ok).
> 
> No?

At which phase would you do that?  We assign types pretty much leaves
to root - type of node is derived from the types of children.

Now, you suggest basically going *other* way.  I.e. noticing that
we have
	<complex expression in narrow> & <complex expression in wide>
and trying to propagate narrowing down another subexpression.

Note that we need *both* arguments typed - we don't know which one
might be narrow here.  So it's really re-evaluation of subexpression.

OK, so we have expand phase that could do that.  _However_, we'd have
to postpone the bitwise checks until that phase, or we'd get them
anyway.  And that is not to mention the fun with evaluate_expression()
mangling the tree, so re-walking it won't be easy.

IOW, I very much prefer to deal with that by _existing_ mechanism;
namely, the type assignment.  It's easier to propagate the information
along with the rest of type information, in the direction we are
already doing.
