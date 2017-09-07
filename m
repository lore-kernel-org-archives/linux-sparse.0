From: Christopher Li <sparse@chrisli.org>
Subject: Re: Simple SSA status
Date: Wed, 6 Sep 2017 22:55:43 -0400
Message-ID: <CANeU7Q=OXu+rma4BLt80bdMMjTz7t8TGX34Q4FJVQ5zRx1huag@mail.gmail.com>
References: <CANeU7Q=9nUo+D3R3ypCS=-kND2vD_Qx84ua59_bi0-VGftPuqA@mail.gmail.com>
 <CAExDi1QryT9Hc6+yY0_E4Y6opsq3JiYo0KOidSDSj4VGD0J1Nw@mail.gmail.com>
 <CACXZuxfkduQSVJjzmYow5akJff_prmBeOS6Os-OnqCNpCCictA@mail.gmail.com>
 <CANeU7QmekgnTBVF_7kZRAL-LB+g2W4MZbchxrApnQVeQk32wDw@mail.gmail.com>
 <20170903202629.bipsxi7xnmh3y3oy@ltop.local> <CANeU7Q==zoxfgzGLKS00AqZ-M07Whr9Nu5gZtANd4PK_u3J47A@mail.gmail.com>
 <20170904200720.cxxfecd7rugyfskx@ltop.local> <CANeU7Q=KV7k+z=SYyvkVJGFLmXE-Un2x-WQeGBmydTb0mj=dbQ@mail.gmail.com>
 <20170905005553.lwwo3hcre3vlgafd@ltop.local> <CANeU7Q=SSLWZL-AYLT8JMh9CVkJLaGVtWz2u5x4jNbgq3SKrDg@mail.gmail.com>
 <20170907020312.yt6z5jsfb4xn6m2a@ltop.local> <CA+55aFxFJf4T4kQq1oRNatFQnXuonPA-Dk7=xNTeU8u9cVyUGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f169.google.com ([209.85.161.169]:32877 "EHLO
        mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751985AbdIGCzp (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 6 Sep 2017 22:55:45 -0400
Received: by mail-yw0-f169.google.com with SMTP id s62so11549033ywg.0
        for <linux-sparse@vger.kernel.org>; Wed, 06 Sep 2017 19:55:44 -0700 (PDT)
In-Reply-To: <CA+55aFxFJf4T4kQq1oRNatFQnXuonPA-Dk7=xNTeU8u9cVyUGA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Sep 6, 2017 at 10:15 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> Even this is not the case.
>
> Not for a C compiler, it isn't.
>
> Sure, if you do compilers for toy languages, it might be, but a C
> compiler has things like "switch()" statements that may not nest with
> loops etc. So even without a goto, you can pretty much have arbitrary
> flow.

I am trying to think if without goto statement, can we create irreducible
graph. The for reducible graph, finding dominator has fast path.
On way to look at the Simple SSA paper is that, it is taking advanctage
of that fast path. The slow path is actually worse than other algorithm.

I originally thinking we have to use goto to create irreducible graph.
Now you mention it. You are right, with creatively mixing of switch
statement and while loop. Some one can create irreducible graph
without goto.

> So I think people should entirely stop thinking that "goto" is somehow
> special. It isn't. It is only special in toy languages like Pascal,
> not in the real world.

Goto can introduce the irreducible graph. That is the only
special part. The compiler of course need to handle all kind of
CFG.

> It's much better to get rid of that "goto is special" mindset, and
> instead say "all control flow is just a goto in the end".
>
> So yes, get rid of the *real* special cases - those structured flow
> constructs. They are nice special cases, but they are nice for
> *humans*, they aren't actually relevant to computers, and they
> shouldn't be.

The only relevant part to computer is weather a fast path exist or not.

> So the real special case is those simple "structured" loops. You
> should never design around them, because it will just hurt later.

In a sense that is why I like the Cytron el al for the SSA conversion
over Simple SSA. Cytron el al does not have special case for
non structured CFG. If the CFG is reducible, the algorithm will
run faster naturally.

Chris
