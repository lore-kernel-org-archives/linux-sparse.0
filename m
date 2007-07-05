From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [RFC] bloody mess with __attribute__() syntax
Date: Thu, 5 Jul 2007 17:53:47 +0100
Message-ID: <20070705165347.GN21478@ftp.linux.org.uk>
References: <20070705093528.GK21478@ftp.linux.org.uk> <alpine.LFD.0.98.0707050930330.9434@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:45189 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758263AbXGEQxs (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 5 Jul 2007 12:53:48 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.98.0707050930330.9434@woody.linux-foundation.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Jul 05, 2007 at 09:41:55AM -0700, Linus Torvalds wrote:
> > Note that gcc rules for __attribute__() (and that's the only source
> > of rules we _have_ for the damn thing) clearly say that
> > 	int __user *p;
> > is the same thing as
> > 	int *__user p;
> 
> Quick question: is there some reason why we have to honor the crazy gcc 
> rules, and cannot try to convince gcc people that they are insane?

AFAICS, they started with storage-class-like attributes.  Consider e.g.
always_inline or section; these are not qualifiers at all and you want
to have
static __attribute__((always_inline)) int foo(int *p);
interpreted with attribute applied to foo, not to its return type.

So they have fsckloads of existing code relying on that parsing.  BTW,
they want things like
int *p __attribute__((section(...)))
and that's a position where qualifiers just do not appear.  Again, existing
codebase (and quite a bit of that is present in the kernel, BTW).

I rather doubt that they'll be able to kill that off and making parsing
dependent on the nature of attribute is not a viable option either -
think of __attribute__((this,that)) where "this" is storage-class-like
and "that" - qualifier-like.
