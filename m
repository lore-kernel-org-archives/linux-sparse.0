From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 1/5] do not corrupt ptrlist while killing unreachable BBs
Date: Fri, 7 Jul 2017 15:25:45 +0200
Message-ID: <CAExDi1TRKuokxpUH3BNC5rQ8TFfpHH=Xoj-M3DU1TfVMopKFeA@mail.gmail.com>
References: <20170706191950.81268-1-luc.vanoostenryck@gmail.com>
 <20170706191950.81268-2-luc.vanoostenryck@gmail.com> <CANeU7QnbwqVcZdbarrj4OdpR9-TaG9=t5Q_CDFZXSuB+SN8zLw@mail.gmail.com>
 <CANeU7QnVNE38ODJ+cgUzD3Vz4XKogk-RL2v6-dS2aX9Oc4_0uQ@mail.gmail.com>
 <CA+55aFyUN-anJrFmo25tATO2wJS8+24S8TK=PAZBEYr0LvZN8g@mail.gmail.com>
 <CANeU7Q=XzVrNoUOScCJjtautBsc0ittc_Okh+0wESuV4rRqing@mail.gmail.com>
 <20170707082802.gphim2wpqsncqoyh@ltop.local> <CANeU7Qk3s90N35co_HOT0vfHhZDjthMv5=5dT9Hy72JQFfc=ng@mail.gmail.com>
 <CACXZuxf5JSfECtZni5OLmh3_iTarC39nu9-DqRNsivTT6iHb7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qk0-f171.google.com ([209.85.220.171]:34132 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750904AbdGGNZr (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 7 Jul 2017 09:25:47 -0400
Received: by mail-qk0-f171.google.com with SMTP id d78so26991902qkb.1
        for <linux-sparse@vger.kernel.org>; Fri, 07 Jul 2017 06:25:46 -0700 (PDT)
In-Reply-To: <CACXZuxf5JSfECtZni5OLmh3_iTarC39nu9-DqRNsivTT6iHb7g@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Christopher Li <sparse@chrisli.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Jul 7, 2017 at 3:18 PM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
> Hi Chris,
>
> On 7 July 2017 at 10:06, Christopher Li <sparse@chrisli.org> wrote:
>> On Fri, Jul 7, 2017 at 1:28 AM, Luc Van Oostenryck
>> <luc.vanoostenryck@gmail.com> wrote:
>>>
>> My idea of the ref count will do exactly that when the inner
>> loop try to delete an entry but outer loop holding the node as well.
>> It will increase the deleted count and replace the ptr entry to
>> NULL.
>>
>> When the ref count of the node drop to zero and node has delete count.
>> Pack the entry[] array, remove NULL entry and even possible delete
>> the node as well.
>>
>> Let me know if you see any problem with that approach.
>>
>
> How will the insertion scenario be handled - or even splits caused by
> insertion? These would also invalidate the order of the entries in a
> ptr list node, right?
>
> I think that maybe an alternative approach is to use a lock, and
> ensure that the ptr list node is locked while it is being iterated.

Don't forget that it's not multithreaded code we're talking here:
a lock, in itself, won't help since there is no concurrent access.

Otherwise, it's quite similar to Chris' idea of using a refcount.
But then, we 'just' have to correctly maintain this refcount.

-- Luc
