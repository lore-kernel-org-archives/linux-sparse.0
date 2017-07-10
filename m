From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] V2 move kill_unreachable_bbs to outer cse stage Was Re:
 [PATCH 1/5] do not corrupt ptrlist while killing unreachable BBs
Date: Sun, 9 Jul 2017 17:19:27 -0700
Message-ID: <CANeU7Qms0KKSWU0dyHomz1iEczdiYn_7SwsJZmPCSXDhsag0Tw@mail.gmail.com>
References: <CANeU7QkCcx1d29megDn9bQ0g7rw04=ujsWCe_bN1Kc1NW_-NZw@mail.gmail.com>
 <20170709165157.w6jnjkwca7dwxj64@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f53.google.com ([74.125.83.53]:34993 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752749AbdGJAT2 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 9 Jul 2017 20:19:28 -0400
Received: by mail-pg0-f53.google.com with SMTP id j186so40557398pge.2
        for <linux-sparse@vger.kernel.org>; Sun, 09 Jul 2017 17:19:28 -0700 (PDT)
In-Reply-To: <20170709165157.w6jnjkwca7dwxj64@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Jul 9, 2017 at 9:52 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> It could have made a difference in the test suite because killing
> unreachable code can create new simplification opportunities.

Yes. As far as I can tell, when the kill instruction get invoked, it should
have cause the REPEAT_CSE. "Kill unreachable bb" shouldn't need
to set CSE flag.

> What do you mean exactly by 'pass full kernel check'? That you get
> exactly the same warnings with & without the patch?

Yes, that is what I usually do to give sparse some workload other
than the test-suite.


>
>> From 484a3a27d95b4bf3be9ac4b9bcf1aca1abe3ac19 Mon Sep 17 00:00:00 2001
>> From: Christopher Li <sparse@chrisli.org>
>> Date: Sat, 8 Jul 2017 19:34:49 -0700
>> Subject: [PATCH] move kill_unreachable_bbs to outer cse stage
>>
>> The current way of kill_unreach_bbs in insert_branch()
>> cause delete entry in ptrlist that the upper level
>> caller is looping on.
>
> I know what you're talking about but otherwise, I really can't parse
> this sentence.
>
> Anyway, I think that this bug merit a much better commit message.
>

Of course. Can you take my patch and merge it with your validation
test? Do what you see fit. I think it'd better commit together, and get
a better commit message.

I was overwhelming by the ptr ref counting. I need some thing in my
branch to stop die on those ep->bbs.

> It would also be nice to know why the patch that came with the bug
> report have been discarded without a single comment.

Sorry I haven't been more specific. I think the original patch is a bit
too complicated. Also just as I suspected, there is more than the bb
list get affected. If possible, I think we should try to avoid get into nested
loop delete in the first place rather than make the nested loop delete
work.

Chris
