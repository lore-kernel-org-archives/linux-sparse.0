From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 00/29] Simple & Efficient SSA construction.
Date: Thu, 17 Aug 2017 07:16:09 +0200
Message-ID: <20170817051607.7tydij5q4zny3zxo@ltop.local>
References: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
 <CANeU7Q=+Jeuz41pDMVwqDNoCVj8C8bk=nx6+LY8uXcdP5pRiPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33300 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750741AbdHQFQO (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 17 Aug 2017 01:16:14 -0400
Received: by mail-wr0-f194.google.com with SMTP id n88so6358580wrb.0
        for <linux-sparse@vger.kernel.org>; Wed, 16 Aug 2017 22:16:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7Q=+Jeuz41pDMVwqDNoCVj8C8bk=nx6+LY8uXcdP5pRiPw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Thu, Aug 17, 2017 at 12:42:19AM -0400, Christopher Li wrote:
> Hi Luc,

Hi,
 
> Thank you so much for the patch.
> 
> Here is the kernel full allmodconfig running ssa-mini-v1 on my new
> compile server. On the new server the timing is very consistent.
> The variance of run to run is under 0.1 second.
> 
> ssa-mini-v1:
> 1205.82user 463.65system 1:16.97elapsed 2168%CPU (0avgtext+0avgdata
> 536216maxresident)k
> 0inputs+12824outputs (0major+132162996minor)pagefaults 0swaps
> 1206.35user 463.27system 1:16.95elapsed 2169%CPU (0avgtext+0avgdata
> 536296maxresident)k
> 0inputs+12824outputs (0major+132156314minor)pagefaults 0swaps
> 
> 
> This is the rc5 as base line.
> 1173.42user 453.56system 1:15.21elapsed 2163%CPU (0avgtext+0avgdata
> 238072maxresident)k
> 0inputs+12784outputs (0major+128858147minor)pagefaults 0swaps
> 1172.86user 453.53system 1:15.14elapsed 2164%CPU (0avgtext+0avgdata
> 238076maxresident)k
> 0inputs+12784outputs (0major+128858804minor)pagefaults 0swaps
> 
> So the ssa-mini-v1 is about 2% slower than the current rc5.

I haven't measured myself, but I guess that is because this series also
includes the removal of simplify_loads().

I wonder what would be these numbers if you measured:
1) r5 + removal of simplify_loads()
2) r5 + sssa-mini-v1 (which includes the removal).

> BTW, how do you want your patches to be merged? Assume there is
> some feed back. Do you want to come up with V2 V3 or have them merged
> to master then come up with fix up on master?

If there is some reasonable needed changes I can make a -v2
But I think that most changes can be done later as additional
patches once it's already in master.
 

> diff -ruN linux-checker/rc5/drivers/base/firmware_class.sp linux-checker/ssa/drivers/base/firmware_class.sp
> --- linux-checker/rc5/drivers/base/firmware_class.sp 2017-08-17
> +++ linux-checker/ssa/drivers/base/firmware_class.sp 2017-08-17
> @@ -1 +1 @@
> -drivers/base/firmware_class.c:395:9: warning: context imbalance in fw_free_buf' - wrong count at exit
> +drivers/base/firmware_class.c:391:13: warning: context imbalance in 'fw_free_buf' - wrong count at exit

There are often a little bunch of such changes, I've learnt to not
worry about them. Basically you have the same warning but at a
different line:colonm, something even a different file (source file /
include file). The cause is that the BBs are packed or merged
differently and the context checking use the position of the BB
and no the postion of a specific token.
It's annoying, I would like to not have that, but nothing to worry
about.


> diff -ruN linux-checker/rc5/drivers/block/drbd/drbd_actlog.sp linux-checker/ssa/drivers/block/drbd/drbd_actlog.sp
> --- linux-checker/rc5/drivers/block/drbd/drbd_actlog.sp 2017-08-17
> +++ linux-checker/ssa/drivers/block/drbd/drbd_actlog.sp 2017-08-17
> @@ -26,3 +26,4 @@
>  drivers/block/drbd/drbd_int.h:1773:14: error: incompatible types in comparison expression (different address spaces)
>  drivers/block/drbd/drbd_actlog.c:469:44: error: incompatible types in comparison expression (different address spaces)
>  drivers/block/drbd/drbd_actlog.c:173:16: warning: context imbalance in '_drbd_md_sync_page_io' - different lock contexts for basic block
> +drivers/block/drbd/drbd_actlog.c:1244:24: warning: context imbalance in 'drbd_rs_del_all' - different lock contexts for basic block

This one is different, it's part of the 8 or so new 'bad context' I was talking about.
I'll investigate about.

I have also one such warning that was present in -rc5 and absent in sssa-mini-v1.

-- Luc
