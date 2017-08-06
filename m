From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Potential incorrect simplification
Date: Sun, 6 Aug 2017 18:51:57 +0200
Message-ID: <20170806165156.onm2bzojkueit6ec@ltop.local>
References: <CAExDi1TtcpZtnEV6ctyA9MacJA_9h4njmhd-MSA3KgOq8oK_gA@mail.gmail.com>
 <CACXZuxfxNNh+ThcT=7Xr98tToL2GimFi7UOTSwgNq6mfLLGNfA@mail.gmail.com>
 <20170328141113.kbrwdva6ttsrokts@macpro.local>
 <CACXZuxen9UFGNp8=-OQHoqRQJ5F__rwQoCJJ6TdkAo6HEXWOQw@mail.gmail.com>
 <CA+55aFx6g3-+6tJ_6Uqu4K1pQoDnqcXrjSGYsryLjjksEtT06A@mail.gmail.com>
 <CANeU7Qk-4U2G_6CZ7KHbGZiqRe9=fpNOzE4eyfLjz3fnd_n3ww@mail.gmail.com>
 <20170806140035.f2tqkmiufjytiwri@ltop.local>
 <CANeU7QnjRSnnSc8ew69-0M7XP2zoSVh3jhCciYDRVF0i24d=sQ@mail.gmail.com>
 <20170806150712.seci4rq2nhuqx2mc@ltop.local>
 <CANeU7QnbtvGQMBZjfBSA-njbMMrPVcTb4xTOU8kd_JPb14n63Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:38423 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751300AbdHFQwB (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 6 Aug 2017 12:52:01 -0400
Received: by mail-wm0-f51.google.com with SMTP id m85so52499177wma.1
        for <linux-sparse@vger.kernel.org>; Sun, 06 Aug 2017 09:52:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7QnbtvGQMBZjfBSA-njbMMrPVcTb4xTOU8kd_JPb14n63Q@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Aug 06, 2017 at 11:51:24AM -0400, Christopher Li wrote:
> On Sun, Aug 6, 2017 at 11:07 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >> Legal SSA form means it preserve the normal SSA
> >> properties. E.g. the dominance property of SSA.
> >
> > And under which conditions are SSA properties *defined*?
> 
> Not sure I understand what you are asking:
> Quote from previous email about the definition of the properties.
> 
> http://marcusdenker.de/talks/08CC/08IntroSSA.pdf
> =====================================
> Φ-Functions are placed in all basic blocks of the
> Dominance Frontier.
> 
> Dominance Property of SSA:
> 1. If x is used in a Phi-function in block N,
> then the definition of x dominates *every* <==== notice "every"
> predecessor of N.
> 2. If x is used in a non-Phi statement in N,
> then the definition of x dominates N
> ======================================
> 
> If we are asking when should we follow those properties.
> I think *always*.

It's typically things that are not discussed about in papers.
They assume proper, well defined inputs (or even simplified
situation only) or that it is easy enough to force it to be
well defined that it's not useful to talk about it.
 
> >> > As I've already tried to explain you several times:
> >> >         it's a *symptom* that something have been wrong, either:
> >> >         - the initial code had some undefined variables
> >>
> >> The source code has some variable uninitialized is still valid
> >> C source code.
> >
> > It's valid in the sense that code is written like this and
> > compilers (and checkers!) should better try to process it
> > in a usefull manner.
> >
> > But accessing such variable is *undefined behaviour*.
> 
> That is true but not relevant.

It's very relevant because its semantic is not defined.
In other words, you can do anything you like (for the
standard point of view).
It's also relevant because you will then probably want 
to avoid to (generate code which) access such vars *and*
want to detect them.

> >> In such condition the compiler produce transformation
> >> that break the dominance property of SSA is wrong IMHO.
> >
> > The SSA properties are not defined for this kind of input.
> 
> That is just your view. It is clearly not the view in academia.

Really?
 

> 2. Do not break the SSA dominance property. Give the uninitialized
>     variable an implicit defined as "uninitialized". That is the method
>     describe in Appel's book. It is also the model gcc and llvm use as
>     well as far as I can tell.

This is also what I'm doing for various reasons.
But once you initialize it with a special value, by definition,
it's not uninitialized anymore.
 
> >> It has incoming edge to the phi node, it need to be defined.
> >
> > And what happen if it is in fact undefined?
> 
> I am getting tired of repeat my self here. There is no undefined
> here if we start every variable in the entry node with define to
> uninitialized, unless specify otherwise.

I was referring to the 'internal bug' case.
The current "crazy programmer" warning is as much a kind of
assert on the internal consistency of the SSA form than a detection
of uninitialized variables.
 
> Refer to the book for more detail description of the algorithm
> how to convert to SSA. We don't need to reinvent the wheel.

Who's talking about reinventing the wheel?
Your question was about "is it legal SSA form" (in the current sparse code)
and I explained to you that it was the symptom of a problem.

Nobody is claiming that the current situation is a good one.

> > No.
> > The only interesting things are:
> >   "what do we do when we have an input that is not well formed, undefined"
> 
> See the above consequence reasoning.
> 
> > and even more interesting:
> >   "how do we *detect* this and how do we emit a diagnostic that is useful".
> 
> We don't need to detect it. Every variable start with defined to uninitialized
> unless specify otherwise.

If you give a special distinguished value to uninitialized vars (or
to every until they receive a real one or the same to pseudos) then
you can detect them when you got this special distinguished value.
It's one method.

The *current* method is to check these self-definition cycles.
It's an inferior method IMO (and apparently you too) but it has
the advantage to be simple *and* to do an internal self-consistency
check at the same time.

Do I mean that we should keep the current method?
Not at all.
Do I mean that we should keep thsi check for the self-consistency
check? Yes, probably, at least as an option.
Is there some better way to do this sort of check?
Maybe and it will also depends on the details of the implementation.
 
> > Also, let's not forget that the (primary) goal of a compiler is to
> > produce (good) code (for well defined inputs). But most significant
> > ones doesn't stop there and try hard to produce usefull diagnostic for
> > the other inputs. And sparse, as a semantic *checker*, should be even
> > more concerned by this aspect.
> 
> True but irrelevant to my discussion. My point is you make the choice,
> you face the consequence. Our garbage in garbage out choice is not
> a good one because I can't use classic ssa algorithms safely.

But if there is an internal bug, this algo will also not be safe,
so the utility for some self-consistency/validity checks.

Next time, instead of asking a question like "is it legal ..."
simply state something like:
 "the current situation with this and that is annoying because
  this and that. I'm planning to change it by this so that ..."
and it will be much more easier for everybody to understand what
you're really asking for.

-- Luc 
