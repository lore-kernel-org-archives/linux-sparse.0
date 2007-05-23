From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: fun with ?:
Date: Wed, 23 May 2007 01:25:06 +0100
Message-ID: <20070523002506.GK4095@ftp.linux.org.uk>
References: <20070519025249.GZ4095@ftp.linux.org.uk> <4653633B.3000000@freedesktop.org> <20070522224619.GI4095@ftp.linux.org.uk> <46537BC1.9000808@freedesktop.org> <20070523000234.GJ4095@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:36035 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757669AbXEWAZH (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 22 May 2007 20:25:07 -0400
Content-Disposition: inline
In-Reply-To: <20070523000234.GJ4095@ftp.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

On Wed, May 23, 2007 at 01:02:34AM +0100, Al Viro wrote:
> Moral: void * -> int * may lose parts of value and trigger undefined behaviour;
> int * -> void * loses information about type, is always revertible and always
> safe.  In assignment operator it's your responsibility to make sure that
> void * you are converting to int * is properly aligned (anything that started
> its life as int * will be).  In ?: C could
> 	* lose type information, allowing any values (result is void *); if
> you are sure that it's well-aligned, you can cast void * argument to int *
> or cast the result.
> 	* require the void * argument to be well-aligned, keep the type.
> 
> The former makes more sense...

PS: that's a design decision that had to be made back when void * got added
to the language and it had to work for all architectures.  IOW, the text
above is explanation why it had to be done that way and why we have to
stick to it on all targets.

> > I see.  I find it very strange that (void *)0 and (void *)(void *)0 have
> > different behavior.  I also find it strange that conditional expressions can't
> > convert void * to an arbitrary pointer as assignment can.
> 
> It would be nicer if C had __null__ as the *only* null pointer constant
> (with flexible type) and could refuse to accept anything else.  Too late
> for that, unfortunately.  As for conversions - see above.

To clarify: all mess with null pointer constants comes from lack of
explicit token and need to avoid massive breakage of old programs.  That's
what it's all about - compiler recognizing some subexpressions as
representations of that missing token and trying to do that in a way that
would break as little as possible of existing C code.  It's an old story -
decisions had to be made in 80s and now we are stuck with them.

IOW, (void *)0 in contexts that allow null pointer constant is *not* a
0 cast to pointer to void; it's a compiler-recognized kludge for __null__.
And it's not a pointer to void.  It can become a pointer to any type,
including void.  If converted to a pointer type it gives the same value
you get if you convert 0 to that type ("null pointer to type").  But
unlike null pointer to type it retains full flexibility.

NULL is required to expand to null pointer constant and that's one of
the reasons why sane code should be using it instead of explicitly spelled
variants.  The next best thing to actually having __null__ in the language...
