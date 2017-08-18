From: Christopher Li <sparse@chrisli.org>
Subject: Re: idea/question about sparse's context checking
Date: Fri, 18 Aug 2017 10:37:18 -0400
Message-ID: <CANeU7QkfuSuZkaEAjpAYtGGs=DEHBZRw6rojFLywsvvKaH2WtA@mail.gmail.com>
References: <20170818132039.hii2siz5sjaua5qr@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.161.176]:35515 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751246AbdHROhT (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 18 Aug 2017 10:37:19 -0400
Received: by mail-yw0-f176.google.com with SMTP id n83so32128265ywn.2
        for <linux-sparse@vger.kernel.org>; Fri, 18 Aug 2017 07:37:19 -0700 (PDT)
In-Reply-To: <20170818132039.hii2siz5sjaua5qr@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Josh Triplett <josh@joshtriplett.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Aug 18, 2017 at 9:20 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> Hi Josh,
>
> I was thinking lately about sparse's context checking.
> I had an idea and I wondered if it hasn't already been
> tried or discussed.
>
> The context checking essentially works with the instruction
> OP_CONTEXT, that do nothing more than adding or subtracting
> some constant value to 'the context'. Then, at checking time,
> these instructions are interpreted along all the paths and if
> there is a disagreement between values from different paths,
> it emits a 'context imbalance' warning (there is also the
> checks for the expected return value of the context).

That is right.

>
> My idea/question is the following: this interpretation
> is already done for all 'normal' values. So couldn't we
> consider the context as a special kind of 'variable',
> use a normal pseudo for it, use phi-nodes on them and

Question. What syntax are you considering for declare
this special pseudo? Does it automatically attach to the
variable that has the context attribute?

> let the normal simplification process act on them?
> If the context is (proveably) well balanced, there
> shouldn't be any phi-node left for this context.

Assume you do the context pseudo attach to the lock
variable. Then you will have to do the pointer alias properly.
People might have different pointer point to that variable.

> I'm not sure if there would be any significant advantage,
> but it seems to me that what is currently done is
> somehow redundant with the 'normal' processing.
> It could also maybe help to have several independent
> contexts.

'normal' process do you mean the context statement?

>
> [of course, we can't really use add/sub for the context
> increase/decrease as we want to check if the context
> don't become negative].

It can become negative for some helper function that
wrap around the unclock function.

I think the biggest problem with context right now is actually
not able to inline or take into account for the function that
change the context. We can add more context attribute to
the function to describe what this function might do to the
context. The best way is automatic to make this happen. I see
that as the biggest cause of the false alarm on context warnings.


Chris
