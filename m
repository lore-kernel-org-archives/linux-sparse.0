From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v1 03/28] misc: always use the node for current_fn
Date: Wed, 20 May 2020 01:37:03 +0100
Message-ID: <0883c784-5ad0-e536-239e-6ed086cf624d@ramsayjones.plus.com>
References: <20200519005728.84594-1-luc.vanoostenryck@gmail.com>
 <20200519005728.84594-4-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from avasout02.plus.net ([212.159.14.17]:60705 "EHLO
        avasout02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgETAhG (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 19 May 2020 20:37:06 -0400
In-Reply-To: <20200519005728.84594-4-luc.vanoostenryck@gmail.com>
Content-Language: en-GB
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>



On 19/05/2020 01:57, Luc Van Oostenryck wrote:
> At evaluation time and at expansion time, current_fn is set
> to the function's base type (SYM_FN) but at parse time it's
> set to its parent type (SYM_NODE).
> 
> Since current_fn is used to access the corresponding ident,
> it should be set to the node type, not the base.
> 
> So, always set current_fn to the node type.
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  evaluate.c | 4 ++--
>  expand.c   | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/evaluate.c b/evaluate.c
> index 54cd5fa136e6..c18ae81df5ad 100644
> --- a/evaluate.c
> +++ b/evaluate.c
> @@ -3422,7 +3422,7 @@ static struct symbol *evaluate_symbol(struct symbol *sym)
>  		if (sym->definition && sym->definition != sym)
>  			return evaluate_symbol(sym->definition);
>  
> -		current_fn = base_type;
> +		current_fn = sym;
>  
>  		examine_fn_arguments(base_type);
>  		if (!base_type->stmt && base_type->inline_stmt)
> @@ -3453,7 +3453,7 @@ static struct symbol *evaluate_return_expression(struct statement *stmt)
>  	struct symbol *fntype, *rettype;
>  
>  	evaluate_expression(expr);
> -	fntype = current_fn;
> +	fntype = current_fn->ctype.base_type;

Ah, OK, question answered!

ATB,
Ramsay Jones

>  	rettype = fntype->ctype.base_type;
>  	if (!rettype || rettype == &void_ctype) {
>  		if (expr && expr->ctype != &void_ctype)
> diff --git a/expand.c b/expand.c
> index e75598781b6c..ab296c730efd 100644
> --- a/expand.c
> +++ b/expand.c
> @@ -918,7 +918,7 @@ static int expand_symbol_call(struct expression *expr, int cost)
>  			struct symbol *fn = def->ctype.base_type;
>  			struct symbol *curr = current_fn;
>  
> -			current_fn = fn;
> +			current_fn = def;
>  			evaluate_statement(expr->statement);
>  			current_fn = curr;
>  
> 
