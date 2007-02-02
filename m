From: Christopher Li <sparse@chrisli.org>
Subject: Re: Feature request - allow boolean operations of undefined cpp symbols
Date: Fri, 2 Feb 2007 13:56:03 -0800
Message-ID: <20070202215603.GA27667@chrisli.org>
References: <1170437836.2272.22.camel@dv> <Pine.LNX.4.64.0702021021570.15057@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from alnrmhc16.comcast.net ([206.18.177.56]:46129 "EHLO
	alnrmhc16.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946123AbXBBWW7 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 2 Feb 2007 17:22:59 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0702021021570.15057@woody.linux-foundation.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Pavel Roskin <proski@gnu.org>, linux-sparse@vger.kernel.org

On Fri, Feb 02, 2007 at 10:25:12AM -0800, Linus Torvalds wrote:
> No.
> 
> 	#if SYMBOL
> 
> has a very specific *problem* - it very possibly is a typo.
> 
> So this is a warning I absolutely *want* for the kernel. If some other 
> projects don't want it, fine, but it should be on by default as a warnign 
> for potentially dangerous use of preprocessor symbols.
> 
I did some trivial test:

#if SYMBOL_NOT_DEFINED
#warning "defined"
#else
#warning "not defined"
#endif

On sparse git tip, or sparse 0.2. Here is what I get:

./sparse /tmp/a.c 
/tmp/a.c:5:2: warning: "not defined"

That is what Pavel wants. So Linus should complain instead.

I am confused.

Chris
