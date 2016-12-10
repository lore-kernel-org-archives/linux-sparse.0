From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH] fix typing error in compound assignment
Date: Sat, 10 Dec 2016 02:14:00 +0000
Message-ID: <20161210021400.GG1555@ZenIV.linux.org.uk>
References: <20161207143342.88825-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:60236 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751953AbcLJCOD (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 9 Dec 2016 21:14:03 -0500
Content-Disposition: inline
In-Reply-To: <20161207143342.88825-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>

On Wed, Dec 07, 2016 at 03:33:42PM +0100, Luc Van Oostenryck wrote:
> But what is really done currently is something like:
> 	x = x + (typeof(x)) a;
> In other words, the left-hand side is casted to the same type as the
> rhs and the operation is always done with this type, neglecting the
> usual conversions and thus forcing the operation to always be done
> with the rhs type, here 'int' instead of 'long'.

Addition is a bad example, actually - your variant (promotions + operaton +
cast down to the first argument due to assignment) will yield the same value.
It's division where the real trouble happens -
	unsigned n1 = 1, n2 = 1;
	long v = -1;
	n1 /= v;
	n2 /= (unsigned)v;

should yield n1 == ~0U, n2 == 0.  And yes, the current logics in sparse
does not distinguish between those.  So ACK on the fix, but you want
a better testcase.
