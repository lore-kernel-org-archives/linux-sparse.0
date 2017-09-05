From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Simple SSA status
Date: Tue, 5 Sep 2017 02:55:54 +0200
Message-ID: <20170905005553.lwwo3hcre3vlgafd@ltop.local>
References: <CANeU7Q=9nUo+D3R3ypCS=-kND2vD_Qx84ua59_bi0-VGftPuqA@mail.gmail.com>
 <CAExDi1QryT9Hc6+yY0_E4Y6opsq3JiYo0KOidSDSj4VGD0J1Nw@mail.gmail.com>
 <CACXZuxfkduQSVJjzmYow5akJff_prmBeOS6Os-OnqCNpCCictA@mail.gmail.com>
 <CANeU7QmekgnTBVF_7kZRAL-LB+g2W4MZbchxrApnQVeQk32wDw@mail.gmail.com>
 <20170903202629.bipsxi7xnmh3y3oy@ltop.local>
 <CANeU7Q==zoxfgzGLKS00AqZ-M07Whr9Nu5gZtANd4PK_u3J47A@mail.gmail.com>
 <20170904200720.cxxfecd7rugyfskx@ltop.local>
 <CANeU7Q=KV7k+z=SYyvkVJGFLmXE-Un2x-WQeGBmydTb0mj=dbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:35743 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754055AbdIEAz6 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 4 Sep 2017 20:55:58 -0400
Received: by mail-wm0-f41.google.com with SMTP id v2so11995409wmf.0
        for <linux-sparse@vger.kernel.org>; Mon, 04 Sep 2017 17:55:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7Q=KV7k+z=SYyvkVJGFLmXE-Un2x-WQeGBmydTb0mj=dbQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Mon, Sep 04, 2017 at 07:31:02PM -0400, Christopher Li wrote:
> On Mon, Sep 4, 2017 at 4:07 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >> I have the same question as well.  When I find out the Simple SSA
> >> can't handle memory to register using pointers. It already means
> >> we need to keep the other non local variable path alive.
> >
> > Well ... we've already talked about this but
> > - identifying which memory accesses can be converted or not is
> >   orthogonal to the conversion itself
> 
> I am not sure that simple SSA can work on CFG after CFG has
> been fully generated. Maybe it can.

It can and it has pro & cons
- pro: the CFG is know in advance, so no complication with gotos
- cons: for non-goto blocks during linearization we know when
	all the predecessors have been already processed
	If done after lineariation, this info need to be somehow
	deduced (but it's just keeping a flag).
 
> > - the current implementation has also two different conversions.
> >   * simplify_symbol_usage(), called early
> >   * simplify_loads(), called later, several times
> >   Both are different in what they can handle or not.
> 
> I am thinking at some point we might just do a proper Cytron et al then
> we might be able to discard those simplify. Those simplify are ad hoc
> any way.

If you look at the literature you will see two things:
- either the article doesn't talk at all about which variable are
  processed, so the alias problem is ignored and implicitly they
  talk only about local vars (which address is never taken in any way)
- or they explicitly say that for this or that reason SSA is only
  well suited for local vars (which address is never taken in any way)
- only rarely is there any mention that some alias analysis must be
  done *before* conversion to select which variable can be converted

So, if it is to do Cytron or else but only on local var, I largely
prefer the Simple SSA way. And this still leave open the problem
for the others variables.

> > The more I've looked at this, the more I realize that what *can*
> > be done on local vars is most of the time unsuited for non-local
> > ones and what is *needed* for non-local ones are unneeded for
> > local ones.
> 
> That is because you already buy into the simple SSA.

Not really. I'm appealing to the Simple SSA because with it we doesn't
have to create those phony stores & loads for local variables and
destroy them just after. Local variables are not memory, doesn't behave
like memory, are not concerned by aliasing and so it's the right thing
to me to not use stores & loads on them.

> The Cytron
> et al should be very similar treatment for local vs non local. They
> all need to find the DF then insert the phi node. Things like finding
> dominator tree etc will be the same for both local vs non local variable.

Yes and no.
When you're talking about the dominator tree it's just that, the dominance
of the BBs in the CFG. What really matters for the SSA conversion is
not this dominance, it's the dominance that variables definitions have
on variables uses.
Of course, the later depends on the former but the problem for non-local
variables is not the same as the one for local variables, you need to take
in account the presence of calls, stores to unrelated vars (and non-var),
... You can consider this as being part of the alias analysis if you
wish but ...

> >> Right. The meet point on the book also call Dominance Frontier :-)
> >
> > Not necessarily. The dominance frontier is where the phi-nodes are
> > strictly needed to guarantee the SSA property. You can put some others
> > phi-nodes, trivial or not, at some other meet points, and this will
> > give you correct SSA too (like dumb-SSA: put a phi-node for each variable
> > at every meet point).
> 
> SSA, yes. Minimal SSA? no.
> I assume we want minimal SSA?

