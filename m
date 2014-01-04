From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH] cgcc: Fix preprocessing of assembler files
Date: Sat, 4 Jan 2014 02:57:43 -0800
Message-ID: <20140104105743.GA5166@leaf>
References: <1388830848-2020-1-git-send-email-sw@weilnetz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:45704 "EHLO
	relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751302AbaADK5x (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 4 Jan 2014 05:57:53 -0500
Content-Disposition: inline
In-Reply-To: <1388830848-2020-1-git-send-email-sw@weilnetz.de>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Stefan Weil <sw@weilnetz.de>
Cc: linux-sparse@vger.kernel.org

On Sat, Jan 04, 2014 at 11:20:48AM +0100, Stefan Weil wrote:
> The old code does not preprocess assembler files when cgcc is called like
> this:
> 
> cgcc -E -o multiboot.asm multiboot.S
> 
> As the preprocessor is not called, no multiboot.asm is generated, and any
> further build steps which need it will fail.
> 
> Fix this by using a new intermediate variable $do_preprocess.
> 
> Signed-off-by: Stefan Weil <sw@weilnetz.de>

Seems reasonable.
Reviewed-by: Josh Triplett <josh@joshtriplett.org>

> 
> This patch allows using cgcc for QEMU builds. I did not run any other tests,
> so please review carefully.
> 
> Thanks,
> Stefan Weil
> 
>  cgcc |    9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/cgcc b/cgcc
> index c075e5f..a43e074 100755
> --- a/cgcc
> +++ b/cgcc
> @@ -10,6 +10,7 @@ my $has_specs = 0;
>  my $gendeps = 0;
>  my $do_check = 0;
>  my $do_compile = 1;
> +my $do_preprocess = 0;
>  my $gcc_base_dir;
>  my $verbose = 0;
>  
> @@ -44,8 +45,7 @@ while (@ARGV) {
>          next;
>      }
>  
> -    # If someone adds "-E", don't pre-process twice.
> -    $do_compile = 0 if $_ eq '-E';
> +    $do_preprocess = 1 if $_ eq '-E';
>  
>      $verbose = 1 if $_ eq '-v';
>  
> @@ -59,6 +59,11 @@ if ($gendeps) {
>      $do_check = 0;
>  }
>  
> +if ($do_check && $do_preprocess) {
> +    # If someone adds "-E", don't pre-process twice.
> +    $do_compile = 0;
> +}
> +
>  if ($do_check) {
>      if (!$has_specs) {
>  	$check .= &add_specs ('host_arch_specs');
> -- 
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sparse" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
