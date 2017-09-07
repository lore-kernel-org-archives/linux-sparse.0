From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Simple SSA status
Date: Thu, 7 Sep 2017 09:38:11 +0200
Message-ID: <CAExDi1QdWcEuYO_wSQ=+J+jMMNdt7N8OJCGhrPqimUp+RFOT7Q@mail.gmail.com>
References: <CANeU7QmekgnTBVF_7kZRAL-LB+g2W4MZbchxrApnQVeQk32wDw@mail.gmail.com>
 <20170903202629.bipsxi7xnmh3y3oy@ltop.local> <CANeU7Q==zoxfgzGLKS00AqZ-M07Whr9Nu5gZtANd4PK_u3J47A@mail.gmail.com>
 <20170904200720.cxxfecd7rugyfskx@ltop.local> <CANeU7Q=KV7k+z=SYyvkVJGFLmXE-Un2x-WQeGBmydTb0mj=dbQ@mail.gmail.com>
 <20170905005553.lwwo3hcre3vlgafd@ltop.local> <CANeU7Q=SSLWZL-AYLT8JMh9CVkJLaGVtWz2u5x4jNbgq3SKrDg@mail.gmail.com>
 <20170907020312.yt6z5jsfb4xn6m2a@ltop.local> <CA+55aFxFJf4T4kQq1oRNatFQnXuonPA-Dk7=xNTeU8u9cVyUGA@mail.gmail.com>
 <CANeU7Q=OXu+rma4BLt80bdMMjTz7t8TGX34Q4FJVQ5zRx1huag@mail.gmail.com>
 <20170907031723.pajy6pfuu6bgf577@ltop.local> <CANeU7Qm-m1zZvbcG7dH_-xkpm7SzSgHdx=uUEg6x6sLG_H+LgQ@mail.gmail.com>
 <CAExDi1QzPStG6SQUmnC8pEgHKMSqnW0zc=tt65_WzSNJMzsZOg@mail.gmail.com> <CANeU7Qm+GAycxm4W=oVo1gzKR++cV-ZC3MCcq=5Gun92bsc4jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lf0-f50.google.com ([209.85.215.50]:34280 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751055AbdIGHiO (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 7 Sep 2017 03:38:14 -0400
Received: by mail-lf0-f50.google.com with SMTP id l196so22597716lfl.1
        for <linux-sparse@vger.kernel.org>; Thu, 07 Sep 2017 00:38:13 -0700 (PDT)
In-Reply-To: <CANeU7Qm+GAycxm4W=oVo1gzKR++cV-ZC3MCcq=5Gun92bsc4jg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Sep 7, 2017 at 8:17 AM, Christopher Li <sparse@chrisli.org> wrote:
> On Thu, Sep 7, 2017 at 12:49 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>

>
> Minimal SSA is actually nice to have. Not minimal SSA will make the
> optimization run less effectively. Cytron el al give minimal form.
>
>> practice it won't make any noticeable difference.
>
> I think it will have some difference there in terms of optimizations.
> If we implement Cytron et al in the future, we can compare the result.

That's the difference between 'in practice' and '(in theory) it will have some'.

In practice, it will, of course, make a big difference *if* what you
have is not at
all minimal, like dumb-SSA. But if 99% of your phis are in fact needed and only
1% are part of the non-minimality, you won't see any *significant* differences.
It's not as if the presence of a single superfluous phi-node will
totally collapse
your performance.

In practice, it also won't make any significative difference because *even* if
you use gotos, this won't make automatically your graph irreducible.
To make your graph irreducible you need to have a goto that jump *into*
a loop and normally it's not something people write (think about it, when it
could make sense?). So in practice, even with gotos, you will rarely have
irreducible graphs and so even without implementing the full phi-node
simplification, you will have minimal SSA.

In practice, it also won't make a difference because the difference in
complexity
will only show up if you have a very large number of nodes and in this case
you have plenty of other problems to worry about (like memory consumption).

>> [Warning, I'm only talking here about the situation with Simple SSA,
>> with the classic methods you have minimal SSA almost by definition but
>> again 'minimal SSA' is 'minimal' only in this very narrow sense and it doesn't
>> mean that no phi-nodes can be removed. For example, I'm pretty
>> sure that what the "Simple SSA" article call 'trivial phi' *can* also
>> happen even in minimal SSA].
>
> I think trivial phi can't happen in minimal SSA. If you place phi node
> in DF, it will need to have more than one parent and more than one
> define.

Thing is that these trivial/redundant phis (as defined in the SSSA article)
can also happen when phi-nodes are placed at the DF. They happen
naturally in some loops. In the article, when talking about these, they
explicitly say "This implies a definition of minimality [that is independent
of the source program and] *more strict* than the definition by Cytron et al."
So it's pretty clear that even with minimal SSA (Cytron's minimality)
you can have those redundant phis. In other words, if you eliminate all
redundant phi-nodes as described in SSSA not only you will not
have more phi-nodes than Cytron but you *can*, in some case, have less!

Anyway, the advantages of the SSSA is not here.


-- Luc
