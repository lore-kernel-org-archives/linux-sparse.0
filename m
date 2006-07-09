From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] Fix warnings from gcc 4.1.1
Date: Sun, 09 Jul 2006 02:31:43 -0400
Message-ID: <1152426703.6603.2.camel@dv>
References: <20060708060004.20321.50429.stgit@dv.roinet.com>
	 <Pine.LNX.4.64.0607081053560.3869@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fencepost.gnu.org ([199.232.76.164]:6531 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S932087AbWGIGbu
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sun, 9 Jul 2006 02:31:50 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1FzSpZ-0006LI-Dj
	for linux-sparse@vger.kernel.org; Sun, 09 Jul 2006 02:31:49 -0400
In-Reply-To: <Pine.LNX.4.64.0607081053560.3869@g5.osdl.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-sparse@vger.kernel.org

On Sat, 2006-07-08 at 11:14 -0700, Linus Torvalds wrote:
> Actually, _that_ is a bug.

Indeed, that's a bug number 26632:
http://gcc.gnu.org/bugzilla/show_bug.cgi?id=26632

Nobody is arguing that it's a feature.

The warning is gone from sparse.  Thank you!

-- 
Regards,
Pavel Roskin
