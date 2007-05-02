From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: sparse -Wptr-subtraction-blows: still needed?
Date: Wed, 2 May 2007 01:02:40 +0100
Message-ID: <20070502000240.GI4095@ftp.linux.org.uk>
References: <4637AC3D.6000008@freedesktop.org> <alpine.LFD.0.98.0705011442320.3808@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:47924 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946090AbXEBACm (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 1 May 2007 20:02:42 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.98.0705011442320.3808@woody.linux-foundation.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Triplett <josh@freedesktop.org>, linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, May 01, 2007 at 02:43:30PM -0700, Linus Torvalds wrote:
> 
> 
> On Tue, 1 May 2007, Josh Triplett wrote:
> > 
> > Does this still apply?  Do current versions of GCC still have this problem?
> > If not, can the option and warning go away?
> 
> Even if current versions of gcc don't triple the build time (and for the 
> kernel, I suspect it doesn't, because we've tried to clean up our header 
> files), the generated _code_ will invariably suck.
> 
> So I'd not want to remove the warning.

Note that code *will* blow: in effect, when we have a*2^b as object size,
we have to choose between
	* generic division by a*2^b (dog-slow pretty much on anything)
	* multiplication by such c that a*c == 1 (mod 2^word_size-b), then
shift down by b.
	* shift down by b, then multiplication by such c that a*c == 1
(mod 2^word_size).
And c in the above won't be small or pretty, so doing multiplication as
series of additions won't be short.

FWIW, I've seen very nasty cases (in userland code) where hot path got blown
by factor of 5 or so in size due to that; basically, it started with
#define INDEX(p) ((p)-array)
and that sucker got used a lot in other macros, so it wasn't immediately
obvious what had been going on.  So yes, we do want to be able to see
such cases.
