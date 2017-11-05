From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 21/36] build: no need to clean *.so and SLIB_FILE
Date: Sun, 5 Nov 2017 09:48:07 -0800
Message-ID: <20171105174807.b4p6hmthwammarbv@s>
References: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
 <20171105162544.72960-21-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:34504 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750731AbdKERsM (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Nov 2017 12:48:12 -0500
Content-Disposition: inline
In-Reply-To: <20171105162544.72960-21-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-sparse@vger.kernel.org, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>

On Sun, Nov 05, 2017 at 05:25:29PM +0100, Luc Van Oostenryck wrote:
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index a8578c305..23c334132 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -207,7 +207,7 @@ version.h: FORCE
>  
>  
>  clean: clean-check
> -	rm -f *.[oa] .*.d *.so $(PROGRAMS) $(SLIB_FILE) version.h
> +	rm -f *.[oa] .*.d $(PROGRAMS) $(SLIB_FILE) version.h

You didn't remove SLIB_FILE here. And also, this should get squashed
into the patch that stops building these.
