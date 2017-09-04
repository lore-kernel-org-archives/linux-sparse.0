From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Simple SSA status
Date: Mon, 4 Sep 2017 22:07:23 +0200
Message-ID: <20170904200720.cxxfecd7rugyfskx@ltop.local>
References: <CANeU7Q=9nUo+D3R3ypCS=-kND2vD_Qx84ua59_bi0-VGftPuqA@mail.gmail.com>
 <CAExDi1QryT9Hc6+yY0_E4Y6opsq3JiYo0KOidSDSj4VGD0J1Nw@mail.gmail.com>
 <CACXZuxfkduQSVJjzmYow5akJff_prmBeOS6Os-OnqCNpCCictA@mail.gmail.com>
 <CANeU7QmekgnTBVF_7kZRAL-LB+g2W4MZbchxrApnQVeQk32wDw@mail.gmail.com>
 <20170903202629.bipsxi7xnmh3y3oy@ltop.local>
 <CANeU7Q==zoxfgzGLKS00AqZ-M07Whr9Nu5gZtANd4PK_u3J47A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:33841 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754146AbdIDUHb (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 4 Sep 2017 16:07:31 -0400
Received: by mail-wm0-f42.google.com with SMTP id 137so17816568wmj.1
        for <linux-sparse@vger.kernel.org>; Mon, 04 Sep 2017 13:07:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7Q==zoxfgzGLKS00AqZ-M07Whr9Nu5gZtANd4PK_u3J47A@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Mon, Sep 04, 2017 at 02:29:46PM -0400, Christopher Li wrote:
> On Sun, Sep 3, 2017 at 4:26 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >>
> >> Merge it when it is ready?
> >
> > I've put it on hold for the moment.
> 
> Thanks for the update. Glad to heard you back.
> 
> > The conversion of purely local vars was the easy job.
> > The real challenge is to do it for the other loads & stores
> > (in simplify_symbol_usage() & simplify_memops()).
> > I'm working on it and have some encouraging results:
> > - correct phi-nodes
> > - pass the test-suite
> > - no crashes in GCC test-suite and others
> > - no infinite loops
> > - no catastrophic performance on exceptional workoads
> > - roughly convert as much stores & loads as currently
> > - good performance (within 2-5% as rc5 on some workloads)
> > - in some case, surprising good effect on optimization
> 
> That is great. Very exciting news.
> 
> >
> > I don't know yet if keeping the Simple SSA during linearization
> > will be worth to keep or not.
> 
> I have the same question as well.  When I find out the Simple SSA
> can't handle memory to register using pointers. It already means
> we need to keep the other non local variable path alive.

Well ... we've already talked about this but
- identifying which memory accesses can be converted or not is
  orthogonal to the conversion itself
- the current implementation has also two different conversions.
  * simplify_symbol_usage(), called early
  * simplify_loads(), called later, several times
  Both are different in what they can handle or not.

The more I've looked at this, the more I realize that what *can*
be done on local vars is most of the time unsuited for non-local
ones and what is *needed* for non-local ones are unneeded for
local ones.

Doing a quick, simple conversion of all local vars can be a good
thing to be able to easily, efficiently *identify* in a later pass,
which other accesses can be converted or not.

> We can do some bench mark to find out. If the performance
> is very similar, remove the simple SSA will actually simplify
> the code because we only need to care about one code path.
> 
> >> Right now I do wish the SSSA has the two options I request
> >> before.
> >
> > I don't remember what was the other option you asked but keeping
> > both the old and the new method is not something I'm interested in.
> > We know that the current method is broken. In fact, it's broken in two
> > different ways:
> 
> I have no intend to keep the broken behavior. My wish list for the two
> options rephrased:
> 1) Option to by pass the simpole SSA conversion which generate the
>     raw load/store instruction before convert memory to register.
> 2) Option to do the memory to register conversion not cover by
>     simple SSA conversion. It sounds like you implement this already.
> 
> > - the phi-nodes are mis-placed (they are on the use site instead of the
> >   meet point).
> 
> Right. The meet point on the book also call Dominance Frontier :-)

Not necessarily. The dominance frontier is where the phi-nodes are
strictly needed to guarantee the SSA property. You can put some others
phi-nodes, trivial or not, at some other meet points, and this will
give you correct SSA too (like dumb-SSA: put a phi-node for each variable
at every meet point).

