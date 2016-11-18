From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 0/2] be more generous with ptrlist repacking
Date: Fri, 18 Nov 2016 13:26:03 +0100
Message-ID: <20161118122602.GA476@macbook.local>
References: <20161117172559.29417-1-luc.vanoostenryck@gmail.com>
 <CA+55aFwYGCD-+GhVLdHedu42cu1RyT+Ko9Dj6-pfTrPv0ZD5Jg@mail.gmail.com>
 <20161117202523.GA35194@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33713 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752307AbcKRM0L (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 18 Nov 2016 07:26:11 -0500
Received: by mail-wm0-f65.google.com with SMTP id u144so5710386wmu.0
        for <linux-sparse@vger.kernel.org>; Fri, 18 Nov 2016 04:26:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20161117202523.GA35194@macpro.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>, Dan Carpenter <dan.carpenter@oracle.com>

On Thu, Nov 17, 2016 at 09:25:24PM +0100, Luc Van Oostenryck wrote:
> Would something like the following be fine?
> 
...

> I've quickly checked it on the testsuite (and it seems to pass ;).
> I'll validate this more thoroughly but I won't be able to do this
> just now.

OK, I've run it on a much bigger set: a make C=2 kernel with allyesconfig,
the same tree as the test I did previously and it gives me the same result
and, of course, no crashes.
So for me the changes are OK.

Tested-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
