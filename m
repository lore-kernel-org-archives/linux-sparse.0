From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH] fix typing error in compound assignment
Date: Sat, 10 Dec 2016 21:22:52 +0000
Message-ID: <2d5af300-0a96-aec0-27a9-61efd768cdd2@ramsayjones.plus.com>
References: <20161210095221.1641-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from avasout06.plus.net ([212.159.14.18]:58766 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752087AbcLJVaf (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 10 Dec 2016 16:30:35 -0500
In-Reply-To: <20161210095221.1641-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Al Viro <viro@zeniv.linux.org.uk>



On 10/12/16 09:52, Luc Van Oostenryck wrote:
> A compound assignment like, for example:
> 	x /= a;
> should have the same effect as the operation followed by the
> assignment except that the left side should only be evaluated
> once. So the statement above (assuming 'x' free of side-effects)
> should have the same effect as:
> 	x = x / a;
> 
> In particular, the usual conversions should applied. So, if the
> type of 'x' and 'a' is, respectively, 'unsigned int' (32 bit) and
> 'long' (64 bit), the statement above should be equivalent to:
> 	x = (unsigned int) ((long) x / a);
> 
> But what is really done currently is something like:
> 	x = x / (unsigned int) a;
> In other words, the left-hand side is casted to the same type as the
> rhs and the operation is always done with this type, neglecting the
> usual conversions and thus forcing the operation to always be done
> with the rhs type, here 'unsigned int' instead of 'long'.

I have read this paragraph repeatedly, but I just can't understand
what you are saying, unless I swap left-hand-side for right-hand-side
and vice-versa. :-P

> For example, with the values:
>         unsigned int x;
          ^^^^^^^^^^^^^^^
          unsigned int x = 1;

>         long a = -1;
> 
> We have:
> 	x = 1 / (unsigned int) (-1);
> 	x = 1 / 0xffffffff;
> 	x = 0;
> instead of the expected:
> 	x = (unsigned int) (1L / -1L);

        x = (unsigned int) ((long)1 / -1L);

> 	x = (unsigned int) (-1L);
> 	x = 0xffffffff;
> 

ATB,
Ramsay Jones


