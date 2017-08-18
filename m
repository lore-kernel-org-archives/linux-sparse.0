From: Christopher Li <sparse@chrisli.org>
Subject: Re: idea/question about sparse's context checking
Date: Fri, 18 Aug 2017 15:59:50 -0400
Message-ID: <CANeU7Qk47B03ut_sWSVeCzx+VaCoQWfaO18ksXDmxwjbdsmFqA@mail.gmail.com>
References: <20170818132039.hii2siz5sjaua5qr@ltop.local> <CANeU7QkfuSuZkaEAjpAYtGGs=DEHBZRw6rojFLywsvvKaH2WtA@mail.gmail.com>
 <CAExDi1Rp5=kqy_nR6rvuM5U-u5Noh-zQsLghM1cHRDtS02P8bA@mail.gmail.com>
 <CANeU7QkY2=KrJTZaLJRu1KVc38Vmpggzmxf_AxawdseoZacCEQ@mail.gmail.com> <CAMHZB6HPD7mt=WVMr6ri7jxyohp-FkcvjR+XK9_sY-5zB4gQUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f178.google.com ([209.85.161.178]:35072 "EHLO
        mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751687AbdHRT7v (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 18 Aug 2017 15:59:51 -0400
Received: by mail-yw0-f178.google.com with SMTP id n83so37143715ywn.2
        for <linux-sparse@vger.kernel.org>; Fri, 18 Aug 2017 12:59:50 -0700 (PDT)
In-Reply-To: <CAMHZB6HPD7mt=WVMr6ri7jxyohp-FkcvjR+XK9_sY-5zB4gQUg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Josh Triplett <josh@joshtriplett.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Aug 18, 2017 at 3:01 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:

> No, it will just be a pseudo, like any other pseudos so we
> could have as much as we want. We'll just need to deal
> with them during simplification phase.

I see. You use a special pseudo to store the context. Every
context change will corresponding that pesudo add/decrease.
That is a good idea.

>> Not sure that is worthy while to warn. It can happen in the function
>> assume the lock is taken when enter the function.
>> The unlock it, do some thing , relock it.
>> There is total legit reason to do it.
>
> No, it's an error to (try to) unlock a lock that is not taken.

Right. But the function itself can't see the caller always call
this function with lock already holed. If the caller call without
holding the lock that will be a bug.

>> There are two issues. I think having multiple context or tight the
>> context into a variable is nice to have, but not that important.
>> Even if we implemented that, most likely it is going to yield more
>> warnings due to not able to find the name/expression properly.
>> It is very unlikely that in the same function has real two context
>> error cancel each other out. So having one context for now
>> is more or less fine.
>
> Well, it can more frequent that we could think of.
> And anyway, it's the goal of a checker to look after error,
> and the rarer they are the more the checker (which
> find them!) is valuable.

That is true. We have have some prototypes and see
how much new warnings it introduce. I am curious how much
of the report is real bug vs false psitives.

> The problem is that the context attribute accept arbitrary
> *expressions* and not a simple name/argument. But it's
> normal that it accepts expressions as otherwise a lot of
> the functions would need a specific argument for it
> (and there is an idea behind that because for the
> functions where the expression is simply one of the
> arguments, we can do the propagation almost for free
> in the inliner).

When you inline it, it is not cross function any more.
That is one way to solve it.

Chris
