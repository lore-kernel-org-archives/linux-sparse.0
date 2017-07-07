From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 1/5] do not corrupt ptrlist while killing unreachable BBs
Date: Thu, 6 Jul 2017 23:02:24 -0700
Message-ID: <CANeU7Q=6MZSn2Lm_+xhqrR1mU95Fq-j6oox8jEYqW+zW=UYTEA@mail.gmail.com>
References: <20170706191950.81268-1-luc.vanoostenryck@gmail.com>
 <20170706191950.81268-2-luc.vanoostenryck@gmail.com> <CANeU7QnbwqVcZdbarrj4OdpR9-TaG9=t5Q_CDFZXSuB+SN8zLw@mail.gmail.com>
 <CANeU7QnVNE38ODJ+cgUzD3Vz4XKogk-RL2v6-dS2aX9Oc4_0uQ@mail.gmail.com> <20170707054459.pkhqnmrz7yt3sppc@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f54.google.com ([74.125.83.54]:33428 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752658AbdGGGCb (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 7 Jul 2017 02:02:31 -0400
Received: by mail-pg0-f54.google.com with SMTP id k14so12134863pgr.0
        for <linux-sparse@vger.kernel.org>; Thu, 06 Jul 2017 23:02:25 -0700 (PDT)
In-Reply-To: <20170707054459.pkhqnmrz7yt3sppc@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Jul 6, 2017 at 10:44 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> Mmmm ...
>
> I really don't like this kind of solution.
> The ptrlist is already fragile and now it would contains
> yet another field that need to be taken care of *and* stay
> coherent with other users. I doubt this will help to reduce bugs.

You totally miss the point. This patch is not a final solution.
I am not suggesting submit this patch as it is.

It is mean to expose existing bugs. The reason ptrlist is fragile
is we did not do it properly. Not safe against recursive ptr
loop with inner loop delete stuff from the same list.

> Also, I don't think the principle of this solution is sound.
> In particular, these die() make me nervous.
> Can you explain a bit how it is working, how you can guarantee
> that these die() won't be called?

It wouldn't, every die() means a bug get discovered. We need to fix that.

Go try this patch with a "make check". It has over one hundreds fails.
Those are real bugs. The current big offender is remove_usage() inside
of the  kill_use_list(). It might relate to your code as well. Can you help me
take a look at the offender?

Chris
