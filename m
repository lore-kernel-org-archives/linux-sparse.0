From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v1 02/28] misc: s/fntype/rettype/
Date: Wed, 20 May 2020 01:35:13 +0100
Message-ID: <0556fd1c-566d-3b3a-d760-418fecf115c0@ramsayjones.plus.com>
References: <20200519005728.84594-1-luc.vanoostenryck@gmail.com>
 <20200519005728.84594-3-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from avasout02.plus.net ([212.159.14.17]:60631 "EHLO
        avasout02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbgETAfR (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 19 May 2020 20:35:17 -0400
In-Reply-To: <20200519005728.84594-3-luc.vanoostenryck@gmail.com>
Content-Language: en-GB
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>



On 19/05/2020 01:57, Luc Van Oostenryck wrote:
> In evaluate_return_expression(), it's checked if the type of
> the return statement match the function return type.
> 
> But, the variable used to hold this type is named 'fntype'
> which is slightly confusing.
> 
> So, rename the variable holding the return type to 'rettype'
> and only use 'fntype' for the one hoding the full function type.

s/hoding/holding/

> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  evaluate.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/evaluate.c b/evaluate.c
> index b7bb1f52aa91..54cd5fa136e6 100644
> --- a/evaluate.c
> +++ b/evaluate.c
> @@ -3450,13 +3450,14 @@ void evaluate_symbol_list(struct symbol_list *list)
>  static struct symbol *evaluate_return_expression(struct statement *stmt)
>  {
>  	struct expression *expr = stmt->expression;
> -	struct symbol *fntype;
> +	struct symbol *fntype, *rettype;
>  
>  	evaluate_expression(expr);
> -	fntype = current_fn->ctype.base_type;
> -	if (!fntype || fntype == &void_ctype) {
> +	fntype = current_fn;
> +	rettype = fntype->ctype.base_type;

So, do you need to keep the 'fntype' variable?

ATB,
Ramsay Jones

> +	if (!rettype || rettype == &void_ctype) {
>  		if (expr && expr->ctype != &void_ctype)
> -			expression_error(expr, "return expression in %s function", fntype?"void":"typeless");
> +			expression_error(expr, "return expression in %s function", rettype?"void":"typeless");
>  		if (expr && Wreturn_void)
>  			warning(stmt->pos, "returning void-valued expression");
>  		return NULL;
> @@ -3468,7 +3469,7 @@ static struct symbol *evaluate_return_expression(struct statement *stmt)
>  	}
>  	if (!expr->ctype)
>  		return NULL;
> -	compatible_assignment_types(expr, fntype, &stmt->expression, "return expression");
> +	compatible_assignment_types(expr, rettype, &stmt->expression, "return expression");
>  	return NULL;
>  }
>  
> 
