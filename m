From: Christopher Li <sparse@chrisli.org>
Subject: Re: Sparse context warning on 0.5.0
Date: Sat, 11 Oct 2014 09:47:31 +0800
Message-ID: <CANeU7Qk8E2pGANy1f8fXCeTwC1u0tE9HPT1FZqf_DGoASXF0rw@mail.gmail.com>
References: <4801d85f4f4c4f97ba83a075fc9a80b4@BY1PR0701MB1240.namprd07.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qc0-f179.google.com ([209.85.216.179]:36340 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304AbaJKBrc (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 10 Oct 2014 21:47:32 -0400
Received: by mail-qc0-f179.google.com with SMTP id x3so2898012qcv.10
        for <linux-sparse@vger.kernel.org>; Fri, 10 Oct 2014 18:47:31 -0700 (PDT)
In-Reply-To: <4801d85f4f4c4f97ba83a075fc9a80b4@BY1PR0701MB1240.namprd07.prod.outlook.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: "Franco, Scott" <Scott.Franco@caviumnetworks.com>
Cc: "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>

On Sat, Oct 11, 2014 at 1:04 AM, Franco, Scott
<Scott.Franco@caviumnetworks.com> wrote:
>
> /nfs/causers2/sfranco/projects/cnnic70xx_rearch/host/driver/src/linux/cavium/octeon_poll.c:130:5: warning: context imbalance in 'octeon_register_poll_fn' - wrong count at exit
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

I did not see any thing wrong with it (yet). Can you try to use
gcc/sparse -E to proprocess the
header file and make a minimal stand along test file? I can try to run
it and see what happen
there.

Chris
