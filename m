From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v3 10/21] expression, evaluate: recognize static objects
 as address constants
Date: Tue, 15 Mar 2016 18:38:05 +0100
Message-ID: <20160315173804.GI1283@macpro.local>
References: <87lh75jh9l.fsf@gmail.com>
 <87egcxi28v.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:38638 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965132AbcCORiJ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 15 Mar 2016 13:38:09 -0400
Received: by mail-wm0-f41.google.com with SMTP id l68so37392580wml.1
        for <linux-sparse@vger.kernel.org>; Tue, 15 Mar 2016 10:38:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87egcxi28v.fsf@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Nicolai Stange <nicstange@gmail.com>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>

On Mon, Feb 01, 2016 at 03:38:24AM +0100, Nicolai Stange wrote:
> Introduce support for recognizing address constants created either
> - explicitly by referencing a static storage duration object by means
>   of the unary & operator,
> - implicitly by the use of an expression of array or function type.
> 
> Initially tag an expression as being an address constant at the primary
> expression level, i.e. upon encountering a symbol designating an object of
> static storage duration in primary_expression().
> 
> Carry the address constant flag over to the *-preop wrapped expression
> created by evaluate_symbol_expression().
> 
> When dereferencing such a *-preop wrapped expression, make
> evaluate_addressof() keep any address constant flag for the unwrapped
> expression.
> 
> Signed-off-by: Nicolai Stange <nicstange@gmail.com>
> ---
> diff --git a/evaluate.c b/evaluate.c
> index 300bfbe..91f89f4 100644
> --- a/evaluate.c
> +++ b/evaluate.c
> @@ -70,9 +70,11 @@ static struct symbol *evaluate_symbol_expression(struct expression *expr)
>  	addr->symbol = sym;
>  	addr->symbol_name = expr->symbol_name;
>  	addr->ctype = &lazy_ptr_ctype;	/* Lazy evaluation: we need to do a proper job if somebody does &sym */
> +	addr->constexpr_flags = expr->constexpr_flags;

I'm not sure to follow this one.
What are the possible value of expr->constexpr_flags at this point?


> diff --git a/expression.c b/expression.c
> index b2d5eb4..11fb9cd 100644
> --- a/expression.c
> +++ b/expression.c
> @@ -440,6 +440,14 @@ struct token *primary_expression(struct token *token, struct expression **tree)
>  		}
>  		expr->symbol_name = token->ident;
>  		expr->symbol = sym;
> +
> +		/*
> +		 * A pointer to an lvalue designating a static storage
> +		 * duration object is an address constant [6.6(9)].
> +		 */
> +		if(sym && (sym->ctype.modifiers & (MOD_TOPLEVEL | MOD_STATIC)))
> +			expr->constexpr_flags = CONSTEXPR_FLAG_ADDR_CONST;


Missing space after the 'if'

