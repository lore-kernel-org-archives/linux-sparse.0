From: Christopher Li <sparse@chrisli.org>
Subject: Re: Simple SSA status
Date: Thu, 7 Sep 2017 02:17:35 -0400
Message-ID: <CANeU7Qm+GAycxm4W=oVo1gzKR++cV-ZC3MCcq=5Gun92bsc4jg@mail.gmail.com>
References: <CANeU7QmekgnTBVF_7kZRAL-LB+g2W4MZbchxrApnQVeQk32wDw@mail.gmail.com>
 <20170903202629.bipsxi7xnmh3y3oy@ltop.local> <CANeU7Q==zoxfgzGLKS00AqZ-M07Whr9Nu5gZtANd4PK_u3J47A@mail.gmail.com>
 <20170904200720.cxxfecd7rugyfskx@ltop.local> <CANeU7Q=KV7k+z=SYyvkVJGFLmXE-Un2x-WQeGBmydTb0mj=dbQ@mail.gmail.com>
 <20170905005553.lwwo3hcre3vlgafd@ltop.local> <CANeU7Q=SSLWZL-AYLT8JMh9CVkJLaGVtWz2u5x4jNbgq3SKrDg@mail.gmail.com>
 <20170907020312.yt6z5jsfb4xn6m2a@ltop.local> <CA+55aFxFJf4T4kQq1oRNatFQnXuonPA-Dk7=xNTeU8u9cVyUGA@mail.gmail.com>
 <CANeU7Q=OXu+rma4BLt80bdMMjTz7t8TGX34Q4FJVQ5zRx1huag@mail.gmail.com>
 <20170907031723.pajy6pfuu6bgf577@ltop.local> <CANeU7Qm-m1zZvbcG7dH_-xkpm7SzSgHdx=uUEg6x6sLG_H+LgQ@mail.gmail.com>
 <CAExDi1QzPStG6SQUmnC8pEgHKMSqnW0zc=tt65_WzSNJMzsZOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f175.google.com ([209.85.161.175]:36757 "EHLO
        mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753468AbdIGGRh (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 7 Sep 2017 02:17:37 -0400
Received: by mail-yw0-f175.google.com with SMTP id w204so27633189ywg.3
        for <linux-sparse@vger.kernel.org>; Wed, 06 Sep 2017 23:17:37 -0700 (PDT)
In-Reply-To: <CAExDi1QzPStG6SQUmnC8pEgHKMSqnW0zc=tt65_WzSNJMzsZOg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Sep 7, 2017 at 12:49 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:

>>
>> That is only half of the job.
>
> No, it's the main job.

From the time complexity point of the view,
it is the not the main job. The later part is.

>> To get minimal SSA there is extra step
>> to remove duplicate phi nodes. That is quadratic if I recall correctly.
>
> Quadratic in what?

Simple SSA paper 4.1 Time Complexity.

O(P + B(B +E)*V*V).
that is O( B*B*V*V + B*E*V*V), where B is basic block,
E is edge, V is variables. That is why I consider it quadratic.

The first half or the part you consider the main job is not
nearly as bad.

> If you have plenty of phi-nodes with plenty of operands, you will have
> more work to do, irrespectively of the size of the graph and its reducibility.

The Keith et al paper is related to reducible. The simple SSA in the O()
form is not relate to reducible.

> Also, even if the reducibility is a property of the whole graph, it's not really
> what matters here because each phi-chain is to be taken independently.
> In other words, what matters here is if the *subgraph* involved in the
> phi-chain is reducible or not. So even if the graph is irreducible, you can
> have 99% of the phi as if the graph was reducible.
>
> Anyway, this minimal SSA and irreducibility is a nice theoretical question
> you seem a bit obsessed with. I absolutely don't care about because in

Minimal SSA is actually nice to have. Not minimal SSA will make the
optimization run less effectively. Cytron el al give minimal form.

> practice it won't make any noticeable difference.

I think it will have some difference there in terms of optimizations.
If we implement Cytron et al in the future, we can compare the result.

> OTOH, there is a huge number of things that can be done on sparse
> which *make* a lot of differences.

Sure, that is a separate patch.


> [Warning, I'm only talking here about the situation with Simple SSA,
> with the classic methods you have minimal SSA almost by definition but
> again 'minimal SSA' is 'minimal' only in this very narrow sense and it doesn't
> mean that no phi-nodes can be removed. For example, I'm pretty
> sure that what the "Simple SSA" article call 'trivial phi' *can* also
> happen even in minimal SSA].

I think trivial phi can't happen in minimal SSA. If you place phi node
in DF, it will need to have more than one parent and more than one
define.

OTOH, minimal SSA can have *dead* phi nodes. Liveness is
independent from the SSA form.

Chris
