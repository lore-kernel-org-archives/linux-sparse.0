From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH] Add __builtin_popcountl
Date: Thu, 26 Oct 2006 20:19:41 +0100
Message-ID: <20061026191941.GK29920@ftp.linux.org.uk>
References: <20061026174730.GE5591@parisc-linux.org> <20061026184301.GJ29920@ftp.linux.org.uk> <Pine.LNX.4.64.0610261153510.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:30856 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1422739AbWJZTTq
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 26 Oct 2006 15:19:46 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610261153510.3962@g5.osdl.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Matthew Wilcox <matthew@wil.cx>, linux-sparse@vger.kernel.org

On Thu, Oct 26, 2006 at 11:56:00AM -0700, Linus Torvalds wrote:
> 
> 
> On Thu, 26 Oct 2006, Al Viro wrote:
> > 
> > AFAICS, that's way over the top.  That kind of stuff is needed only
> > when builtin can't be described as a normal function.  This, OTOH...
> 
> On the other hand, adding "true" builtin functions is actually a lot 
> cheaper than adding bogus code to be parsed explicitly.
> 
> So I'd actually prefer a way to have a table to describe and initialize 
> these things, as a way to make it a lot more efficient, and without the 
> silly preprocessor buffer hacks..
> 
> The preprocessor hack is certainly simple, but it's not what you really 
> want in real life.

Well...  Keep in mind that those _are_ functions; i.e. unlike something
like __builtin_choose_expr() you can pass such puppy to a function
expecting a callback, etc.

So it's not enough to special-case them; we really need types for those
symbols.  I don't think that it will be more efficient in the end.
