From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v2 03/13] expression: examine constness of binops and
 alike at evaluation only
Date: Tue, 26 Jan 2016 01:14:14 +0100
Message-ID: <20160126001412.GA45368@macpro.local>
References: <87twm1g1go.fsf@gmail.com>
 <87h9i1g19d.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33861 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756071AbcAZAOS (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 25 Jan 2016 19:14:18 -0500
Received: by mail-wm0-f66.google.com with SMTP id b14so14357281wmb.1
        for <linux-sparse@vger.kernel.org>; Mon, 25 Jan 2016 16:14:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <87h9i1g19d.fsf@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Nicolai Stange <nicstange@gmail.com>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>

On Mon, Jan 25, 2016 at 03:52:14PM +0100, Nicolai Stange wrote:
> Currently, the propagation of expressions' constness flags through
> binary operations, compare and logical expressions is done in two
> steps:
> - Several flags are speculatively set at expression parsing time
> - and possibly cleared again at evaluation time.
> 
> Set aside this unfortunate split of code, the early propagation of
> constness flags is not able to recognize constant expressions such as
>   0 + __builtin_choose_expr(0, 0, 0)
>   0 < __builtin_choose_expr(0, 0, 0)
>   0 && __builtin_choose_expr(0, 0, 0)
> since the final expression to be thrown into the binop-like expression
> is known only after evaluation.
> 
> Move the whole calculation of binary operations', compare and logical
> expressions' constness flags to the evaluation phase.
> 
> Introduce support for tracking arithmetic constness propagation through
> binop-like expressions.

Same as previous patch regarding the description and splitness of the patch.
 
> @@ -893,14 +891,11 @@ static struct symbol *evaluate_binop(struct expression *expr)
>  	int rclass = classify_type(expr->right->ctype, &rtype);
>  	int op = expr->op;
>  
> -	if (expr->flags) {
> -		if (!(expr->left->flags & expr->right->flags &
> -				EXPR_FLAG_INT_CONST_EXPR))
> -			expr->flags = EXPR_FLAG_NONE;
> -	}
> -
>  	/* number op number */
>  	if (lclass & rclass & TYPE_NUM) {
> +		expr->flags = expr->left->flags & expr->right->flags;
> +		expr_flags_decay_consts(&expr->flags);
> +

What about expr->flags now if not TYPE_NUM?
Are we sure it's always initialized to NONE by the alloctor?

> diff --git a/validation/constexpr-binop.c b/validation/constexpr-binop.c
> @@ -0,0 +1,33 @@
> +static int a[] = {
> +	[0 + 0] = 0,						// OK
> +	[0 + 0.] = 0,						// KO
> +	[(void*)0 + 0] = 0,					// KO
> +	[0 + __builtin_choose_expr(0, 0, 0)] = 0,		// OK
> +	[0 + __builtin_choose_expr(0, 0., 0)] = 0,		// OK
> +	[0 + __builtin_choose_expr(0, 0, 0.)] = 0,		// KO
> +	[0 < 0] = 0,						// OK
> +	[0 < 0.] = 0,						// KO

It's not clear to me what the standrad says about this case.
What about the constness of 'usual artihmetic conversions' ?
Also GCC don't complain on this one.

> +	[0 && 0.] = 0,						// KO

Same here.


Luc
