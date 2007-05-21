From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH] Fix compilation warning on 64 bits platforms
Date: Mon, 21 May 2007 01:33:18 +0100
Message-ID: <20070521003318.GB4095@ftp.linux.org.uk>
References: <11797058752907-git-send-email-damien.lespiau@gmail.com> <4650E7B5.4030207@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:43103 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758286AbXEUAdU (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 20 May 2007 20:33:20 -0400
Content-Disposition: inline
In-Reply-To: <4650E7B5.4030207@freedesktop.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: Damien Lespiau <damien.lespiau@gmail.com>, linux-sparse@vger.kernel.org

On Sun, May 20, 2007 at 05:28:37PM -0700, Josh Triplett wrote:
> Damien Lespiau wrote:
> > Fix: format '%d' expects type 'int', but argument 2 has type 'long int'
> [...]
> > @@ -461,7 +461,7 @@ const char *show_instruction(struct instruction *insn)
> >  	}
> >  
> >  	if (buf >= buffer + sizeof(buffer))
> > -		die("instruction buffer overflowed %d\n", buf - buffer);
> > +		die("instruction buffer overflowed %d\n", (int)(buf - buffer));
> 
> A cast doesn't seem like the right fix.  The difference between two pointers
> has type ptrdiff_t.  sizeof(ptrdiff_t) == 8 on 64-bit platforms, leading to
> the legitimate warning you saw.  This cast would truncate the difference to 32
> bits.  glibc supplies a "t" length modifier for ptrdiff_t, but I don't think
> sparse can't portably use that.

Not just glibc; it's in C99.  So yes, I'd say we should use %td here.
