From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH] Update maintainers in the manpage
Date: Wed, 7 Dec 2016 21:43:44 -0800
Message-ID: <20161208054343.vvmc2nfruwy53dez@x>
References: <20160111192813.GA27713@cloud>
 <20161208044856.14476-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:48262 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752029AbcLHFnv (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 8 Dec 2016 00:43:51 -0500
Content-Disposition: inline
In-Reply-To: <20161208044856.14476-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Nicolai Stange <nicstange@gmail.com>

On Thu, Dec 08, 2016 at 05:48:56AM +0100, Luc Van Oostenryck wrote:
> The manpage still mentioned Josh Triplett as the maintainer
> while Christopher is the maintainer since 2009.
> 
> CC: Christopher Li <sparse@chrisli.org>
> CC: Josh Triplett <josh@joshtriplett.org>
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Reviewed-by: Josh Triplett <josh@joshtriplett.org>

>  sparse.1 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sparse.1 b/sparse.1
> index ccae55cc..4aeb0039 100644
> --- a/sparse.1
> +++ b/sparse.1
> @@ -364,4 +364,4 @@ https://sparse.wiki.kernel.org/
>  linux-sparse@vger.kernel.org
>  .
>  .SH MAINTAINER
> -Josh Triplett <josh@kernel.org>
> +Christopher Li <sparse@chrisli.org>
> -- 
> 2.10.2
> 
