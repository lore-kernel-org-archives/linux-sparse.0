From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: [PATCH 1/5] do not corrupt ptrlist while killing unreachable BBs
Date: Fri, 7 Jul 2017 14:18:53 +0100
Message-ID: <CACXZuxf5JSfECtZni5OLmh3_iTarC39nu9-DqRNsivTT6iHb7g@mail.gmail.com>
References: <20170706191950.81268-1-luc.vanoostenryck@gmail.com>
 <20170706191950.81268-2-luc.vanoostenryck@gmail.com> <CANeU7QnbwqVcZdbarrj4OdpR9-TaG9=t5Q_CDFZXSuB+SN8zLw@mail.gmail.com>
 <CANeU7QnVNE38ODJ+cgUzD3Vz4XKogk-RL2v6-dS2aX9Oc4_0uQ@mail.gmail.com>
 <CA+55aFyUN-anJrFmo25tATO2wJS8+24S8TK=PAZBEYr0LvZN8g@mail.gmail.com>
 <CANeU7Q=XzVrNoUOScCJjtautBsc0ittc_Okh+0wESuV4rRqing@mail.gmail.com>
 <20170707082802.gphim2wpqsncqoyh@ltop.local> <CANeU7Qk3s90N35co_HOT0vfHhZDjthMv5=5dT9Hy72JQFfc=ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f180.google.com ([209.85.128.180]:36168 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750778AbdGGNSz (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 7 Jul 2017 09:18:55 -0400
Received: by mail-wr0-f180.google.com with SMTP id c11so46825564wrc.3
        for <linux-sparse@vger.kernel.org>; Fri, 07 Jul 2017 06:18:54 -0700 (PDT)
In-Reply-To: <CANeU7Qk3s90N35co_HOT0vfHhZDjthMv5=5dT9Hy72JQFfc=ng@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Chris,

On 7 July 2017 at 10:06, Christopher Li <sparse@chrisli.org> wrote:
> On Fri, Jul 7, 2017 at 1:28 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>>
> My idea of the ref count will do exactly that when the inner
> loop try to delete an entry but outer loop holding the node as well.
> It will increase the deleted count and replace the ptr entry to
> NULL.
>
> When the ref count of the node drop to zero and node has delete count.
> Pack the entry[] array, remove NULL entry and even possible delete
> the node as well.
>
> Let me know if you see any problem with that approach.
>

How will the insertion scenario be handled - or even splits caused by
insertion? These would also invalidate the order of the entries in a
ptr list node, right?

I think that maybe an alternative approach is to use a lock, and
ensure that the ptr list node is locked while it is being iterated.
Only lock holder can modify. Any inner loop will fail if it tries to
modify the node. The lock can be a pointer - so if NULL unlocked, else
locked. Using a pointer as lock allows concept of ownership.

But anyway this is only to catch scenarios where the list is being
changed by an inner loop.

Regards
Dibyendu
