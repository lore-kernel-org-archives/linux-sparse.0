From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Simple SSA status
Date: Thu, 7 Sep 2017 04:03:13 +0200
Message-ID: <20170907020312.yt6z5jsfb4xn6m2a@ltop.local>
References: <CANeU7Q=9nUo+D3R3ypCS=-kND2vD_Qx84ua59_bi0-VGftPuqA@mail.gmail.com>
 <CAExDi1QryT9Hc6+yY0_E4Y6opsq3JiYo0KOidSDSj4VGD0J1Nw@mail.gmail.com>
 <CACXZuxfkduQSVJjzmYow5akJff_prmBeOS6Os-OnqCNpCCictA@mail.gmail.com>
 <CANeU7QmekgnTBVF_7kZRAL-LB+g2W4MZbchxrApnQVeQk32wDw@mail.gmail.com>
 <20170903202629.bipsxi7xnmh3y3oy@ltop.local>
 <CANeU7Q==zoxfgzGLKS00AqZ-M07Whr9Nu5gZtANd4PK_u3J47A@mail.gmail.com>
 <20170904200720.cxxfecd7rugyfskx@ltop.local>
 <CANeU7Q=KV7k+z=SYyvkVJGFLmXE-Un2x-WQeGBmydTb0mj=dbQ@mail.gmail.com>
 <20170905005553.lwwo3hcre3vlgafd@ltop.local>
 <CANeU7Q=SSLWZL-AYLT8JMh9CVkJLaGVtWz2u5x4jNbgq3SKrDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f171.google.com ([209.85.128.171]:33877 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751287AbdIGCDR (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 6 Sep 2017 22:03:17 -0400
Received: by mail-wr0-f171.google.com with SMTP id v109so1209504wrc.1
        for <linux-sparse@vger.kernel.org>; Wed, 06 Sep 2017 19:03:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7Q=SSLWZL-AYLT8JMh9CVkJLaGVtWz2u5x4jNbgq3SKrDg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Mon, Sep 04, 2017 at 11:28:07PM -0400, Christopher Li wrote:
> On Mon, Sep 4, 2017 at 8:55 PM, Luc Van Oostenryck wrote:
> >
> > It can and it has pro & cons
> > - pro: the CFG is know in advance, so no complication with gotos
> > - cons: for non-goto blocks during linearization we know when
> >         all the predecessors have been already processed
> >         If done after lineariation, this info need to be somehow
> >         deduced (but it's just keeping a flag).
> 
> For non-goto blocks the dominator tree is easy.

Mmmm, I think you're confused.
The dominator tree is a function of the whole graph, not just
some blocks. Also, after linearization, there is no more for(),
while() & do-while() or gotos: all CFG edges are alike.

What was written here above is that, *during linearization*,
when you have a branch from a structured-programming statement,
you know what are all the possible parents of the current block.
For branches coming from goto, it's not the case.
This has nothing to do with the dominance tree as such.

What is trivial about the dominator tree is when it is done
on an acyclic graph (you just have do to a DFS and voilà)
but that's independent of the presence or absence of gotos.

[Of course, the presence of gotos *can* create irreducible graphs
 and for those calculating their dominance tree *can* take a bit
 more time, but that's all.]

> > Of course, the later depends on the former but the problem for non-local
> > variables is not the same as the one for local variables, you need to take
> > in account the presence of calls, stores to unrelated vars (and non-var),
> > ... You can consider this as being part of the alias analysis if you
> > wish but ...
> 
> Local variable can have address taken and pass around as well.

I suppose you hadn't seen the note I added:
> > Note: here above, I use 'local var' to mean '(local) var which can
> >       safely be converted because it cannot be aliased to anything'
This, of course, excludes variables which had their address (explicitly)
taken but also things like:
- arrays
- structures & unions
- global variables
- EQUIVALENCE declarations in fortran
- variables with alias attribute (as gcc extension)
- ...

-- Luc
