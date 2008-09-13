From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH] sparse: Make pre_buffer dynamically increasable
Date: Sun, 14 Sep 2008 00:49:51 +0900 (JST)
Message-ID: <20080914.004951.41872502.anemo@mba.ocn.ne.jp>
References: <20080720.002224.108306935.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mba.ocn.ne.jp ([122.1.235.107]:56997 "EHLO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751559AbYIMPtm (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sat, 13 Sep 2008 11:49:42 -0400
In-Reply-To: <20080720.002224.108306935.anemo@mba.ocn.ne.jp>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: linux-mips@linux-mips.org, sam@ravnborg.org, viro@ZenIV.linux.org.uk

On Sun, 20 Jul 2008 00:22:24 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> I got this error when running sparse on mips kernel with gcc 4.3:
> 
> builtin:272:1: warning: Newline in string or character constant
> 
> The linux-mips kernel uses '$(CC) -dM -E' to generates arguments for
> sparse.  With gcc 4.3, it generates lot of '-D' options and causes
> pre_buffer overflow.  The linux-mips kernel can filter unused symbols
> out to avoid overflow, but sparse should be fixed anyway.
> 
> This patch make pre_buffer dynamically increasable and add extra
> checking for overflow instead of silently truncating.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

Ping?

> ---
> diff --git a/lib.c b/lib.c
> index 0abcc9a..6e8d09b 100644
> --- a/lib.c
> +++ b/lib.c
> @@ -186,7 +186,8 @@ void die(const char *fmt, ...)
>  }
>  
>  static unsigned int pre_buffer_size;
> -static char pre_buffer[8192];
> +static unsigned int pre_buffer_alloc_size;
> +static char *pre_buffer;
>  
>  int Waddress_space = 1;
>  int Wbitwise = 0;
> @@ -232,12 +233,20 @@ void add_pre_buffer(const char *fmt, ...)
>  	unsigned int size;
>  
>  	va_start(args, fmt);
> +	if (pre_buffer_alloc_size < pre_buffer_size + getpagesize()) {
> +		pre_buffer_alloc_size += getpagesize();
> +		pre_buffer = realloc(pre_buffer, pre_buffer_alloc_size);
> +		if (!pre_buffer)
> +			die("Unable to allocate more pre_buffer space");
> +	}
>  	size = pre_buffer_size;
>  	size += vsnprintf(pre_buffer + size,
> -		sizeof(pre_buffer) - size,
> +		pre_buffer_alloc_size - size,
>  		fmt, args);
>  	pre_buffer_size = size;
>  	va_end(args);
> +	if (pre_buffer_size >= pre_buffer_alloc_size - 1)
> +		die("pre_buffer overflow");
>  }
>  
>  static char **handle_switch_D(char *arg, char **next)

