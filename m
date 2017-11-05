From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 29/36] build: use git-clean
Date: Sun, 5 Nov 2017 09:41:02 -0800
Message-ID: <20171105174100.r3y4o4m2i47d25o5@s>
References: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
 <20171105162544.72960-29-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:37452 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750750AbdKERlJ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Nov 2017 12:41:09 -0500
Content-Disposition: inline
In-Reply-To: <20171105162544.72960-29-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-sparse@vger.kernel.org, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>

On Sun, Nov 05, 2017 at 05:25:37PM +0100, Luc Van Oostenryck wrote:
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

No, you can't use git-clean here, for two reasons.

First, it has to be possible to build, and clean, sparse from a
tarball release, not just a git repository.

And second, even if not for that, this should *not* use -x or -d, *only*
-X. Otherwise, you might remove, say, a pile of carefully written
patches and cover letters sitting in the user's Sparse source directory.
