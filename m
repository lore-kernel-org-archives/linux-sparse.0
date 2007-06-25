From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH 16/16] fix handling of integer constant expressions
Date: Mon, 25 Jun 2007 20:55:11 +0100
Message-ID: <20070625195511.GG21478@ftp.linux.org.uk>
References: <E1I2N6V-0003g9-8H@ZenIV.linux.org.uk> <20070624174732.GZ21478@ftp.linux.org.uk> <alpine.LFD.0.98.0706241102160.3593@woody.linux-foundation.org> <20070624183547.GA21478@ftp.linux.org.uk> <alpine.LFD.0.98.0706241203530.3593@woody.linux-foundation.org> <1a25667a20e43a072f733a3ec2b8e79d@kernel.crashing.org> <20070624203837.GE21478@ftp.linux.org.uk> <467F531A.3030702@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:56349 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753212AbXFYTzO (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 25 Jun 2007 15:55:14 -0400
Content-Disposition: inline
In-Reply-To: <467F531A.3030702@freedesktop.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: Segher Boessenkool <segher@kernel.crashing.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org

On Sun, Jun 24, 2007 at 10:31:06PM -0700, Josh Triplett wrote:
> Al Viro wrote:
> > Joy.  OK, folks, disregard 16/16 in the current form; everything prior
> > to it stands on its own.
> 
> Acknowledged.  The rest of the patches look good to me, so I'll merge 1-15
> soon, and ignore 16.
> 
> Do you have those patches in public git somewhere, or would you like me to
> just apply the patches from mail?

git://git.kernel.org/pub/scm/linux/kernel/git/viro/sparse.git/ misc

(or directly from hera)
