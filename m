From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 01/36] build: make PREFIX overwritable from the
 environment
Date: Sun, 5 Nov 2017 09:44:09 -0800
Message-ID: <20171105174408.33uctnzyt53ig2uv@s>
References: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
 <20171105162544.72960-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:52888 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750731AbdKERoP (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Nov 2017 12:44:15 -0500
Content-Disposition: inline
In-Reply-To: <20171105162544.72960-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-sparse@vger.kernel.org, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>

On Sun, Nov 05, 2017 at 05:25:09PM +0100, Luc Van Oostenryck wrote:
> From: Uwe Kleine-König <uwe@kleine-koenig.org>
> 
> This way I can just use
> 
> 	env PREFIX=/usr make install
> 
> on the command line to install sparse into the system.

You can already use "make PREFIX=/usr install" to do this, which seems
far more conventional, and seems less error-prone (e.g. it won't pick up
something random from the environment, only something intentionally put
on the command line).

Any particular reason to do this?

>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index d03417641..e011df3cc 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -54,7 +54,7 @@ BASIC_CFLAGS += -Wp,-MD,$(@D)/.$(@F).d
>  endif
>  
>  DESTDIR=
> -PREFIX=$(HOME)
> +PREFIX ?= $(HOME)
>  BINDIR=$(PREFIX)/bin
>  LIBDIR=$(PREFIX)/lib
>  MANDIR=$(PREFIX)/share/man
> -- 
> 2.14.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sparse" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
