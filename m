From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] V2 move kill_unreachable_bbs to outer cse stage Was Re:
 [PATCH 1/5] do not corrupt ptrlist while killing unreachable BBs
Date: Mon, 10 Jul 2017 06:21:22 -0700
Message-ID: <CANeU7QnoP5g2kww5Up1gW7ucWB2H7xuGdzQ-0bTei4cWxjAz=w@mail.gmail.com>
References: <CANeU7QkCcx1d29megDn9bQ0g7rw04=ujsWCe_bN1Kc1NW_-NZw@mail.gmail.com>
 <20170709165157.w6jnjkwca7dwxj64@ltop.local> <CANeU7Qms0KKSWU0dyHomz1iEczdiYn_7SwsJZmPCSXDhsag0Tw@mail.gmail.com>
 <20170710070520.fzr3wqgaugkfocfo@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33059 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753839AbdGJNVX (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 10 Jul 2017 09:21:23 -0400
Received: by mail-pf0-f176.google.com with SMTP id e7so49991578pfk.0
        for <linux-sparse@vger.kernel.org>; Mon, 10 Jul 2017 06:21:23 -0700 (PDT)
In-Reply-To: <20170710070520.fzr3wqgaugkfocfo@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Jul 10, 2017 at 12:05 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>> > It would also be nice to know why the patch that came with the bug
>> > report have been discarded without a single comment.
>>
>> Sorry I haven't been more specific. I think the original patch is a bit
>> too complicated. Also just as I suspected, there is more than the bb
>> list get affected. If possible, I think we should try to avoid get into nested
>> loop delete in the first place rather than make the nested loop delete
>> work.
>
> I can hardly qualify my patch as 'complicated' but well ...
> This patch have been done with two goals in mind:
> 1) solve the problem with the deleted BB
> 2) do not change anything at the simplification since interaction
>    between differents parts there can have bad effects (it's to fix
>    a problem there that the kill_unreachable_bbs() had been added).
>
> Your patch, take care of point 1) but not 2) and effectively
> change when the BBs are removed and this change the interaction
> between insert_branch() and some others parts.

You are right. I will never consider 2) as my goal. Simply because
if the compiler has to depend on certain order of optimization (delete
dead BB vs memops, CSE) and it can't figure out the order by itself.
Then I consider a bug in the compiler.

> I have given a run of some of my tests I run here and there
> is indeed some changes.
> Most of these changes are obviously correct.
> Some are not obvious at all and would need to be investigated.
> Some look scary (and of course would need to be investigated too).

Great to have you looking at those. That is why I want to get your
insight on this.

> In short, I can't guarantee that the "crazy programmer" problem
> won't come back or that a similar one haven't been created.

Nobody can.That "crazy programmer" fix is not even a complete fix.
We will need to work on it any way.

> Sure, but this have nothing to do with the choice of patches here
> since your pacth also just tak ecare of the deleted BBs from the
> inner kill_unreachable_bbs().

It does in my thinking process. If there is other list involved, then
we need to look for other solutions for those. That other solution
might work on the BB list as well. There for, I don't want to invest
too much into this temporary change, especially the API change
of kill unreachable BB.

>> If possible, I think we should try to avoid get into nested
>> loop delete in the first place rather than make the nested loop delete
>> work.
>
> This seems an obvious and easy way to avoid problems but this won't
> something that will be sustainable. It would put a huge constraint
> on what can be done and what can't done, which is why, of course,

I would not rule out that possibility so quickly without consider it.
For example,
we can design the optimization process using work queue to defer certain
things do be done outside of the loop. There are many different things we
can do to solve the problem.

If nested loop deleted can be avoided, that is likely cheaper and less
complicate.

> I earlier suggested to instead change the way elements are 'deleted'
> (like instructions are already never removed from their list but
> just marked as deleted).

That looks simple but it has hidden complications as well. The issue is that
we need to find out which list need this kind of special treatment. Who is
the outer loop. If the same function can be both call as the outer
loop and inner
loop then it is complicate to decide when it should do the finalize.
There is also
the price to pay for walking the list twice which does not exist if nested loop
can be avoided.

Chris
