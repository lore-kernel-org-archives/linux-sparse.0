From: Pavel Roskin <proski@gnu.org>
Subject: Re: Finding all typedefs
Date: Wed, 01 Aug 2007 11:45:12 -0400
Message-ID: <1185983112.2425.12.camel@dv>
References: <1185574111.2029.10.camel@dv>
	 <20070727160147.6ecbfd86.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fencepost.gnu.org ([140.186.70.10]:59732 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761550AbXHAPpP (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 1 Aug 2007 11:45:15 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1IGGQB-0008Qa-3h
	for linux-sparse@vger.kernel.org; Wed, 01 Aug 2007 11:47:35 -0400
In-Reply-To: <20070727160147.6ecbfd86.rdunlap@xenotime.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: linux-sparse@vger.kernel.org

Hello, Randy!

On Fri, 2007-07-27 at 16:01 -0700, Randy Dunlap wrote:

> I asked Linus about 3 years ago for something that would dump
> global data sizes.  It's attached (updated to recent sparse;
> it also has '-keywords' to warn about using C++ keywords, but you
> can ignore/delete that part).  It may be fixable to do what you want,
> although I have no info on sparse symbol struct contents.
> Or maybe Josh et al can do what you want rather easily... :)

Sorry for delay.  Thank you!  I'm not sure I can reuse anything from
that code to dump typedefs.

My point is, I want to write a script that would use existing software
to produce checkpatch.pl conforming code.  If I need to hack anything,
I'd rather contribute to indent or astyle.  In fact, it would be a much
better approach to recognize argument lists and format them differently,
rather than deal with a list of typedefs.

I hoped that c2xml would give me typedefs, but it doesn't.

-- 
Regards,
Pavel Roskin
