From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Add __builtin_popcountl
Date: Thu, 26 Oct 2006 11:56:00 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610261153510.3962@g5.osdl.org>
References: <20061026174730.GE5591@parisc-linux.org> <20061026184301.GJ29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:11207 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1423485AbWJZS4P (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 26 Oct 2006 14:56:15 -0400
In-Reply-To: <20061026184301.GJ29920@ftp.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Matthew Wilcox <matthew@wil.cx>, linux-sparse@vger.kernel.org



On Thu, 26 Oct 2006, Al Viro wrote:
> 
> AFAICS, that's way over the top.  That kind of stuff is needed only
> when builtin can't be described as a normal function.  This, OTOH...

On the other hand, adding "true" builtin functions is actually a lot 
cheaper than adding bogus code to be parsed explicitly.

So I'd actually prefer a way to have a table to describe and initialize 
these things, as a way to make it a lot more efficient, and without the 
silly preprocessor buffer hacks..

The preprocessor hack is certainly simple, but it's not what you really 
want in real life.

		Linus
