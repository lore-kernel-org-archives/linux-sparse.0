From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: fun with ?:
Date: Wed, 23 May 2007 01:02:34 +0100
Message-ID: <20070523000234.GJ4095@ftp.linux.org.uk>
References: <20070519025249.GZ4095@ftp.linux.org.uk> <4653633B.3000000@freedesktop.org> <20070522224619.GI4095@ftp.linux.org.uk> <46537BC1.9000808@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:60319 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757603AbXEWACf (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 22 May 2007 20:02:35 -0400
Content-Disposition: inline
In-Reply-To: <46537BC1.9000808@freedesktop.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

On Tue, May 22, 2007 at 04:24:49PM -0700, Josh Triplett wrote:
> Makes sense, except that in C you can assign a void pointer to an arbitrary *
> without a warning, so why can't conditional expressions do the equivalent?

{in sparse it's obviously not true due to address_space, but that hadn't
affected C standard decisions; the rest applies to standard C}

For one thing, no, you can't (pointers to functions have every right to
be unrelated to void *).  For another, you are not guaranteed that
conversion from void * to int * will not yield undefined behaviour.
It is OK if the value of void * is properly aligned; then you know
that conversion back to void * will give the original pointer.  Otherwise
you are in nasal demon country.  The other way round (int * to void *
to int *) you are always safe.

Rationale: systems that have pointers to words and char smaller than word.
There you can very well have pointers to void and pointers to less-than-word
objects bigger than pointers to anything word-sized or bigger (e.g. they
can be represented as word address + bit offset).  Conversion to the latter
will lose offset and compiler is allowed to throw up on that at runtime.

Moral: void * -> int * may lose parts of value and trigger undefined behaviour;
int * -> void * loses information about type, is always revertible and always
safe.  In assignment operator it's your responsibility to make sure that
void * you are converting to int * is properly aligned (anything that started
its life as int * will be).  In ?: C could
	* lose type information, allowing any values (result is void *); if
you are sure that it's well-aligned, you can cast void * argument to int *
or cast the result.
	* require the void * argument to be well-aligned, keep the type.

The former makes more sense...
 
> > Again, null pointer constant is not the same thing as null pointer to void.
> 
> I see.  I find it very strange that (void *)0 and (void *)(void *)0 have
> different behavior.  I also find it strange that conditional expressions can't
> convert void * to an arbitrary pointer as assignment can.

It would be nicer if C had __null__ as the *only* null pointer constant
(with flexible type) and could refuse to accept anything else.  Too late
for that, unfortunately.  As for conversions - see above.
 
> > BTW, there's another painful area: what do we do to somebody who uses
> > (void *)(69 + 1 - 70) as null pointer constant?  Currenly sparse doesn't
> > recognize it as such; C standard does.  IMO the right thing to do is
> > to add a flag that would switch to full-blown standard rules in that area
> > ("integer constant expression returning 0" instead of basically "0 in some
> > layers of ()") and flame to the crisp any wanker caught at actually doing
> > that.  Any suggestions re sufficiently violent warning messages?
> 
> I didn't know that the C standard actually *required* constant folding.
> Interesting.  Would it add excessively to compilation time to apply the usual
> Sparse constant folding here?  If so, and if you really think this case
> matters, let's have an option to turn on this constant folding, and warn
> whenever we see it.

Usual sparse constant folding is _almost_ OK, provided that we play a bit
with evaluate_expression() and let it decide if subexpression is an integer
constant expression.  No prototype changes, we just get a global flag
and save/restore it around sizeof argument handling and several other
places.  It's actually pretty easy.  And if we get "it is an integer
constant expression", well, then caller can call expand stuff.

"Almost" bit above refers to another bit of insanity, fortunately easily
handled; we need division by zero to raise no error and just yield "the
entire thing is not an integer constant expression with value 0".  That's
exactly what longjmp() is for...

Speaking of C standard, if you need access to the current one - yell.
