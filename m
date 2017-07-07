From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: [PATCH 1/5] do not corrupt ptrlist while killing unreachable BBs
Date: Fri, 7 Jul 2017 10:26:38 +0100
Message-ID: <CACXZuxeN2E5TCvof+7N0iFwZpULePf3E7V=0-+kUTrNURV2tvw@mail.gmail.com>
References: <20170706191950.81268-1-luc.vanoostenryck@gmail.com>
 <20170706191950.81268-2-luc.vanoostenryck@gmail.com> <CANeU7QnbwqVcZdbarrj4OdpR9-TaG9=t5Q_CDFZXSuB+SN8zLw@mail.gmail.com>
 <CANeU7QnVNE38ODJ+cgUzD3Vz4XKogk-RL2v6-dS2aX9Oc4_0uQ@mail.gmail.com>
 <20170707054459.pkhqnmrz7yt3sppc@ltop.local> <CANeU7Q=6MZSn2Lm_+xhqrR1mU95Fq-j6oox8jEYqW+zW=UYTEA@mail.gmail.com>
 <CACXZuxfoPyT65p46wZBN8=FMEgTwCeh3Y2P3Rc5KbYO39OK_xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f181.google.com ([209.85.128.181]:36173 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750903AbdGGJ0k (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 7 Jul 2017 05:26:40 -0400
Received: by mail-wr0-f181.google.com with SMTP id c11so38388996wrc.3
        for <linux-sparse@vger.kernel.org>; Fri, 07 Jul 2017 02:26:39 -0700 (PDT)
In-Reply-To: <CACXZuxfoPyT65p46wZBN8=FMEgTwCeh3Y2P3Rc5KbYO39OK_xg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

Apologies for the typo - correction below.

On 7 July 2017 at 10:19, Dibyendu Majumdar <mobile@majumdar.org.uk> wrote:
> Hi,
>
> On 7 July 2017 at 07:02, Christopher Li <sparse@chrisli.org> wrote:
>> On Thu, Jul 6, 2017 at 10:44 PM, Luc Van Oostenryck
>> <luc.vanoostenryck@gmail.com> wrote:
>>> The ptrlist is already fragile and now it would contains
>>> yet another field that need to be taken care of *and* stay
>>> coherent with other users. I doubt this will help to reduce bugs.
>>>
>> The reason ptrlist is fragile
>> is we did not do it properly. Not safe against recursive ptr
>> loop with inner loop delete stuff from the same list.
>>
>

In general though - while a list is being traversed, deleting items
should be expected to work, as long as a ptrlist node is not deleted.
The reason is that an iterator is presumably on a particular node -
and if unknown to if the node it is on is deleted, then the iterator
has no way to
continue. So maybe calling pack in the middle of an operation is
causing the problem?

I think the current implementation (and my version too) is safe as
long as nodes are not deleted while a traversal is going on?

Thanks and Regards
Dibyendu
