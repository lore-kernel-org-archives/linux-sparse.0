From: Christopher Li <sparse@chrisli.org>
Subject: Re: Feature request - suppress warnings for system libraries
Date: Fri, 2 Feb 2007 14:31:55 -0800
Message-ID: <20070202223155.GD27667@chrisli.org>
References: <1170438183.2272.29.camel@dv> <20070202220148.GB27667@chrisli.org> <1170455865.4698.8.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rwcrmhc13.comcast.net ([204.127.192.83]:36069 "EHLO
	rwcrmhc13.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946123AbXBBW6v (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 2 Feb 2007 17:58:51 -0500
Content-Disposition: inline
In-Reply-To: <1170455865.4698.8.camel@dv>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
Cc: linux-sparse@vger.kernel.org

On Fri, Feb 02, 2007 at 05:37:45PM -0500, Pavel Roskin wrote:
> 
> /usr/include/sys/socket.h:88:62: error: attribute
> '__transparent_union__': ignoring attribute __transparent_union__
> /usr/include/sys/socket.h:92:68: error: attribute
> '__transparent_union__': ignoring attribute __transparent_union__
> /usr/include/netdb.h:661:60: error: typename in expression
> /usr/include/stdlib.h:72:56: error: attribute '__transparent_union__':
> ignoring attribute __transparent_union__

I see, that is because sparse does not handle attribute
__transparent_union__ yet. We should improve sparse instead of paper
cover the error message.

> /usr/include/regex.h:543:27: error: typename in expression

Similar here, that is because gcc has this key word "restrict"
inside bracket. Sparse know nothing about "restrict".

> I'm not going to fix socket.h.  I'm checking my code, not glibc.

Again, we should fix sparse instead.

Chris
