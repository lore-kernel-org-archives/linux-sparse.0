From: Pavel Roskin <proski@gnu.org>
Subject: Re: Feature request - allow boolean operations of undefined cpp
	symbols
Date: Fri, 02 Feb 2007 17:58:30 -0500
Message-ID: <1170457110.4698.18.camel@dv>
References: <1170437836.2272.22.camel@dv>
	 <Pine.LNX.4.64.0702021021570.15057@woody.linux-foundation.org>
	 <20070202215603.GA27667@chrisli.org> <1170455437.4698.2.camel@dv>
	 <20070202221009.GC27667@chrisli.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fencepost.gnu.org ([199.232.76.164]:60557 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946121AbXBBW6d (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 2 Feb 2007 17:58:33 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1HD7LV-0004fm-Tu
	for linux-sparse@vger.kernel.org; Fri, 02 Feb 2007 17:57:30 -0500
In-Reply-To: <20070202221009.GC27667@chrisli.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-sparse@vger.kernel.org

On Fri, 2007-02-02 at 14:10 -0800, Christopher Li wrote:
> On Fri, Feb 02, 2007 at 05:30:37PM -0500, Pavel Roskin wrote:
> > 
> > You need -Wundef or -Wall to check for undefined preprocessor symbols.
> > 
> > $ sparse -Wundef test.c 
> > test.c:1:5: warning: undefined preprocessor identifier
> > 'SYMBOL_NOT_DEFINED'
> > test.c:4:2: warning: "not defined"
> 
> Ha, I see. So do you still want some thing more than -Wno-undef?

My intention was that we always allow boolean operations of undefined
cpp symbols, regardless of the flags.

Since Linus wants the existing strictness of -Wundef for the kernel, and
the kernel is sparse's "number one customer", I'll need to think of
something better to accommodate both the kernel and the userspace.

-- 
Regards,
Pavel Roskin
