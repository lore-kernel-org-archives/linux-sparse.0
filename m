From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: make selfcheck
Date: Mon, 17 Jul 2017 19:19:30 +0100
Message-ID: <39e3d856-fd32-8059-10bb-ad1367e7d7a9@ramsayjones.plus.com>
References: <d5ab8af1-6a09-9985-7de1-8ad639369795@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from avasout06.plus.net ([212.159.14.18]:57506 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751315AbdGQSTd (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 17 Jul 2017 14:19:33 -0400
In-Reply-To: <d5ab8af1-6a09-9985-7de1-8ad639369795@ramsayjones.plus.com>
Content-Language: en-GB
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>



On 17/07/17 17:30, Ramsay Jones wrote:
> Hi Christopher,
> 
> The 'make selfcheck' target fails very quickly on cygwin, like so:
> 
>   $ make selfcheck
>        CHECK    target.c
>        CHECK    parse.c
>   /usr/include/sys/_default_fcntl.h:163:14: error: redefinition of struct flock
>   make: *** [Makefile:204: parse.sc] Error 1
>   $ 
> 
> This is caused by sparse not defining the '__CYGWIN__' macro, which
> would have been defined by cgcc, so the follwing fixes that:
> 
> -- >8 --
> diff --git a/Makefile b/Makefile
> index 4214e17..a3d3b9c 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -201,7 +201,7 @@ c2xml.o c2xml.sc: CFLAGS += $(LIBXML_CFLAGS)
>  	$(QUIET_CC)$(CC) -o $@ -c $(ALL_CFLAGS) $<
>  
>  %.sc: %.c sparse
> -	$(QUIET_CHECK) ./sparse -c $(ALL_CFLAGS) $<
> +	$(QUIET_CHECK) ./cgcc -c $(ALL_CFLAGS) $<

This should have been './cgcc -no-compile', of course. :(

ATB,
Ramsay Jones
