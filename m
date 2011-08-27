From: Jeff Garzik <jeff@garzik.org>
Subject: Re: linearize bug?
Date: Sat, 27 Aug 2011 11:37:06 -0400
Message-ID: <4E590F22.6030800@garzik.org>
References: <4E588EB8.80808@garzik.org> <201108271334.17659.kdudka@redhat.com> <CA+55aFzGViNgNO8rkv1kT8TZBXNWoJ8kMDHFormT_EzK3LGvZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:59420 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750908Ab1H0PhI (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 27 Aug 2011 11:37:08 -0400
Received: by qwk3 with SMTP id 3so2548748qwk.19
        for <linux-sparse@vger.kernel.org>; Sat, 27 Aug 2011 08:37:07 -0700 (PDT)
In-Reply-To: <CA+55aFzGViNgNO8rkv1kT8TZBXNWoJ8kMDHFormT_EzK3LGvZQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kamil Dudka <kdudka@redhat.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>, Pekka J Enberg <penberg@cs.helsinki.fi>

On 08/27/2011 11:29 AM, Linus Torvalds wrote:
> On Sat, Aug 27, 2011 at 4:34 AM, Kamil Dudka<kdudka@redhat.com>  wrote:
>>
>> Two years ago I proposed a patch that I believe would solve your problem:
>>
>> https://patchwork.kernel.org/patch/40307/
>
> Ack.
>
> The sparse output still looks like sh*t, because when linearizing
> loops sparse doesn't treat the first conditional specially, so instead
> of noticing that "0<  10" and getting rid of the first jump, it will
> generate the loop with the (general) conditional at the end, which
> will then result in lots of phi-nodes etc.
>
> I guess some trivial loop optimizations might be a good idea. But
> Kamil's patch looks correct, and the PHI-node cross-bb optimization
> does look bogus.


On our point of view, we probably prefer to simply turn off as many 
transformations as possible.  They just waste time, when an optimizing 
LLVM backend is going to perform the same transformations anyway.

	Jeff


