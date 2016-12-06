From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 0/2] be more generous with ptrlist repacking
Date: Tue, 6 Dec 2016 08:24:00 +0800
Message-ID: <CANeU7QmzbMc9Uairgj6ZAMBOkLj-6mCuZLzU79ZXBo0i9SHRQg@mail.gmail.com>
References: <20161117172559.29417-1-luc.vanoostenryck@gmail.com>
 <CA+55aFwYGCD-+GhVLdHedu42cu1RyT+Ko9Dj6-pfTrPv0ZD5Jg@mail.gmail.com>
 <20161117202523.GA35194@macpro.local> <CA+55aFwsQYAFO+hbSi3pxvkjVA6Jv=DpeZrVHyzj9-RmAuF=tQ@mail.gmail.com>
 <20161118002918.GA35373@macpro.local> <20161128211514.GA1077@macbook.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:35557 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751427AbcLFAii (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 5 Dec 2016 19:38:38 -0500
Received: by mail-io0-f195.google.com with SMTP id h133so18041299ioe.2
        for <linux-sparse@vger.kernel.org>; Mon, 05 Dec 2016 16:38:30 -0800 (PST)
In-Reply-To: <20161128211514.GA1077@macbook.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>, Dan Carpenter <dan.carpenter@oracle.com>

On Mon, Nov 28, 2016 at 1:15 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> I've worked a bit more on this. I had a nice, clean & compact
> implementation where basically all ptr_list walking was done by
> something like:
>         struct ptr_iter iter;
>         ptr_iter_init(&iter, head);
>         while ((ptr = ptr_iter_next(&iter)))
>                 ...

Last time I try that, I look at the machine code and realized that
using iter struct is not quite the same as using macro. On each function
boundary, the compiler still try to sync the data register content
into the iter structure in memory. In other words, there is no way to make the
iter variable as register, it always get sync into memory.

I did run a full kernel source check back then, did not find an observable
difference. The time difference is within the variance of each run.
Maybe due to most of the list are very short.

Chris
