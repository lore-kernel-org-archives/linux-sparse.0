From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] V2 move kill_unreachable_bbs to outer cse stage Was Re:
 [PATCH 1/5] do not corrupt ptrlist while killing unreachable BBs
Date: Sun, 9 Jul 2017 18:52:00 +0200
Message-ID: <20170709165157.w6jnjkwca7dwxj64@ltop.local>
References: <CANeU7QkCcx1d29megDn9bQ0g7rw04=ujsWCe_bN1Kc1NW_-NZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33655 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752146AbdGIQwF (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 9 Jul 2017 12:52:05 -0400
Received: by mail-wr0-f195.google.com with SMTP id x23so19679248wrb.0
        for <linux-sparse@vger.kernel.org>; Sun, 09 Jul 2017 09:52:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7QkCcx1d29megDn9bQ0g7rw04=ujsWCe_bN1Kc1NW_-NZw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Jul 09, 2017 at 09:07:06AM -0700, Christopher Li wrote:
> On Sun, Jul 9, 2017 at 3:26 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >>
> >> - repeat_phase &= ~REPEAT_CFG_CLEANUP;
> >> + repeat_phase |=  REPEAT_CSE ;
> >
> > It would be good to add a comment for why the '|= REPEAT_CSE' is needed here.
> >
> 
> You are right.
> 
> Actually I just find out that is not needed. I was having impression that I
> need that to pass one of the test-suit. It seems fine without.

It could have made a difference in the test suite because killing
unreachable code can create new simplification opportunities.

> It pass the
> full kernel check as well.

What do you mean exactly by 'pass full kernel check'? That you get
exactly the same warnings with & without the patch?

> From 484a3a27d95b4bf3be9ac4b9bcf1aca1abe3ac19 Mon Sep 17 00:00:00 2001
> From: Christopher Li <sparse@chrisli.org>
> Date: Sat, 8 Jul 2017 19:34:49 -0700
> Subject: [PATCH] move kill_unreachable_bbs to outer cse stage
> 
> The current way of kill_unreach_bbs in insert_branch()
> cause delete entry in ptrlist that the upper level
> caller is looping on.

I know what you're talking about but otherwise, I really can't parse
this sentence.
 
Anyway, I think that this bug merit a much better commit message.
 
It would also be nice to know why the patch that came with the bug
report have been discarded without a single comment.

-- Luc
