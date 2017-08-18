From: Christopher Li <sparse@chrisli.org>
Subject: Re: idea/question about sparse's context checking
Date: Fri, 18 Aug 2017 14:18:51 -0400
Message-ID: <CANeU7QkY2=KrJTZaLJRu1KVc38Vmpggzmxf_AxawdseoZacCEQ@mail.gmail.com>
References: <20170818132039.hii2siz5sjaua5qr@ltop.local> <CANeU7QkfuSuZkaEAjpAYtGGs=DEHBZRw6rojFLywsvvKaH2WtA@mail.gmail.com>
 <CAExDi1Rp5=kqy_nR6rvuM5U-u5Noh-zQsLghM1cHRDtS02P8bA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f181.google.com ([209.85.161.181]:33129 "EHLO
        mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751204AbdHRSSw (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 18 Aug 2017 14:18:52 -0400
Received: by mail-yw0-f181.google.com with SMTP id p68so63566656ywg.0
        for <linux-sparse@vger.kernel.org>; Fri, 18 Aug 2017 11:18:52 -0700 (PDT)
In-Reply-To: <CAExDi1Rp5=kqy_nR6rvuM5U-u5Noh-zQsLghM1cHRDtS02P8bA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Josh Triplett <josh@joshtriplett.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Aug 18, 2017 at 12:15 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>>> let the normal simplification process act on them?
>>> If the context is (proveably) well balanced, there
>>> shouldn't be any phi-node left for this context.
>>
>> Assume you do the context pseudo attach to the lock
>> variable. Then you will have to do the pointer alias properly.
>> People might have different pointer point to that variable.
>
> No no, it's not the point here.
> What I meant in the idea is that currently OP_CONTEXT
> and its associated attribute work with a unique implicit
> 'object', called 'context' but not explicitly associated to
> a symbol/variable and thus they need their own specific
> machinery.

Ah, I did not get your idea at the first read. So you mean
do not use bb->context to store the context. There will
be still one context per BB. Store the context into pseudo
and some how that pseudo in link into the BB.

I was thinking weather you are going to create more than one
context per BB, attach the context to the locking objects.
That is not what you are trying to do.

If my understanding of you just try to move bb->context
into pseudos. In principle that is fine. It is also depend on
a lot of implementation details as well. Do you still need to
lookup the context per basic block?

>> It can become negative for some helper function that
>> wrap around the unclock function.
>
> This need to be checked (and currently there is a small gap
> where it can go negative and positive again and not warned
> about it.

Not sure that is worthy while to warn. It can happen in the function
assume the lock is taken when enter the function.
The unlock it, do some thing , relock it.
There is total legit reason to do it.

Without cross function checking, there is no good way to know
the function is(or should) always called with lock held.

> There are several problems here:
> 1) the false alarms. These are unavoidable, it's equivalent to the
>     halting problem. We can only be correct and precise in restricted
>    situations (no loops, for example). It's not what the idea here is about.

The really hard one are not avoidable. The one I am talking about.
Which call some helper function to acquired the lock is avoidable.
Last time I look at it, that make up a the large part of the false
alarm.

> 2) what you describe here about the inlines.
>     The underlying problems is to match the 'names/expression'
>     given in the declarations with the ones used in(side) the definition.
>     I've some drafts but I'm not totally sure about what exactly can be
>    done.
> 3) because of 2) we ignore all the names and we simply care about
>     the sum of all contexts.
>     So, in truth, we can only deal with a single context.

There are two issues. I think having multiple context or tight the
context into a variable is nice to have, but not that important.
Even if we implemented that, most likely it is going to yield more
warnings due to not able to find the name/expression properly.
It is very unlikely that in the same function has real two context
error cancel each other out. So having one context for now
is more or less fine.

Not able to do cross function check on context is the big
issue in context checking. If we can do cross function
checking, then a lot of warning can be eliminated.

You can also take a look at the metalevel compiling papers.
The company coverity was started out doing metalevel compiling
checks. Coverity report a lot of bugs in Linux kernel back in the days.

Chris
