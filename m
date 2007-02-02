From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Feature request - suppress warnings for system libraries
Date: Fri, 2 Feb 2007 15:25:20 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702021522480.15057@woody.linux-foundation.org>
References: <1170438183.2272.29.camel@dv> <20070202220148.GB27667@chrisli.org>
 <1170455865.4698.8.camel@dv> <20070202223155.GD27667@chrisli.org>
 <20070202231705.GF10050@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:44295 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946161AbXBBXZz (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Fri, 2 Feb 2007 18:25:55 -0500
In-Reply-To: <20070202231705.GF10050@ftp.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Christopher Li <sparse@chrisli.org>, Pavel Roskin <proski@gnu.org>, linux-sparse@vger.kernel.org



On Fri, 2 Feb 2007, Al Viro wrote:
> 
> I'm not sure.  __transparent_union__ is an atrocious kludge and it does
> deserve a warning.  So getting it to STFU on known offenders we have no
> chance to fix is OK, but legitimizing that abortion is not.

Yeah, it really is pretty nasty. That said, nobody really uses it except 
for glibc, and almost nobody is interested in that warning. So we could 
have something that just barely parses the thing enough to avoid the 
warning at parse type, and then sets a flag: don't check this type on the 
caller (so that the _sane_ callers of "wait()" don't get warnings about 
the type).

IOW, just a hack to avoid the warning, no real "support" for that horrid 
thing.

> Unlike __transparent_union__, restrict is at least a valid C...  It's not
> that hard to handle, except for the shortage of bits for modifiers...

At worst, we could parse and ignore it.

		Linus
