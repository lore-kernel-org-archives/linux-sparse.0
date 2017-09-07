From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Simple SSA status
Date: Thu, 7 Sep 2017 06:49:40 +0200
Message-ID: <CAExDi1QzPStG6SQUmnC8pEgHKMSqnW0zc=tt65_WzSNJMzsZOg@mail.gmail.com>
References: <CANeU7QmekgnTBVF_7kZRAL-LB+g2W4MZbchxrApnQVeQk32wDw@mail.gmail.com>
 <20170903202629.bipsxi7xnmh3y3oy@ltop.local> <CANeU7Q==zoxfgzGLKS00AqZ-M07Whr9Nu5gZtANd4PK_u3J47A@mail.gmail.com>
 <20170904200720.cxxfecd7rugyfskx@ltop.local> <CANeU7Q=KV7k+z=SYyvkVJGFLmXE-Un2x-WQeGBmydTb0mj=dbQ@mail.gmail.com>
 <20170905005553.lwwo3hcre3vlgafd@ltop.local> <CANeU7Q=SSLWZL-AYLT8JMh9CVkJLaGVtWz2u5x4jNbgq3SKrDg@mail.gmail.com>
 <20170907020312.yt6z5jsfb4xn6m2a@ltop.local> <CA+55aFxFJf4T4kQq1oRNatFQnXuonPA-Dk7=xNTeU8u9cVyUGA@mail.gmail.com>
 <CANeU7Q=OXu+rma4BLt80bdMMjTz7t8TGX34Q4FJVQ5zRx1huag@mail.gmail.com>
 <20170907031723.pajy6pfuu6bgf577@ltop.local> <CANeU7Qm-m1zZvbcG7dH_-xkpm7SzSgHdx=uUEg6x6sLG_H+LgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lf0-f50.google.com ([209.85.215.50]:38829 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751780AbdIGEtm (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 7 Sep 2017 00:49:42 -0400
Received: by mail-lf0-f50.google.com with SMTP id q132so21830489lfe.5
        for <linux-sparse@vger.kernel.org>; Wed, 06 Sep 2017 21:49:41 -0700 (PDT)
In-Reply-To: <CANeU7Qm-m1zZvbcG7dH_-xkpm7SzSgHdx=uUEg6x6sLG_H+LgQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Sep 7, 2017 at 6:04 AM, Christopher Li <sparse@chrisli.org> wrote:
> On Wed, Sep 6, 2017 at 11:17 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>>
>> Bah ...
>> Depending on the algorithm you use, irreducible graphs may indeed be a bit
>> faster to calculate but since you don't know in advance if your graph is
>  ^^^^^^^^
> You mean slower here.

Of course.

>> reducible or not, you can't take advantage of that. So, at least to me,
>> this doesn't make it a fast path.
>
> Well, if the graph is not reducible, it will have a extra step to get
> get minimal
> SSA, that is what I consider the slow path.
>
> For Cytron et al, the slowest part is finding dominator tree.
> If using the Keith Cooper paper, reducible graph will converge
> faster naturally. You don't need to know it is reducible or not in
> advance to benefit from it.

OK, it's just faster on reducible graphs.

>>
>>> On way to look at the Simple SSA paper is that, it is taking advanctage
>>> of that fast path.
>>
>> No. It takes advantage at every point where it is known that all the parents
>> have already been processed. That's all.
>
> That is only half of the job.

No, it's the main job.

> To get minimal SSA there is extra step
> to remove duplicate phi nodes. That is quadratic if I recall correctly.

Quadratic in what?
If you have plenty of phi-nodes with plenty of operands, you will have
more work to do, irrespectively of the size of the graph and its reducibility.

Also, even if the reducibility is a property of the whole graph, it's not really
what matters here because each phi-chain is to be taken independently.
In other words, what matters here is if the *subgraph* involved in the
phi-chain is reducible or not. So even if the graph is irreducible, you can
have 99% of the phi as if the graph was reducible.

Anyway, this minimal SSA and irreducibility is a nice theoretical question
you seem a bit obsessed with. I absolutely don't care about because in
practice it won't make any noticeable difference.
OTOH, there is a huge number of things that can be done on sparse
which *make* a lot of differences.

>> The part where reducibility matter is after the conversion is done, if
>> you whish to simplify what they call trivial phi-nodes. And again, since
>> you don't know in advance if your graph is reducible or not, there is no
>> fast path.
>
> So you are saying in order to get minimal SSA, you need to run do the
> remove extra phi node even if it is already minimal? Because we don't
> know it is reducible or not.

Yes and no.
There are a lot of cases where you can simplify away the phi-nodes by
simple ways.  For the remaining ones, yes, most probably.

[Warning, I'm only talking here about the situation with Simple SSA,
with the classic methods you have minimal SSA almost by definition but
again 'minimal SSA' is 'minimal' only in this very narrow sense and it doesn't
mean that no phi-nodes can be removed. For example, I'm pretty
sure that what the "Simple SSA" article call 'trivial phi' *can* also
happen even in minimal SSA].

-- Luc
