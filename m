From: "Franco, Scott" <Scott.Franco@caviumnetworks.com>
Subject: RE: Sparse context warning on 0.5.0
Date: Sat, 11 Oct 2014 01:52:35 +0000
Message-ID: <4f5fd314ec274d16816d5cf17dd2cdfd@BY1PR0701MB1240.namprd07.prod.outlook.com>
References: <4801d85f4f4c4f97ba83a075fc9a80b4@BY1PR0701MB1240.namprd07.prod.outlook.com>
 <CANeU7Qk8E2pGANy1f8fXCeTwC1u0tE9HPT1FZqf_DGoASXF0rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-bn1bon0070.outbound.protection.outlook.com ([157.56.111.70]:29348
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750706AbaJKBwm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 10 Oct 2014 21:52:42 -0400
In-Reply-To: <CANeU7Qk8E2pGANy1f8fXCeTwC1u0tE9HPT1FZqf_DGoASXF0rw@mail.gmail.com>
Content-Language: en-US
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>

Chistopher,

Thanks for looking at my issue. I've been running it via the kernel make (make c=1),
So I'll figure out how to strip it out of the make and get back to you (I suspect the
Easiest way is to make --dry it and use the output).

Scott

-----Original Message-----
From: christ.li@gmail.com [mailto:christ.li@gmail.com] On Behalf Of Christopher Li
Sent: Friday, October 10, 2014 6:48 PM
To: Franco, Scott
Cc: linux-sparse@vger.kernel.org
Subject: Re: Sparse context warning on 0.5.0

On Sat, Oct 11, 2014 at 1:04 AM, Franco, Scott <Scott.Franco@caviumnetworks.com> wrote:
>
> /nfs/causers2/sfranco/projects/cnnic70xx_rearch/host/driver/src/linux/
> cavium/octeon_poll.c:130:5: warning: context imbalance in 
> 'octeon_register_poll_fn' - wrong count at exit
>
> The routine now is:
>
> static spinlock_t mylock = SPIN_LOCK_UNLOCKED;
>
> int octeon_register_poll_fn(int oct_id, octeon_poll_ops_t * ops)
>
> {
>
>     spin_lock(&mylock);
>     spin_unlock(&mylock);
>
>     return 0;
> }

I did not see any thing wrong with it (yet). Can you try to use gcc/sparse -E to proprocess the header file and make a minimal stand along test file? I can try to run it and see what happen there.

Chris
