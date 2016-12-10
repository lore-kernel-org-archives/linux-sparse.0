From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] fix typing error in compound assignment
Date: Sat, 10 Dec 2016 23:40:47 +0100
Message-ID: <20161210224046.GA7541@macbook.local>
References: <20161210095221.1641-1-luc.vanoostenryck@gmail.com>
 <2d5af300-0a96-aec0-27a9-61efd768cdd2@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wj0-f195.google.com ([209.85.210.195]:36223 "EHLO
        mail-wj0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752250AbcLJWkw (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 10 Dec 2016 17:40:52 -0500
Received: by mail-wj0-f195.google.com with SMTP id j10so6662140wjb.3
        for <linux-sparse@vger.kernel.org>; Sat, 10 Dec 2016 14:40:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <2d5af300-0a96-aec0-27a9-61efd768cdd2@ramsayjones.plus.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: linux-sparse@vger.kernel.org

On Sat, Dec 10, 2016 at 09:22:52PM +0000, Ramsay Jones wrote:
> On 10/12/16 09:52, Luc Van Oostenryck wrote:
> > But what is really done currently is something like:
> > 	x = x / (unsigned int) a;
> > In other words, the left-hand side is casted to the same type as the
> > rhs and the operation is always done with this type, neglecting the
> > usual conversions and thus forcing the operation to always be done
> > with the rhs type, here 'unsigned int' instead of 'long'.
> 
> I have read this paragraph repeatedly, but I just can't understand
> what you are saying, unless I swap left-hand-side for right-hand-side
> and vice-versa. :-P

Hum ... yes, you're absolutely right.
Thanks.
