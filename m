From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH] sparse: minor manpage corrections
Date: Sat, 20 Jan 2018 16:16:15 -0800
Message-ID: <20180121001615.GA17630@localhost>
References: <8f4eac6f-fe62-8238-0e89-fe117131b921@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:51029 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750987AbeAUAQV (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 20 Jan 2018 19:16:21 -0500
Content-Disposition: inline
In-Reply-To: <8f4eac6f-fe62-8238-0e89-fe117131b921@infradead.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>

On Sat, Jan 20, 2018 at 03:48:58PM -0800, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix some man page typos, punctuation, and grammar.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Josh Triplett <josh@joshtriplett.org>

Looks good to me.
Reviewed-by: Josh Triplett <josh@joshtriplett.org>

>  sparse.1 |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> --- sprs-2018-0119.orig/sparse.1
> +++ sprs-2018-0119/sparse.1
> @@ -56,7 +56,7 @@ arithmetic operations other than bitwise
>  one restricted type into another, except via a cast that includes
>  \fB__attribute__((force))\fR.
>  
> -__bitwise ends up being a "stronger integer separation". That one
> +__bitwise ends up being a "stronger integer separation", one that
>  doesn't allow you to mix with non-bitwise integers, so now it's much
>  harder to lose the type by mistake.
>  
> @@ -204,7 +204,7 @@ Sparse issues these warnings by default.
>  .B \-Winit\-cstring
>  Warn about initialization of a char array with a too long constant C string.
>  
> -If the size of the char array and the length of the string is the same,
> +If the size of the char array and the length of the string are the same,
>  there is no space for the last nul char of the string in the array:
>  
>  .nf
> @@ -348,7 +348,7 @@ Warn about preprocessor conditionals tha
>  preprocessor symbol.
>  
>  Standard C (C99 6.10.1) permits using the value of an undefined preprocessor
> -symbol in preprocessor conditionals, and specifies it has have a value of 0.
> +symbol in preprocessor conditionals, and specifies it has a value of 0.
>  However, this behavior can lead to subtle errors.
>  
>  Sparse does not issue these warnings by default.
> @@ -368,7 +368,7 @@ normalized GNU triplet. (e.g. i386-linux
>  .TP
>  .B \-fdump-linearize[=only]
>  Dump the IR code of a function directly after its linearization,
> -before any simplifications is made. If the argument \fB=only\fR is
> +before any simplifications are made. If the argument \fB=only\fR is
>  also given no further processing is done on the function.
>  .
>  .B \-fmem-report
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sparse" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
