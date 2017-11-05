From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 04/36] build: drop -g from LDFLAGS
Date: Sun, 5 Nov 2017 09:45:38 -0800
Message-ID: <20171105174538.ojexmlkchugd4gxe@s>
References: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
 <20171105162544.72960-4-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:49983 "EHLO
        slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750731AbdKERpp (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Nov 2017 12:45:45 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by slow1-d.mail.gandi.net (Postfix) with ESMTP id 28788487C16
        for <linux-sparse@vger.kernel.org>; Sun,  5 Nov 2017 18:45:44 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20171105162544.72960-4-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-sparse@vger.kernel.org, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>

On Sun, Nov 05, 2017 at 05:25:12PM +0100, Luc Van Oostenryck wrote:
> From: Uwe Kleine-König <uwe@kleine-koenig.org>
> 
> -g is a compiler option that is ignored by the linker. So it should be
> included in CFLAGS (it already is) but not LDFLAGS.
> 
> Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Reviewed-by: Josh Triplett <josh@joshtriplett.org>

>  Makefile | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index 069dae6c8..39b34f901 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -14,7 +14,6 @@ OS = linux
>  CC = gcc
>  CFLAGS = -O2 -finline-functions -fno-strict-aliasing -g
>  CFLAGS += -Wall -Wwrite-strings
> -LDFLAGS += -g
>  LD = gcc
>  AR = ar
>  PKG_CONFIG = pkg-config
> -- 
> 2.14.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sparse" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
