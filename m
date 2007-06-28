From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2/6] Hardcode actual type sizes, add -m32 support
Date: Thu, 28 Jun 2007 02:47:37 -0400
Message-ID: <46835989.5030805@garzik.org>
References: <20070628053954.30704.66440.stgit@dv.roinet.com> <20070628053959.30704.91680.stgit@dv.roinet.com> <20070628055850.GE21478@ftp.linux.org.uk> <46834FA0.8010201@freedesktop.org>  <46835471.4070000@garzik.org> <1183013061.32164.31.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:46537 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759780AbXF1Grl (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 28 Jun 2007 02:47:41 -0400
In-Reply-To: <1183013061.32164.31.camel@dv>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
Cc: Josh Triplett <josh@freedesktop.org>, Al Viro <viro@ftp.linux.org.uk>, linux-sparse@vger.kernel.org

Pavel Roskin wrote:
> On Thu, 2007-06-28 at 02:25 -0400, Jeff Garzik wrote:
>> Josh Triplett wrote:
>>> While I agree that I'd like a better approach (specifically, I want any Sparse
>>> build to support any target arch), I don't yet have a solution for that, and
>>> this patch does at least seem like an improvement over the current hardcoded
>>> values.
>> That's my desire as well:  My ideal sparse backend should be able to 
>> compile x86, x86-64, ppc64, ia64, arm, etc. with just a change of 
>> command line switches.
> 
> That would probably mean having some runtime-loadable files describing
> the architectures,

Runtime-loadable, or compiled in.  But in general... agreed.


>> The gcc approach is just bloody awful.
> 
> Ironically, gcc specfiles do something like that.  Of course, they are
> not sufficient to actually _compile_ the code, but they may be
> sufficient to verify that code.

I was mainly grousing about having to recompile gcc for each target, 
which is insanely silly.

	Jeff
