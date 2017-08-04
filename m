From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH RFC] Let pseudo->users loop on duplicate version of list
Date: Fri, 4 Aug 2017 18:58:41 +0200
Message-ID: <20170804165839.shbkk2eb7w743nri@ltop.local>
References: <CAMHZB6E9LkHc4KR5ktoS2MzZpZpW09h4_U8XH+PVE4HTmi1LcQ@mail.gmail.com>
 <CANeU7Qmr00XPkKgE_60TyZMToGwGOgzsqbb3Gwj1JqKTZ1PW_Q@mail.gmail.com>
 <CAExDi1Tt4P9oFZVoEL9yWwU4N_Te5ZEtNe=KcvAYJuaHtbEVyQ@mail.gmail.com>
 <CANeU7Qn+O=yXQP11uw-i2R0rmDCiyNsvFZX4M=zwLO-4-MJk_A@mail.gmail.com>
 <20170803101835.qhxbyrvly3bhfxyd@ltop.local>
 <CANeU7Q=nH-mfJ4=ggHhN2xCS9OPHZhUPPXkXd9HGoc6gEhGm7w@mail.gmail.com>
 <20170804004110.ctq3w6lcv5jclur7@ltop.local>
 <CANeU7Q=qSLDM99=S3btE1OqZ_n_nHChtYvqi8H_48EHhc04JkA@mail.gmail.com>
 <20170804103835.ahb3dv2t2ictuvwf@ltop.local>
 <CANeU7Qk8LrOG7+n3=r0B7m+CK6DTNeKs9cWzoZKTzckEz_96Fw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:35957 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752433AbdHDQ6p (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 4 Aug 2017 12:58:45 -0400
Received: by mail-wm0-f48.google.com with SMTP id t201so24464199wmt.1
        for <linux-sparse@vger.kernel.org>; Fri, 04 Aug 2017 09:58:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7Qk8LrOG7+n3=r0B7m+CK6DTNeKs9cWzoZKTzckEz_96Fw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Fri, Aug 04, 2017 at 10:48:35AM -0400, Christopher Li wrote:
> On Fri, Aug 4, 2017 at 6:38 AM, Luc Van Oostenryck wrote:
> > It was a rethorical question as a reponse to your own question
> > because your own asking to show something while we're talking
> > design and potentiality doesn't help at all.
> 
> That is exactly the feeling I am getting from you. You said some thing
> might not work. I want to find out exactly what do you have in mind might
> not work.  Otherwise the conversion is base on doubt is not very
> useful.

Replace 'doubt' by 'warning' and it give already another sense to it.
My whole message has always been the same: "Warning, it's not so easy
or obvious and I have reasons to think that it won't always be possible
or desirable (so it may be good to also think about alternative or to
somehow accept thet idea that maybe not all cases will be solved the
same way".

> I want details. This goes both ways. You can also ask me to clarify
> more details on certain things in my mental model.

You can ask details about an existing implementation, you can ask
details about some idea already well elaborated. 
You can't ask details about something that by nature have not yet details,
but I have already tried to give you all sort of indices that would
give some matter to think about.

> > 1) Converting a recursive algo to an iterative one is not always
> >    a good solution, for example the iterative one can be much
> >    more complex/less elegant. You may also need more memory
> >    (because you often need to store additional info).
> >    A typical example is searching in a tree: it can be done
> >    with iteration but it's generaly not done because the
> >    recursive version is so much simpler & elegant (and probably
> >    efficient too).
> 
> In my observe and modify model, the traverse of a tree can use
> recursive, even on the same ptrlist.

When you're searching in a (binary) tree, at some point you will need
to backtrack, to return to some previous branching point. The usual
way to do that is to use recursion and the branching point is
implicitely stored in the stack. You can do the same without recursion,
without using the call stack but then you need to store info about the
branching point.
It's an example that this sort of changes is no for free.

> > 2) Converting something to a work queue is not the same as
> >    converting recursion to iteration anyway.
> >    Recursion vs. iteration is something about how walking through
> >    a data structure. Using a work queue is about how/when doing an
> >    operation on an object.
> 
> You walk the graph to do some thing. That is given. Nobody walk the graph
> for the sake of just walking the graph. The optimize can be model
> as an algorithm walk the graph and make modification of the graph.
> Is that a fair statement?

Sorry, I don't understand what you mean. 

