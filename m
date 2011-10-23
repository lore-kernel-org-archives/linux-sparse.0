From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [RFC/PATCH 2/2] sparse: Use native sizes for data types
Date: Sun, 23 Oct 2011 11:53:00 -0400
Message-ID: <4EA4385C.1050800@garzik.org>
References: <1319373420-8967-1-git-send-email-penberg@cs.helsinki.fi> <1319373420-8967-2-git-send-email-penberg@cs.helsinki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:58920 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592Ab1JWPxD (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 23 Oct 2011 11:53:03 -0400
Received: by vcge1 with SMTP id e1so4290616vcg.19
        for <linux-sparse@vger.kernel.org>; Sun, 23 Oct 2011 08:53:02 -0700 (PDT)
In-Reply-To: <1319373420-8967-2-git-send-email-penberg@cs.helsinki.fi>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: penberg@cs.helsinki.fi
Cc: linux-sparse@vger.kernel.org, Pekka Enberg <penberg@kernel.org>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>

On 10/23/2011 08:37 AM, penberg@cs.helsinki.fi wrote:
> From: Pekka Enberg<penberg@kernel.org>
>
> This patch is needed to fix the sparsec LLVM backend data type sizes.
>
> Cc: Christopher Li<sparse@chrisli.org>
> Cc: Jeff Garzik<jgarzik@redhat.com>
> Cc: Linus Torvalds<torvalds@linux-foundation.org>
> Signed-off-by: Pekka Enberg<penberg@kernel.org>
> ---
>   target.c |   10 +++++-----
>   1 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/target.c b/target.c
> index 6a535bc..009002f 100644
> --- a/target.c
> +++ b/target.c
> @@ -17,9 +17,9 @@ int max_alignment = 16;
>   int bits_in_bool = 8;
>   int bits_in_char = 8;
>   int bits_in_short = 16;
> -int bits_in_int = 32;
> -int bits_in_long = 32;
> -int bits_in_longlong = 64;
> +int bits_in_int = sizeof(int) * 8;
> +int bits_in_long = sizeof(long) * 8;
> +int bits_in_longlong = sizeof(long long) * 8;
>   int bits_in_longlonglong = 128;
>
>   int max_int_alignment = 4;
> @@ -36,8 +36,8 @@ int max_fp_alignment = 8;
>   /*
>    * Pointer data type
>    */
> -int bits_in_pointer = 32;
> -int pointer_alignment = 4;
> +int bits_in_pointer = sizeof(void *) * 8;
> +int pointer_alignment = sizeof(void *);

No objection, but ideally we should select from a target template.

We don't want to start down the road of making runtime target switching 
(i386/x86-64) difficult.

	Jeff


