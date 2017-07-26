From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: sparse-next and preview of 0.5.1-rc5
Date: Wed, 26 Jul 2017 21:28:41 +0200
Message-ID: <20170726192840.uw22cwbihmlvjp3a@ltop.local>
References: <CANeU7Qk-9RcNkWoEL5-0AKyd2Q30BvtjfivEG_KgD4kAH-aEdA@mail.gmail.com>
 <20170715182159.ltikqlbe6rktxfhz@ltop.local>
 <CANeU7Qkt4+QsgrrwUSwiiJ_V77gnJgb5YW0qSwwx1-uu9-GhLw@mail.gmail.com>
 <20170719221738.2gkctzmdjajz4uec@ltop.local>
 <CANeU7QkevpEdcp-WmM820sjJ4-LhVyPHeGHETh64WG3jPzewhA@mail.gmail.com>
 <20170720223554.54ohh7pfl7qm43dc@ltop.local>
 <CANeU7QkgF5N_Byw3j4G-dV1ZoWR6CW+y+UZa3MkrVcFNZmYz8Q@mail.gmail.com>
 <CANeU7QnovxzRQuhjyRHY==B2Vk5qU9Qk08rTDuvdwmARGci4Og@mail.gmail.com>
 <20170726090022.2waraq4rgci2wuq2@ltop.local>
 <CANeU7Q=YQUgzBeKhzOSROdJEobTAjXU1oSbicceB9axg1sFGsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:38092 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750955AbdGZT2q (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 26 Jul 2017 15:28:46 -0400
Received: by mail-wm0-f46.google.com with SMTP id m85so75962504wma.1
        for <linux-sparse@vger.kernel.org>; Wed, 26 Jul 2017 12:28:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7Q=YQUgzBeKhzOSROdJEobTAjXU1oSbicceB9axg1sFGsg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>

On Wed, Jul 26, 2017 at 12:10:20PM -0400, Christopher Li wrote:
> On Wed, Jul 26, 2017 at 5:00 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > This is typical of situations where undefined pseudos are involved.
> > For example this is what Linus wrote on the subject some months ago:
> >
> >                and.32      %r3 <- %r4, $-65
> >                 or.32       %r4 <- %r3, $64
> >
> >         which *initializes* the pseudo %r4 in the second instruction, but uses
> >         it in the first one. That's a classic pattern of uninitialized pseudos
> >         in sparse exactly because of the SSA logic.
> >
> >         But it is all internally consistent, and the simplification is
> >         "correct". The simplification phase very much has a "garbage in,
> >         garbage out" model.
> 
> I think that model is wrong.

I'm not fond of it myself, far from it, but for the moment
it's how sparse is working.

> It is not only "garbage in, garbage out".
> It cause sparse freak out due to incorrect SSA form like the wine dead
> loop bug. In the above example, %r4 was used *before* it's define,
> so there must exist an execution flow loop back to the beginning of
> this block.

I hadn't time to look closely to the wine bug but I'm very aware
of what can happen to undefined pseudos *coupled* to the optimization
that are done on them (basically they are essentially ignored as
phi-sources, this coupled with CSE make that once loops are involved
you have this sort of self-defined pseudos, directly or indirectly).

> So the proper way should be some thing like:
> 
> phi.32 %phi4 <- %phisrc1(VOID), %phisrc2(%r4)
> and.32 %r3 <- %phi4, $-65
> or.32 %r4 <- %r3, $64
> phisrc.32 %phiscrc2 <- %r4
> 
> Luc, are you fully back yet?
> 
> If you are, please take a look at the wine compile dead loop bug. I
> already simplify the test source into minimal form. My guess is that it
> is cause by this invalid SSA form as well.

I had the impression it was something else but as I said I
haven't really looked at it.

> BTW, gcc does not do this kind of invalid SSA form in their IR.

GCC has a very different optimization architecture, for example,
they don't try to reach a fix-point as this would be way too costly.
They simply have a number of passes, in a fixed order, and some of them
can be (optionally) repeadted at some stages (-frerun-cse-after-loop,
-fgcse, -fgcse-after-reload, ...).
 
GCC is also very bad at giving good warnings for undefined variables
(cfr., for example, https://gcc.gnu.org/bugzilla/show_bug.cgi?id=18501)

> We really should change this model.

The patch series I have to solve the problem of misplaced phi-nodes
use an explicit PSEUDO_UNDEF type don't try to do anything with them
(on pupose, so that 1) we can given some warnings about undef vars,
2) we can *decide* to do optimization on them or not).
This is of course not material for a -rc5.

