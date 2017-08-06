From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Potential incorrect simplification
Date: Sun, 6 Aug 2017 17:07:13 +0200
Message-ID: <20170806150712.seci4rq2nhuqx2mc@ltop.local>
References: <CACXZuxeRXsYWgwihs1nmmTYaLoyhw+PDAy6jEemkZJFpySdfQA@mail.gmail.com>
 <CAExDi1TtcpZtnEV6ctyA9MacJA_9h4njmhd-MSA3KgOq8oK_gA@mail.gmail.com>
 <CACXZuxfxNNh+ThcT=7Xr98tToL2GimFi7UOTSwgNq6mfLLGNfA@mail.gmail.com>
 <20170328141113.kbrwdva6ttsrokts@macpro.local>
 <CACXZuxen9UFGNp8=-OQHoqRQJ5F__rwQoCJJ6TdkAo6HEXWOQw@mail.gmail.com>
 <CA+55aFx6g3-+6tJ_6Uqu4K1pQoDnqcXrjSGYsryLjjksEtT06A@mail.gmail.com>
 <CANeU7Qk-4U2G_6CZ7KHbGZiqRe9=fpNOzE4eyfLjz3fnd_n3ww@mail.gmail.com>
 <20170806140035.f2tqkmiufjytiwri@ltop.local>
 <CANeU7QnjRSnnSc8ew69-0M7XP2zoSVh3jhCciYDRVF0i24d=sQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:37456 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751300AbdHFPHR (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 6 Aug 2017 11:07:17 -0400
Received: by mail-wm0-f54.google.com with SMTP id t201so51454613wmt.0
        for <linux-sparse@vger.kernel.org>; Sun, 06 Aug 2017 08:07:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7QnjRSnnSc8ew69-0M7XP2zoSVh3jhCciYDRVF0i24d=sQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Aug 06, 2017 at 10:24:30AM -0400, Christopher Li wrote:
> On Sun, Aug 6, 2017 at 10:00 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >> Sorry I wasn't able to participate this discussion earlier. I am catching
> >> up at the important sparse mailing list discussion. This is one of them.
> >>
> >> This has puzzle me for a long time. From the looks it seems %4 was
> >> used before it was define. Is that legal SSA form?
> >
> > What do you mean exactly by "legal SSA form"?
> 
> Legal SSA form means it preserve the normal SSA
> properties. E.g. the dominance property of SSA.

And under which conditions are SSA properties *defined*?
 
> > As I've already tried to explain you several times:
> >         it's a *symptom* that something have been wrong, either:
> >         - the initial code had some undefined variables
> 
> The source code has some variable uninitialized is still valid
> C source code.

It's valid in the sense that code is written like this and
compilers (and checkers!) should better try to process it
in a usefull manner.

But accessing such variable is *undefined behaviour*.

> In such condition the compiler produce transformation
> that break the dominance property of SSA is wrong IMHO.

The SSA properties are not defined for this kind of input.
It's not that the compiler that produce a transformation
that break the property, the property wasn't there/defined
since the beginning. The compiler only (maybe) made it obvious
that the input is wrong.

> >         - it's an internal bug.
> >
> > In both cases you can't do anymore 'normal' processing on it.
> > In this sense it's "illegal".
> 
> I mean the transformation that break the SSA dominance property
> is illegal. The source code is legal to have uninitialized values.

Your use of 'legal/illegal' only create dramatic black/white
situations which doesn't help you to understand the situation.
You can call it 'legal' but its semantic is undefined.
If its semantic is not defined, it means that all those nice
discussions about breaking SSA property is meaningless.

> When
> we convert the memory variable to pseudo, we should take into account
> that uninitialized variable has one implicit initial define value
> "uninitialized".
> 
> In other words, we shouldn't produce the IR that use before define like
> this:
>          and.32      %r3 <- %r4, $-65
>          or.32       %r4 <- %r3, $64

Good.
You can avoid to produce such IR if you first detect uninitialized
variables (and emit a diagnostic and stop things there).
Do you a good plan to detect uninitialized variables?

> > The other way to see it is something like: "ok, this means that the
> > pseudo was not initialized" (and ignore the internal bug aspect) and
> 
> No, in SSA world, there is no pseudo is not initialized.

In textbook and articles, yes, they suppose that the input is well
defined and leave others input as an exercise for the reader.

> Please refer back
> Dominance Property of SSA:
> 1. If x is used in a Phi-function in block N,
> then the definition of x dominates *every* <==== notice "every"
> predecessor of N.

For input without undefined behaviour, yes surely.

> It has incoming edge to the phi node, it need to be defined.

And what happen if it is in fact undefined?

> It means that you can't just do what ever you want with that
> edge. You can pick a what ever initial value for the uninitialized
> value, you can't just pretend that uninitialized edge does not exist
> and do whatever you want with it.
> 
> > then process it as such (for example choose any value you like for it).
> > You can call this "a new/legal SSA form" if you like but it will only
> > confuse discussion and won't change it's nature.
> 
> OK, points taken. Replace "illegal SSA from" with "SSA form that violate
> the SSA dominance property" so that we are clear what we are talking
> about here.

No.
The only interesting things are:
  "what do we do when we have an input that is not well formed, undefined"
and even more interesting:
  "how do we *detect* this and how do we emit a diagnostic that is useful".

Also, let's not forget that the (primary) goal of a compiler is to
produce (good) code (for well defined inputs). But most significant
ones doesn't stop there and try hard to produce usefull diagnostic for
the other inputs. And sparse, as a semantic *checker*, should be even
more concerned by this aspect.

-- Luc
