From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [RFC] sparse SSA construction
Date: Tue, 15 Aug 2017 23:43:57 +0200
Message-ID: <CAExDi1QQzTKeC1b=9sJYTANBvBDswqwqH1O1XsSED_oeYYVwnA@mail.gmail.com>
References: <20170806202651.8763-1-luc.vanoostenryck@gmail.com>
 <CACXZuxchKzgv_cN7MzZnT09OX1thdODoinqSVzK8jSxdPCVK8w@mail.gmail.com>
 <CANeU7Qk9C-78+-a2TOGUWiLof9S_p9vO6bHyNf6xZqZ5X1CoUQ@mail.gmail.com>
 <CACXZuxeGgFmjDosHv-Exd9qRLfonFGUrD7sx-ucQejuR0jsD+w@mail.gmail.com>
 <CANeU7QmQ8DdeBLx9kDNf-xnTOUc=V7VNu95A+dAL4oUbLngonw@mail.gmail.com>
 <CACXZuxcb8YVcdkTjvo-0cxDughp0kveQCN_sDKWzxxE0QFs=+A@mail.gmail.com>
 <CA+55aFwXc6QDgZSv++ZUUTHEixsMoKUq6Wc-6sQ4g5po5ZmA5g@mail.gmail.com>
 <CAMHZB6GZCcOfAD3qkFs39hVQ1om5TdCM5CTTwAb2aqLH1Hbriw@mail.gmail.com> <CA+55aFzvNEGEbO=H9C5q29js7A57zMm00a8i5NqDfPsZAxpr2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:34698 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752031AbdHOVn7 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 15 Aug 2017 17:43:59 -0400
Received: by mail-oi0-f46.google.com with SMTP id x3so19627124oia.1
        for <linux-sparse@vger.kernel.org>; Tue, 15 Aug 2017 14:43:58 -0700 (PDT)
In-Reply-To: <CA+55aFzvNEGEbO=H9C5q29js7A57zMm00a8i5NqDfPsZAxpr2g@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Aug 15, 2017 at 10:43 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Tue, Aug 15, 2017 at 1:14 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>>
>> For information, the current SSA construction is very broken,
>> both in simplify_one_symbol() (the main SSA construction)
>> and simplify_loads() (which also creates phi-nodes). They both
>> are 'load-driven' which is OK but they both put the phi-nodes
>> where the load is while phi-nodes need to placed where branches
>> meet. The loads are often placed in a BB following where the
>> join-point. Often this *seems* to be OK but in fact is very wrong
>> and create all sort of problems a bit everywhere
>
> I do think you're too hung up about the placement of the phi nodes.
>
> It may be an issue for simple models that just walk the linearized
> code directly and try to turn it into code. But the original intent of
> the existing phi node code was to just be as sources of the pseudo's -
> the location should be largely immaterial.

Yes, what I thought for a long while,
But when things like try_ti_simplify_bb() come in play,
with pack_basic_blocks() on top the things become
*very* messy I often you can't make sense of it anymore.

This has also consequences on liveness (but it can't explain
the root of the problem there, i's month's I realized it was useless.

> IOW, you could think of the phi nodes as being "outside" the
> instruction flow entirely, and just being the definition of the pseudo
> they define. They have to be placed somewhere, but the "somewhere" is
> somewhat arbitrary.

It's true to a certain point, after it, you need to have them placed at
the confluence point. I can't explain better for now. I'll have an
example tomorrow.


> That said, I like your new ssa construction -independently- of that
> issue - the old SSA constructor really was very ad-hoc. Look through
> the git history if you don't believe me ;)

Oh I believe ve *and* I have view the logs.

Not directly related to that is that I really think we need to associate
a ph-node's source to it's parent BB.

So if you have something:

|      |      |
A    B    C
\      |     /
       *rx: phi, *phsra, %phisrb, %phisrcx ,

We really want something like:
|      |      |
A    B    C
\      |     /
       *rx: phi, A:*phsra, B:%phisrb, C:%phisrcx
It's essential for a number of things (I suspect a number
of SSA algorithm, for liveliness , writing a trivial simulator, ....)

-- Luc
