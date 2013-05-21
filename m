From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 4/5] test-suite: Add -b option to ignore CR at eol on
 MinGW
Date: Tue, 21 May 2013 14:16:50 -0700
Message-ID: <20130521211650.GA11463@jtriplet-mobl1>
References: <519BC87D.5080002@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:38774 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751953Ab3EUVRC (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 21 May 2013 17:17:02 -0400
Content-Disposition: inline
In-Reply-To: <519BC87D.5080002@ramsay1.demon.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Cc: Christopher Li <sparse@chrisli.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Tue, May 21, 2013 at 08:18:21PM +0100, Ramsay Jones wrote:
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>

-b doesn't just ignore CR at end of line; it would also ignore changes
in the amount of whitespace elsewhere on the line.  You might consider
piping the input that has CRs through sed before storing it, to delete
the CR at end of line before comparing, instead.

> ---
>  validation/test-suite | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/validation/test-suite b/validation/test-suite
> index 3c011c6..ded93fc 100755
> --- a/validation/test-suite
> +++ b/validation/test-suite
> @@ -126,7 +126,7 @@ do_test()
>  	actual_exit_value=$?
>  
>  	for stream in output error; do
> -		diff -u "$file".$stream.expected "$file".$stream.got > "$file".$stream.diff
> +		diff -ub "$file".$stream.expected "$file".$stream.got > "$file".$stream.diff
>  		if [ "$?" -ne "0" ]; then
>  			error "actual $stream text does not match expected $stream text."
>  			error  "see $file.$stream.* for further investigation."
> -- 
> 1.8.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sparse" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