We certainly don't want dumb-SSA.
Some superfluous phi-node in irreducible regions are not a problem.
Anyway this 'minimal' SSA is only minimal in a very narrow-sense and
you can have lots of unneeded phi-nodes and still be minimal-SSA.

> 
> >
> > So no, the DF is only a subset of all the meet point.
> > Here I was saying that some phi-node are not even put at a meet-point.
> > For example:
> >         .L1:
> >                 ...
> >                 phisrc  %phi1, %r1
> >                 br      .L3
> >         .L2
> >                 ...
> >                 phisrc  %phi2, %r2
> >                 br      .L3
> >         .L3
> >                 // phi-node should be here, it's a meet point
> >                 ...
> >                 br      .L4
> >         .L4
> >                 # lnop ...
> >                 phi     %r4 <- %phi1, %phi2
> >
> > The method put the phi-node at .L4 because it was in this block
> > that the load/use was present but it should have been put at .L3,
> 
> I think I give an example very similar to this before. That is where
> the current sparse do it wrong.
> 
> > the meet point. Often it's not a problem, it's why it hasn't been
> 
> It is a problem already. Because at .L4, there is no incoming
> edge information like .L3. At .L3 we can do phinode properly.
> You need to place one phi node at .L3 any way. You can't do it at L4
> without placing one at L3. At L3 it is the minimal requirement.
> L4 is not required for minimal SSA.

Yes yes yes, it's wrong. What I meant by "often it's not a problem"
is that currently, with the help of the phisources, often the code
can deal with it and do something sensical.
This doesn't make it less wrong and there is also enough situations
where the code can't possibly do anything sensical with it.

> > seen earlier (and probably few people took much time to look at
> > the generated IR). It creates problems though once you:
> > - merge some blocks, phi-conversion, try_to_simplify_bb(), ...
> > - you have undefined vars in the way
> 
> 
> >> > - each phi-nodes have as many sources as there are definitions for this
> >> >   variable (more or less) instead of having one for each parents.
> >>
> >> I am not sure I understand this. If you always place phi node at
> >> DF. It will have as many source as incoming edge. That is part
> >> of the common SSA dominance property. If we do it right, I can't
> >> see why we still need the phi source instruction.
> >
> > Hehe, note how I said 'sources' and not 'phi-sources'. I just meant
> > the argument of the phi-nodes, their operands.
> 
> 
> 
> >
> > Note that I was saying that, currently, even when the phi-node
> > is correctly placed, it sometimes has more operands than predecessors
> > because the current method sortof accumulates with the operands of
> > other dominating phi-nodes related to this variable.
> 
> Are you saying current sparse doing that or that is the right thing
> to do? I think currently sparse might do that. But that is wrong.

Yes, currently sparse do that and it's very very wrong. More wrong
than the misplacement of phi-nodes. The code can never do something
sensical with it.

> It is conflict with the SSA dominance property. Every incoming edge
> should have one definition. It should  not have more than one
> define per incoming edge.

