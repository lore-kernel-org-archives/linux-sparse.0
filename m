From: Christopher Li <sparse@chrisli.org>
Subject: Re: Simple SSA status
Date: Mon, 4 Sep 2017 14:29:46 -0400
Message-ID: <CANeU7Q==zoxfgzGLKS00AqZ-M07Whr9Nu5gZtANd4PK_u3J47A@mail.gmail.com>
References: <CANeU7Q=9nUo+D3R3ypCS=-kND2vD_Qx84ua59_bi0-VGftPuqA@mail.gmail.com>
 <CAExDi1QryT9Hc6+yY0_E4Y6opsq3JiYo0KOidSDSj4VGD0J1Nw@mail.gmail.com>
 <CACXZuxfkduQSVJjzmYow5akJff_prmBeOS6Os-OnqCNpCCictA@mail.gmail.com>
 <CANeU7QmekgnTBVF_7kZRAL-LB+g2W4MZbchxrApnQVeQk32wDw@mail.gmail.com> <20170903202629.bipsxi7xnmh3y3oy@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f180.google.com ([209.85.161.180]:34316 "EHLO
        mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753932AbdIDS3r (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 4 Sep 2017 14:29:47 -0400
Received: by mail-yw0-f180.google.com with SMTP id k78so4896646ywe.1
        for <linux-sparse@vger.kernel.org>; Mon, 04 Sep 2017 11:29:47 -0700 (PDT)
In-Reply-To: <20170903202629.bipsxi7xnmh3y3oy@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Sun, Sep 3, 2017 at 4:26 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>>
>> Merge it when it is ready?
>
> I've put it on hold for the moment.

Thanks for the update. Glad to heard you back.

> The conversion of purely local vars was the easy job.
> The real challenge is to do it for the other loads & stores
> (in simplify_symbol_usage() & simplify_memops()).
> I'm working on it and have some encouraging results:
> - correct phi-nodes
> - pass the test-suite
> - no crashes in GCC test-suite and others
> - no infinite loops
> - no catastrophic performance on exceptional workoads
> - roughly convert as much stores & loads as currently
> - good performance (within 2-5% as rc5 on some workloads)
> - in some case, surprising good effect on optimization

That is great. Very exciting news.

>
> I don't know yet if keeping the Simple SSA during linearization
> will be worth to keep or not.

I have the same question as well.  When I find out the Simple SSA
can't handle memory to register using pointers. It already means
we need to keep the other non local variable path alive.
We can do some bench mark to find out. If the performance
is very similar, remove the simple SSA will actually simplify
the code because we only need to care about one code path.

>> Right now I do wish the SSSA has the two options I request
>> before.
>
> I don't remember what was the other option you asked but keeping
> both the old and the new method is not something I'm interested in.
> We know that the current method is broken. In fact, it's broken in two
> different ways:

I have no intend to keep the broken behavior. My wish list for the two
options rephrased:
1) Option to by pass the simpole SSA conversion which generate the
    raw load/store instruction before convert memory to register.
2) Option to do the memory to register conversion not cover by
    simple SSA conversion. It sounds like you implement this already.

> - the phi-nodes are mis-placed (they are on the use site instead of the
>   meet point).

Right. The meet point on the book also call Dominance Frontier :-)

> - each phi-nodes have as many sources as there are definitions for this
>   variable (more or less) instead of having one for each parents.

I am not sure I understand this. If you always place phi node at
DF. It will have as many source as incoming edge. That is part
of the common SSA dominance property. If we do it right, I can't
see why we still need the phi source instruction.


>
> I also recently discovered that the logic for aliases is broken.
> For example, code like:
>         int foo(void)
>         {
>                 int i = 1;
>                 int *a;
>                 int **p;
>
>                 a = &i;
>                 p = &a;
>                 *p[0] = 0;
>                 return i;
>         }
> is mis-compiled as it always returns 1 instead of 0
> (it fails to see that *p[0] is aliased to i).

That is exactly why we need instruction level aliases
analyze. The SSA conversion should be done after
aliases analyze.
>
> What I'm interested in is, in this order:
> 1) produce correct IR

Agree.

> 2) convert as much loads & stores as currently
>    (but only when it's correct to do it, of course)

Agree.

> 3) have performance that is similar as we currently have

Agree.

>
> Point 2) is needed to avoid more false warnings during
> context checking (and have a very significant effect on
> performance).

It seems we are all in agreement.

Chris
