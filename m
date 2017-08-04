From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 4/4] mark pseudo users as deleted instead of removing them
Date: Fri, 4 Aug 2017 23:34:16 +0200
Message-ID: <CAExDi1T5kFzPi6XJCeDabP3wY+HgF39QQvsfTgN8uQLNUnaZLQ@mail.gmail.com>
References: <CANeU7QkRWygQB_dsD4o4omB-G_xtZZVLZP4-DgaK3iDMd=HB4w@mail.gmail.com>
 <20170804200915.56738-1-luc.vanoostenryck@gmail.com> <20170804200915.56738-5-luc.vanoostenryck@gmail.com>
 <CANeU7QkoXb-G3FQ9+iPx_WGN9x8jeao0wt--FYz8rb0ZvndHpg@mail.gmail.com>
 <CAExDi1QbMcq+Npc+kFpadjj44i8rm3W3ccE=RhkRAgp98jtHSw@mail.gmail.com>
 <CANeU7QmwOOkmC1U+_Pf1EVJ01vN+_Venhh_4D=W=pU1P1j0q+Q@mail.gmail.com>
 <CAExDi1T0GtbmZue1PJedPXKOGRKa462Oe_grpuG938y5jo3gpw@mail.gmail.com> <CANeU7QmVn0wd-JJc4MPhDPK+QLP-DgsbKNm2sHF-QAmG8kR12Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:37358 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751271AbdHDVeR (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 4 Aug 2017 17:34:17 -0400
Received: by mail-qk0-f176.google.com with SMTP id z18so15907785qka.4
        for <linux-sparse@vger.kernel.org>; Fri, 04 Aug 2017 14:34:17 -0700 (PDT)
In-Reply-To: <CANeU7QmVn0wd-JJc4MPhDPK+QLP-DgsbKNm2sHF-QAmG8kR12Q@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Aug 4, 2017 at 11:14 PM, Christopher Li <sparse@chrisli.org> wrote:
> On Fri, Aug 4, 2017 at 5:03 PM, Luc Van Oostenryck wrote:
>>> I am not sure we are on the same page. Only 2 macro need to be updated:
>>> DO_FOR_EACH_PTR, DO_FOR_EACH_REVERSE.
>>
>> It's not for the number of macros defined.
>> It's about the code size & the run-time effect on the iteration of
>> the other lists. It seems simple enough but it would add two load-test-branch
>
> Because the rm is near the nr, which get visit every loop iteration.
> From cache line point of view, the ptrlist->rm will not cause extra cache load.
> The second test and load will not matter for most of the ptrlist any way.

Yes, we agree.

> I am willing to bet even my test-ptrlist benchmark will not see much a
> difference.

It will depend on how micro the benchmark is but indeed on real code,
most probably it won't make any measurable difference.

>> to every such macro invocation and these macros are already quite heavy.
>
> The flip side is if some one forget to check that, it will be very
> bad. How do you
> make sure you add the check to every single one of the loop iterator?

Oh, I agree on this one but the same argument when pushed further
can lead to absurd situations. We're not there though.

> I can take patch as it is. It is only a suggestion. No deal breaker.

Frankly, I don't know.

I never liked to have to add these checks a bit everywhere,
that's why I called it 'not very pretty'.
My inclination would be to create a variant FOR_EACH_PTR_NULL(),
this can be done without duplicating the real macro DO_...
but then you can as easily forgot to call this variant that you could
forgot to add the test locally (adding some typing could help here though).
On the other hand, adding these tests to all list iteration code when
not needed looks bad.

OK, since the run-time impact will be low enough let's choose the
solution with the smallest (source) code impact.
New version on the way.

-- Luc