> OK we are on the same page on cause of the crazy programmer.
> Only different view on the SSA form.
> 
>  the BB early to avoid the "crazy programmer".
> >> That sounds more like a cover up rather than a proper fix up.
> >
> > Like explained in the original patch description, this situation with
> > a self-defined pseudo can happen in unreachable code *even* if the
> > pseudo was in fact defined if:
> > - the definition was done in a loop header
> > - the loop header was deleted by insert_branch()
> >   * the definition is then removed, the pseudo become undefined
> >   * it shouldn't matter since all it's use is now in dead code
> >   * we don't know the that the loop is now dead code before
> >     kill_unreachable_bbs() is called.
> >   * therefore, kill_unreachable_bbs() must be called:
> >     - after a branch have been deleted
> >     - before simplify_one_memop() is called and is about to issue the
> >       "crazy programmer" warning
> >       BECAUSE THE "crazy programmer" WARNING SHOULD NOT BE ISSUED
> >       IF THE CONCERNED CODE IS IN FACT DEAD CODE.
> 
> I totally get that part. My point is that, the crazy programmer warning
> is an ill form of SSA to begin with. We might need to address that illegal
> SSA form as well.

OK. In short, undefined pseudos cause this SSA you call illegal and that
Linus call typical of uninitialized pseudos. Different nomenclatures, fine.

But the whole thing about all this discussion is that
- after some optimizations
- in dead/unreachable code
- you *can* have uninitialized pseudos that *were* perfectly initialized
  in the initial code.
- and doing further optimization on this dead code wil then create real
  problems like this false "crazy programmer" warning.

It's of course an unpleasant situation, one that is present since
a long time, sort of at the core of sparse. I can be solved in
severals ways but the only simple one, adequate for an -rc5 is
to avoid doing optimization on those unreachable BBs, like my
patch insure to do in all cases and your version do only some cases.

> My impression is that the illegal SSA from cause the
> wine dead loop bug as well.

I'll take a look at it.

> > So, if you really prefer, you can call kill_unreachable_bbs() just before
> > the "crazy programmer" check instead of just after the branch delete
> > like it was done in my patch but calling kill_unreachable_bbs()
> > only after clean_up_insn() like done in your patch is wrong.
> 
> I don't think it is wrong. Because even with your patch, there is
> other ways to get into "crazy programmer" situation. We need to
> address that.
> 
> My point is that, "crazy programmer" is an ill form of  SSA it shouldn't
> exist in the first place.

The "crazy programmer" warning is a very valid warning.
It has a very bad description but it is simply a warning for
vars. Try on some code like:
	void bad0(void)
	{
		int *a;
		*a++;
	}

It will very legitimately give you one of such "crazy programmer"
warning, which really should be something like:
	warning: (possibly) undefined variable 'a'
In others words, what you call 'illegal SSA form' is, very much
by design, the symptoms of undefined vars and it's the only one we
currently have. It's also fo form of self-consistency check that will
need to stay independently of how undefined vars are treated.

Of course, once we get this situation and this warning on perfectly
valid and defined code because we try to apply some optimizations
on code that have been partially optimized away (the initialization
have been removed but the uses have not), things are very different.

> > I found absolutely incredible the amount of time already wasted
> > on this issue and it is even not closed yet.
> > I feel really tired and totally disgusted by all this.
> 
> Luc, I hope you have a good rest during your time off sparse.
> 
> Getting the compiler back end optimization right is hard and
> tedious.

Absolutely, and I would really appreciate to spend my time on
useful work rather than on these discussions.

-- Luc
