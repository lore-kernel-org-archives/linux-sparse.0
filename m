From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: fun with ?:
Date: Wed, 23 May 2007 05:53:19 +0100
Message-ID: <20070523045319.GL4095@ftp.linux.org.uk>
References: <20070519025249.GZ4095@ftp.linux.org.uk> <4653633B.3000000@freedesktop.org> <20070522224619.GI4095@ftp.linux.org.uk> <46537BC1.9000808@freedesktop.org> <20070523000234.GJ4095@ftp.linux.org.uk> <20070523002506.GK4095@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:57494 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754888AbXEWExU (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 23 May 2007 00:53:20 -0400
Content-Disposition: inline
In-Reply-To: <20070523002506.GK4095@ftp.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

On Wed, May 23, 2007 at 01:25:06AM +0100, Al Viro wrote:
> To clarify: all mess with null pointer constants comes from lack of
> explicit token and need to avoid massive breakage of old programs.  That's
> what it's all about - compiler recognizing some subexpressions as
> representations of that missing token and trying to do that in a way that
> would break as little as possible of existing C code.  It's an old story -
> decisions had to be made in 80s and now we are stuck with them.
> 
> IOW, (void *)0 in contexts that allow null pointer constant is *not* a
> 0 cast to pointer to void; it's a compiler-recognized kludge for __null__.
> And it's not a pointer to void.  It can become a pointer to any type,
> including void.  If converted to a pointer type it gives the same value
> you get if you convert 0 to that type ("null pointer to type").  But
> unlike null pointer to type it retains full flexibility.

PPS: original idiom for that sucker was, of course, simply 0.  My
understanding (and I'm seriously risking playing wrongbot here, so
take it with big grain of salt) is that raise of "cast 0 to pointer"
idiom was mostly due to targets where sizeof(pointer) > sizeof(int); there
the lack of prototypes meant that passing 0 in pointer argument would
do the wrong thing.  I _think_ it predates the introduction of void *, but
not by much; 32V source is available, so that would be a useful data point.
When use of void * stopped being serious portability issue it became the
best variant in that family (the most type-neutral of available options).
Then (void *)0 went into Feb 86 ANSI draft as acceptable alternative for null
pointer constant (i.e. recognized by compiler and converted to type
appropriate by context).

BTW, note that null pointer constant is *not* recognized in variable part
of argument list when you are calling a vararg function, so there you
get what you get - integer-type 0 or null pointer to void.  Which may
make life bloody interesting wrt portability.  Fortunately, these days
userland headers tend to have NULL defined to (void *)0 or integer 0
of the right size, so you are probably OK as long as you use
va_arg(..., void *) to get it, but $DEITY help you if you pass NULL
in vararg in place of pointer to function - on minimally weird targets
it will be ugly.  I don't think that sparse can catch that kind of
braindamage, though...
