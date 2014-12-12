From: Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: Bogus 'Initializer entry defined twice' warnings
Date: Fri, 12 Dec 2014 09:04:14 +0100
Message-ID: <548AA17E.9030504@xs4all.nl>
References: <5400357A.5050705@xs4all.nl>	<CANeU7Q=q7AL=nh2BGfHyAYqjHbMu9cu3NbR7Jkfw4wd+SPRWUA@mail.gmail.com>	<5481B580.3080100@xs4all.nl> <CANeU7Qko4VY_hZbuuNVLbRjaiEeFAyb8VLDmew0zSz1SYrPA9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lb2-smtp-cloud6.xs4all.net ([194.109.24.28]:55627 "EHLO
	lb2-smtp-cloud6.xs4all.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750759AbaLLIEZ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 12 Dec 2014 03:04:25 -0500
In-Reply-To: <CANeU7Qko4VY_hZbuuNVLbRjaiEeFAyb8VLDmew0zSz1SYrPA9w@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On 12/12/2014 05:32 AM, Christopher Li wrote:
> On Fri, Dec 5, 2014 at 9:39 PM, Hans Verkuil <hverkuil@xs4all.nl> wrote:
>>> Still need more work to fix it.
>>
>> Any updates on this?
>>
> 
> The search is over.
> 
>     Ptr list sorting should use memmove instead of memcpy
> 
>     The target buffer is overlapped with source buffer.
>     This cause the duplicate entry warning reported by Hans.

Fantastic! This fixes the problem, now I can concentrate on getting rid
of the last few remaining sparse warnings in drivers/media.

Regards,

	Hans

> 
>     Reported-by: Hans Verkuil <hverkuil@xs4all.nl>
>     Signed-off-by: Christopher Li <sparse@chrisli.org>
> 
> diff --git a/sort.c b/sort.c
> index afd7184..430ba44 100644
> --- a/sort.c
> +++ b/sort.c
> @@ -99,7 +99,7 @@ static void verify_seq_sorted (struct ptr_list *l, int n,
>         assert (nbuf >= nr);                                    \
>         memcpy ((b)->list, buffer, nr * sizeof (void *));       \
>         nbuf -= nr;                                             \
> -       memcpy (buffer, buffer + nr, nbuf * sizeof (void *));   \
> +       memmove (buffer, buffer + nr, nbuf * sizeof (void *));  \
>    } while (0)
> 
> 
> Chris
> 

