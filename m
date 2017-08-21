From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: RFC: One strange idea inspired by the SSSA
Date: Mon, 21 Aug 2017 16:14:14 +0200
Message-ID: <CAMHZB6EuyzzTiJdwPC5p727628uDhyt1aRQFdg+Yj6V3hmDozw@mail.gmail.com>
References: <CANeU7Qn2zyruhC5r1bMM8uOzCvk_6xvezQCWdV_U6jAxQiVuDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ua0-f177.google.com ([209.85.217.177]:36478 "EHLO
        mail-ua0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754175AbdHUOOP (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 21 Aug 2017 10:14:15 -0400
Received: by mail-ua0-f177.google.com with SMTP id k12so9798507uag.3
        for <linux-sparse@vger.kernel.org>; Mon, 21 Aug 2017 07:14:15 -0700 (PDT)
In-Reply-To: <CANeU7Qn2zyruhC5r1bMM8uOzCvk_6xvezQCWdV_U6jAxQiVuDg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Aug 21, 2017 at 3:28 PM, Christopher Li <sparse@chrisli.org> wrote:
> The SSSA paper idea is interesting. It get the simple case
> handle very fast. However, I see it has two draw backs.
> 1) Creating the redundant phi node and using per pseudo
>     ptrmap[block] -> pesudo mapping has over head in terms
>     of memory allocation and execution.

I've checked yesterday evening on some big functions and the
ptrmap use 26 times less memory than the ptrlist. I then added
the call needed to free all ptrmap as soon as they're not needed.
I really think this memory for ptrmap is a non-issue.

> 2) it does not handle the case access memory via pointers.
>     This draw back is a major one.
>     This means we need to have other means of promoting
>     memory access to pseudo, (may be using classing SSA
>     conversion?)
>
>
> My have a hunch that the SSA promoting from the instruction
> level is kind of unavoidable. e.g. some promotion might happen
> after CSE.

Right.

> If we take that as an assumption. Then I have this idea similar
> to the SSSA paper in the sense that it take advantage of the
> source file that is reducible graph. Instead of inserting the phi
> instruction on all possible block join point.

Mind to explain what you mean by 'all possible block join point' and
why you believe the method do this?

> We can do some thing
> else that can be beneficial to the classic SSA promotion algorithm.
> We can mark the DF local defined in the Appel "morden
> compiler implementation in java" page 406.
>
> DF local(n) define as: The successor of n that is not strictly
> dominated by n.

Don't you need the whole CFG for this (when you have
a loop, for example)?

> ...
>
> So if we mark those DF local(n) for a block during linearization.
> Then we don't need to go through the dominating *tree* to find
> DF(n). We know that during linearization. This can serve as
> some thing similar to the "single store short cut", except that
> it can place the phi node properly.

The SSSA method already do something very close to the
'single-store shortcut'. I strongly encourage you to play a bit
with 'test-linearize -fdump-linearize=only' on some examples.

Also, we must not forget that it's all a question of trade-off.
The advantage of this method is that it can do a good part
of the job on-the-fly, without needing the CFG. With the CFG
you can do some smarter things but then you first need to build
everything blindly and only then you can begin to be smarter.

It's the same if you want pruned SSA. Then you only have
to do the conversion for live variables but ... you first need
to calculate the liveness information. Idem about the
dominance graph.

-- Luc
