From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 1/5] do not corrupt ptrlist while killing unreachable BBs
Date: Fri, 7 Jul 2017 11:52:27 +0200
Message-ID: <20170707095225.piowt2kwy6mfd7pi@ltop.local>
References: <20170706191950.81268-1-luc.vanoostenryck@gmail.com>
 <20170706191950.81268-2-luc.vanoostenryck@gmail.com>
 <CANeU7QnbwqVcZdbarrj4OdpR9-TaG9=t5Q_CDFZXSuB+SN8zLw@mail.gmail.com>
 <CANeU7QnVNE38ODJ+cgUzD3Vz4XKogk-RL2v6-dS2aX9Oc4_0uQ@mail.gmail.com>
 <CA+55aFyUN-anJrFmo25tATO2wJS8+24S8TK=PAZBEYr0LvZN8g@mail.gmail.com>
 <CANeU7Q=XzVrNoUOScCJjtautBsc0ittc_Okh+0wESuV4rRqing@mail.gmail.com>
 <20170707082802.gphim2wpqsncqoyh@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f177.google.com ([209.85.128.177]:35375 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751862AbdGGJwb (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 7 Jul 2017 05:52:31 -0400
Received: by mail-wr0-f177.google.com with SMTP id k67so39212824wrc.2
        for <linux-sparse@vger.kernel.org>; Fri, 07 Jul 2017 02:52:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170707082802.gphim2wpqsncqoyh@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Jul 07, 2017 at 10:28:03AM +0200, Luc Van Oostenryck wrote:
> Another point to take in account is that the list packing was needed
> because the list walking didn't like empty blocks. But months ago,
> because of another bugs we made all the list walking robust against
> empty blocks, so list packing shouldn't be needed anymore for
> correctness. So we could in general avoid any list packing,
> and only do it at some specific safe points just to save memory &
> CPU time when walking lists with several blocks but few elements
> (and we need to keep in mind that most lists are very very short).
> 
> I'm more and more inclined to:
> 1) in general, avoid altogether deletion from lists in favor
>    marking elements as being deleted, either like we do for
>    instructions (setting insn->bb to NULL) or storing a special
>    value in the ptrlist.
> 2) at some specific points, as an optimization, doing a sort of
>    GC of the list: removing elements marked as deleted and/or
>    doing the list packing.
> That sound to me as simple, generic and robust.

Another thing that could help is that, in fact, for most lists/
list types we can't have nested list walking.

In practice, BB & insn lists will be the ones really concerned
and insns are immune to the problem since they are never deleted
but simply marked as deleted.

And this is only because the cleanup code is all done inside the
ep->bbs & bb->insns loops. So at the end, I wouldn't be surprised
that only the BBs are impacted, which is coherent to what the
testing showed.

But yes, we need to have guarantees.

-- Luc
