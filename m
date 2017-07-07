From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 1/5] do not corrupt ptrlist while killing unreachable BBs
Date: Thu, 6 Jul 2017 22:15:02 -0700
Message-ID: <CANeU7Q=XzVrNoUOScCJjtautBsc0ittc_Okh+0wESuV4rRqing@mail.gmail.com>
References: <20170706191950.81268-1-luc.vanoostenryck@gmail.com>
 <20170706191950.81268-2-luc.vanoostenryck@gmail.com> <CANeU7QnbwqVcZdbarrj4OdpR9-TaG9=t5Q_CDFZXSuB+SN8zLw@mail.gmail.com>
 <CANeU7QnVNE38ODJ+cgUzD3Vz4XKogk-RL2v6-dS2aX9Oc4_0uQ@mail.gmail.com> <CA+55aFyUN-anJrFmo25tATO2wJS8+24S8TK=PAZBEYr0LvZN8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:33870 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751053AbdGGFPD (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 7 Jul 2017 01:15:03 -0400
Received: by mail-pf0-f175.google.com with SMTP id q85so11518704pfq.1
        for <linux-sparse@vger.kernel.org>; Thu, 06 Jul 2017 22:15:03 -0700 (PDT)
In-Reply-To: <CA+55aFyUN-anJrFmo25tATO2wJS8+24S8TK=PAZBEYr0LvZN8g@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Jul 6, 2017 at 6:35 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> Gaah.
>
> I think the original idea for this was to call pack_ptr_list() only at
> the end of all the list traversal that could delete things.
>

That is a very good suggestion. The problem would be to find out who
is the last one using that list. Also walking the list to find out the empty
ptr is extra overhead.

I have an idea. We can actually reference count the ptr_list usage like the
above patch. We need to because we want to know who is the lats one using
that ptrlist bucket. The last one using the ptr_list bucket (not the whole list)
can pack this bucket. It will avoid walking the list more than once just to do
the packing. I will try this idea soon. It might work.

Chris
