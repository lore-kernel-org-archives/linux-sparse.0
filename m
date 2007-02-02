From: Pavel Roskin <proski@gnu.org>
Subject: Re: Feature request - suppress warnings for system libraries
Date: Fri, 02 Feb 2007 17:37:45 -0500
Message-ID: <1170455865.4698.8.camel@dv>
References: <1170438183.2272.29.camel@dv>
	 <20070202220148.GB27667@chrisli.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fencepost.gnu.org ([199.232.76.164]:43051 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946139AbXBBWhr (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 2 Feb 2007 17:37:47 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1HD71P-0004Ep-U2
	for linux-sparse@vger.kernel.org; Fri, 02 Feb 2007 17:36:43 -0500
In-Reply-To: <20070202220148.GB27667@chrisli.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

On Fri, 2007-02-02 at 14:01 -0800, Christopher Li wrote:
> On Fri, Feb 02, 2007 at 12:43:03PM -0500, Pavel Roskin wrote:
> > Hello!
> > 
> > It would be great if sparse could optionally suppress warnings about
> > system headers included using from implicit locations, such as
> > "usr/include", "/usr/local/include" and GCC_INTERNAL_INCLUDE (see
> > pre-process.c).
> 
> Can you be more specific about which warning you are complaining?
> Point to the line of sparse code or give a small test case will be nice.

I don't want to see stuff like this for every non-trivial file I compile
(that's Fedora Core 6, not some ancient distro):

/usr/include/sys/socket.h:88:62: error: attribute
'__transparent_union__': ignoring attribute __transparent_union__
/usr/include/sys/socket.h:92:68: error: attribute
'__transparent_union__': ignoring attribute __transparent_union__
/usr/include/netdb.h:661:60: error: typename in expression
/usr/include/stdlib.h:72:56: error: attribute '__transparent_union__':
ignoring attribute __transparent_union__
/usr/include/regex.h:543:27: error: typename in expression

I'm not going to fix socket.h.  I'm checking my code, not glibc.

> Kernel checking takes more priority. But again, it does not hurt to have
> option to disable it, as long as it is off by default.

Actually, the kernel should not be affected since it's compiled without
system includes.

-- 
Regards,
Pavel Roskin
