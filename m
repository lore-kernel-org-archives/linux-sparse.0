From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: Bogus 'Initializer entry defined twice' warnings
Date: Fri, 12 Dec 2014 00:12:10 -0800
Message-ID: <20141212081209.GA16645@thin>
References: <5400357A.5050705@xs4all.nl>
 <CANeU7Q=q7AL=nh2BGfHyAYqjHbMu9cu3NbR7Jkfw4wd+SPRWUA@mail.gmail.com>
 <5481B580.3080100@xs4all.nl>
 <CANeU7Qko4VY_hZbuuNVLbRjaiEeFAyb8VLDmew0zSz1SYrPA9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:41987 "EHLO
	relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758536AbaLLIMS (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 12 Dec 2014 03:12:18 -0500
Content-Disposition: inline
In-Reply-To: <CANeU7Qko4VY_hZbuuNVLbRjaiEeFAyb8VLDmew0zSz1SYrPA9w@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Fri, Dec 12, 2014 at 12:32:47PM +0800, Christopher Li wrote:
> On Fri, Dec 5, 2014 at 9:39 PM, Hans Verkuil <hverkuil@xs4all.nl> wrote:
> >> Still need more work to fix it.
> >
> > Any updates on this?
> >
> 
> The search is over.
> 
>     Ptr list sorting should use memmove instead of memcpy
> 
>     The target buffer is overlapped with source buffer.
>     This cause the duplicate entry warning reported by Hans.
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

Great catch, Chris!

- Josh Triplett
