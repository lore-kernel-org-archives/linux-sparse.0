From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 16/16] fix handling of integer constant expressions
Date: Sun, 24 Jun 2007 11:04:57 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706241102160.3593@woody.linux-foundation.org>
References: <E1I2N6V-0003g9-8H@ZenIV.linux.org.uk>
 <20070624174732.GZ21478@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:49852 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751505AbXFXSGC (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 24 Jun 2007 14:06:02 -0400
In-Reply-To: <20070624174732.GZ21478@ftp.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org



On Sun, 24 Jun 2007, Al Viro wrote:
> 
> Heh...  The first catches are lovely:
>                  struct fxsrAlignAssert {
>                          int _:!(offsetof(struct task_struct,
>                                          thread.i387.fxsave) & 15);

Ok, that's a bit odd.

> as an idiotic way to do BUILD_BUG() and
> #define _IOC_TYPECHECK(t) \
>         ((sizeof(t) == sizeof(t[1]) && \
>           sizeof(t) < (1 << _IOC_SIZEBITS)) ? \
>           sizeof(t) : __invalid_size_argument_for_IOC)
> poisoning _IOW() et.al., so those who do something like
> 
> static const char *v4l1_ioctls[] = {
>         [_IOC_NR(VIDIOCGCAP)]       = "VIDIOCGCAP",

On the other hand, this one really does seem to be "nice".

I don't think it's a misfeature to be able to do "obvious compile-time 
constant optimizations" on initializer indexes. The bitfield size thing in 
some ways does do the same thing - it's clearly _odd_, but if I had my  
choice, I'd prefer a language that allows it over one that doesn't.

> Objections?  The only reason that doesn't break gcc to hell and back is
> that gcc has unfixed bugs in that area.  It certainly is not a valid C
> or even a remotely sane one.

I agree that it's obviously not "valid C", but I don't agree that it's not 
remotely sane. Why not allow that extension? 

		Linus
