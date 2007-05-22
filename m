From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: fun with ?:
Date: Tue, 22 May 2007 23:46:19 +0100
Message-ID: <20070522224619.GI4095@ftp.linux.org.uk>
References: <20070519025249.GZ4095@ftp.linux.org.uk> <4653633B.3000000@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:42911 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755619AbXEVWqU (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 22 May 2007 18:46:20 -0400
Content-Disposition: inline
In-Reply-To: <4653633B.3000000@freedesktop.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

On Tue, May 22, 2007 at 02:40:11PM -0700, Josh Triplett wrote:
> > What's going on here is pretty simple: there are two degenerate cases of
> > conditional operator: pointer vs. null pointer constant and pointer vs.
> > possibly qualified pointer to void.  Look at these cases:
> > 	n ? p : NULL => should be the same type as p
> > 	n ? p : v => clearly const void * - pointer to void with union of
> > qualifiers; in this case we obviously lose any information about the type
> > of object being pointed to.
> 
> I didn't actually know about the special case for a null pointer constant.

Rationale is pretty simple: normally if you have void * in the mix, you
_can't_ expect more type information from the result; i.e. you are not
promised that result of ?: will point to int.  However, null pointer constant
is a chameleon - it accepts whatever pointer type you might need in given
context.  So in that case you do _not_ lose the type information.

> In particular:
> > n ? p : (void *)NULL		int *	=>	void *
> Shouldn't this have type int * just like n ? p : NULL ?

No.  It's "void * and I _mean_ it".  Well... actually (void *)(void *)0 if
you want to be 100% portable and protect yourself against cretinous systems
that define NULL to 0.

Again, null pointer constant is not the same thing as null pointer to void.

BTW, there's another painful area: what do we do to somebody who uses
(void *)(69 + 1 - 70) as null pointer constant?  Currenly sparse doesn't
recognize it as such; C standard does.  IMO the right thing to do is
to add a flag that would switch to full-blown standard rules in that area
("integer constant expression returning 0" instead of basically "0 in some
layers of ()") and flame to the crisp any wanker caught at actually doing
that.  Any suggestions re sufficiently violent warning messages?
