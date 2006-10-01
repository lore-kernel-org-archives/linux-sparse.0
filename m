From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCHSET] fouled-bitwise handling
Date: Sun, 1 Oct 2006 09:21:21 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610010906030.3952@g5.osdl.org>
References: <E1GU1od-0006tu-Oo@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:16588 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751234AbWJAQVf (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 1 Oct 2006 12:21:35 -0400
In-Reply-To: <E1GU1od-0006tu-Oo@ZenIV.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-sparse@vger.kernel.org



On Sun, 1 Oct 2006, Al Viro wrote:
> 
> This stuff comes from handling smaller-than-int bitwise types (e.g. __le16).
> The problem is in handling things like
> 	__be16 x, y;
> 	...
> 	if (x == (x & ~y))
> The code is bitwise-clean, but current sparse can't deduce that.

Al, I understand why you did it the way you did, but I think it's wrong.

Why do I think it's wrong? Let me count the ways.

Umm. Ok, I counted, and there's only one way.

The only reason I think you're doing it wrong is that you're using this 
totally new separate mechanism for it (which is not a bad mechanism, but 
it's very much a special case), and you should not need to!

The fact is, regardless of any bitwise issues, the

	(cast) narrower-type <op> (wider-type "&" (cast) narrower-type)

should _always_ be simplified to a small-type.

See? Even from a purely optimization angle, we're actually better off just 
noticing that the whole comparison can be done in the narrower type.

Imagine this piece of code:

	int mask;
	char c, *p;

	if (*p == (mask & c))

where there is no bitwise stuff, a good compiler should notice on its own 
that it should just be done in 8 bits rather than having to convert "c" 
and "*p" to integers.

And once you do that _generic_ optimization, your whole "fouled" thing is 
useless.

Btw, we _already_ do this optimization for a few cases, we just didn't do 
it for enough cases.  We do it purely for assignment statements, ie notice 
how git already does not warn for

	__le16 a, b;

	a = ~b;

exactly because we have done a simplification of

	a = (implicit cast back to __le16)~(implicit cast to int)b;

to just keeping everything in the narrower type..

See commit 4b6c2e63d3423931ac687f113882cec427df9f91 for details.

And I _think_ we should be able to do exactly the same for this one, by 
simply noticing that doing a

	(widening-cast) a == b & (widening-cast) c

is by definition throwing away the higher bits on both sides, and we can 
just turn it into the simpler

	a == c & (narrowing-cast) b

instead. Of course, we can only do this with ops that don't have overflow 
from the narrower type (but comparisons and bitops are ok).

No?

		Linus
