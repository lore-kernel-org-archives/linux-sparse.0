From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH 3/3] add support for -fmemcpy-max-count
Date: Fri, 2 Jun 2017 02:42:16 +0100
Message-ID: <faa88d94-b243-e8be-39f0-b84ccbf92ba0@ramsayjones.plus.com>
References: <84e547c2-8a5b-225c-1363-361e091821f4@ramsayjones.plus.com>
 <20170601202724.77597-1-luc.vanoostenryck@gmail.com>
 <20170601202724.77597-4-luc.vanoostenryck@gmail.com>
 <45f3b371-2839-5353-17a7-ea82b113d4f1@ramsayjones.plus.com>
 <CAMHZB6GT8d2UUBO2po+o0QLaBh_3ZOLgA0_zYz7s1_xgDr4DQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from avasout08.plus.net ([212.159.14.20]:34568 "EHLO
        avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751120AbdFBBmU (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 1 Jun 2017 21:42:20 -0400
In-Reply-To: <CAMHZB6GT8d2UUBO2po+o0QLaBh_3ZOLgA0_zYz7s1_xgDr4DQA@mail.gmail.com>
Content-Language: en-GB
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Chris Li <sparse@chrisli.org>, Junio C Hamano <gitster@pobox.com>



On 02/06/17 01:38, Luc Van Oostenryck wrote:
> On Fri, Jun 2, 2017 at 2:30 AM, Ramsay Jones
> <ramsay@ramsayjones.plus.com> wrote:
> 
>>>  .SH OTHER OPTIONS
>>>  .TP
>>> +.B \-fmemcpy-limit=COUNT
>>> +By default, sparse will warn if \fBmemcpy()\fR (or \fBmemset()\fR,
>>> +\fBcopy_from_user()\fR, copy_to_user()\fR) is called with a very large
>>> +(known at compile-time) byte-count. COUNT is the value under which
>>> +no such warning will be given. The default limit is 100000.
>>> +.
>>> +.TP
>>
>> So, in addition to -Wno-memcpy-max-count, you could turn the warning
>> off with just -fmemcpy-limit=0. cool.
>>
>> Thanks!
>>
>> ATB,
>> Ramsay Jones
> 
> Well, for now setting the limit to 0 would just warn about any
> non-zero memcpy/memset
> but it's something that could very easily be added, sure.

Yes, as I noted in another email, I didn't read the code correctly!
(and in my patch I had a single -Wmem-limit=n argument which _did_
disable the check when n = 0).

Naming issues aside (and I'm bad at naming, so don't listen to me
on that), I like your -W[no-]memcpy-max-count and -fmemcpy-limit=n
split.

[You may want to remove the '=COUNT' from the commit message of
the 2/3 patch].

Thanks again.

ATB,
Ramsay Jones


