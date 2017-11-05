From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 05/36] build: pass CPPFLAGS to compiler
Date: Sun, 5 Nov 2017 09:46:30 -0800
Message-ID: <20171105174630.n7czuvsbratxvd65@s>
References: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
 <20171105162544.72960-5-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:45820 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750731AbdKERqf (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Nov 2017 12:46:35 -0500
Content-Disposition: inline
In-Reply-To: <20171105162544.72960-5-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-sparse@vger.kernel.org, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>

On Sun, Nov 05, 2017 at 05:25:13PM +0100, Luc Van Oostenryck wrote:
> From: Uwe Kleine-König <uwe@kleine-koenig.org>
> 
> Debian packages use CPPFLAGS to pass -D_FORTIFY_SOURCE=2 for hardening.
> 
> Originally-by: Uwe Kleine-König <uwe@kleine-koenig.org>
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Reviewed-by: Josh Triplett <josh@joshtriplett.org>

>  Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 39b34f901..f1af83e32 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -209,10 +209,10 @@ c2xml.o c2xml.sc: CFLAGS += $(LIBXML_CFLAGS)
>  pre-process.sc: CHECKER_FLAGS += -Wno-vla
>  
>  %.o: %.c $(LIB_H)
> -	$(QUIET_CC)$(CC) -o $@ -c $(CFLAGS) $<
> +	$(QUIET_CC)$(CC) $(CFLAGS) $(CPPFLAGS) -c -o $@ $<
>  
>  %.sc: %.c sparse
> -	$(QUIET_CHECK) $(CHECKER) $(CHECKER_FLAGS) -c $(CFLAGS) $<
> +	$(QUIET_CHECK) $(CHECKER) $(CHECKER_FLAGS) $(CFLAGS) $(CPPFLAGS) -c $<
>  
>  ALL_OBJS :=  $(LIB_OBJS) $(foreach p,$(PROGRAMS),$(p).o $($(p)_EXTRA_DEPS))
>  selfcheck: $(ALL_OBJS:.o=.sc)
> -- 
> 2.14.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sparse" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
