From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Over-eager code elimination?
Date: Tue, 20 Feb 2007 09:30:53 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702200818020.20368@woody.linux-foundation.org>
References: <1171967902.5848.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:41258 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965158AbXBTRbA (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 20 Feb 2007 12:31:00 -0500
In-Reply-To: <1171967902.5848.2.camel@localhost.localdomain>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dan Sheridan <djs@postman.org.uk>
Cc: linux-sparse@vger.kernel.org



On Tue, 20 Feb 2007, Dan Sheridan wrote:
> 
> So it thinks that both x and y are in %r2. However, if y is initialised,
> the assignment happens as expected.
> 
> Any ideas?

Heh. I think you found a nasty nasty bug.

I didn't look very closely, but using "-vv" shows the loads of 'y' have 
been turned into lnop's, which means that the dominance analysis decided 
that it could just replace all uses of 'y' with the (single) assignment to 
it. Basically, it decides that the 

	y = x;

assignment always dominates the use ("return x-y"), so it will happily 
have turned it into "return x-x" (and then it *should* have simplified 
that, but didn't - it's not a simplification pattern I ever added).

Looks like some totally nasty, and probably very fundamental dominance 
analysis bug. I *suspect* that what happens is simply that we create a 
phi-node for the load (rewrite_load_instruction), but then since there is 
only a single phi source associated with it, we simplify it to just use 
the pseudo directly.

Which is why adding the initialization hides the bug: suddenly there is 
more than one dominator, and the bogus optimization goes away.

(It's possible that the optimization happened even before the PHI node was 
even created: we have several layers of this, and I think you may even be 
hitting the "we have a single def for this variable, so replace all loads 
with that def even without doing any dominance analysis AT ALL" case)

I'll try to look at it, but I may not have the time. It looks like a 
fairly fundamental thinko, though.

		Linus
