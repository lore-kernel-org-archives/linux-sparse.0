From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: fun with ?:
Date: Wed, 23 May 2007 16:32:55 +0100
Message-ID: <20070523153255.GA4095@ftp.linux.org.uk>
References: <20070519025249.GZ4095@ftp.linux.org.uk> <4653633B.3000000@freedesktop.org> <20070522224619.GI4095@ftp.linux.org.uk> <46537BC1.9000808@freedesktop.org> <20070523000234.GJ4095@ftp.linux.org.uk> <20070523142544.GB2547@daikokuya.co.uk> <20070523143202.GY4095@ftp.linux.org.uk> <20070523144716.GC2547@daikokuya.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:47066 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756276AbXEWPc5 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 23 May 2007 11:32:57 -0400
Content-Disposition: inline
In-Reply-To: <20070523144716.GC2547@daikokuya.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Neil Booth <neil@daikokuya.co.uk>
Cc: Josh Triplett <josh@freedesktop.org>, linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

On Wed, May 23, 2007 at 11:47:16PM +0900, Neil Booth wrote:
> > gcc integer constant expressions handling is a bad joke.
> > 
> > extern int n;
> > struct {
> > 	int x : 1 + n - n;
> > } y;
> > 
> > passes with -pedantic -std=c99.  Replacing that with 1 + n - n + n - n
> > is still OK with gcc; 1 + n + n - n - n is not.
> > 
> > So that's hardly an example of, well, anything.
> 
> Consistency?  :-)  I wasn't aware of the quirk of the second example.
> 
> Apparently these expressions are only folded if their net result
> is obvious as parsed by the grammar.  Fixing this in GCC is a
> horrendous amount of work; so much internal logic relies on this
> early simplification, which is why it's not been done I guess.

With sparse that's easier - we have parsing and typechecking separated
enough.  And yes, blind evaluate + expand will suffer similar problems.
However, it's not hard to have evaluate_expression() to set a flag
when it steps into a construct prohibited in integer constant expressions.
BTW, immediate cast from float is not hard - you need all casts other than
under sizeof go to integer type *and* you need any operations involving
floating point types to set "not an integer constant expression".  Since
comma and function calls are also banned, float will either go all
way up or it will be eaten by cast.

BTW, the fun question is whether (int)(1.1) is allowed; the same goes
for "is ((void *)0) a null pointer constant".  6.5.1 is sloppy ;-)
