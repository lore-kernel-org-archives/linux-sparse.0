From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH RFC] Let pseudo->users loop on duplicate version of list
Date: Fri, 4 Aug 2017 10:48:35 -0400
Message-ID: <CANeU7Qk8LrOG7+n3=r0B7m+CK6DTNeKs9cWzoZKTzckEz_96Fw@mail.gmail.com>
References: <20170719211437.7axhrrjrvr4k6dvg@ltop.local> <CANeU7QmQ4JmD_wLoZ6r7bV7Uu4BASnvuHpmQ7VKAoZXR9FD93w@mail.gmail.com>
 <CAMHZB6E9LkHc4KR5ktoS2MzZpZpW09h4_U8XH+PVE4HTmi1LcQ@mail.gmail.com>
 <CANeU7Qmr00XPkKgE_60TyZMToGwGOgzsqbb3Gwj1JqKTZ1PW_Q@mail.gmail.com>
 <CAExDi1Tt4P9oFZVoEL9yWwU4N_Te5ZEtNe=KcvAYJuaHtbEVyQ@mail.gmail.com>
 <CANeU7Qn+O=yXQP11uw-i2R0rmDCiyNsvFZX4M=zwLO-4-MJk_A@mail.gmail.com>
 <20170803101835.qhxbyrvly3bhfxyd@ltop.local> <CANeU7Q=nH-mfJ4=ggHhN2xCS9OPHZhUPPXkXd9HGoc6gEhGm7w@mail.gmail.com>
 <20170804004110.ctq3w6lcv5jclur7@ltop.local> <CANeU7Q=qSLDM99=S3btE1OqZ_n_nHChtYvqi8H_48EHhc04JkA@mail.gmail.com>
 <20170804103835.ahb3dv2t2ictuvwf@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:33556 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751384AbdHDOsg (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 4 Aug 2017 10:48:36 -0400
Received: by mail-pf0-f175.google.com with SMTP id d67so8859762pfc.0
        for <linux-sparse@vger.kernel.org>; Fri, 04 Aug 2017 07:48:36 -0700 (PDT)
In-Reply-To: <20170804103835.ahb3dv2t2ictuvwf@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Fri, Aug 4, 2017 at 6:38 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> It was a rethorical question as a reponse to your own question
> because your own asking to show something while we're talking
> design and potentiality doesn't help at all.

That is exactly the feeling I am getting from you. You said some thing
might not work. I want to find out exactly what do you have in mind might
not work.  Otherwise the conversion is base on doubt is not very
useful. I want details. This goes both ways. You can also ask me to clarify
more details on certain things in my mental model.
>
> 1) Converting a recursive algo to an iterative one is not always
>    a good solution, for example the iterative one can be much
>    more complex/less elegant. You may also need more memory
>    (because you often need to store additional info).
>    A typical example is searching in a tree: it can be done
>    with iteration but it's generaly not done because the
>    recursive version is so much simpler & elegant (and probably
>    efficient too).

In my observe and modify model, the traverse of a tree can use
recursive, even on the same ptrlist. It is the modify get deferred.
I think I mention that observe and modify in previous email already.
So what you are describing above is not a good example to against it.

> 2) Converting something to a work queue is not the same as
>    converting recursion to iteration anyway.
>    Recursion vs. iteration is something about how walking through
>    a data structure. Using a work queue is about how/when doing an
>    operation on an object.

You walk the graph to do some thing. That is given. Nobody walk the graph
for the sake of just walking the graph. The optimize can be model
as an algorithm walk the graph and make modification of the graph.
Is that a fair statement?

>
> An example among other of complications you can have when converting
> to work queue is something like:
> Imagine you're iterating through a list of instruction checking/
> searching after something. If found, you want to do an operation
> on the instruction just found.

Now we are talking.

> Sound like something for a work queue, right? Just put the
> object you found in the work queue and let do the operation later.
> Now what if the operation is about inserting another instruction
> just before the one just found (like done when adding death notes)?
> - if you do it immediatly, you have the context of the instruction
>   and inserting the death notes is easy/cheap

Here you make some assumption that you can't save the context of
the instruction in the work queue. That is not necessary true. In
my mental model, the work queue will contain the context of what
needs to be done, e.g. the pointer to the instruct. Other context
if needed. I want to know more about what context you can't save.

BTW, most of the context can be found on the graph does not
need to save in to work queue.

Take simplify_branch_branch for example, when you know this
instruction should be simplified, there is very little information
need to be save in the work queue. Basically we can start with
call arguments to rewrite_branch(), go from there.

> - if you do the insertion later when processing the work queue
>   you won't have anymore the context of the instruction
>   and to insert the death note you will first have to
>   search after it (to have the context back) before you will
>   be able to do the insertion and this search will cost you.

Again, I don't have a clear picture of what context you are talking
about. Please clarify. If it is the instruction before this instruction,
I can't image why I need it. If really need it I can still cache it or
search it in the bb->insns list.

BTW, my impression is that, the algorithm "constant propagation using ssa"
is such an example what you are describing here. In the constant
propagation, you first find the instruction that use constant.
Then you find out if that instruction can be simplify as constant.
Next thing is put the instruction using of this simplify instruction result
into the queue to see if they can be simplify as well.

It is actually a lot better than our current approach to rescan the
whole instruction list just to find out, oh, we got some new instruction
have constant input now (due to last round constant propagation).

> It's just an example but there is a whole class of similar situations.
> Delaying thing by moving it to a work queue will also have negative
> impact on cache (but in a way, it's also a problem of having lost the
> context).

Caching, maybe. But I don't think caching is a strong point to against it.
I am just a system guy playing catch up game on compiler designs. The more
I read, the more I find out using work queue is a very common
thing amount those classic optimization algorithms.

> And again, I'm not telling that using workqueue is never a good solution,
> I'm saying that most probably it won't always be a good solution.

My reading is that, "I have doubt but I can't articulate precisely why it
is the case." Fill in more detail we can have more discussion.

Granted, no algorithm is *always" a good solution to all problem.
As I express in my previous email, I have no doubt this can be done.
The question is weather it can be done *clean* enough for sparse.

When we introduce "dead code elimination using ssa", work queue like
frame work will be needed any way.

Chris
