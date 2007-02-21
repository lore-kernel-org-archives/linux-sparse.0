From: Christopher Li <sparse@chrisli.org>
Subject: Re: Over-eager code elimination?
Date: Wed, 21 Feb 2007 00:09:01 -0800
Message-ID: <20070221080901.GA3893@chrisli.org>
References: <1171967902.5848.2.camel@localhost.localdomain> <Pine.LNX.4.64.0702200818020.20368@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from alnrmhc11.comcast.net ([206.18.177.51]:61749 "EHLO
	alnrmhc11.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751198AbXBUIkW (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 21 Feb 2007 03:40:22 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0702200818020.20368@woody.linux-foundation.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dan Sheridan <djs@postman.org.uk>, linux-sparse@vger.kernel.org

On Tue, Feb 20, 2007 at 09:30:53AM -0800, Linus Torvalds wrote:
> 
> Looks like some totally nasty, and probably very fundamental dominance 
> analysis bug. I *suspect* that what happens is simply that we create a 
> phi-node for the load (rewrite_load_instruction), but then since there is 
> only a single phi source associated with it, we simplify it to just use 
> the pseudo directly.
> 
> Which is why adding the initialization hides the bug: suddenly there is 
> more than one dominator, and the bogus optimization goes away.

I think there is two problem here:

The first one is minor, 'y' can be used without initialized. 
We always give the 'y' the value as its last defined value.
Since not initialized value is not defined, I guess use the last
define one should be fine.

The second one is the bigger issue:

In simplify_one_symbol, we find out that the address of 'y' is not
taken, and y has only one store. So we happily go ahead replace
all the load with the define pseudo.

	/*
	 * Goodie, we have a single store (if even that) in the whole
	 * thing. Replace all loads with moves from the pseudo,
	 * replace the store with a def.
	 */

Notice that in this path, it uses convert_load_instruction instead
of rewrite_load_instruction. It does not do the phi stuff.

> (It's possible that the optimization happened even before the PHI node was 
> even created: we have several layers of this, and I think you may even be 
> hitting the "we have a single def for this variable, so replace all loads 
> with that def even without doing any dominance analysis AT ALL" case)

That is exactly what happened. But even if we use phi node here, it is
not correct. Because when it using the value of 'y', it is not using the latest
value of the phi node 'x'. It is using a old version of 'x' when "y = x;" happens.

It seems that we have to use a copy instruction here to save the old value of 'x'.

> I'll try to look at it, but I may not have the time. It looks like a 
> fairly fundamental thinko, though.

I take that as "I hope somebody else fix this so I don't have to." ;-)

Chris
