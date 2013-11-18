From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] Clarify error on directive in macro arguments (Re:
 [PATCH] jffs2: fix sparse errors: directive in argument list)
Date: Sun, 17 Nov 2013 18:15:32 -0800
Message-ID: <1384740932.5814.4.camel@joe-AO722>
References: <20131118020746.GX16018@ringworld.MIT.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtprelay0152.hostedemail.com ([216.40.44.152]:38898 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751546Ab3KRCPi (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 17 Nov 2013 21:15:38 -0500
In-Reply-To: <20131118020746.GX16018@ringworld.MIT.EDU>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Greg Price <price@MIT.EDU>
Cc: Al Viro <viro@ZenIV.linux.org.uk>, Christopher Li <sparse@chrisli.org>, Erico Nunes <nunes.erico@gmail.com>, linux-sparse@vger.kernel.org, dwmw2 <dwmw2@infradead.org>, linux-mtd <linux-mtd@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>

On Sun, 2013-11-17 at 21:07 -0500, Greg Price wrote:
> [+linux-sparse and Chris]
> 
> On Mon, Nov 18, 2013 at 01:33:49AM +0000, Al Viro wrote:
> > On Sun, Nov 17, 2013 at 02:45:05PM -0800, Joe Perches wrote:
> > > Yes.  I think it's a defect in how sparse
> > > treats string concatenation.
> > > 
> > > That style [... with printk ...] is pretty common in the kernel sources.
> > 
> > ... and it's perfectly fine, until somebody starts playing in nasal
> > daemon country and do that in *macro* arguments.  And a nasal daemon
> > country it is - it's an undefined behaviour.  See 6.10.3p11 in C99.
> > And trying to define a semantics for that gets real ugly real fast.
> > sparse matches gcc behaviour (I hope), but it warns about such abuses.
> > It's a defect, all right - one being reported by sparse.
> 
> Perhaps the following tweak to the error message would make this
> subtlety clearer?

Maybe, but this case isn't a macro.  It's a function.
Dunno if differentiating when it's a macro or a
function is difficult though.


