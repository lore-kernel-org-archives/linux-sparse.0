From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: sparse-next and preview of 0.5.1-rc5
Date: Fri, 21 Jul 2017 00:35:57 +0200
Message-ID: <20170720223554.54ohh7pfl7qm43dc@ltop.local>
References: <CANeU7Qk-9RcNkWoEL5-0AKyd2Q30BvtjfivEG_KgD4kAH-aEdA@mail.gmail.com>
 <20170715182159.ltikqlbe6rktxfhz@ltop.local>
 <CANeU7Qkt4+QsgrrwUSwiiJ_V77gnJgb5YW0qSwwx1-uu9-GhLw@mail.gmail.com>
 <20170719221738.2gkctzmdjajz4uec@ltop.local>
 <CANeU7QkevpEdcp-WmM820sjJ4-LhVyPHeGHETh64WG3jPzewhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37986 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965821AbdGTWgF (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 20 Jul 2017 18:36:05 -0400
Received: by mail-wm0-f41.google.com with SMTP id w191so38563611wmw.1
        for <linux-sparse@vger.kernel.org>; Thu, 20 Jul 2017 15:36:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7QkevpEdcp-WmM820sjJ4-LhVyPHeGHETh64WG3jPzewhA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>

On Wed, Jul 19, 2017 at 08:19:02PM -0700, Christopher Li wrote:
> On Wed, Jul 19, 2017 at 3:17 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >
> > Even now, I'm not really back. Just taking time to reply here
> > while I have the opportunity to.
> 
> OK. Good to know then guessing
> 
> 
> >> Can you show me some C input file that your original patch will do the
> >> right thing and current one will miss the opportunity to simplify?
> >> Even for the case it is just a suspect of producing worse code is fine.
> >> Just point me to some test case, I will investigate and compare the
> >> results.
> >
> > Test cases are test cases and code is code.
> >
> > I'll copy here verbatim the commit message of the patch that was fixed
> > by the original patch (the one that had "Fixes: 51cfbc90a5e1462fcd624a1598ecd985a508a5d6
> 
> I still don't have a valid test case to difference sparse-next
> and your patch series.

You don't need a test case to *think* about the code or simply read
the explanation I wrote here under.
 
> If your test case is that switch statement, I make a test case
> out of it. Sparse-next and yoru patch show the same result
> bytecode wise:

Of course, it does.
 
> >         commit 51cfbc90a5e1462fcd624a1598ecd985a508a5d6
> >         Author: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> >         Date:   2017-04-26 12:21:21 +0200
> >
> >             fix: kill unreachable BBs after killing a child
> >
> >             When simplifying a switch into a simple branch all the now
> >             unused children of the current BB must be removed.
> >             If one of these children become now orphaned, it is directly
> >             killed (it will need to be killed soon or later since it is
> >             unreachable).
> >
> >             However, if one of the killed children is the header of a loop
> >             where some variables are updated this may cause problems.
> >             Indeed, by killing the header (which contains the phisrc of
> >             the entry value of the variable) the whole loop may become
> >             unreachable but is not killed yet, OTOH simplification of
> >             the associated OP_PHI may create a cycle which may then be
> >             detected later by simplify_one_memop() which will issue a
> >             "crazy programmer" warning while the programmer was innocent.
> 
> That sounds very much like the wine dead loop case recently report on
> the mailing list.

These two cases are not at all related.

> >             This situation can be seen in code like:
> >                     int *p;
> >                     switch (i - i) {        // will be optimized to 0
> >                     case 0:                 // will be the simple branch
> >                             return 0;
> >                     case 1:                 // will be optimized away
> >                             p = ptr;
> >                             do {            // will be an unreachable loop
> >                                     *p++ = 123;
> >                             } while (--i);
> >                     }
> >
> >             Fix this by calling kill_unreachable_bbs() after having
> >             simplified the switch into a branch. This will avoid to
> >             create a cycle with because of the removed phisrc in the
> >             header and as an added benefit will avoid to waste time
> >             trying to simplify BBs that are unreachable.
> >
> >             In addition, it's now useless to call kill_bb() for each
> >             removed switch's children as kill_unreachable_bbs() will
> >             do that too.
> 
> The simple patch in sparse-next has the same output result
> 
> > It's not at all a problem of some missing optimization opportunity.
> > It's a problem of applying some optimization (OP_PHI simplification)
> > and then giving a warning for the consequence of this optimization
> > (the "crazy programmer" warning) in incorrect conditions/wrong
> > assumption (a variable must not be considered as undefined if it
> > is part of an unreachable BB, it should just be ignored).
> >
> > I hope it is clear enough now.
> 
> Can you show me a test C code trigger the problem?

OK, it wasn't clear enough.

It will be a few more days before I can access to my usual dev stuff
where my tests and tests results are.

However, using the description here above, it's not very hard to imagine
a situation where the two patch will behave differently.
You can even create a test case from the old test case here above
and removing a single line, the one "p = ptr;". It's also very easy
to create all sort of variants of it.
 
-- Luc
