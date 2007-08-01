From: Josh Triplett <josht@linux.vnet.ibm.com>
Subject: Re: Finding all typedefs
Date: Wed, 01 Aug 2007 10:01:31 -0700
Message-ID: <1185987691.3123.33.camel@josh-work.beaverton.ibm.com>
References: <1185574111.2029.10.camel@dv>
	 <20070727160147.6ecbfd86.rdunlap@xenotime.net>
	 <1185983112.2425.12.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:47031 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756164AbXHARBL (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 1 Aug 2007 13:01:11 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l71H16Tv016296
	for <linux-sparse@vger.kernel.org>; Wed, 1 Aug 2007 13:01:06 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id l71H136w155848
	for <linux-sparse@vger.kernel.org>; Wed, 1 Aug 2007 11:01:04 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l71H125h016656
	for <linux-sparse@vger.kernel.org>; Wed, 1 Aug 2007 11:01:02 -0600
In-Reply-To: <1185983112.2425.12.camel@dv>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>, Rob Taylor <rob.taylor@codethink.co.uk>
Cc: Randy Dunlap <rdunlap@xenotime.net>, linux-sparse@vger.kernel.org

On Wed, 2007-08-01 at 11:45 -0400, Pavel Roskin wrote:
> On Fri, 2007-07-27 at 16:01 -0700, Randy Dunlap wrote:
> > I asked Linus about 3 years ago for something that would dump
> > global data sizes.  It's attached (updated to recent sparse;
> > it also has '-keywords' to warn about using C++ keywords, but you
> > can ignore/delete that part).  It may be fixable to do what you want,
> > although I have no info on sparse symbol struct contents.
> > Or maybe Josh et al can do what you want rather easily... :)
> 
> Sorry for delay.  Thank you!  I'm not sure I can reuse anything from
> that code to dump typedefs.
> 
> My point is, I want to write a script that would use existing software
> to produce checkpatch.pl conforming code.  If I need to hack anything,
> I'd rather contribute to indent or astyle.  In fact, it would be a much
> better approach to recognize argument lists and format them differently,
> rather than deal with a list of typedefs.
> 
> I hoped that c2xml would give me typedefs, but it doesn't.

It certainly should; I didn't realize that it didn't.  I'll look into it
and see if I can change that.

CCing Rob (the author of c2xml) to see if he has any thoughts on this.

- Josh Triplett
