From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [patchset] rewrite of initializer handling
Date: Mon, 18 Jun 2007 20:30:26 +0100
Message-ID: <20070618193026.GH21478@ftp.linux.org.uk>
References: <20070618101929.GE21478@ftp.linux.org.uk> <alpine.LFD.0.98.0706181002590.14121@woody.linux-foundation.org> <4676C8CF.6020201@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:39478 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761331AbXFRTa2 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 18 Jun 2007 15:30:28 -0400
Content-Disposition: inline
In-Reply-To: <4676C8CF.6020201@freedesktop.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-sparse@vger.kernel.org

On Mon, Jun 18, 2007 at 11:02:55AM -0700, Josh Triplett wrote:
 
> Yeah, I've observed the same thing from activity in both the kernel community
> and the Sparse community.  I still look at the patches, but primarily so I
> can understand them and learn something from them, not because I expect to
> find anything wrong. :)

That's never a good idea, no matter where the patches are coming from.
Odds are that you have a different set of blind spots, so having "why
isn't that broken here?" as background attitude while reading any code
tends to find exactly the crap that happens to be hard to find for author
of the code in question...