Currently, there is no relation between phi-nodes operands and
incoming edges. The only relation that exist (and that the code
need and care about) is the one between phi-nodes and their
phi-sources.

> Do you have example?

I have lots of examples :)
In a few days I'll submit a series of test cases and some will
be exhibit this.  A simple example is:
	#define TEST(N)			\
		do {			\
			d = b + a[N];	\
			if (d < b)	\
				c++;	\
			b = d;		\
		} while (0)
	
	int foo(int *a, int b, int c)
	{
		int d;
	
		TEST(0);
		TEST(1);
		TEST(2);
	
		return d + c;
	}

Where you will have 3 phi-nodes (OK, there is 3 ifs), the first with
2 sources (OK), the second with 3 and the third with 4 sources while
all nodes have 2 parents or less.
Even more interestingly, if you add another TEST(x), you will have
another phi-node with ... 5 sources and so one. One more source for
each TEST(x) invocation, so yes this give a nice quadratic processing
time and memory consumption.

> > About the phi-sources, I agree strongly with this. To me these
> > phi-sources are just a nuisance. Once things will be in better
> > shape, I'll see what can be done to get rid of them (quite a bit
> > of the logic depends on them for the moment, though).
> >
> > To be fair, these phi-sources have they use for the moment, but
> > as far as I can see it's only because we don't have a one-to-one
> > mapping between the phi-nodes operands and the block's predecessors.
> > In most notation, articles, ... you will see phi-nodes like:
> >         phi     %r4 <- [.L1:%r1, .L2:%r2]
> > to explicitly show the correspondance between each operands
> > and each predecessor (internally, things can be implicit,
> > it's what I have now, in fact).
> 
> Seems all good then.
> 
> 
> >> That is exactly why we need instruction level aliases
> >> analyze. The SSA conversion should be done after
> >> aliases analyze.
> >
> > And it's here where the egg & chicken problem begin.
> > To efficiently do the alias analysis, you better already
> > have IR in SSA form, having constant propagation already
> > done, having dead code elimination already done, ...
> 
> That just mean it need more than one pass. Ideally if
> the optimized code can be driven by incremental change
> then we don't need to do too many unnecessary pass.
> 
> > And, it's here where doing first the simple SSA can be
> > a good thing.
> >
> > Currently we have:
> >         1) linearization
> >         2) simple alias analysis + conversion of local loads +
> >            conversion of other loads + simplification of
> >            unnneded stores (simplify_symbol_usage())
> >         3) simplification & CSE
> >         4) more conversion of memory accesses (simplify_memops())
> >         5) goto 3)
> >
> > With the Simple SSA code we have:
> >         1) linearization & conversion of local loads & stores
> >         2) reuse or not the broken simplify_symbol_usage() to
> >            convert loads
> >         3) simplification & CSE
> >         4) reuse or not the broken simplify_memops()
> >            or reuse only the non-broken part of it.
> >         5) goto 3)
> >
> > What we would like to have (more or less):
> >         1) linearization
> >         1') conversion of local vars (maybe via Simple SSA)
> >         2) first pass of simplifications & CSE
> >         3) alias analysis
> >         3') conversion of memory accesses using 3)
> >         5) more simplification & CSE
> >         6) goto 3)
> > This correspond to a very classical architecture.
> 
> I think it is a good direction to go after. I also think constant
> propagation should be separate out from  2) and 5)
> because there is classic SSA algorithm to do it very
> effectively.

It was implicitly included in 'simplification' which can contains all
sort of optimization. And yes, sure, we want SCCP for this.
 
> > Note: here above, I use 'local var' to mean '(local) var which can
> >       safely be converted because it cannot be aliased to anything'
> > Note: there are a lot of possible alias analyses, varying greatly
> >       in precision, complexity & run-time ressources.
> >       It's still very OK to me to have (first) something quite simple
> >       as we currently have.
> 
> Sure, it is depend on how much this fast path can save, and how
> complex is this fast path.

Sure. 


-- Luc
