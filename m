From: Christopher Li <sparse@chrisli.org>
Subject: Re: Simple SSA status
Date: Mon, 4 Sep 2017 23:28:07 -0400
Message-ID: <CANeU7Q=SSLWZL-AYLT8JMh9CVkJLaGVtWz2u5x4jNbgq3SKrDg@mail.gmail.com>
References: <CANeU7Q=9nUo+D3R3ypCS=-kND2vD_Qx84ua59_bi0-VGftPuqA@mail.gmail.com>
 <CAExDi1QryT9Hc6+yY0_E4Y6opsq3JiYo0KOidSDSj4VGD0J1Nw@mail.gmail.com>
 <CACXZuxfkduQSVJjzmYow5akJff_prmBeOS6Os-OnqCNpCCictA@mail.gmail.com>
 <CANeU7QmekgnTBVF_7kZRAL-LB+g2W4MZbchxrApnQVeQk32wDw@mail.gmail.com>
 <20170903202629.bipsxi7xnmh3y3oy@ltop.local> <CANeU7Q==zoxfgzGLKS00AqZ-M07Whr9Nu5gZtANd4PK_u3J47A@mail.gmail.com>
 <20170904200720.cxxfecd7rugyfskx@ltop.local> <CANeU7Q=KV7k+z=SYyvkVJGFLmXE-Un2x-WQeGBmydTb0mj=dbQ@mail.gmail.com>
 <20170905005553.lwwo3hcre3vlgafd@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f177.google.com ([209.85.161.177]:36000 "EHLO
        mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753774AbdIED2I (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 4 Sep 2017 23:28:08 -0400
Received: by mail-yw0-f177.google.com with SMTP id w204so8155328ywg.3
        for <linux-sparse@vger.kernel.org>; Mon, 04 Sep 2017 20:28:08 -0700 (PDT)
In-Reply-To: <20170905005553.lwwo3hcre3vlgafd@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Mon, Sep 4, 2017 at 8:55 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> It can and it has pro & cons
> - pro: the CFG is know in advance, so no complication with gotos
> - cons: for non-goto blocks during linearization we know when
>         all the predecessors have been already processed
>         If done after lineariation, this info need to be somehow
>         deduced (but it's just keeping a flag).

For non-goto blocks the dominator tree is easy.

>>
>> I am thinking at some point we might just do a proper Cytron et al then
>> we might be able to discard those simplify. Those simplify are ad hoc
>> any way.
>
> If you look at the literature you will see two things:
> - either the article doesn't talk at all about which variable are
>   processed, so the alias problem is ignored and implicitly they
>   talk only about local vars (which address is never taken in any way)
> - or they explicitly say that for this or that reason SSA is only
>   well suited for local vars (which address is never taken in any way)
> - only rarely is there any mention that some alias analysis must be
>   done *before* conversion to select which variable can be converted
>
> So, if it is to do Cytron or else but only on local var, I largely
> prefer the Simple SSA way. And this still leave open the problem
> for the others variables.

I mean do the Cytron et al for all memory store/load, not just
limit to local variable. Yes, it will need the help of alias analyze.

> Of course, the later depends on the former but the problem for non-local
> variables is not the same as the one for local variables, you need to take
> in account the presence of calls, stores to unrelated vars (and non-var),
> ... You can consider this as being part of the alias analysis if you
> wish but ...

Local variable can have address taken and pass around as well.
If you only look at local variable has never been taken address,
yes, that is different than the rest. But that different is largely due to how
you select the set as well. If you consider the more general case,
local variable can have address taken, it is just like other memory
storage.

> Yes yes yes, it's wrong. What I meant by "often it's not a problem"
> is that currently, with the help of the phisources, often the code
> can deal with it and do something sensical.
> This doesn't make it less wrong and there is also enough situations
> where the code can't possibly do anything sensical with it.

Yes, I think we have the same view on this.

>> It is conflict with the SSA dominance property. Every incoming edge
>> should have one definition. It should  not have more than one
>> define per incoming edge.
>
> Currently, there is no relation between phi-nodes operands and
> incoming edges. The only relation that exist (and that the code
> need and care about) is the one between phi-nodes and their
> phi-sources.
>
>> Do you have example?
>
> I have lots of examples :)
> In a few days I'll submit a series of test cases and some will
> be exhibit this.  A simple example is:
>         #define TEST(N)                 \
>                 do {                    \
>                         d = b + a[N];   \
>                         if (d < b)      \
>                                 c++;    \
>                         b = d;          \
>                 } while (0)
>
>         int foo(int *a, int b, int c)
>         {
>                 int d;
>
>                 TEST(0);
>                 TEST(1);
>                 TEST(2);
>
>                 return d + c;
>         }
>
> Where you will have 3 phi-nodes (OK, there is 3 ifs), the first with
> 2 sources (OK), the second with 3 and the third with 4 sources while
> all nodes have 2 parents or less.
> Even more interestingly, if you add another TEST(x), you will have
> another phi-node with ... 5 sources and so one. One more source for
> each TEST(x) invocation, so yes this give a nice quadratic processing
> time and memory consumption.

Yes, we are talking about how things done wrong right now,
Not how things should be.

Chris
