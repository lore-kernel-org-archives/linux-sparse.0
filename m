From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] Re: Fun with Linux 2.6.21-rc1
Date: Fri, 23 Feb 2007 20:53:12 -0500
Message-ID: <1172281992.19767.20.camel@dv>
References: <1172251518.6229.6.camel@dv> <1172260766.14431.3.camel@dv>
	 <20070223223027.GA5671@chrisli.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fencepost.gnu.org ([199.232.76.164]:55953 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933327AbXBXBxO (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 23 Feb 2007 20:53:14 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1HKm4c-0006B9-SN
	for linux-sparse@vger.kernel.org; Fri, 23 Feb 2007 20:51:42 -0500
In-Reply-To: <20070223223027.GA5671@chrisli.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

On Fri, 2007-02-23 at 14:30 -0800, Christopher Li wrote:
> On Fri, Feb 23, 2007 at 02:59:26PM -0500, Pavel Roskin wrote:
> > P.S. The breakage has nothing to do to Linux changes.  It was caused by
> > the patch called "Make the ptrlist using the sparse allocator".  Undoing
> > the patch fixes the problem.
> >
> 
> No, that was not it. The bug does not trigger if I remove "-O" or remove
> the recent struct attribute patch.
> 
> You make me guilt for 5 mins. But the real bugs is match_idents did not
> end with NULL.

I understand your patch triggered a bug that was sitting there for more
than two years.  That's quite rare.  Sorry for assuming your guilt.

> This patch should fix it:

Yes, it's working.  Thank you!

-- 
Regards,
Pavel Roskin
