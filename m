From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [RFC] sparse SSA construction
Date: Mon, 7 Aug 2017 01:44:42 +0200
Message-ID: <20170806234441.vcpux6zyhfsfef3c@ltop.local>
References: <20170806202651.8763-1-luc.vanoostenryck@gmail.com>
 <CANeU7Qk3trZmFqyGuhOxBLzFBOT131o=HhNhwQrzLrHoO2PQ1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:37065 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751355AbdHFXoq (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 6 Aug 2017 19:44:46 -0400
Received: by mail-wm0-f53.google.com with SMTP id t201so56174869wmt.0
        for <linux-sparse@vger.kernel.org>; Sun, 06 Aug 2017 16:44:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7Qk3trZmFqyGuhOxBLzFBOT131o=HhNhwQrzLrHoO2PQ1Q@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Aug 06, 2017 at 07:01:29PM -0400, Christopher Li wrote:
> On Sun, Aug 6, 2017 at 4:26 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > Since it seems to be some interest on the subject and
> > to avoid duplicated work, here is a rewrite of sparse's
> > construction of the SSA form.
> >
> > It's not using one of the classical algorithm but is
> > using something newer, simpler and often faster.
> > It's main advantage beyond the simplicity is that you don't
> > need to first build the whole CFG & linearized code to
> > to directly throw it away (or heavily transform it) as
> > it builds the SSA form directly during the linearization.
> 
> OK, great.
> 
> May I ask the question that, the SSA form you are building
> from this codes. Does it violate the SSA dominance property

Of course not. Unless there is a bug, that is.

> In other word, does it produce the "usage before
> define" IR similar to this?
> 
>         and.32      %r3 <- %r4, $-65
>          or.32       %r4 <- %r3, $64

It gives the code as I showed as reply to Dibyendu's mail.
For example, his code gives:
        foo:
        .L0:
                <entry-point>
                and.32      %r2 <- UNDEF, $-65
                or.32       %r3 <- %r2, $64
                lsr.32      %r4 <- %r3, $6
                cast.1      %r5 <- (32) %r4
                cast.32     %r6 <- (1) %r5
                setne.32    %r7 <- %r6, $1
                ret.32      %r7

with UNDEF being a new type of pseudo.

On purpose, nothing is done yet with the UNDEFs.

> That I am very curios how it was done. See the above
> question.

IMO, the best is to read the article. My code is
still very close to the article's pseudo-code.

Basically, it's a lazy approach. Things are done
when possible and are delayed if not. 
More specifically, you can do what is needed in a BB
once you have all the parents, otherwise you need to
delay things. The article call this 'BB is sealed'
and there is a 'seal' operation that need to be called
to process what was delayed.
Complications arise with gotos (and the article doesn't
talk about them) but I've added a solution for it
(but I would like to return to it later).

From what I've seen/heard this algo have been pretty well
received. Personnaly, I'm very happy with its simplicity
and its result. 

One thing that is missing is the more complex cases
with trivial phi-nodes.

Another thing I would like to change is the ptrmap
implementation I've added: it need to be hash-table based
(but it's only an implementation detail that matters
for performance on really big functions).

-- Luc
