From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH] kmemcheck: fix sparse warning
Date: Wed, 8 Jul 2009 23:29:08 -0700
Message-ID: <20090709062906.GA14804@feather>
References: <1246873983.20908.0.camel@johannes.local>
 <19f34abd0907081228p541d1cdao85f37aaa479fcfc5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from slow3-v.mail.gandi.net ([217.70.178.89]:36102 "EHLO
	slow3-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752563AbZGIGnZ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 9 Jul 2009 02:43:25 -0400
Content-Disposition: inline
In-Reply-To: <19f34abd0907081228p541d1cdao85f37aaa479fcfc5@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Vegard Nossum <vegard.nossum@gmail.com>
Cc: Linux Torvalds <torvalds@linux-foundation.org>, Johannes Berg <johannes@sipsolutions.net>, Pekka J Enberg <penberg@cs.helsinki.fi>, linux-kernel <linux-kernel@vger.kernel.org>, linux-sparse@vger.kernel.org

[Adding Linus and Chris Li to CC; Linus for further background on
-Wdo-while, and Chris Li for Sparse.]

On Wed, Jul 08, 2009 at 09:28:24PM +0200, Vegard Nossum wrote:
> 2009/7/6 Johannes Berg <johannes@sipsolutions.net>:
> > Whether or not the sparse warning
> >
> > warning: do-while statement is not a compound statement
> >
> > is justified or not in this case, it is annoying and
> > trivial to fix.
[...]
> 
> I'll change the patch title to "kmemcheck: work around bogus sparse
> warning" and fix the indentation, sounds ok?
> 
> Meanwhile, I Cced sparse mailing list in case somebody else knows
> anything else about this warning (what it means, whether it's
> justified in this case, whether it should be fixed in sparse, etc.).

-Wdo-while gives a warning if you write:

do
    statement
while (...);

where "statement" does not consist of a compound statement surrounded by
braces.  As far as I know, this warning exists primarily because it
matched Linus's preference for readability.

However, note that Sparse does not have -Wdo-while enabled by default.
Sparse only issues that warning if you use -Wdo-while explicitly, or if
you pass -Wall.  (The latter often happens due to passing the same
warning flags to GCC and Sparse, without using cgcc which filters out
-Wall for Sparse for that reason.)

Much discussion has occurred previously suggesting that Sparse's -Wall
should match GCC's "all useful warnings" rather than "all possible
warnings", and some other option should exist for "all possible
warnings" (for instance, -Weverything).  This seems very reasonable.
Given that Sparse *exists* to give warnings, -Wall's "all useful
warnings" approach seems like it matches Sparse's default behavior;
thus, I think it would make the most sense to make Sparse just interpret
-Wall as "enable all the warnings enabled by default" (which would
normally act as a no-op, but would make a difference if you passed
"-Wno-foo -Wall" for some default warning foo).

This would improve Sparse's behavior for the case where you invoke
sparse $(CFLAGS) directly rather than setting CC=cgcc, if CFLAGS
contains -Wall.

- Josh Triplett
