From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] fix OP_PHI usage in try_to_simplify_bb(), correctly
Date: Sat, 1 Apr 2017 01:51:33 +0200
Message-ID: <CAExDi1SYjs5G8ePWc45aYmzJbKoPh=2zp3OK6c=rxif+EnrckQ@mail.gmail.com>
References: <CACXZuxeomDxKsmdu7e5YEg_-3exNpV-psjQ_o3P0BLV1A2=z0Q@mail.gmail.com>
 <20170322105331.91596-1-luc.vanoostenryck@gmail.com> <CANeU7QmX3ZgkC4RjecbNp8TvCnYUr4LzY4364AV-6EeJTbjC5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qt0-f179.google.com ([209.85.216.179]:33799 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933485AbdCaXve (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 31 Mar 2017 19:51:34 -0400
Received: by mail-qt0-f179.google.com with SMTP id n21so78053414qta.1
        for <linux-sparse@vger.kernel.org>; Fri, 31 Mar 2017 16:51:34 -0700 (PDT)
In-Reply-To: <CANeU7QmX3ZgkC4RjecbNp8TvCnYUr4LzY4364AV-6EeJTbjC5A@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>

On Sat, Apr 1, 2017 at 1:27 AM, Christopher Li <sparse@chrisli.org> wrote:

>> +       curr->generation = generation;
>> +       FOR_EACH_PTR(curr->children, bb) {
>> +               if (bb->generation == generation)
>> +                       continue;
>> +               if (bb == phi->bb)
>> +                       continue;
>> +               if (pseudo_in_list(bb->defines, target)) {
>> +                       continue;
>> +               }
>
> For just one line continue, there is no need for {}
>
>> +               if (pseudo_in_list(bb->needs, target)) {
>> +                       rc = 1;
>> +                       goto ret;
>
> Can this simplify as "return 1;"
>
>> +               }
>> +               rc = needed_phisrc(phi, bb, generation);
>> +               if (rc)
>> +                       goto ret;
> needed_phisrc(phi, bb, generation)
>
> And "return 1;" here
>> +
>> +       } END_FOR_EACH_PTR(bb);
>
>
>> +
>> +ret:
>> +       return rc;
>
> "return 0" here.
> There is no need for rc variable.

Yes, sure. This is some debugging leftover.
In truth, I detest this patch, it's a bandaid more than anything else
but I haven't anything better for the moment.

I'll respin it but it will most probably be for Sunday.

-- Luc
