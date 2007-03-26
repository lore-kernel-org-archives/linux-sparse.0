From: Christopher Li <sparse@chrisli.org>
Subject: Re: more spewage (Re: sparse segfault on ppc64)
Date: Mon, 26 Mar 2007 11:07:41 -0700
Message-ID: <20070326180741.GA24841@chrisli.org>
References: <20070322073344.GU4095@ftp.linux.org.uk> <20070322070354.GA22151@chrisli.org> <20070322171118.GL15364@redhat.com> <20070322221050.GC22151@chrisli.org> <20070323150459.52b02342.rdunlap@xenotime.net> <20070323233127.GA10115@uranus.ravnborg.org> <20070323164307.3e2e2803.rdunlap@xenotime.net> <20070324064456.GA13745@uranus.ravnborg.org> <20070324094648.60505bd3.rdunlap@xenotime.net> <Pine.LNX.4.64.0703240957530.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from sccrmhc12.comcast.net ([63.240.77.82]:57942 "EHLO
	sccrmhc12.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752678AbXCZSqw (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 26 Mar 2007 14:46:52 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0703240957530.6730@woody.linux-foundation.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Randy Dunlap <rdunlap@xenotime.net>, Sam Ravnborg <sam@ravnborg.org>, Dave Jones <davej@redhat.com>, Al Viro <viro@ftp.linux.org.uk>, linux-sparse@vger.kernel.org

On Sat, Mar 24, 2007 at 10:02:22AM -0700, Linus Torvalds wrote:
> 
> Well, sparse is often also an "arbiter of good taste".
> 
> "Technically correct" or "..but gcc accepts it" are secondary to "does the 
> source make sense".
> 
> For example, gcc accepts a *lot* of insanity when it comes to attributes 
> in odd places. That doesn't necessarily mean that sparse should accept it.

Points taken.  Sparse can parse it and warn about it. It is still better than
the obscure parser error from sparse.

Chris
