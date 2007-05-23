From: Neil Booth <neil@daikokuya.co.uk>
Subject: Re: fun with ?:
Date: Wed, 23 May 2007 23:25:44 +0900
Message-ID: <20070523142544.GB2547@daikokuya.co.uk>
References: <20070519025249.GZ4095@ftp.linux.org.uk> <4653633B.3000000@freedesktop.org> <20070522224619.GI4095@ftp.linux.org.uk> <46537BC1.9000808@freedesktop.org> <20070523000234.GJ4095@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from v035086.ppp.asahi-net.or.jp ([124.155.35.86]:7447 "HELO
	daikokuya.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1755343AbXEWOZi (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 23 May 2007 10:25:38 -0400
Content-Disposition: inline
In-Reply-To: <20070523000234.GJ4095@ftp.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Josh Triplett <josh@freedesktop.org>, linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

Al Viro wrote:-

> > Sparse constant folding here?  If so, and if you really think this case
> > matters, let's have an option to turn on this constant folding, and warn
> > whenever we see it.
> 
> Usual sparse constant folding is _almost_ OK, provided that we play a bit
> with evaluate_expression() and let it decide if subexpression is an integer
> constant expression.  No prototype changes, we just get a global flag
> and save/restore it around sizeof argument handling and several other
> places.  It's actually pretty easy.  And if we get "it is an integer
> constant expression", well, then caller can call expand stuff.
> 
> "Almost" bit above refers to another bit of insanity, fortunately easily
> handled; we need division by zero to raise no error and just yield "the
> entire thing is not an integer constant expression with value 0".  That's
> exactly what longjmp() is for...

I respect you too much Al to doubt you, but I do warn you that
getting the rules for integer constant expressions right in C is
harder than it looks.  GCC is not very close.  The immediate
cast of float bit painful in recursive descent parsers.  I've managed
to find cases where Comeau's online compiler doesn't get it right,
and they're pretty good.

I have a test suite that tests these things to an unhealthy level of
pedantry for my own implementation (the only one I know passes the lot,
of course 8-); happy to run sparse when you've finished if you like.

Neil.
