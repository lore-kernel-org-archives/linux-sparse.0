From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: idea/question about sparse's context checking
Date: Fri, 18 Aug 2017 18:15:10 +0200
Message-ID: <CAExDi1Rp5=kqy_nR6rvuM5U-u5Noh-zQsLghM1cHRDtS02P8bA@mail.gmail.com>
References: <20170818132039.hii2siz5sjaua5qr@ltop.local> <CANeU7QkfuSuZkaEAjpAYtGGs=DEHBZRw6rojFLywsvvKaH2WtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f54.google.com ([209.85.218.54]:33011 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750971AbdHRQPM (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 18 Aug 2017 12:15:12 -0400
Received: by mail-oi0-f54.google.com with SMTP id f11so101210322oic.0
        for <linux-sparse@vger.kernel.org>; Fri, 18 Aug 2017 09:15:12 -0700 (PDT)
In-Reply-To: <CANeU7QkfuSuZkaEAjpAYtGGs=DEHBZRw6rojFLywsvvKaH2WtA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Josh Triplett <josh@joshtriplett.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Aug 18, 2017 at 4:37 PM, Christopher Li <sparse@chrisli.org> wrote:
>> My idea/question is the following: this interpretation
>> is already done for all 'normal' values. So couldn't we
>> consider the context as a special kind of 'variable',
>> use a normal pseudo for it, use phi-nodes on them and
>
> Question. What syntax are you considering for declare
> this special pseudo? Does it automatically attach to the
> variable that has the context attribute?

First, it's only a vague idea. Soaking since a little while
but still only a vague idea.

You don't need at this point a special syntax.
For example, the return value is currently stored in a special
variable/symbol: 'return' in a special namespace/scope.

>> let the normal simplification process act on them?
>> If the context is (proveably) well balanced, there
>> shouldn't be any phi-node left for this context.
>
> Assume you do the context pseudo attach to the lock
> variable. Then you will have to do the pointer alias properly.
> People might have different pointer point to that variable.

No no, it's not the point here.
What I meant in the idea is that currently OP_CONTEXT
and its associated attribute work with a unique implicit
'object', called 'context' but not explicitly associated to
a symbol/variable and thus they need their own specific
machinery.

>> I'm not sure if there would be any significant advantage,
>> but it seems to me that what is currently done is
>> somehow redundant with the 'normal' processing.
>> It could also maybe help to have several independent
>> contexts.
>
> 'normal' process do you mean the context statement?

No, the processing of variables and pseudos.

>> [of course, we can't really use add/sub for the context
>> increase/decrease as we want to check if the context
>> don't become negative].
>
> It can become negative for some helper function that
> wrap around the unclock function.

This need to be checked (and currently there is a small gap
where it can go negative and positive again and not warned
about it.

> I think the biggest problem with context right now is actually
> not able to inline or take into account for the function that
> change the context. We can add more context attribute to
> the function to describe what this function might do to the
> context. The best way is automatic to make this happen. I see
> that as the biggest cause of the false alarm on context warnings.

There are several problems here:
1) the false alarms. These are unavoidable, it's equivalent to the
    halting problem. We can only be correct and precise in restricted
   situations (no loops, for example). It's not what the idea here is about.
2) what you describe here about the inlines.
    The underlying problems is to match the 'names/expression'
    given in the declarations with the ones used in(side) the definition.
    I've some drafts but I'm not totally sure about what exactly can be
   done.
3) because of 2) we ignore all the names and we simply care about
    the sum of all contexts.
    So, in truth, we can only deal with a single context.
4) the duplicated machinery this idea/question is about.

-- Luc
