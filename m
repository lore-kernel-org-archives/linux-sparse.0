From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] fix typing error in compound assignment
Date: Sat, 10 Dec 2016 07:25:14 +0100
Message-ID: <20161210062513.GA5558@macbook.local>
References: <20161207143342.88825-1-luc.vanoostenryck@gmail.com>
 <20161210021400.GG1555@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36587 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751360AbcLJGZU (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 10 Dec 2016 01:25:20 -0500
Received: by mail-wm0-f66.google.com with SMTP id m203so820315wma.3
        for <linux-sparse@vger.kernel.org>; Fri, 09 Dec 2016 22:25:19 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20161210021400.GG1555@ZenIV.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>

On Sat, Dec 10, 2016 at 02:14:00AM +0000, Al Viro wrote:
> On Wed, Dec 07, 2016 at 03:33:42PM +0100, Luc Van Oostenryck wrote:
> > But what is really done currently is something like:
> > 	x = x + (typeof(x)) a;
> > In other words, the left-hand side is casted to the same type as the
> > rhs and the operation is always done with this type, neglecting the
> > usual conversions and thus forcing the operation to always be done
> > with the rhs type, here 'int' instead of 'long'.
> 
> Addition is a bad example, actually - your variant (promotions + operaton +
> cast down to the first argument due to assignment) will yield the same value.
> It's division where the real trouble happens -
> 	unsigned n1 = 1, n2 = 1;
> 	long v = -1;
> 	n1 /= v;
> 	n2 /= (unsigned)v;
> 
> should yield n1 == ~0U, n2 == 0.  And yes, the current logics in sparse
> does not distinguish between those.  So ACK on the fix, but you want
> a better testcase.

Absolutely. In fact, I found the problem when a was a double and
I saw that the addition was still done with a 32bit wide operation.
I used this example because there is too much problems with floating-point
operations.
I'll reuse your example, which is more 'dramatic' that mine.

Thanks for the review.
