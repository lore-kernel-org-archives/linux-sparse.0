From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 1/5] do not corrupt ptrlist while killing unreachable BBs
Date: Fri, 7 Jul 2017 02:06:14 -0700
Message-ID: <CANeU7Qk3s90N35co_HOT0vfHhZDjthMv5=5dT9Hy72JQFfc=ng@mail.gmail.com>
References: <20170706191950.81268-1-luc.vanoostenryck@gmail.com>
 <20170706191950.81268-2-luc.vanoostenryck@gmail.com> <CANeU7QnbwqVcZdbarrj4OdpR9-TaG9=t5Q_CDFZXSuB+SN8zLw@mail.gmail.com>
 <CANeU7QnVNE38ODJ+cgUzD3Vz4XKogk-RL2v6-dS2aX9Oc4_0uQ@mail.gmail.com>
 <CA+55aFyUN-anJrFmo25tATO2wJS8+24S8TK=PAZBEYr0LvZN8g@mail.gmail.com>
 <CANeU7Q=XzVrNoUOScCJjtautBsc0ittc_Okh+0wESuV4rRqing@mail.gmail.com> <20170707082802.gphim2wpqsncqoyh@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:36081 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751782AbdGGJGQ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 7 Jul 2017 05:06:16 -0400
Received: by mail-pf0-f173.google.com with SMTP id q86so14252779pfl.3
        for <linux-sparse@vger.kernel.org>; Fri, 07 Jul 2017 02:06:16 -0700 (PDT)
In-Reply-To: <20170707082802.gphim2wpqsncqoyh@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Jul 7, 2017 at 1:28 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> This reference count is a property of the whole list and would thus
> need to be stored in the head of the list, which doesn't really exist.

Obviously I am too tired to think straight right now. But I  think my
idea of reference counting on the list node, not the while list might
actually work.  Because, if the inner loop delete an entry of a different
node than the outer loop was currently holding on, it is actually fine.
Why? Because by the time the outer loop advance to the that the
deleted node, it will reload the list->nr from memory.
I can be wrong through. I should be able to find out soon enough.

> Also, I'm not convinced that the problem can only caused by the list
> packing in the inner loop (looking at the code for the FOR_EACH, it
> looks as it should be OK, but if you enter in the equation, reverse
> walking and/or list splitting, I have doubts).

Like I said, if you delete entry while the outer loop holding the
same ptr node, it is a bug even without packing the list in inner
loop.

I think ref counting the node should be fine with reversing. List
spiting I have to. Will find out.

>
> Another point to take in account is that the list packing was needed
> because the list walking didn't like empty blocks. But months ago,
> because of another bugs we made all the list walking robust against
> empty blocks, so list packing shouldn't be needed anymore for
> correctness. So we could in general avoid any list packing,
> and only do it at some specific safe points just to save memory &
> CPU time when walking lists with several blocks but few elements
> (and we need to keep in mind that most lists are very very short).

I still think if ref counting node properly, it will solve the bug I describe
and possible the list packing as well. If nobody else is holding that
node, it should be fine to pack and delete it. It is not thread safe but
that is a different issue.

>
> I'm more and more inclined to:
> 1) in general, avoid altogether deletion from lists in favor
>    marking elements as being deleted, either like we do for
>    instructions (setting insn->bb to NULL) or storing a special
>    value in the ptrlist.

My idea of the ref count will do exactly that when the inner
loop try to delete an entry but outer loop holding the node as well.
It will increase the deleted count and replace the ptr entry to
NULL.

When the ref count of the node drop to zero and node has delete count.
Pack the entry[] array, remove NULL entry and even possible delete
the node as well.

Let me know if you see any problem with that approach.

> 2) at some specific points, as an optimization, doing a sort of
>    GC of the list: removing elements marked as deleted and/or
>    doing the list packing.

If the ref count node works, then just pack the node when
ref count drop to zero (or one with some care).

One idea is that we can use sparse to check itself
if there is any sparse code return in a loop without dec the ref count.

> That sound to me as simple, generic and robust.

Yes. So our idea is actually very similar. The only difference
is I use ref count as means of GC, so the ptrlist always knows
when it is safe to delete stuff.

I will find out more.

Chris
