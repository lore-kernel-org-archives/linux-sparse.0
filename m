From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 00/29] Simple & Efficient SSA construction.
Date: Thu, 17 Aug 2017 08:09:26 +0200
Message-ID: <CAExDi1QztpLweagbMV6kA=K+O4H0F401JQwV=BF88CK69JMiEg@mail.gmail.com>
References: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
 <CANeU7Q=+Jeuz41pDMVwqDNoCVj8C8bk=nx6+LY8uXcdP5pRiPw@mail.gmail.com> <20170817051607.7tydij5q4zny3zxo@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34345 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750957AbdHQGJ1 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 17 Aug 2017 02:09:27 -0400
Received: by mail-oi0-f68.google.com with SMTP id v11so5614898oif.1
        for <linux-sparse@vger.kernel.org>; Wed, 16 Aug 2017 23:09:26 -0700 (PDT)
In-Reply-To: <20170817051607.7tydij5q4zny3zxo@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Thu, Aug 17, 2017 at 7:16 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
>> diff -ruN linux-checker/rc5/drivers/block/drbd/drbd_actlog.sp linux-checker/ssa/drivers/block/drbd/drbd_actlog.sp
>> --- linux-checker/rc5/drivers/block/drbd/drbd_actlog.sp 2017-08-17
>> +++ linux-checker/ssa/drivers/block/drbd/drbd_actlog.sp 2017-08-17
>> @@ -26,3 +26,4 @@
>>  drivers/block/drbd/drbd_int.h:1773:14: error: incompatible types in comparison expression (different address spaces)
>>  drivers/block/drbd/drbd_actlog.c:469:44: error: incompatible types in comparison expression (different address spaces)
>>  drivers/block/drbd/drbd_actlog.c:173:16: warning: context imbalance in '_drbd_md_sync_page_io' - different lock contexts for basic block
>> +drivers/block/drbd/drbd_actlog.c:1244:24: warning: context imbalance in 'drbd_rs_del_all' - different lock contexts for basic block
>
> This one is different, it's part of the 8 or so new 'bad context' I was talking about.
> I'll investigate about.

I just took a quick look at this one. It's interesting.
The IR seems correct, the locking is correct too.
The problem seems that the 'correct' presence of phi-nodes make
that some BB that were merged are not anymore. Nothing is wrong,
just different code. But the context checking is quite limited and see now
a path where the context could differ. I practice they won't differ and with
previous code the context checking saw that because this patch was
unexisting due to more aggressive merge of BB.

One way to see at it is this is a false warning that appears because
of a lack of BB optimizations.
I've a vague idea of what can be done here. I'll look at it later, this evening.

-- Luc
