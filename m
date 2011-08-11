From: blp@cs.stanford.edu (Ben Pfaff)
Subject: intended use of "safe"?
Date: Thu, 11 Aug 2011 10:14:22 -0700
Message-ID: <874o1nzx8x.fsf@blp.benpfaff.org>
Reply-To: blp@cs.stanford.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:59070 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751041Ab1HKSPI (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 11 Aug 2011 14:15:08 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcps-linux-sparse@m.gmane.org>)
	id 1QrZmc-0004U1-QD
	for linux-sparse@vger.kernel.org; Thu, 11 Aug 2011 20:15:06 +0200
Received: from 76.14.48.202 ([76.14.48.202])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-sparse@vger.kernel.org>; Thu, 11 Aug 2011 20:15:06 +0200
Received: from blp by 76.14.48.202 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-sparse@vger.kernel.org>; Thu, 11 Aug 2011 20:15:06 +0200
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

It looks like the sparse "safe" attribute warns about use of
"safe" values as conditional expressions.  It's not obvious to me
when I would find that useful.

What is the intended use of the sparse "safe" attribute?  I do
not see any uses of it in Linux (although there is a __safe macro
for it).  I don't see any documentation for it either.

Thanks,

Ben.
-- 
Ben Pfaff 
http://benpfaff.org

