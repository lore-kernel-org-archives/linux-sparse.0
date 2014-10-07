From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v2] sparse: Make -Werror turn warnigns into errors
Date: Tue, 7 Oct 2014 12:45:08 +0300
Message-ID: <20141007094508.GN23154@mwanda>
References: <795aaa7448d91bd59bcbea3d8e49b068a569409e.1411632579.git.tgraf@suug.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:42747 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753332AbaJGJpt (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 7 Oct 2014 05:45:49 -0400
Content-Disposition: inline
In-Reply-To: <795aaa7448d91bd59bcbea3d8e49b068a569409e.1411632579.git.tgraf@suug.ch>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Thomas Graf <tgraf@suug.ch>
Cc: linux-sparse@vger.kernel.org, sparse@chrisli.org

> diff --git a/cgcc b/cgcc
> index c075e5f..204bda3 100755
> --- a/cgcc
> +++ b/cgcc
> @@ -70,7 +70,7 @@ if ($do_check) {
>  
>      print "$check\n" if $verbose;
>      if ($do_compile) {
> -	system ($check);
> +	system ($check) == 0 or die;

This just enables -Werror for everyone so now I can't run Sparse on
itself now because there are old errors from 2007.

lib.c:192:6: error: symbol 'error_die' redeclared with different type (originally declared at lib.h:97) - different modifiers
lib.c:201:6: error: symbol 'die' redeclared with different type (originally declared at lib.h:93) - different modifiers

Btw, these errors also disable warnings for the rest of the file...  I
don't think just because there are different modifiers it means that
we should give up looking for other warnings.  In the kernel we miss
some endian bugs because of this.

regards,
dan carpenter

