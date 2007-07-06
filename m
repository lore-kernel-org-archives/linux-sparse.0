From: Josh Triplett <josht@linux.vnet.ibm.com>
Subject: Re: [patch 5/9] x86_64: arch_pick_mmap_layout() fixlet
Date: Fri, 06 Jul 2007 12:53:46 -0700
Message-ID: <1183751626.2613.54.camel@josh-work.beaverton.ibm.com>
References: <200707060939.l669drk2019988@imap1.linux-foundation.org>
	 <alpine.LFD.0.98.0707061010060.21374@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:58725 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756279AbXGFTxj (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 6 Jul 2007 15:53:39 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l66Jrcbs016229
	for <linux-sparse@vger.kernel.org>; Fri, 6 Jul 2007 15:53:38 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l66Jrc8I205562
	for <linux-sparse@vger.kernel.org>; Fri, 6 Jul 2007 13:53:38 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l66JrbdS004059
	for <linux-sparse@vger.kernel.org>; Fri, 6 Jul 2007 13:53:38 -0600
In-Reply-To: <alpine.LFD.0.98.0707061010060.21374@woody.linux-foundation.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: akpm@linux-foundation.org, Josh Triplett <josh@freedesktop.org>, Al Viro <viro@zeniv.linux.org.uk>, linux-sparse@vger.kernel.org, adobriyan@sw.ru, ak@suse.de

On Fri, 2007-07-06 at 10:21 -0700, Linus Torvalds wrote:
> This would be a sparse bug, I think.
> 
> Returning a void-valued expression in a void-valued function is 
> proper C99 (and gcc has allowed it for longer). And it often makes for 
> nicer-looking code, with no real downsides.
> 
> This seems to be a new bug introduced by Al Viro in sparse: -Wall should 
> _not_ enable -Wreturn-void, I think (and I don't think Al meant it to: his 
> commit message says "Conditional on -Wreturn-void", and he probably didn't 
> think about the fact that -Wall will force them all on.
> 
> Josh, Al and sparse mailing list added to participants list, and patch 
> dropped. I think -Wreturn-void is fine, but it just shouldn't be part of 
> -Wall, and thus shouldn't trigger for the kernl.

The kernel does not seem to use sparse -Wall by default.  Did the patch
submitter use CF=-Wall or CF=-Wreturn-void, or otherwise change the set
of warnings emitted by Sparse?

I do think the sparse warning logic needs some work.  -Wall logically
should mean "all warnings", but gcc historically uses it to mean "some
reasonable set of warnings".  However, since Sparse exists solely to
give warnings, it defaults to "some reasonable set of warnings", and
uses -Wall for "all warnings".  Perhaps for gcc compatibility, that
should change.  I'd love to hear suggestions for how Sparse should
behave.  A few options:

      * Leave the current behavior, and tell people annoyed by Sparse
        warnings they don't care about that they should either avoid
        -Wall or use -Wall -Wno-warning-i-do-not-care-about.
      * Ignore -Wall since we already give a reasonable default set of
        warnings, and possibly introduce a -Weverything or similar that
        really does mean "turn on every Sparse warning".
      * Change -Wall to mean "turn on some additional warnings, but not
        all of them".  We then have to decide which warnings -Wall
        should enable, and again we might want to add a -Weverything.
      * Turn off all warnings by default unless you give -Wall.  This
        seems entirely broken, given the purpose of Sparse.

> On Fri, 6 Jul 2007, akpm@linux-foundation.org wrote:
> > From: Alexey Dobriyan <adobriyan@sw.ru>
> > 
> > sparse now warns about
> > arch/x86_64/mm/mmap.c:15:3: warning: returning void-valued expression

- Josh Triplett
