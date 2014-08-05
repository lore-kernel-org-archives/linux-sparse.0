From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH] parse.c: remove duplicate 'may_alias' ignored_attributes
Date: Tue, 5 Aug 2014 09:43:49 -0700
Message-ID: <20140805164348.GC3146@thin>
References: <53DFE6A5.2070903@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:49480 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755181AbaHEQn5 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 5 Aug 2014 12:43:57 -0400
Content-Disposition: inline
In-Reply-To: <53DFE6A5.2070903@ramsay1.demon.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Cc: Christopher Li <sparse@chrisli.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Mon, Aug 04, 2014 at 09:01:41PM +0100, Ramsay Jones wrote:
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>

Reviewed-by: Josh Triplett <josh@joshtriplett.org>

Ironic attribute to duplicate.  Apparently may_alias may alias.

> Hi Chris,
> 
> I noticed this recently when rebasing an old branch, but forgot
> to write a patch.
> 
> ATB,
> Ramsay Jones
> 
>  parse.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/parse.c b/parse.c
> index 69bcf82..471fb31 100644
> --- a/parse.c
> +++ b/parse.c
> @@ -548,8 +548,6 @@ const char *ignored_attributes[] = {
>  	"__l1_data__",
>  	"l2",
>  	"__l2__",
> -	"may_alias",
> -	"__may_alias__",
>  	"malloc",
>  	"__malloc__",
>  	"may_alias",
> -- 
> 2.0.0
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sparse" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
