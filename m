From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH 2/6] Hardcode actual type sizes, add -m32 support
Date: Thu, 28 Jun 2007 02:44:21 -0400
Message-ID: <1183013061.32164.31.camel@dv>
References: <20070628053954.30704.66440.stgit@dv.roinet.com>
	 <20070628053959.30704.91680.stgit@dv.roinet.com>
	 <20070628055850.GE21478@ftp.linux.org.uk>
	 <46834FA0.8010201@freedesktop.org>  <46835471.4070000@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fencepost.gnu.org ([140.186.70.10]:49927 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759125AbXF1Go0 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 28 Jun 2007 02:44:26 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1I3njt-00029H-Gr
	for linux-sparse@vger.kernel.org; Thu, 28 Jun 2007 02:44:25 -0400
In-Reply-To: <46835471.4070000@garzik.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Josh Triplett <josh@freedesktop.org>, Al Viro <viro@ftp.linux.org.uk>, linux-sparse@vger.kernel.org

On Thu, 2007-06-28 at 02:25 -0400, Jeff Garzik wrote:
> Josh Triplett wrote:
> > While I agree that I'd like a better approach (specifically, I want any Sparse
> > build to support any target arch), I don't yet have a solution for that, and
> > this patch does at least seem like an improvement over the current hardcoded
> > values.
> 
> That's my desire as well:  My ideal sparse backend should be able to 
> compile x86, x86-64, ppc64, ia64, arm, etc. with just a change of 
> command line switches.

That would probably mean having some runtime-loadable files describing
the architectures, as you would not want to describe the architecture
with several switches.

Perhaps some machine options could be described in those files, namely
whether they are acceptable and how they affect the architecture
description.

> The gcc approach is just bloody awful.

Ironically, gcc specfiles do something like that.  Of course, they are
not sufficient to actually _compile_ the code, but they may be
sufficient to verify that code.

-- 
Regards,
Pavel Roskin
