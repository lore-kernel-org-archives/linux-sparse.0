From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 4/5] test-suite: Add -b option to ignore CR at eol on
 MinGW
Date: Tue, 21 May 2013 14:46:07 -0700
Message-ID: <20130521214607.GB11463@jtriplet-mobl1>
References: <519BC87D.5080002@ramsay1.demon.co.uk>
 <20130521211650.GA11463@jtriplet-mobl1>
 <1369171620.10614.0.camel@jlt4.sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:57603 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751397Ab3EUVqS (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 21 May 2013 17:46:18 -0400
Content-Disposition: inline
In-Reply-To: <1369171620.10614.0.camel@jlt4.sipsolutions.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>, Christopher Li <sparse@chrisli.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Tue, May 21, 2013 at 11:27:00PM +0200, Johannes Berg wrote:
> On Tue, 2013-05-21 at 14:16 -0700, Josh Triplett wrote:
> > On Tue, May 21, 2013 at 08:18:21PM +0100, Ramsay Jones wrote:
> > > Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> > 
> > -b doesn't just ignore CR at end of line; it would also ignore changes
> > in the amount of whitespace elsewhere on the line.  You might consider
> > piping the input that has CRs through sed before storing it, to delete
> > the CR at end of line before comparing, instead.
> 
> Or just use --strip-trailing-cr, no? Or maybe that's not available?

Nice, I didn't know about that one.  Yes, if MinGW's diff has that, by
all means use it.

- Josh Triplett
