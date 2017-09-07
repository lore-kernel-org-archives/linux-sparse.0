From: Christopher Li <sparse@chrisli.org>
Subject: Re: Simple SSA status
Date: Thu, 7 Sep 2017 00:04:45 -0400
Message-ID: <CANeU7Qm-m1zZvbcG7dH_-xkpm7SzSgHdx=uUEg6x6sLG_H+LgQ@mail.gmail.com>
References: <CANeU7QmekgnTBVF_7kZRAL-LB+g2W4MZbchxrApnQVeQk32wDw@mail.gmail.com>
 <20170903202629.bipsxi7xnmh3y3oy@ltop.local> <CANeU7Q==zoxfgzGLKS00AqZ-M07Whr9Nu5gZtANd4PK_u3J47A@mail.gmail.com>
 <20170904200720.cxxfecd7rugyfskx@ltop.local> <CANeU7Q=KV7k+z=SYyvkVJGFLmXE-Un2x-WQeGBmydTb0mj=dbQ@mail.gmail.com>
 <20170905005553.lwwo3hcre3vlgafd@ltop.local> <CANeU7Q=SSLWZL-AYLT8JMh9CVkJLaGVtWz2u5x4jNbgq3SKrDg@mail.gmail.com>
 <20170907020312.yt6z5jsfb4xn6m2a@ltop.local> <CA+55aFxFJf4T4kQq1oRNatFQnXuonPA-Dk7=xNTeU8u9cVyUGA@mail.gmail.com>
 <CANeU7Q=OXu+rma4BLt80bdMMjTz7t8TGX34Q4FJVQ5zRx1huag@mail.gmail.com> <20170907031723.pajy6pfuu6bgf577@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f180.google.com ([209.85.161.180]:35709 "EHLO
        mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750725AbdIGEEr (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 7 Sep 2017 00:04:47 -0400
Received: by mail-yw0-f180.google.com with SMTP id q80so2468226ywg.2
        for <linux-sparse@vger.kernel.org>; Wed, 06 Sep 2017 21:04:46 -0700 (PDT)
In-Reply-To: <20170907031723.pajy6pfuu6bgf577@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Sep 6, 2017 at 11:17 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> Bah ...
> Depending on the algorithm you use, irreducible graphs may indeed be a bit
> faster to calculate but since you don't know in advance if your graph is
 ^^^^^^^^
You mean slower here.

> reducible or not, you can't take advantage of that. So, at least to me,
> this doesn't make it a fast path.

Well, if the graph is not reducible, it will have a extra step to get
get minimal
SSA, that is what I consider the slow path.

For Cytron et al, the slowest part is finding dominator tree.
If using the Keith Cooper paper, reducible graph will converge
faster naturally. You don't need to know it is reducible or not in
advance to benefit from it.

>
>> On way to look at the Simple SSA paper is that, it is taking advanctage
>> of that fast path.
>
> No. It takes advantage at every point where it is known that all the parents
> have already been processed. That's all.

That is only half of the job. To get minimal SSA there is extra step
to remove duplicate phi nodes. That is quadratic if I recall correctly.

> The part where reducibility matter is after the conversion is done, if
> you whish to simplify what they call trivial phi-nodes. And again, since
> you don't know in advance if your graph is reducible or not, there is no
> fast path.

So you are saying in order to get minimal SSA, you need to run do the
remove extra phi node even if it is already minimal? Because we don't
know it is reducible or not.

Chris
