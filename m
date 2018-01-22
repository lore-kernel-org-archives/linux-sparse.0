From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH] Documentation: editing fixes in test-suite
Date: Mon, 22 Jan 2018 07:31:18 -0800
Message-ID: <20180122153118.GA1233@localhost>
References: <5bf3731a-c3be-e94e-2aaf-4c443e6ed870@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:56840 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751191AbeAVPb0 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 22 Jan 2018 10:31:26 -0500
Content-Disposition: inline
In-Reply-To: <5bf3731a-c3be-e94e-2aaf-4c443e6ed870@infradead.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

On Sun, Jan 21, 2018 at 09:38:39PM -0800, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix typos, grammar, punctuation, and spelling in Documentation/test-suite.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> Cc: Josh Triplett <josh@joshtriplett.org>

Reviewed-by: Josh Triplett <josh@joshtriplett.org>

>  Documentation/test-suite |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> --- sprs-2018-0119.orig/Documentation/test-suite
> +++ sprs-2018-0119/Documentation/test-suite
> @@ -35,7 +35,7 @@ check-output-start / check-output-end (o
>  
>  check-output-ignore / check-error-ignore (optional)
>  	Don't check the expected output (stdout or stderr) of check-command
> -	(usefull when this output is not comparable or if you're only interested
> +	(useful when this output is not comparable or if you're only interested
>  	in the exit value).
>  	By default this check is done.
>  
> @@ -54,8 +54,8 @@ check-output-excludes: <pattern> (option
>  	must contains none of the patterns.
>  
>  check-output-pattern-<nbr>-times: <pattern> (optional)
> -	Similar than the contains/excludes her above, but with full control
> -	of the number of times the pattern should occurs in the output.
> +	Similar to the contains/excludes above, but with full control
> +	of the number of times the pattern should occur in the output.
>  
>  	Using test-suite
>  	~~~~~~~~~~~~~~~~
> @@ -84,7 +84,7 @@ cmd:
>  	"sparse $file".
>  
>  The output of the test-suite format command can be redirected into the
> -test case to create a test-suite formated file.
> +test case to create a test-suite formatted file.
>  
>  $ ./test-suite format bad-assignment.c Assignment >> bad-assignment.c
>  $ cat !$
> 
> 
