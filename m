From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH 16/16] fix handling of integer constant expressions
Date: Sun, 24 Jun 2007 18:47:32 +0100
Message-ID: <20070624174732.GZ21478@ftp.linux.org.uk>
References: <E1I2N6V-0003g9-8H@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:43282 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751477AbXFXRrd (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 24 Jun 2007 13:47:33 -0400
Content-Disposition: inline
In-Reply-To: <E1I2N6V-0003g9-8H@ZenIV.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org

On Sun, Jun 24, 2007 at 09:05:51AM +0100, Al Viro wrote:
> 
> Hopefully correct handling of integer constant expressions.  Please, review.

Heh...  The first catches are lovely:
                 struct fxsrAlignAssert {
                         int _:!(offsetof(struct task_struct,
                                         thread.i387.fxsave) & 15);
                 };
as an idiotic way to do BUILD_BUG() and
#define _IOC_TYPECHECK(t) \
        ((sizeof(t) == sizeof(t[1]) && \
          sizeof(t) < (1 << _IOC_SIZEBITS)) ? \
          sizeof(t) : __invalid_size_argument_for_IOC)
poisoning _IOW() et.al., so those who do something like

static const char *v4l1_ioctls[] = {
        [_IOC_NR(VIDIOCGCAP)]       = "VIDIOCGCAP",

run into trouble.  The former is "tell jbeulich to cut down on crack",
but the latter...  Probably ought to be
#define _IOC_TYPECHECK(t) \
        (sizeof(t) + BUILD_BUG_ON_ZERO(sizeof(t) == sizeof(t[1]) && \
          sizeof(t) < (1 << _IOC_SIZEBITS)))

Objections?  The only reason that doesn't break gcc to hell and back is
that gcc has unfixed bugs in that area.  It certainly is not a valid C
or even a remotely sane one.
