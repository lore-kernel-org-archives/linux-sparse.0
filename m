From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 0/2] Fix illegal simplification of volatile stores
Date: Sun, 12 Nov 2017 06:19:58 +0100
Message-ID: <CAExDi1QwQFQ+dci=j5KrB6_Q65JD496J0U4w_Hv7usHwb-qj-g@mail.gmail.com>
References: <20171111162500.69476-1-luc.vanoostenryck@gmail.com>
 <CANeU7QnJgGdWtM3KkJOtWG72v_soBZfeXGkqMUmQcv-L=NM5oQ@mail.gmail.com>
 <20171111225218.m3cqbid6ug7r57jw@ltop.local> <CANeU7QnSOro=WkH_VBoGGCPonAaw-hMGJTVG_8OQPzm19zKvaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:45619 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750771AbdKLFT7 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 12 Nov 2017 00:19:59 -0500
Received: by mail-io0-f182.google.com with SMTP id i38so2907014iod.2
        for <linux-sparse@vger.kernel.org>; Sat, 11 Nov 2017 21:19:59 -0800 (PST)
In-Reply-To: <CANeU7QnSOro=WkH_VBoGGCPonAaw-hMGJTVG_8OQPzm19zKvaQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Nov 12, 2017 at 2:14 AM, Christopher Li <sparse@chrisli.org> wrote:
> On Sun, Nov 12, 2017 at 6:59 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>> On Sun, Nov 12, 2017 at 01:29:08AM +0800, Christopher Li wrote:
>>
>> If you would do that:
>> 1) it would be equivalent to rebasing one of my branches
>> 2) it make me wonder if I have misunderstood something to the way
>>    we had, some months ago, agreed to work together.
>
> Just asking. Because you start to send patches like the build
> series I don't intend to apply. I need to know it fall into the same
> category.
>
>> 3) it make me wonder why there is 67 branches in my github
>>    tree waiting for you to pull them, most having been totally
>>    ignored by you, a good number of them being 7 or 8 months old
>>    with a few even older (not talking about the dozens of other
>>    topic branches that I've never bothered to submit because they
>>    don't make sense without their parent branches).
>
> Hey, I assume you mean the llvm fix series.

The LLVM fixes series and the 66 others series.

> We have agreement that will resume the pull again after the 5.0.1.
> Which means right now.

Chris ...
v0.5.1 was out mid-August (and you made a very long and painful thing of it).
You ignored the last pull request for 7 weeks.

> That series I just send out one important
> feed back about the OP_PUSH. I thought I have send that one out
> but I just find out it haven't. That is my bad.

Is that serious?
Given how you have been so good the last 2-3 years at ignoring
patches & series, must I, once more, trust you and believe this?

-- Luc
