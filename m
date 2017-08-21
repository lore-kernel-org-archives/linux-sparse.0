From: Christopher Li <sparse@chrisli.org>
Subject: Re: SSSA and some C pointer manipulation.
Date: Sun, 20 Aug 2017 23:29:52 -0400
Message-ID: <CANeU7QmSDAAr+mgs+GC58Hb3kB=jx1p3m9Df3cmR4KfjQgoq8g@mail.gmail.com>
References: <CANeU7Qm-k0xzRXwVx0bSg688+yFTa_PrC7EnKdyJY8HCWZT-uw@mail.gmail.com>
 <CAExDi1Tgs7UpXm0OCwLbLDVfZsAHQx2z-ygWEQ1fUnWVU1aNXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f173.google.com ([209.85.161.173]:35953 "EHLO
        mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750962AbdHUD3y (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 20 Aug 2017 23:29:54 -0400
Received: by mail-yw0-f173.google.com with SMTP id y64so47851ywf.3
        for <linux-sparse@vger.kernel.org>; Sun, 20 Aug 2017 20:29:53 -0700 (PDT)
In-Reply-To: <CAExDi1Tgs7UpXm0OCwLbLDVfZsAHQx2z-ygWEQ1fUnWVU1aNXg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Aug 20, 2017 at 12:18 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>> One thing I notices is that, if the use site is very far
>> from define, there are a lot of blocks in between. That
>> will cause a lot of possible phi node to be created.
>
> That's not what's happenning or what should happening.
> I know that in such situation the current SSA may
> creates fewer phi-nodes because the creation of phi-nodes
> are delayed to the point where the value is effectively
> used, but the's precisely why this method is wrong.

I am more on the line of thinking comparing the SSSA vs
fixing the previous SSA method, place the phi node in DF.

> On the other hand, I have some very nice examples
> where you have N if-statements and the current SSA
> method creates N^2 phi-nodes while only N are needed
> and the new method only creates these N ones.
>
> It's really dangerous to compare the new method with
> the old one because the old one does it wrongly.

Yes, the current method does it wrong. I am trying
to evaluate what doe it take to get it right, fixing it
vs having the new rewrite of SSSA.

> It's very confusing to use the word 'C pointer' here.
> A pointer is just a value like any other. What's you're
> talking about, I think, is variables accessed through a
> pointer.

No necessary variables. It can be just memory objects
like link->next, link->prev etc. Those object are not
declare in the function. The pointer might be.

> It's indeed a difference between the current method
> and the new one. The new one simply hasn't yet enough
> information to prove that these global vars can't be
> modified by some external way between the
> accesses.
>
> You must also not forget that the current method also
> can't convert all possible global vars to pseudo
> during the SSA conversion (simplify_symbol_usage()).
> Simplify_loads() which is called *after* the 'general' SSA
> conversion convert some such accesses after (and do it
> wrongly too!).
>
> What I mean here is that it's normal to not be able to
> convert all possible accesses directly. But yes, for sure,
> the most we can convert early, the best it is.

What I am trying to evaluate is that, can SSSA satisify
all our need to promote memory access into pseudo.
If seems the answer is no, we still need to other other
means to promote memory into pseudo, e.g. the memory
storage access by pointers. That is actually a very common case.

>
>> I look back the paper, the paper actually did not
>> discuss pointer at all.
>
> Of course, because this topic is unrelated to the method.
> What's your talking about is:
> 1) decide/select which vars will be promoted to pseudos
>     (and this will be concerned witht he SSA)
> 2) alias analysis
> These are topics orthogonal to the conversion *method*
> (which doesn't mean that all methods offer the same possibilities).
>
> You must also not forget that the paper is an academic paper
> about a method. It's not a step-by-step guide on how
> you must engineer your compiler.

Right. Back to sparse. first of all. Let's agree on promoting
memory access into SSA pseudo is some thing we need.
It other words, we need more than just SSA convert local
variables. We want other type of memory access as well.

If SSSA does not support that easily. We need to have other
means to support memory access into SSA pseudo, one
of the possibility just doing the classic SSA conversion for
the case that SSSA does not support (memory access
through pointers).

For merging SSSA to master, I want to make two request:

1) instead of delete the old code and lost feature of promoting
    memory (other than local variable) to pseudo. Leave the
    previous code in and control by some debug options.
    When the option is turn on, it will use the old code path
    to promote the memory not cover by SSSA into pseudo.
    I understand currently the old code path does it wrong,
    I am trying to figure out what it takes to fix it. It is a lot
    harder try to fix it if the code is removed. This option can
    be off by default.

2) Have some option for SSSA to disable the SSSA promotion
    variable to pseudo without extra execution cost. This is
    can get us the current pre-simplify linearization byte code.
    This has two purpose.  The first one is just one debugging
    checkpoint. If we have bug in SSA,  we can find out if the
    linearization has bug or the bug was introduce in SSSA.
    The second purpose is that, if we fix the SSA promotion on
    existing code path, by  implementing some of the classic SSA.
    I am curious to find out what is the running number comparing
    again SSSA. We can turn SSSA off and let the alternative
    SSA conversion do all the work. And see how well it perform.
    This option can be on by default.

If you have other ways to make SSSA works with memory
accessed by pointers, we can add that later as well. As of the
current SSSA patches, this part of the feature is missing.

Chris
