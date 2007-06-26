From: Josh Triplett <josht@linux.vnet.ibm.com>
Subject: Re: [PATCH 16/16] fix handling of integer constant expressions
Date: Tue, 26 Jun 2007 15:49:23 -0700
Message-ID: <1182898163.3191.7.camel@josh-work.beaverton.ibm.com>
References: <E1I2N6V-0003g9-8H@ZenIV.linux.org.uk>
	 <20070624174732.GZ21478@ftp.linux.org.uk>
	 <alpine.LFD.0.98.0706241102160.3593@woody.linux-foundation.org>
	 <20070624183547.GA21478@ftp.linux.org.uk>
	 <alpine.LFD.0.98.0706241203530.3593@woody.linux-foundation.org>
	 <1a25667a20e43a072f733a3ec2b8e79d@kernel.crashing.org>
	 <20070624203837.GE21478@ftp.linux.org.uk>
	 <467F531A.3030702@freedesktop.org>
	 <20070626221040.GI21478@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:54379 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752358AbXFZWtZ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 26 Jun 2007 18:49:25 -0400
In-Reply-To: <20070626221040.GI21478@ftp.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Josh Triplett <josh@freedesktop.org>, Segher Boessenkool <segher@kernel.crashing.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org

On Tue, 2007-06-26 at 23:10 +0100, Al Viro wrote:
> On Sun, Jun 24, 2007 at 10:31:06PM -0700, Josh Triplett wrote:
> > Al Viro wrote:
> > > Joy.  OK, folks, disregard 16/16 in the current form; everything prior
> > > to it stands on its own.
> > 
> > Acknowledged.  The rest of the patches look good to me, so I'll merge 1-15
> > soon, and ignore 16.
> 
> OK, here's the replacement.  First the handling of __builtin_offsetof()
> (below in this mail), then integer constant expressions (in followup).
> They can be pulled from
> git://git.kernel.org/pub/scm/linux/kernel/git/viro/sparse.git/ integer-constant

Both patches looked good to me in review, and neither changes the
validation output.  Merged.  Thanks!

- Josh Triplett