So no, the DF is only a subset of all the meet point.
Here I was saying that some phi-node are not even put at a meet-point.
For example:
	.L1:
		...
		phisrc	%phi1, %r1
		br	.L3
	.L2
		...
		phisrc	%phi2, %r2
		br	.L3
	.L3
		// phi-node should be here, it's a meet point
		...
		br	.L4
	.L4
		# lnop ...
		phi	%r4 <- %phi1, %phi2

The method put the phi-node at .L4 because it was in this block
that the load/use was present but it should have been put at .L3,
the meet point. Often it's not a problem, it's why it hasn't been
seen earlier (and probably few people took much time to look at
the generated IR). It creates problems though once you:
- merge some blocks, phi-conversion, try_to_simplify_bb(), ...
- you have undefined vars in the way

> > - each phi-nodes have as many sources as there are definitions for this
> >   variable (more or less) instead of having one for each parents.
> 
> I am not sure I understand this. If you always place phi node at
> DF. It will have as many source as incoming edge. That is part
> of the common SSA dominance property. If we do it right, I can't
> see why we still need the phi source instruction.

Hehe, note how I said 'sources' and not 'phi-sources'. I just meant
the argument of the phi-nodes, their operands.

Note that I was saying that, currently, even when the phi-node
is correctly placed, it sometimes has more operands than predecessors
because the current method sortof accumulates with the operands of
other dominating phi-nodes related to this variable.

About the phi-sources, I agree strongly with this. To me these
phi-sources are just a nuisance. Once things will be in better
shape, I'll see what can be done to get rid of them (quite a bit
of the logic depends on them for the moment, though).

To be fair, these phi-sources have they use for the moment, but
as far as I can see it's only because we don't have a one-to-one
mapping between the phi-nodes operands and the block's predecessors.
In most notation, articles, ... you will see phi-nodes like:
	phi	%r4 <- [.L1:%r1, .L2:%r2]
to explicitly show the correspondance between each operands
and each predecessor (internally, things can be implicit,
it's what I have now, in fact).

> >
> > I also recently discovered that the logic for aliases is broken.
> > For example, code like:
> >         int foo(void)
> >         {
> >                 int i = 1;
> >                 int *a;
> >                 int **p;
> >
> >                 a = &i;
> >                 p = &a;
> >                 *p[0] = 0;
> >                 return i;
> >         }
> > is mis-compiled as it always returns 1 instead of 0
> > (it fails to see that *p[0] is aliased to i).
> 
> That is exactly why we need instruction level aliases
> analyze. The SSA conversion should be done after
> aliases analyze.

And it's here where the egg & chicken problem begin.
To efficiently do the alias analysis, you better already
have IR in SSA form, having constant propagation already
done, having dead code elimination already done, ...

And, it's here where doing first the simple SSA can be
a good thing.

Currently we have:
	1) linearization
	2) simple alias analysis + conversion of local loads +
	   conversion of other loads + simplification of
           unnneded stores (simplify_symbol_usage())
	3) simplification & CSE
	4) more conversion of memory accesses (simplify_memops())
	5) goto 3)

With the Simple SSA code we have:
	1) linearization & conversion of local loads & stores
	2) reuse or not the broken simplify_symbol_usage() to
           convert loads
	3) simplification & CSE
	4) reuse or not the broken simplify_memops()
           or reuse only the non-broken part of it.
	5) goto 3)

What we would like to have (more or less):
	1) linearization
	1') conversion of local vars (maybe via Simple SSA)
	2) first pass of simplifications & CSE
	3) alias analysis
	3') conversion of memory accesses using 3)
	5) more simplification & CSE
	6) goto 3)
This correspond to a very classical architecture.


Note: here above, I use 'local var' to mean '(local) var which can
      safely be converted because it cannot be aliased to anything'
Note: there are a lot of possible alias analyses, varying greatly
      in precision, complexity & run-time ressources.
      It's still very OK to me to have (first) something quite simple
      as we currently have.
      It's also OK to do the conversion while doing the analysis if
      it's advantageaous to do so (no need memory to hold the info).
Note: simplification & CSE should include Dead Code Elimination and
      it's not clear to me what exactly we're doing about it.

-- Luc
