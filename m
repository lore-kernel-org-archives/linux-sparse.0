From: Jeff Layton <jlayton@redhat.com>
Subject: Re: [PATCH 29/36] build: use git-clean
Date: Wed, 08 Nov 2017 06:42:36 -0500
Message-ID: <1510141356.8401.1.camel@redhat.com>
References: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
         <20171105162544.72960-29-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:49713 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751826AbdKHLmj (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 8 Nov 2017 06:42:39 -0500
Received: by mail-qk0-f195.google.com with SMTP id q83so2873457qke.6
        for <linux-sparse@vger.kernel.org>; Wed, 08 Nov 2017 03:42:38 -0800 (PST)
In-Reply-To: <20171105162544.72960-29-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, linux-sparse@vger.kernel.org
Cc: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>

On Sun, 2017-11-05 at 17:25 +0100, Luc Van Oostenryck wrote:
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  Makefile | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index afc1efe98..f0f7a5b69 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -233,16 +233,8 @@ check: all
>  	$(Q)cd validation && ./test-suite
>  
>  
> -clean: clean-check
> -	@rm -f *.[oa] .*.d $(PROGRAMS) version.h
> -clean-check:
> +clean: FORCE
>  	@echo '     CLEAN'
> -	@find validation/ \( -name "*.c.output.expected" \
> -	                 -o -name "*.c.output.got" \
> -	                 -o -name "*.c.output.diff" \
> -	                 -o -name "*.c.error.expected" \
> -	                 -o -name "*.c.error.got" \
> -	                 -o -name "*.c.error.diff" \
> -	                 \) -exec rm {} \;
> +	@git clean -q -d -x -e .sparse.mk -e '*.[ch]'
>  
>  .PHONY: FORCE

This seems wrong. It's certainly possible to build sparse out of a
tarball that was generated from (e.g.) git-archive. In fact that's
generally how fedora (and I imagine Debian) build packages.

This would break the ability to do "make clean" in that setup.
-- 
Jeff Layton <jlayton@redhat.com>
