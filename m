From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 1/5] do not corrupt ptrlist while killing unreachable BBs
Date: Thu, 6 Jul 2017 23:07:10 -0700
Message-ID: <CANeU7Q=G0_60JYPUFi6+9VSM4cSKVh6xd45pEj_RduVQH4SSDQ@mail.gmail.com>
References: <20170706191950.81268-1-luc.vanoostenryck@gmail.com>
 <20170706191950.81268-2-luc.vanoostenryck@gmail.com> <CANeU7QnbwqVcZdbarrj4OdpR9-TaG9=t5Q_CDFZXSuB+SN8zLw@mail.gmail.com>
 <CANeU7QnVNE38ODJ+cgUzD3Vz4XKogk-RL2v6-dS2aX9Oc4_0uQ@mail.gmail.com> <CA+55aFyUN-anJrFmo25tATO2wJS8+24S8TK=PAZBEYr0LvZN8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f53.google.com ([74.125.83.53]:35533 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750950AbdGGGHM (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 7 Jul 2017 02:07:12 -0400
Received: by mail-pg0-f53.google.com with SMTP id j186so12116516pge.2
        for <linux-sparse@vger.kernel.org>; Thu, 06 Jul 2017 23:07:12 -0700 (PDT)
In-Reply-To: <CA+55aFyUN-anJrFmo25tATO2wJS8+24S8TK=PAZBEYr0LvZN8g@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Jul 6, 2017 at 6:35 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>>
>> Basiclly, the parent DO_FOR_EACH() has __nr caching the
>> current ptr position. When the inner loop function delete
>> one entry before the current position. The parent current
>> position needs to be adjust, because the entry[] has been
>> move forward.
>
> Gaah.
>
> I think the original idea for this was to call pack_ptr_list() only at
> the end of all the list traversal that could delete things.

Actually,  the point I am making is different than pack_ptr_list().
I just take a closer look. Pack_ptr_list() only remove empty ptr nodes.
It does not take care my realization that entry[] array sliding forward
causing the parent for loop *missing* ptr entry. Basically the parent
for loop will skip some ptr entry. It is s very subtle and hard to discover.

Chris
