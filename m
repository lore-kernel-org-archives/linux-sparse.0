From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 00/29] Simple & Efficient SSA construction.
Date: Thu, 17 Aug 2017 01:58:43 -0400
Message-ID: <CANeU7Qn1FN3YfQ5fh3qgHqY3xDL=TKFgS9-F2OD2Qt5iSA9BXQ@mail.gmail.com>
References: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
 <CANeU7Q=+Jeuz41pDMVwqDNoCVj8C8bk=nx6+LY8uXcdP5pRiPw@mail.gmail.com> <20170817051607.7tydij5q4zny3zxo@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f193.google.com ([209.85.161.193]:38248 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750903AbdHQF6p (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 17 Aug 2017 01:58:45 -0400
Received: by mail-yw0-f193.google.com with SMTP id p68so3555784ywg.5
        for <linux-sparse@vger.kernel.org>; Wed, 16 Aug 2017 22:58:45 -0700 (PDT)
In-Reply-To: <20170817051607.7tydij5q4zny3zxo@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Thu, Aug 17, 2017 at 1:16 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Thu, Aug 17, 2017 at 12:42:19AM -0400, Christopher Li wrote:
>> Hi Luc,
>
> Hi,
>
>> Thank you so much for the patch.
>>
>> Here is the kernel full allmodconfig running ssa-mini-v1 on my new
>> compile server. On the new server the timing is very consistent.
>> The variance of run to run is under 0.1 second.
>>
>> ssa-mini-v1:
>> 1205.82user 463.65system 1:16.97elapsed 2168%CPU (0avgtext+0avgdata
>> 536216maxresident)k
>> 0inputs+12824outputs (0major+132162996minor)pagefaults 0swaps
>> 1206.35user 463.27system 1:16.95elapsed 2169%CPU (0avgtext+0avgdata
>> 536296maxresident)k
>> 0inputs+12824outputs (0major+132156314minor)pagefaults 0swaps
>>
>>
>> This is the rc5 as base line.
>> 1173.42user 453.56system 1:15.21elapsed 2163%CPU (0avgtext+0avgdata
>> 238072maxresident)k
>> 0inputs+12784outputs (0major+128858147minor)pagefaults 0swaps
>> 1172.86user 453.53system 1:15.14elapsed 2164%CPU (0avgtext+0avgdata
>> 238076maxresident)k
>> 0inputs+12784outputs (0major+128858804minor)pagefaults 0swaps
>>
>> So the ssa-mini-v1 is about 2% slower than the current rc5.
>
> I haven't measured myself, but I guess that is because this series also
> includes the removal of simplify_loads().
>
> I wonder what would be these numbers if you measured:
> 1) r5 + removal of simplify_loads()

1170.54user 453.61system 1:15.05elapsed 2164%CPU (0avgtext+0avgdata
238104maxresident)k
0inputs+12792outputs (0major+128794771minor)pagefaults 0swaps
1172.00user 452.53system 1:14.96elapsed 2166%CPU (0avgtext+0avgdata
238076maxresident)k
0inputs+12784outputs (0major+128795134minor)pagefaults 0swaps


> 2) r5 + sssa-mini-v1 (which includes the removal).
1205.84user 463.12system 1:16.84elapsed 2171%CPU (0avgtext+0avgdata
536300maxresident)k
0inputs+12824outputs (0major+132152193minor)pagefaults 0swaps
1204.59user 462.09system 1:16.77elapsed 2170%CPU (0avgtext+0avgdata
536132maxresident)k
0inputs+12824outputs (0major+132160134minor)pagefaults 0swaps


>
>> BTW, how do you want your patches to be merged? Assume there is
>> some feed back. Do you want to come up with V2 V3 or have them merged
>> to master then come up with fix up on master?
>
> If there is some reasonable needed changes I can make a -v2
> But I think that most changes can be done later as additional
> patches once it's already in master.

Sure.

Speaking of which, can you do me a favor bump the -rc5 to finial?
Just drop the "-rc5" part in Makefile. Let's release the 0.5.1 and
start merging patches :-)

Thanks

Chris
