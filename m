From: Dan Carpenter <error27@gmail.com>
Subject: Re: [0/4] inspector for sparse
Date: Fri, 23 Apr 2010 22:37:51 +0200
Message-ID: <20100423203751.GM29093@bicker>
References: <u2n70318cbf1004021136t65b4d8acmf8bfd7e18b410dfe@mail.gmail.com> <w2j70318cbf1004021159y2fa50d58y62bd878c6355a972@mail.gmail.com> <20100423203040.GL29093@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ww0-f46.google.com ([74.125.82.46]:47488 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756194Ab0DWUiK (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 23 Apr 2010 16:38:10 -0400
Received: by wwg30 with SMTP id 30so234413wwg.19
        for <linux-sparse@vger.kernel.org>; Fri, 23 Apr 2010 13:38:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100423203040.GL29093@bicker>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Apr 23, 2010 at 10:30:40PM +0200, Dan Carpenter wrote:
> On Fri, Apr 02, 2010 at 11:59:39AM -0700, Christopher Li wrote:
> > I add a treeview branch on sparse/chrisl so you can pull from it.
> > 
> > http://git.kernel.org/?p=devel/sparse/chrisl/sparse.git;a=shortlog;h=refs/heads/treeview
> > 
> > In fedora, you need to install gtk2-devel package to enable it.
> > 
> > Chris
> 
> This is an really useful program.
> 
> Inline functions don't show up in the list of functions.  Is there a way 
> to inspect these as well?  This is more a general sparse question, since
> smatch doesn't parse inline functions either.

Crap.  I'm dumb.  You actually can click through your program to where the
inline function is called and see it.

Really useful program as I said before.

regards,
dan carpenter

> 
> regards,
> dan carpenter
