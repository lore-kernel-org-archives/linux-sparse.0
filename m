From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [RFC] sparse SSA construction
Date: Tue, 15 Aug 2017 22:14:00 +0200
Message-ID: <CAMHZB6GZCcOfAD3qkFs39hVQ1om5TdCM5CTTwAb2aqLH1Hbriw@mail.gmail.com>
References: <20170806202651.8763-1-luc.vanoostenryck@gmail.com>
 <CACXZuxchKzgv_cN7MzZnT09OX1thdODoinqSVzK8jSxdPCVK8w@mail.gmail.com>
 <CANeU7Qk9C-78+-a2TOGUWiLof9S_p9vO6bHyNf6xZqZ5X1CoUQ@mail.gmail.com>
 <CACXZuxeGgFmjDosHv-Exd9qRLfonFGUrD7sx-ucQejuR0jsD+w@mail.gmail.com>
 <CANeU7QmQ8DdeBLx9kDNf-xnTOUc=V7VNu95A+dAL4oUbLngonw@mail.gmail.com>
 <CACXZuxcb8YVcdkTjvo-0cxDughp0kveQCN_sDKWzxxE0QFs=+A@mail.gmail.com> <CA+55aFwXc6QDgZSv++ZUUTHEixsMoKUq6Wc-6sQ4g5po5ZmA5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ua0-f174.google.com ([209.85.217.174]:37118 "EHLO
        mail-ua0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751780AbdHOUOB (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 15 Aug 2017 16:14:01 -0400
Received: by mail-ua0-f174.google.com with SMTP id f9so6865109uaf.4
        for <linux-sparse@vger.kernel.org>; Tue, 15 Aug 2017 13:14:01 -0700 (PDT)
In-Reply-To: <CA+55aFwXc6QDgZSv++ZUUTHEixsMoKUq6Wc-6sQ4g5po5ZmA5g@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Aug 15, 2017 at 8:36 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>> https://github.com/lucvoo/sparse/tree/sssa-mini-clean
>
> I like it. But the commit messages are sorely lacking. And I'm not
> talking just about the lack of sign-off's, I'm talking about the
> messages just not explaining what is going on AT ALL.

I know, sorry for that, I don't like it myself (often I've the
impression to spend more time to wrote a decent commit
message than to write the corresponding code).
I'll work on that tomorrow (Europe here, already evening, sorry).

One of the thing I'm afraid won't be able to do (without a quite
a bit more work) is to do some nice small step-by-step commits.
It's completely changing the method, a step-by-step will be very
artificial and quite useless, I think.

> But with that fixed, I heartily recommend merging the new ssa
> construction code. It's based on a real paper, rather than being
> ad-hoc.

It's just too bad that the paper simply ignores gotos. The method
is really cool, fast, simple and clean, I love it. But I had to add
a few things, more akin to kludges than hacks IMO, to make it
work with gotos. But as is, it works pretty well, is fast and produce
correct SSA (also avoid few quadratic behaviours the current
simplify_one_symbol() has).

Improvement areas are:
- I feel we can do better with gotos and computed gotos
  it needs investigation
- the ptrmap thing need an hash based implementation
  but this is only needed for extreme cases. The trick will
  be to do something with dynamic size and which will not
  waste (too much)  memory. Nothing hard, but it will need
  some experiment  and I want first to collect some statistics
- there is an optimization that can be added for (what I call)
  'complex trivial phi-nodes' (it's clear in the paper, I think)

But none of this is blocking, just something that can easily
be added later.

The current situation is:
- As far as I saw the generated IR is correct (from a phi-node
  point of view).
- The performance is pretty nice (faster than the current method)
- There are some optimizations for free because the method
  do a kind of global-numbering.
- It does very well on a kernel allyesconfig. It just creates
  something like 8 or 12 more context/locking warnings I
  would like to understand (OTOH, knowing how broken
  the current SSA is, I'm surprised there isn't more differences).

For information, the current SSA construction is very broken,
both in simplify_one_symbol() (the main SSA construction)
and simplify_loads() (which also creates phi-nodes). They both
are 'load-driven' which is OK but they both put the phi-nodes
where the load is while phi-nodes need to placed where branches
meet. The loads are often placed in a BB following where the
join-point. Often this *seems* to be OK but in fact is very wrong
and create all sort of problems a bit everywhere

Best regards,
-- Luc Van Oostenryck
