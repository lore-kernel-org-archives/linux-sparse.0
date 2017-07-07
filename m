From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 1/5] do not corrupt ptrlist while killing unreachable BBs
Date: Fri, 7 Jul 2017 10:28:03 +0200
Message-ID: <20170707082802.gphim2wpqsncqoyh@ltop.local>
References: <20170706191950.81268-1-luc.vanoostenryck@gmail.com>
 <20170706191950.81268-2-luc.vanoostenryck@gmail.com>
 <CANeU7QnbwqVcZdbarrj4OdpR9-TaG9=t5Q_CDFZXSuB+SN8zLw@mail.gmail.com>
 <CANeU7QnVNE38ODJ+cgUzD3Vz4XKogk-RL2v6-dS2aX9Oc4_0uQ@mail.gmail.com>
 <CA+55aFyUN-anJrFmo25tATO2wJS8+24S8TK=PAZBEYr0LvZN8g@mail.gmail.com>
 <CANeU7Q=XzVrNoUOScCJjtautBsc0ittc_Okh+0wESuV4rRqing@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f171.google.com ([209.85.128.171]:36828 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750848AbdGGI2G (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 7 Jul 2017 04:28:06 -0400
Received: by mail-wr0-f171.google.com with SMTP id c11so36316454wrc.3
        for <linux-sparse@vger.kernel.org>; Fri, 07 Jul 2017 01:28:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7Q=XzVrNoUOScCJjtautBsc0ittc_Okh+0wESuV4rRqing@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Jul 06, 2017 at 10:15:02PM -0700, Christopher Li wrote:
> On Thu, Jul 6, 2017 at 6:35 PM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> > Gaah.
> >
> > I think the original idea for this was to call pack_ptr_list() only at
> > the end of all the list traversal that could delete things.
> >
> 
> That is a very good suggestion. The problem would be to find out who
> is the last one using that list. Also walking the list to find out the empty
> ptr is extra overhead.
> 
> I have an idea. We can actually reference count the ptr_list usage like the
> above patch. We need to because we want to know who is the lats one using
> that ptrlist bucket. The last one using the ptr_list bucket (not the whole list)
> can pack this bucket. It will avoid walking the list more than once just to do
> the packing. I will try this idea soon. It might work.

This reference count is a property of the whole list and would thus
need to be stored in the head of the list, which doesn't really exist.

Also, I'm not convinced that the problem can only caused by the list
packing in the inner loop (looking at the code for the FOR_EACH, it
looks as it should be OK, but if you enter in the equation, reverse
walking and/or list splitting, I have doubts).

Another point to take in account is that the list packing was needed
because the list walking didn't like empty blocks. But months ago,
because of another bugs we made all the list walking robust against
empty blocks, so list packing shouldn't be needed anymore for
correctness. So we could in general avoid any list packing,
and only do it at some specific safe points just to save memory &
CPU time when walking lists with several blocks but few elements
(and we need to keep in mind that most lists are very very short).

I'm more and more inclined to:
1) in general, avoid altogether deletion from lists in favor
   marking elements as being deleted, either like we do for
   instructions (setting insn->bb to NULL) or storing a special
   value in the ptrlist.
2) at some specific points, as an optimization, doing a sort of
   GC of the list: removing elements marked as deleted and/or
   doing the list packing.
That sound to me as simple, generic and robust.

-- Luc
