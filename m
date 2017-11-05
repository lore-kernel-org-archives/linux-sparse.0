From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 02/36] build: put comment about local.mk to the place
 where it is included
Date: Sun, 5 Nov 2017 09:44:40 -0800
Message-ID: <20171105174439.t23gnuuaaiuf27al@s>
References: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
 <20171105162544.72960-2-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:44463 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750731AbdKERoo (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Nov 2017 12:44:44 -0500
Content-Disposition: inline
In-Reply-To: <20171105162544.72960-2-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-sparse@vger.kernel.org, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>

On Sun, Nov 05, 2017 at 05:25:10PM +0100, Luc Van Oostenryck wrote:
> From: Uwe Kleine-König <uwe@kleine-koenig.org>
> 
> Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Reviewed-by: Josh Triplett <josh@joshtriplett.org>

>  Makefile | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index e011df3cc..ddb4c5e3d 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -22,11 +22,6 @@ CHECKER = ./cgcc -no-compile
>  CHECKER_FLAGS =
>  
>  ALL_CFLAGS = $(CFLAGS) $(BASIC_CFLAGS)
> -#
> -# For debugging, put this in local.mk:
> -#
> -#     CFLAGS += -O0 -DDEBUG -g3 -gdwarf-2
> -#
>  
>  HAVE_LIBXML:=$(shell $(PKG_CONFIG) --exists libxml-2.0 2>/dev/null && echo 'yes')
>  HAVE_GCC_DEP:=$(shell touch .gcc-test.c && 				\
> @@ -167,6 +162,10 @@ SED_PC_CMD = 's|@version@|$(VERSION)|g;		\
>  
>  
>  # Allow users to override build settings without dirtying their trees
> +# For debugging, put this in local.mk:
> +#
> +#     CFLAGS += -O0 -DDEBUG -g3 -gdwarf-2
> +#
>  -include local.mk
>  
>  
> -- 
> 2.14.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sparse" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
