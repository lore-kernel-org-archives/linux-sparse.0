From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [RFC] sparse SSA construction
Date: Wed, 16 Aug 2017 08:41:26 +0200
Message-ID: <20170816064123.beykdmsgskahutde@ltop.local>
References: <20170806202651.8763-1-luc.vanoostenryck@gmail.com>
 <CACXZuxchKzgv_cN7MzZnT09OX1thdODoinqSVzK8jSxdPCVK8w@mail.gmail.com>
 <CANeU7Qk9C-78+-a2TOGUWiLof9S_p9vO6bHyNf6xZqZ5X1CoUQ@mail.gmail.com>
 <CACXZuxeGgFmjDosHv-Exd9qRLfonFGUrD7sx-ucQejuR0jsD+w@mail.gmail.com>
 <CANeU7QmQ8DdeBLx9kDNf-xnTOUc=V7VNu95A+dAL4oUbLngonw@mail.gmail.com>
 <CACXZuxcb8YVcdkTjvo-0cxDughp0kveQCN_sDKWzxxE0QFs=+A@mail.gmail.com>
 <CA+55aFwXc6QDgZSv++ZUUTHEixsMoKUq6Wc-6sQ4g5po5ZmA5g@mail.gmail.com>
 <CAMHZB6GZCcOfAD3qkFs39hVQ1om5TdCM5CTTwAb2aqLH1Hbriw@mail.gmail.com>
 <CA+55aFzvNEGEbO=H9C5q29js7A57zMm00a8i5NqDfPsZAxpr2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34039 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751389AbdHPGla (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 16 Aug 2017 02:41:30 -0400
Received: by mail-wm0-f65.google.com with SMTP id x64so3657076wmg.1
        for <linux-sparse@vger.kernel.org>; Tue, 15 Aug 2017 23:41:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CA+55aFzvNEGEbO=H9C5q29js7A57zMm00a8i5NqDfPsZAxpr2g@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Aug 15, 2017 at 01:43:15PM -0700, Linus Torvalds wrote:
> On Tue, Aug 15, 2017 at 1:14 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >
> > For information, the current SSA construction is very broken,
> > both in simplify_one_symbol() (the main SSA construction)
> > and simplify_loads() (which also creates phi-nodes). They both
> > are 'load-driven' which is OK but they both put the phi-nodes
> > where the load is while phi-nodes need to placed where branches
> > meet. The loads are often placed in a BB following where the
> > join-point. Often this *seems* to be OK but in fact is very wrong
> > and create all sort of problems a bit everywhere
> 
> I do think you're too hung up about the placement of the phi nodes.
> 
> It may be an issue for simple models that just walk the linearized
> code directly and try to turn it into code. But the original intent of
> the existing phi node code was to just be as sources of the pseudo's -
> the location should be largely immaterial.

I somehow disagree here.
A:	B:	C:
Va = a;	Vb = b;	Vc = c;
  |	  |	  |
   \      |      / 
    \     |     / 
     \    |    / 
      \   |   / 
       \  |  / 
	M:
	  |
	  |
	  |
	  |
	N:
	  V = PHI(Va, Vb, Vc)

Now what must happen if B: has to be removed?

A:		C:
Va = a;		Vc = c;
  |	  	  |
   \             / 
    \           / 
     \         / 
      \       / 
       \     / 
	M:
	  |
	  |
	  |
	  |
	N:
	  V = PHI(Va, VOID, Vc)

where VOID represent here a non-present element. It's still 'correct'
You have to interpret the void as 'nothing here anymore'

One of the funnies begin if we now have to add a branch D to M

A:	C:	D:
Va = a;	Vc = c;	Vd = d;
  |	  |	  |
   \      |      / 
    \     |     / 
     \    |    / 
      \   |   / 
       \  |  / 
	M:
	  V' = PHI(Va, Vc, Vd)
	  |
	  |
	  |
	  |
	  |
	N:
	  V = PHI(Va, VOID, Vc)

What for V if we came from branch D?

You can also see things like:


     Vd   Vb   Ve 
       \  |  / 
	O:
     Va   |   Vc 
       \  |  / 
	M:
	  |
	  |
	  |
	N:
	  V = PHI(Va, Vc, Vd, Vb, Ve)

In others words,s a phi-nodes with much more sources/args than the first
branching parent has.

We also have (after BB packing)
     Va   Vb   Vc 
       \  |  / 
	M:
	  V = PHI(Va, Vb, Vc)
          .....
	  .....
	  F' = PHI(Fa, Fc)

THus a phi-node in the middle of a BB (it was at top first but
two BB have been joined).


At best, it's hard to see any kind of plausibly correct interpretation,
often you can't.
Thing becomes really messy when a new branch is inserted somewhere
in the middle of the chain.

But I also agree that there is two problmes here:
- having a correct SSA form (maybe not the same as what can always
  be found in the literature but we need one on which we can reason)
- once the SSA construction is done, we now have ti maintain it
  each time we make a change to the CFG. I doubt we do this
  correctly.

 
> IOW, you could think of the phi nodes as being "outside" the
> instruction flow entirely, and just being the definition of the pseudo
> they define.

Right, they are not really part of the normal instruction flow.
I think it's even best to *not* see them as part of the instruction.
They are more akin to arguments receive by a function at its start.
The phi-node are then: heer are the values we for this BB if
we come from this or this path.
They also must have the multi-assignement semantics (but in sparse,
we don't care because there is always  this layer of phi-source)
> They have to be placed somewhere, but the "somewhere" is
> somewhat arbitrary.

I disagree here.
IMO, the somwhere has to be at the top of the BB where others
BBs meet and there each phi-node has to have as much sources
as there the BB has parents.
This is the only sane semantic.

> That said, I like your new ssa construction -independently- of that
> issue - the old SSA constructor really was very ad-hoc. Look through
> the git history if you don't believe me ;)

Thank you. I would have liked that the ideas where mine though!
(in fact, when I foud the article, I had some related ideas in head
triggered by one of your replies to me wheer you said 'you can't
directly translate local var inti pseudo).


Best regards,
-- Luc
