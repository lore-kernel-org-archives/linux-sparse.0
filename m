From: Christopher Li <sparse@chrisli.org>
Subject: Re: Feature request - suppress warnings for system libraries
Date: Fri, 2 Feb 2007 14:01:48 -0800
Message-ID: <20070202220148.GB27667@chrisli.org>
References: <1170438183.2272.29.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rwcrmhc12.comcast.net ([204.127.192.82]:34224 "EHLO
	rwcrmhc12.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946124AbXBBW2r (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 2 Feb 2007 17:28:47 -0500
Content-Disposition: inline
In-Reply-To: <1170438183.2272.29.camel@dv>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
Cc: linux-sparse@vger.kernel.org

On Fri, Feb 02, 2007 at 12:43:03PM -0500, Pavel Roskin wrote:
> Hello!
> 
> It would be great if sparse could optionally suppress warnings about
> system headers included using from implicit locations, such as
> "usr/include", "/usr/local/include" and GCC_INTERNAL_INCLUDE (see
> pre-process.c).

Can you be more specific about which warning you are complaining?
Point to the line of sparse code or give a small test case will be nice.

> Perhaps some major warnings could be left if they can indicate that
> sparse may have failed to parse the header properly.  But the petty
> stuff should be suppressed.
> 
> This would greatly help make sparse useful for code other than Linux
> kernel.

Kernel checking takes more priority. But again, it does not hurt to have
option to disable it, as long as it is off by default.

Chris
