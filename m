From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Potential incorrect simplification
Date: Tue, 28 Mar 2017 22:27:47 +0200
Message-ID: <20170328202746.bmamqhxitmpvfsad@macpro.local>
References: <CACXZuxeRXsYWgwihs1nmmTYaLoyhw+PDAy6jEemkZJFpySdfQA@mail.gmail.com>
 <CAExDi1TtcpZtnEV6ctyA9MacJA_9h4njmhd-MSA3KgOq8oK_gA@mail.gmail.com>
 <CACXZuxfxNNh+ThcT=7Xr98tToL2GimFi7UOTSwgNq6mfLLGNfA@mail.gmail.com>
 <20170328141113.kbrwdva6ttsrokts@macpro.local>
 <CACXZuxen9UFGNp8=-OQHoqRQJ5F__rwQoCJJ6TdkAo6HEXWOQw@mail.gmail.com>
 <CA+55aFx6g3-+6tJ_6Uqu4K1pQoDnqcXrjSGYsryLjjksEtT06A@mail.gmail.com>
 <20170328170049.2y6lwxx64yzjjwmc@macpro.local>
 <CA+55aFz6C5bEJqr72mBauWRUQiKYJ8eQpiXrKRW7JEiKXjZdrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:38328 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932207AbdC1U2C (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 28 Mar 2017 16:28:02 -0400
Received: by mail-wm0-f49.google.com with SMTP id t189so8512822wmt.1
        for <linux-sparse@vger.kernel.org>; Tue, 28 Mar 2017 13:27:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CA+55aFz6C5bEJqr72mBauWRUQiKYJ8eQpiXrKRW7JEiKXjZdrw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Mar 28, 2017 at 11:02:32AM -0700, Linus Torvalds wrote:
> On Tue, Mar 28, 2017 at 10:00 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >
> > I agree, of course, but I think there is a problem anyway.
> 
> Yes. I just wanted to point out that it's not the simplification phase
> that is the problem, and that sparse is technically correct (for some
> definition of "technically" ;)

Ok :)
 
> > The problem here with this %r4 is created by the single-store
> > shortcut which replace all loads with the same value as the one
> > used for the unique store (even loads that are not dominated
> > by the store). Fair enough, don't use uninitialized vars.
> 
> Yeah.
> 
> Personally, I absolutely detest a lot of the undefined C corner cases.
> I'm a huge fan of the language, but almost all of the the "undefined
> behavior" in C is a huge mistake.

And things become even more fun once you try to understand the standard.
 
> ...
>
> > But what annoys me really is that:
> > -) once you remove the single-store shortcut, it seems there is
> >    other problems (I just saw it by doing some code comparison,
> >    I need to create a few clear examples).
> 
> The single-store shortcut is actually pretty important, because it is
> what turns a *lot* of local variables from stack memory things into
> pseudos. That's partly because the sparse optimizations aren't all
> that smart.

Everytime I look at this part of the code, I think the same:
  why turn all vars into stack memory to have to turn them later
  into pseudos?
 
> Sparse code gen sometimes looks really good, but it's really largely
> due to SSA really being a wonderful model. It makes some "complex"
> optimizations magically trivial.  But outside of those things, sparse
> really is pretty damn stupid.
> 
> I actually would whole-heartedly support a "all local variables are
> initialized to zero" mode, which would get rid of a lot of these
> undefined cases.

It shouldn't be hard but then things like single-store shortcut then
become useless.

> But it would also be good to just warn about it

I have a trivial patch for that (just look at ep->entry->bb->needs)
but for the moment it's not yet useful because there is too much
problems there (but maybe I should look at it again).

> - the problem is that
> sparse doesn't even necessarily *understand* when it generates garbage
> from garbage input, because the transformations are so mindless, and
> the SSA code works without ever understanding the notion of truly
> "dominating" operations.
> 
>                    Linus
