From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Simple SSA status
Date: Thu, 7 Sep 2017 05:05:21 +0200
Message-ID: <20170907030520.vmxbklljde7d7puc@ltop.local>
References: <CACXZuxfkduQSVJjzmYow5akJff_prmBeOS6Os-OnqCNpCCictA@mail.gmail.com>
 <CANeU7QmekgnTBVF_7kZRAL-LB+g2W4MZbchxrApnQVeQk32wDw@mail.gmail.com>
 <20170903202629.bipsxi7xnmh3y3oy@ltop.local>
 <CANeU7Q==zoxfgzGLKS00AqZ-M07Whr9Nu5gZtANd4PK_u3J47A@mail.gmail.com>
 <20170904200720.cxxfecd7rugyfskx@ltop.local>
 <CANeU7Q=KV7k+z=SYyvkVJGFLmXE-Un2x-WQeGBmydTb0mj=dbQ@mail.gmail.com>
 <20170905005553.lwwo3hcre3vlgafd@ltop.local>
 <CANeU7Q=SSLWZL-AYLT8JMh9CVkJLaGVtWz2u5x4jNbgq3SKrDg@mail.gmail.com>
 <20170907020312.yt6z5jsfb4xn6m2a@ltop.local>
 <CA+55aFxFJf4T4kQq1oRNatFQnXuonPA-Dk7=xNTeU8u9cVyUGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f175.google.com ([209.85.128.175]:37358 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753614AbdIGDFZ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 6 Sep 2017 23:05:25 -0400
Received: by mail-wr0-f175.google.com with SMTP id k20so7880051wre.4
        for <linux-sparse@vger.kernel.org>; Wed, 06 Sep 2017 20:05:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CA+55aFxFJf4T4kQq1oRNatFQnXuonPA-Dk7=xNTeU8u9cVyUGA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Sep 06, 2017 at 07:15:13PM -0700, Linus Torvalds wrote:
> On Wed, Sep 6, 2017 at 7:03 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >
> > What was written here above is that, *during linearization*,
> > when you have a branch from a structured-programming statement,
> > you know what are all the possible parents of the current block.
> > For branches coming from goto, it's not the case.
> 
> Even this is not the case.
> 
> Not for a C compiler, it isn't.
> 
> Sure, if you do compilers for toy languages, it might be, but a C
> compiler has things like "switch()" statements that may not nest with
> loops etc. So even without a goto, you can pretty much have arbitrary
> flow.

Yes, sure. But what I wrote still hold because, even for such cases,
the linearization create trivial and useless BBs and for each of those
you know where the possible parents are and when their linearization
is finished while doing the linearization of each strutured construct
of the AST. For gotos & computed gotos, it's not the case.

It doesn't matter in itself, but it matters for the Simple SSA method
because the processing of BBs for which you don't know yet all the
parents must be delayed (it's the price you have to pay for being able
to do things mostly on the fly). This delaying happens everywhere you
have some kind of back-edge but knowing when all parents are done means
that you also know when you can 'un-delay' things (the article call
this 'unseal') and it's advantageous do do that as soon as possible.

So for this Simple SSA method, gotos are kinda annoying and computed
gotos even more so.

Anyway, I've put this method on hold for the moment, focusing on
the conversion of non-local variables (which Simple SSA can't do)
and several related issues.

> So I think people should entirely stop thinking that "goto" is somehow
> special. It isn't. It is only special in toy languages like Pascal,
> not in the real world.
> 
> It's much better to get rid of that "goto is special" mindset, and
> instead say "all control flow is just a goto in the end".
> 
> So yes, get rid of the *real* special cases - those structured flow
> constructs. They are nice special cases, but they are nice for
> *humans*, they aren't actually relevant to computers, and they
> shouldn't be.
> 
> So the real special case is those simple "structured" loops. You
> should never design around them, because it will just hurt later.
> 
> Turn those "structures loop" constructs into goto's as quickly as you
> can, and just forget about the structure that they really never
> enforced anyway.

Totally agree and it's what's done (I suppose by you and Chris,
years ago) and will stay as such: directly after linearization
you just have BBs with the list of parents & children.

-- Luc Van Oostenryck
