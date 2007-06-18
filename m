From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [patchset] rewrite of initializer handling
Date: Mon, 18 Jun 2007 10:07:54 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706181002590.14121@woody.linux-foundation.org>
References: <20070618101929.GE21478@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:48242 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760063AbXFRRI4 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 18 Jun 2007 13:08:56 -0400
In-Reply-To: <20070618101929.GE21478@ftp.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: linux-sparse@vger.kernel.org



On Mon, 18 Jun 2007, Al Viro wrote:
>
> 	Current tree handling of initializers is rather incomplete
> and in many cases broken.  Patchset rewrites that stuff pretty much
> from scratch; AFAICS it works.

Josh - you may already be aware of it, but I thought I'd point it out 
anyway: when Al Viro sends me a patch (or set of patches), I personally 
just realize that a superior intellect has contacted me, told me I'm 
wrong, and given me the keys to fix it.

IOW, Al's patches tend to be a good point to just say "Oh, ok, I was a 
moron for ever writing anything else, thank you for not pointing it out 
any more impolitely and not chewing my head off", and then just applying 
or pulling them.

Which is not to say that I've never gotten a patch without a bug in it 
from Al, but I've never seen Al do something that wasn't fundamentally the 
"Right Thing(tm)" to do.

IOW, Al is one of those few people where I can just close my eyes and say 
"yup, I'll apply it" without even bothering to look at the patch.

			Linus
