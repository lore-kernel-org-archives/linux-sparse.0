From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH 2/6] Hardcode actual type sizes, add -m32 support
Date: Thu, 28 Jun 2007 02:27:35 -0400
Message-ID: <1183012055.32164.24.camel@dv>
References: <20070628053954.30704.66440.stgit@dv.roinet.com>
	 <20070628053959.30704.91680.stgit@dv.roinet.com>
	 <20070628055850.GE21478@ftp.linux.org.uk>
	 <46834FA0.8010201@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fencepost.gnu.org ([140.186.70.10]:59304 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758178AbXF1G1j (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 28 Jun 2007 02:27:39 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1I3nTe-0001HS-JQ
	for linux-sparse@vger.kernel.org; Thu, 28 Jun 2007 02:27:38 -0400
In-Reply-To: <46834FA0.8010201@freedesktop.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: Al Viro <viro@ftp.linux.org.uk>, linux-sparse@vger.kernel.org

On Wed, 2007-06-27 at 23:05 -0700, Josh Triplett wrote:

> And the current approach of hard-coding all the sizes doesn't?
> 
> While I agree that I'd like a better approach (specifically, I want any Sparse
> build to support any target arch), I don't yet have a solution for that, and
> this patch does at least seem like an improvement over the current hardcoded
> values.

Another problem with this patch is that sparse is actually fed many "-m"
options that it's supposed to ignore, such as "-march=nocona" on my
x86_64.  That's makes live painful for native builds too.  So, adding
strict verification was a bit premature.

Ideally, sparse should know all "-m" options it's given.  I was wrong
that I only tested this change on userspace programs.

So please drop the patch for now.  However, this is not an attempt to
stop the discussion, as it may be very useful.

-- 
Regards,
Pavel Roskin
