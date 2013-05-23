From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 3/5] Fix some "unknown format" warnings
Date: Thu, 23 May 2013 08:42:51 -0700
Message-ID: <519E38FB.2020207@chrisli.org>
References: <519BC851.5090202@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:38120 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759389Ab3EWPnV (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 23 May 2013 11:43:21 -0400
Received: by mail-pa0-f48.google.com with SMTP id kp6so3124515pab.35
        for <linux-sparse@vger.kernel.org>; Thu, 23 May 2013 08:43:21 -0700 (PDT)
In-Reply-To: <519BC851.5090202@ramsay1.demon.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>


On 05/21/2013 12:17 PM, Ramsay Jones wrote:

> +#if !defined(__MINGW32__)
>  			buf += sprintf(buf, "%Lf", expr->fvalue);
> +#else
> +			buf += sprintf(buf, "%f", (double)expr->fvalue);
> +#endif

I don't like to stash !define(__MINW32__) all over the sparse
code. Let's move this to the compat abstract layer. Can you create a
function "char *print_float(float value)" function in compat-mingw.c and
the normal implementation in compat/*.c


> +#if !defined(__MINGW32__)
>  		strftime(buffer, 12, "%b %e %Y", localtime(&t));
> +#else
> +		strftime(buffer, 12, "%b %d %Y", localtime(&t));
> +		if (buffer[4] == '0') buffer[4] = ' ';
> +#endif

Same here, try to move to the compat layer.

> +#if !defined(__MINGW32__)
>  	printf("\tmovf.%d\t\tv%d,$%Lf\n", expr->ctype->bit_size, new, value);
> +#else
> +	printf("\tmovf.%d\t\tv%d,$%f\n", expr->ctype->bit_size, new, (double)value);
> +#endif

Here we can reuse the previous print_float() function.

Chris
