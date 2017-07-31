From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v3 1/7] fix ptrlist corruption while killing unreachable BBs
Date: Tue, 1 Aug 2017 00:10:22 +0200
Message-ID: <CAExDi1SET3QbLdkGU8REGTBoZzarsXjE48AyDLzfmq-2ONYQng@mail.gmail.com>
References: <20170731203624.58971-1-luc.vanoostenryck@gmail.com>
 <20170731203624.58971-2-luc.vanoostenryck@gmail.com> <CANeU7QmGhg0T0ZkGthDoER3QxbV696OZLJ602dc9Tnv0bojFgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qt0-f175.google.com ([209.85.216.175]:35724 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751623AbdGaWKX (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 31 Jul 2017 18:10:23 -0400
Received: by mail-qt0-f175.google.com with SMTP id p3so114339573qtg.2
        for <linux-sparse@vger.kernel.org>; Mon, 31 Jul 2017 15:10:23 -0700 (PDT)
In-Reply-To: <CANeU7QmGhg0T0ZkGthDoER3QxbV696OZLJ602dc9Tnv0bojFgA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Michael Stefaniuc <mstefani@mykolab.com>

On Mon, Jul 31, 2017 at 11:41 PM, Christopher Li <sparse@chrisli.org> wrote:
> On Mon, Jul 31, 2017 at 4:36 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>>
>> Fix this by:
>> 1) refuse to emit the "crazy programmer" warning if there
>>    is a potential dead BB
>> 2) move kill_unreachable_bbs() in the main cleanup loop
>>    which will avoid nested ep->bbs loop.
>
> Great!

> Interesting.  So my reading is that, this is similar to the other
> alternative patch
> we discuss with different that:
> 1. move up kill_unreachable_bbs(ep) right after clean_up_insns(ep)
> 2. Avoid issue "crazy programmer" if we still have dead code to clean up.
>
> That sound very reasonable and I feel that is better than the previous version
> which eager to kill bbs. That is great.

Yes.
I just hope there isn't some other condition to would force again to
have to do the kill_unreachable_bbs() sooner.

> I really appreciate the change.

I thought you would.
The second difference is fundamental for correctness.
For the first, difference, I placed it between cleanup & CSE
because cleanup can create opportunities for dead BBs while
CSE doesn't and it's useless to do CSE on dead BBs.
So, it would be a small perf improvement.

Having some kill_unreachable_bbs() in the main loop was also
needed for the infinite loop problem (this in itself already stopped
the infinite loop with the wine code but the generated code was
very very wrong thus the need for the bb_depends_on() patch
which I think now fixes the root cause there).

I'll launch some stress testing tomorrow.

-- Luc
