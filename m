From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH 7] Adding the interrupt checker
Date: Mon, 02 Apr 2007 12:52:18 -0400
Message-ID: <1175532738.10606.24.camel@dv>
References: <5166c2f30703301726q2a3cfb91p7fdb5f7ae146d22d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fencepost.gnu.org ([199.232.76.164]:32865 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933372AbXDBQwV (ORCPT
	<rfc822;linux-sparse@VGER.KERNEL.ORG>);
	Mon, 2 Apr 2007 12:52:21 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1HYPjJ-00086g-U8
	for linux-sparse@VGER.KERNEL.ORG; Mon, 02 Apr 2007 12:50:06 -0400
In-Reply-To: <5166c2f30703301726q2a3cfb91p7fdb5f7ae146d22d@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Suhabe Bugrara <suhabe@stanford.edu>
Cc: linux-sparse@VGER.KERNEL.ORG

On Fri, 2007-03-30 at 17:26 -0700, Suhabe Bugrara wrote:
> On Thu, 2007-03-01 at 6:07:06, Pavel Roskin wrote:
> > Moreover, I think that incorrect use of locking is a remaining major
> > issue not covered by sparse.
> 
> Hello,
> 
> What particular locking usage rules would Sparse ideally check? I
> guess this would include finding double locking/unlocking errors. Are
> there other more important locking usage rules?

I suggest that we check what we can.  The priority should be given to
whatever check finds most (and/or worst) errors with minimal annotation.

I wish we could have rules mandating certain locks to be held when some
data is accessed, but there should be an exception for initialization
stage, when the data is being populated.

> Could locking errors
> in the kernel be potentially more serious than dereferencing an
> unchecked user pointer for example?

It's hard to compare seriousness.  Lockups are normally treated as less
serious bugs than unauthorized access.  On the other hand unauthorized
access rarely leads to anything more serious than embarrassment and
monetary loss, whereas lockups could lead to life loss, even if the
equipment is not connected to the network.  Think of airplanes losing
control, unexploded munitions, life support equipment stopping when it's
most needed etc.

-- 
Regards,
Pavel Roskin
