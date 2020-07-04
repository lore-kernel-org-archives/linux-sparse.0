From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH 2/3] add memory asm constraint for PPC
Date: Sat, 4 Jul 2020 22:07:15 +0100
Message-ID: <900dd2ad-9037-cefb-6a22-27cd0b971716@ramsayjones.plus.com>
References: <20200704135747.87752-1-luc.vanoostenryck@gmail.com>
 <20200704135747.87752-3-luc.vanoostenryck@gmail.com>
 <693a3fa0-5202-3695-54cf-aa1cc1f514fd@ramsayjones.plus.com>
 <20200704193248.simtaedrt7gbiepy@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from avasout07.plus.net ([84.93.230.235]:49432 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbgGDVHU (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 4 Jul 2020 17:07:20 -0400
In-Reply-To: <20200704193248.simtaedrt7gbiepy@ltop.local>
Content-Language: en-GB
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-sparse@vger.kernel.org



On 04/07/2020 20:32, Luc Van Oostenryck wrote:
> On Sat, Jul 04, 2020 at 06:44:53PM +0100, Ramsay Jones wrote:

>> On 04/07/2020 14:57, Luc Van Oostenryck wrote:
>>> The 'Z' asm constraint is used for doing IO accessors on PPC but
>>> isn't part of the 'common constraints'. It's responsible for
>>> more than half of all warnings (with defconfig + allyesconfig).
>>
>> Not a problem, but this made me think 'half of which warnings'. :-D
>> I assume, but it's just a guess, this means 'half of all asm-constraints
>> warnings on the kernel PPC build'.
>>
>> How many warnings is that? What percentage is that of _all_ sparse
>> warnings on a typical kernel build?
> 
> It's literally more than half of all warnings issued by sparse when doing
> a build of the kernel with 'defconfig' and another one with 'allyesconfig'
> (all my tests on kernel builds are done like so) on a ppc64 machine:
> 	$ grep ': \(error\|warning\):' log-master-master | wc -l
> 	138581
> 	$ grep ': \(error\|warning\):' log-arch-asm-mem | wc -l
> 	50006
> So, this series eliminates about 64% of all warnings, a nice
> improvement of the S/N ratio.

Oh, nice!

It's a _long_ time since I last built the kernel (about when reading
Greg's 'Linux Kernel in a Nutshell' book, so about 2006), and I don't
even recall if I ran sparse over it. (Hmm, did you have to specify
a C parameter to make or something?).

Anyway, that is still a very large number of error/warnings - has it
always been that bad?

>> [BTW, I also noticed the (long running) 'luc/options' branch, which
>> looks like it could prove to be a nice cleanup - I've only read the
>> commit messages, not the actual commits.]
> 
> Yes, I think it's a nice cleanup because this code is quite messy but,
> OTOH, moving around all this code break all its history (via 'git blame'
> or 'git log -L') is is guaranteed to create really nasty conflicts with
> anything touching the code for the options. This is really a downside.

Yep, I know what you mean. However, I don't think you should shy
away from clean-ups for too long - it will be counter-productive
in the end.

ATB,
Ramsay Jones