> > An example among other of complications you can have when converting
> > to work queue is something like:
> > Imagine you're iterating through a list of instruction checking/
> > searching after something. If found, you want to do an operation
> > on the instruction just found.
> 
> Now we are talking.
> 
> > Sound like something for a work queue, right? Just put the
> > object you found in the work queue and let do the operation later.
> > Now what if the operation is about inserting another instruction
> > just before the one just found (like done when adding death notes)?
> > - if you do it immediatly, you have the context of the instruction
> >   and inserting the death notes is easy/cheap
> 
> Here you make some assumption that you can't save the context of
> the instruction in the work queue.

No, I don't make such assumption, it's an example showing that not
doing things there may have a cost. Saving the context is such a cost.

> That is not necessary true. In
> my mental model, the work queue will contain the context of what
> needs to be done, e.g. the pointer to the instruct. Other context
> if needed. I want to know more about what context you can't save.

I never said you can't save context.
On the contrary I've said that you'll most probably have to store
some context to be able to do things in a deferred way and this
will have a cost (and I use here the word 'context' in a very general
abstract meaning).

> BTW, most of the context can be found on the graph does not
> need to save in to work queue.
> 
> Take simplify_branch_branch for example, when you know this
> instruction should be simplified, there is very little information
> need to be save in the work queue.

Absolutely, in this example yes.
In some others examples, it is less so.

> > - if you do the insertion later when processing the work queue
> >   you won't have anymore the context of the instruction
> >   and to insert the death note you will first have to
> >   search after it (to have the context back) before you will
> >   be able to do the insertion and this search will cost you.
> 
> Again, I don't have a clear picture of what context you are talking
> about.

You have an instruction and you need to insert another instruction
in front of it. If you do that while you was searching after this
instruction, it's very easy because you have the head-list-nr trio
implicitely available via the ptrlist macros. This trio is here
the context you need in order to efficiently insert an instruction
in front ot it.

Now, for some reasons you want to defer this instruction.
What will you put in the work queue?
- the pointer to the instruction?
  then to insert you will need to search again in the list until
  you found the instruction. At this point you will have back
  the context needed to do the insertion but you had to do a search.
- the pointer to where the instruction stored in the list?
  then you can easily exchange this instruction with another one
  but how will this be usefull to the insertion? Well sure,
  with the pointer you can get back the original head-list-nr
  but is this usefull here? If you store somewhere the instruction
  pointer pointer, in practice that mean that the list that contain
  it become immutable (presumably you also hold pointers for the
  neighbour instructions). The only thing that can work at this point
  is a normal liked list, nor the block-based ptrlist.
  Is that a problem? Maybe, maybe not much.

> Please clarify. If it is the instruction before this instruction,
> I can't image why I need it. If really need it I can still cache it or
> search it in the bb->insns list.
> 
> BTW, my impression is that, the algorithm "constant propagation using ssa"
> is such an example what you are describing here. In the constant
> propagation, you first find the instruction that use constant.
> Then you find out if that instruction can be simplify as constant.
> Next thing is put the instruction using of this simplify instruction result
> into the queue to see if they can be simplify as well.

No, because in this case each instruction is still independend, you 
don't need to know anything about the surrounding instructions.
So it's a case where it should be easy to convert it.
The example for the deathnotes insertion is not like this.

> > It's just an example but there is a whole class of similar situations.
> > Delaying thing by moving it to a work queue will also have negative
> > impact on cache (but in a way, it's also a problem of having lost the
> > context).
> 
> Caching, maybe. But I don't think caching is a strong point to against it.
> I am just a system guy playing catch up game on compiler designs. The more
> I read, the more I find out using work queue is a very common
> thing amount those classic optimization algorithms.
> 
> > And again, I'm not telling that using workqueue is never a good solution,
> > I'm saying that most probably it won't always be a good solution.
> 
> My reading is that, "I have doubt but I can't articulate precisely why it
> is the case." Fill in more detail we can have more discussion.

If by "I have doubt" you understand "I have doubt about using it
systematically to avoid problems with nested lists", you would be
quite close. If you mean instead "I have doubt about using
it preferably (for cleanless and effective solution to avoid problems
with nested lists" you would be very wrong.

> Granted, no algorithm is *always" a good solution to all problem.
> As I express in my previous email, I have no doubt this can be done.

You have no doubts that it can be done everywhere in sparse to avoid
problems with nested lists or you have no doubts that it can be
done at least in some or most case?

Like I have already told since the beginning, I have doubts about doing
it everywhere and I have already explained why (or at least tried to).

-- Luc
