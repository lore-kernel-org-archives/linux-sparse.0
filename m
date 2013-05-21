From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 2/5] Add support for the MinGW platform
Date: Tue, 21 May 2013 15:09:07 -0700
Message-ID: <20130521220907.GE11463@jtriplet-mobl1>
References: <519BC816.3000304@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:60314 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751724Ab3EUWJO (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 21 May 2013 18:09:14 -0400
Content-Disposition: inline
In-Reply-To: <519BC816.3000304@ramsay1.demon.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Cc: Christopher Li <sparse@chrisli.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Tue, May 21, 2013 at 08:16:38PM +0100, Ramsay Jones wrote:
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>

I believe this will match both 32-bit and 64-bit MinGW, which seems
wrong.  Please do check the architecture strings for 32-bit and 64-bit
MinGW, and handle them separately.

> ---
>  cgcc | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/cgcc b/cgcc
> index c075e5f..e94a965 100755
> --- a/cgcc
> +++ b/cgcc
> @@ -226,6 +226,19 @@ sub add_specs {
>  	    ' -D__OpenBSD__=1';
>      } elsif ($spec eq 'unix') {
>  	return ' -Dunix=1 -D__unix=1 -D__unix__=1';
> +    } elsif ($spec =~ /^mingw/) {
> +	return ' -isystem /mingw/include' .
> +	    ' -D__MINGW32__=1' .
> +	    ' -D__MSVCRT__=1' .
> +	    ' -DWIN32=1 -D_WIN32=1 -D__WIN32=1 -D__WIN32__=1' .
> +	    ' -DWINNT=1 -D__WINNT=1 -D__WINNT__=1' .
> +	    " -D'_cdecl=__attribute__((__cdecl__))'" .
> +	    " -D'__cdecl=__attribute__((__cdecl__))'" .
> +	    " -D'_stdcall=__attribute__((__stdcall__))'" .
> +	    " -D'__stdcall=__attribute__((__stdcall__))'" .
> +	    " -D'_fastcall=__attribute__((__fastcall__))'" .
> +	    " -D'__fastcall=__attribute__((__fastcall__))'" .
> +	    " -D'__declspec(x)=__attribute__((x))'";
>      } elsif ( $spec =~ /^cygwin/) {
>  	return &add_specs ('unix') .
>  	    ' -D__CYGWIN__=1 -D__CYGWIN32__=1' .
> -- 
> 1.8.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sparse" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
