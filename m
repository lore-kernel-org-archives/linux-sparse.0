From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH 0/6] testsuite speedup
Date: Mon, 29 May 2017 02:44:52 +0100
Message-ID: <b5d44360-82c0-5a3f-ecdc-98a9b7e9f35a@ramsayjones.plus.com>
References: <20170528192906.1023-1-luc.vanoostenryck@gmail.com>
 <47420cd6-74bc-8037-5d92-7e65f8aa8560@ramsayjones.plus.com>
 <CAExDi1S9oFHbUtv08rwGKOvjOVijzsrGm20dzW65N2ue=pUy1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from avasout08.plus.net ([212.159.14.20]:50198 "EHLO
        avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750864AbdE2Boz (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 28 May 2017 21:44:55 -0400
In-Reply-To: <CAExDi1S9oFHbUtv08rwGKOvjOVijzsrGm20dzW65N2ue=pUy1Q@mail.gmail.com>
Content-Language: en-GB
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>



On 28/05/17 23:39, Luc Van Oostenryck wrote:
> On Mon, May 29, 2017 at 12:04 AM, Ramsay Jones
> <ramsay@ramsayjones.plus.com> wrote:
>>
>>
>> On 28/05/17 20:29, Luc Van Oostenryck wrote:
>>> The goal of this series is to speedup the testsuite,
>>> mainly by avoiding to unneedlessly spawn child processes.
>>>
>>> The resulting speedup here is over 2.5, which is quite appreciable.
>>
>> I would have liked to try these out, particularly on cygwin, but I
>> could not get them to apply. (patch #4 has a line: 'rm -f $file.{error,output}.{expected,got,diff}' in the context which I don't have).
>>
>> I was attempting to apply on top of 'sparse-next-20170516'.
>> Should I apply to a different branch?
>> Were they built on a branch I don't have?
> 
> Ah yes, sorry for that.
> It should be applied on top of the next sparse-next but Chris hasn't yet
> pulled it.
> 
> If you wish you can directly use the branch on my github tree:
>         git://github.com/lucvoo/sparse.git testsuite-faster

Thanks. I very quickly tried it on cygwin and the time to run the
testsuite fell from 2m14.607s down to 1m0.298s. So, a nice time
saver. ;-)

ATB,
Ramsay Jones

