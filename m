From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [RFC] bloody mess with __attribute__() syntax
Date: Sun, 8 Jul 2007 22:50:15 +0100
Message-ID: <20070708215015.GN21668@ftp.linux.org.uk>
References: <20070705093528.GK21478@ftp.linux.org.uk> <468D1003.1050901@freedesktop.org> <20070705164334.GM21478@ftp.linux.org.uk> <1183661456.2604.43.camel@josh-work.beaverton.ibm.com> <20070706074803.GV21478@ftp.linux.org.uk> <468DFE5A.8080602@freedesktop.org> <20070706155245.GX21478@ftp.linux.org.uk> <1183750167.2613.36.camel@josh-work.beaverton.ibm.com> <20070707021152.GA21668@ftp.linux.org.uk> <1183775283.2613.168.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:44680 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758577AbXGHVuT (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 8 Jul 2007 17:50:19 -0400
Content-Disposition: inline
In-Reply-To: <1183775283.2613.168.camel@josh-work.beaverton.ibm.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josht@linux.vnet.ibm.com>
Cc: Josh Triplett <josh@freedesktop.org>, linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

On Fri, Jul 06, 2007 at 07:28:03PM -0700, Josh Triplett wrote:
> > 	int foo(struct bar *p) __acquires(p);
> > 	int bar(struct bar *p) __acquires(p);
> > since you will have different symbols (same name, different scopes) here.
> 
> Not necessarily.  You need to substitute the actual arguments for the
> formal arguments when you look at the context expression.  Given
> sufficiently good analysis, you could figure this case out; in
> (n ? foo : bar)(p), both cases want to acquire &p->lock, or p in the
> latter case.

baz = n ? foo : bar;
