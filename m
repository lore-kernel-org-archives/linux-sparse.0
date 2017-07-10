From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] V2 move kill_unreachable_bbs to outer cse stage Was Re:
 [PATCH 1/5] do not corrupt ptrlist while killing unreachable BBs
Date: Mon, 10 Jul 2017 09:05:22 +0200
Message-ID: <20170710070520.fzr3wqgaugkfocfo@ltop.local>
References: <CANeU7QkCcx1d29megDn9bQ0g7rw04=ujsWCe_bN1Kc1NW_-NZw@mail.gmail.com>
 <20170709165157.w6jnjkwca7dwxj64@ltop.local>
 <CANeU7Qms0KKSWU0dyHomz1iEczdiYn_7SwsJZmPCSXDhsag0Tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f180.google.com ([209.85.128.180]:36479 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751124AbdGJHF0 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 10 Jul 2017 03:05:26 -0400
Received: by mail-wr0-f180.google.com with SMTP id c11so125321987wrc.3
        for <linux-sparse@vger.kernel.org>; Mon, 10 Jul 2017 00:05:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7Qms0KKSWU0dyHomz1iEczdiYn_7SwsJZmPCSXDhsag0Tw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Jul 09, 2017 at 05:19:27PM -0700, Christopher Li wrote:
> On Sun, Jul 9, 2017 at 9:52 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >
> > It could have made a difference in the test suite because killing
> > unreachable code can create new simplification opportunities.
> 
> Yes. As far as I can tell, when the kill instruction get invoked, it should
> have cause the REPEAT_CSE. "Kill unreachable bb" shouldn't need
> to set CSE flag.
> 
> > What do you mean exactly by 'pass full kernel check'? That you get
> > exactly the same warnings with & without the patch?
> 
> Yes, that is what I usually do to give sparse some workload other
> than the test-suite.

OK. 

> > It would also be nice to know why the patch that came with the bug
> > report have been discarded without a single comment.
> 
> Sorry I haven't been more specific. I think the original patch is a bit
> too complicated. Also just as I suspected, there is more than the bb
> list get affected. If possible, I think we should try to avoid get into nested
> loop delete in the first place rather than make the nested loop delete
> work.

I can hardly qualify my patch as 'complicated' but well ...
This patch have been done with two goals in mind:
1) solve the problem with the deleted BB 
2) do not change anything at the simplification since interaction
   between differents parts there can have bad effects (it's to fix
   a problem there that the kill_unreachable_bbs() had been added).

Your patch, take care of point 1) but not 2) and effectively
change when the BBs are removed and this change the interaction
between insert_branch() and some others parts.

I have given a run of some of my tests I run here and there
is indeed some changes.
Most of these changes are obviously correct.
Some are not obvious at all and would need to be investigated.
Some look scary (and of course would need to be investigated too).

In short, I can't guarantee that the "crazy programmer" problem
won't come back or that a similar one haven't been created.

> Also just as I suspected, there is more than the bb
> list get affected.

Sure, but this have nothing to do with the choice of patches here
since your pacth also just tak ecare of the deleted BBs from the
inner kill_unreachable_bbs().

> If possible, I think we should try to avoid get into nested
> loop delete in the first place rather than make the nested loop delete
> work.

This seems an obvious and easy way to avoid problems but this won't
something that will be sustainable. It would put a huge constraint
on what can be done and what can't done, which is why, of course,
I earlier suggested to instead change the way elements are 'deleted'
(like instructions are already never removed from their list but
just marked as deleted).


-- Luc
