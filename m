From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: idea/question about sparse's context checking
Date: Fri, 18 Aug 2017 21:01:21 +0200
Message-ID: <CAMHZB6HPD7mt=WVMr6ri7jxyohp-FkcvjR+XK9_sY-5zB4gQUg@mail.gmail.com>
References: <20170818132039.hii2siz5sjaua5qr@ltop.local> <CANeU7QkfuSuZkaEAjpAYtGGs=DEHBZRw6rojFLywsvvKaH2WtA@mail.gmail.com>
 <CAExDi1Rp5=kqy_nR6rvuM5U-u5Noh-zQsLghM1cHRDtS02P8bA@mail.gmail.com> <CANeU7QkY2=KrJTZaLJRu1KVc38Vmpggzmxf_AxawdseoZacCEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vk0-f47.google.com ([209.85.213.47]:36573 "EHLO
        mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750971AbdHRTBW (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 18 Aug 2017 15:01:22 -0400
Received: by mail-vk0-f47.google.com with SMTP id u133so35130911vke.3
        for <linux-sparse@vger.kernel.org>; Fri, 18 Aug 2017 12:01:22 -0700 (PDT)
In-Reply-To: <CANeU7QkY2=KrJTZaLJRu1KVc38Vmpggzmxf_AxawdseoZacCEQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Josh Triplett <josh@joshtriplett.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Aug 18, 2017 at 8:18 PM, Christopher Li <sparse@chrisli.org> wrote:
> On Fri, Aug 18, 2017 at 12:15 PM, Luc Van Oostenryck wrote:
>>
>> No no, it's not the point here.
>> What I meant in the idea is that currently OP_CONTEXT
>> and its associated attribute work with a unique implicit
>> 'object', called 'context' but not explicitly associated to
>> a symbol/variable and thus they need their own specific
>> machinery.
>
> Ah, I did not get your idea at the first read. So you mean
> do not use bb->context to store the context.

Exactly.
> There will
> be still one context per BB. Store the context into pseudo
> and some how that pseudo in link into the BB.

No, it will just be a pseudo, like any other pseudos so we
could have as much as we want. We'll just need to deal
with them during simplification phase.

> I was thinking weather you are going to create more than one
> context per BB, attach the context to the locking objects.
> That is not what you are trying to do.

Sorta. The contexts will be in (special) pseudos.

> If my understanding of you just try to move bb->context
> into pseudos. In principle that is fine. It is also depend on
> a lot of implementation details as well. Do you still need to
> lookup the context per basic block?

The main idea is to avoid that.

>>> It can become negative for some helper function that
>>> wrap around the unclock function.
>>
>> This need to be checked (and currently there is a small gap
>> where it can go negative and positive again and not warned
>> about it.
>
> Not sure that is worthy while to warn. It can happen in the function
> assume the lock is taken when enter the function.
> The unlock it, do some thing , relock it.
> There is total legit reason to do it.

No, it's an error to (try to) unlock a lock that is not taken.

> Without cross function checking, there is no good way to know
> the function is(or should) always called with lock held.
>
>> There are several problems here:
>> 1) the false alarms. These are unavoidable, it's equivalent to the
>>     halting problem. We can only be correct and precise in restricted
>>    situations (no loops, for example). It's not what the idea here is about.
>
> The really hard one are not avoidable. The one I am talking about.
> Which call some helper function to acquired the lock is avoidable.
> Last time I look at it, that make up a the large part of the false
> alarm.

Yes, most probably.

>> 2) what you describe here about the inlines.
>>     The underlying problems is to match the 'names/expression'
>>     given in the declarations with the ones used in(side) the definition.
>>     I've some drafts but I'm not totally sure about what exactly can be
>>    done.
>> 3) because of 2) we ignore all the names and we simply care about
>>     the sum of all contexts.
>>     So, in truth, we can only deal with a single context.
>
> There are two issues. I think having multiple context or tight the
> context into a variable is nice to have, but not that important.
> Even if we implemented that, most likely it is going to yield more
> warnings due to not able to find the name/expression properly.
> It is very unlikely that in the same function has real two context
> error cancel each other out. So having one context for now
> is more or less fine.

Well, it can more frequent that we could think of.
And anyway, it's the goal of a checker to look after error,
and the rarer they are the more the checker (which
find them!) is valuable.

> Not able to do cross function check on context is the big
> issue in context checking. If we can do cross function
> checking, then a lot of warning can be eliminated.

The problem is that the context attribute accept arbitrary
*expressions* and not a simple name/argument. But it's
normal that it accepts expressions as otherwise a lot of
the functions would need a specific argument for it
(and there is an idea behind that because for the
functions where the expression is simply one of the
arguments, we can do the propagation almost for free
in the inliner).

-- Luc
