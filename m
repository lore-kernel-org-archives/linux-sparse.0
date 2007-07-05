From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [RFC] bloody mess with __attribute__() syntax
Date: Thu, 5 Jul 2007 21:08:39 +0100
Message-ID: <20070705200839.GR21478@ftp.linux.org.uk>
References: <20070705093528.GK21478@ftp.linux.org.uk> <468D1003.1050901@freedesktop.org> <20070705164334.GM21478@ftp.linux.org.uk> <1183661456.2604.43.camel@josh-work.beaverton.ibm.com> <20070705191358.GQ21478@ftp.linux.org.uk> <1183664153.2604.63.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:35619 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762127AbXGEUIo (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 5 Jul 2007 16:08:44 -0400
Content-Disposition: inline
In-Reply-To: <1183664153.2604.63.camel@josh-work.beaverton.ibm.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josht@linux.vnet.ibm.com>
Cc: Josh Triplett <josh@freedesktop.org>, linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org

On Thu, Jul 05, 2007 at 12:35:53PM -0700, Josh Triplett wrote:
> OK, that seems inconsistent with what you said before.  You said that 
> T __attribute__((foo)) *v;

... in gcc.

> gives you a foo-pointer-to-T.  So shouldn't
> int __attribute__((noderef)) *v;
> give you a noderef-pointer-to-int?

... if we followed gcc rules. 

> However, noderef seems like a property of a pointer, hence why I
> proposed the example I did.  A warning should occur when you do
> *(<noderef T *>v) to get a T, not when you do *(<* noderef T>v) to get a
> noderef T.

Nope.  __noderef is a property of object being pointed to.  Again,
consider &p->x.  It should not be int *.  And it should not be
an error.  We want it to be int __noderef *.

Semantics of noderef is simple: you should not access or modify the value
of noderef object.  That's all.  int __noderef * is an absolutely normal
pointer to such object.  Think of __noderef as of a stronger variant of const.

It's just another qualifier, with usual qualifier syntax.  It can occur
in the same places where const can, giving the same kind of effect on type.
See 6.7.5.1 and 6.7.3 for general stuff on qualifiers...
