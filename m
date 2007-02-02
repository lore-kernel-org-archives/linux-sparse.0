From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: Feature request - suppress warnings for system libraries
Date: Fri, 2 Feb 2007 23:17:05 +0000
Message-ID: <20070202231705.GF10050@ftp.linux.org.uk>
References: <1170438183.2272.29.camel@dv> <20070202220148.GB27667@chrisli.org> <1170455865.4698.8.camel@dv> <20070202223155.GD27667@chrisli.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:60155 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946124AbXBBXRI (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 2 Feb 2007 18:17:08 -0500
Content-Disposition: inline
In-Reply-To: <20070202223155.GD27667@chrisli.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Pavel Roskin <proski@gnu.org>, linux-sparse@vger.kernel.org

On Fri, Feb 02, 2007 at 02:31:55PM -0800, Christopher Li wrote:
> On Fri, Feb 02, 2007 at 05:37:45PM -0500, Pavel Roskin wrote:
> > 
> > /usr/include/sys/socket.h:88:62: error: attribute
> > '__transparent_union__': ignoring attribute __transparent_union__
> > /usr/include/sys/socket.h:92:68: error: attribute
> > '__transparent_union__': ignoring attribute __transparent_union__
> > /usr/include/netdb.h:661:60: error: typename in expression
> > /usr/include/stdlib.h:72:56: error: attribute '__transparent_union__':
> > ignoring attribute __transparent_union__
> 
> I see, that is because sparse does not handle attribute
> __transparent_union__ yet. We should improve sparse instead of paper
> cover the error message.

I'm not sure.  __transparent_union__ is an atrocious kludge and it does
deserve a warning.  So getting it to STFU on known offenders we have no
chance to fix is OK, but legitimizing that abortion is not.
 
> > /usr/include/regex.h:543:27: error: typename in expression
> 
> Similar here, that is because gcc has this key word "restrict"
> inside bracket. Sparse know nothing about "restrict".
> 
> > I'm not going to fix socket.h.  I'm checking my code, not glibc.
> 
> Again, we should fix sparse instead.

Unlike __transparent_union__, restrict is at least a valid C...  It's not
that hard to handle, except for the shortage of bits for modifiers...
