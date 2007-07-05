From: Josh Triplett <josht@linux.vnet.ibm.com>
Subject: Re: [RFC] bloody mess with __attribute__() syntax
Date: Thu, 05 Jul 2007 14:09:16 -0700
Message-ID: <1183669756.2604.117.camel@josh-work.beaverton.ibm.com>
References: <20070705093528.GK21478@ftp.linux.org.uk>
	 <468D1003.1050901@freedesktop.org>
	 <20070705164334.GM21478@ftp.linux.org.uk>
	 <1183661456.2604.43.camel@josh-work.beaverton.ibm.com>
	 <20070705191358.GQ21478@ftp.linux.org.uk>
	 <1183664153.2604.63.camel@josh-work.beaverton.ibm.com>
	 <20070705200839.GR21478@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:49044 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757465AbXGEVJK (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 5 Jul 2007 17:09:10 -0400
In-Reply-To: <20070705200839.GR21478@ftp.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Josh Triplett <josh@freedesktop.org>, linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org

On Thu, 2007-07-05 at 21:08 +0100, Al Viro wrote:
> On Thu, Jul 05, 2007 at 12:35:53PM -0700, Josh Triplett wrote:
> > OK, that seems inconsistent with what you said before.  You said that 
> > T __attribute__((foo)) *v;
> 
> ... in gcc.
> 
> > gives you a foo-pointer-to-T.  So shouldn't
> > int __attribute__((noderef)) *v;
> > give you a noderef-pointer-to-int?
> 
> ... if we followed gcc rules. 

Ah, OK.

> > However, noderef seems like a property of a pointer, hence why I
> > proposed the example I did.  A warning should occur when you do
> > *(<noderef T *>v) to get a T, not when you do *(<* noderef T>v) to get a
> > noderef T.
> 
> Nope.  __noderef is a property of object being pointed to.  Again,
> consider &p->x.  It should not be int *.  And it should not be
> an error.  We want it to be int __noderef *.
> 
> Semantics of noderef is simple: you should not access or modify the value
> of noderef object.  That's all.  int __noderef * is an absolutely normal
> pointer to such object.  Think of __noderef as of a stronger variant of const.

OK.  It hadn't occurred to me that "noderef int x" could have any useful
meaning on its own, but you've given a clear explanation of why it does,
which makes it meaningful to apply noderef to the pointer target rather
than the pointer.  Thanks.

- Josh Triplett
