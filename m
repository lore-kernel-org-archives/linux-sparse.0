From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 1/2] linearize: Emit C99 declarations correctly
Date: Wed, 2 Nov 2016 14:57:55 +0100
Message-ID: <20161102135754.GA9029@macpro.local>
References: <1462365584-20536-1-git-send-email-emily@emilymaier.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35018 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751573AbcKBN57 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 2 Nov 2016 09:57:59 -0400
Received: by mail-wm0-f67.google.com with SMTP id 68so3214181wmz.2
        for <linux-sparse@vger.kernel.org>; Wed, 02 Nov 2016 06:57:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1462365584-20536-1-git-send-email-emily@emilymaier.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Emily Maier <emily@emilymaier.net>
Cc: linux-sparse@vger.kernel.org

On Wed, May 04, 2016 at 08:39:43AM -0400, Emily Maier wrote:
> Variables declared with C99 syntax inside a for statement should be
> linearized in the loop top, rather than implicitly inside the loop body.
> 
> Signed-off-by: Emily Maier <emily@emilymaier.net>
> ---
>  linearize.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/linearize.c b/linearize.c
> index c6ada1e..1309c7d 100644
> --- a/linearize.c
> +++ b/linearize.c
> @@ -1946,7 +1946,11 @@ static pseudo_t linearize_iterator(struct entrypoint *ep, struct statement *stmt
>  	struct statement  *post_statement = stmt->iterator_post_statement;
>  	struct expression *post_condition = stmt->iterator_post_condition;
>  	struct basic_block *loop_top, *loop_body, *loop_continue, *loop_end;
> +	struct symbol *sym;
>  
> +	FOR_EACH_PTR(stmt->iterator_syms, sym) {
> +		linearize_one_symbol(ep, sym);
> +	} END_FOR_EACH_PTR(sym);
>  	concat_symbol_list(stmt->iterator_syms, &ep->syms);
>  	linearize_statement(ep, pre_statement);
>  
> -- 

Interesting catch!

Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Tested-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
