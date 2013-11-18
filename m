From: Greg Price <price@MIT.EDU>
Subject: Re: [PATCH] Clarify error on directive in macro arguments (Re:
 [PATCH] jffs2: fix sparse errors: directive in argument list)
Date: Sun, 17 Nov 2013 23:01:00 -0500
Message-ID: <20131118040100.GE8043@ringworld.MIT.EDU>
References: <20131118020746.GX16018@ringworld.MIT.EDU>
 <1384740932.5814.4.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from dmz-mailsec-scanner-1.mit.edu ([18.9.25.12]:64403 "EHLO
	dmz-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750960Ab3KREBI (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 17 Nov 2013 23:01:08 -0500
Content-Disposition: inline
In-Reply-To: <1384740932.5814.4.camel@joe-AO722>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Al Viro <viro@ZenIV.linux.org.uk>, Christopher Li <sparse@chrisli.org>, Erico Nunes <nunes.erico@gmail.com>, linux-sparse@vger.kernel.org, dwmw2 <dwmw2@infradead.org>, linux-mtd <linux-mtd@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>

On Sun, Nov 17, 2013 at 06:15:32PM -0800, Joe Perches wrote:
> On Sun, 2013-11-17 at 21:07 -0500, Greg Price wrote:
> > Perhaps the following tweak to the error message would make this
> > subtlety clearer?
> 
> Maybe, but this case isn't a macro.  It's a function.
> Dunno if differentiating when it's a macro or a
> function is difficult though.

Yeah, this error message is already only emitted for directives in
macro arguments -- in this case, pr_info.  It's in sparse's
preprocessor code; the error arises when a directive is spotted while
parsing a macro's arguments.  By the time sparse (or an idealized C
compiler) parses the arguments of a real function, the token stream is
already the output of the preprocessor and any directives are gone.

Cheers,
Greg
