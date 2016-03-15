From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v3 16/21] expression: examine constness of
 __builtin_offsetof at evaluation only
Date: Tue, 15 Mar 2016 20:52:46 +0100
Message-ID: <20160315195245.GS1283@macpro.local>
References: <87lh75jh9l.fsf@gmail.com>
 <87oac1gngs.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:38224 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934911AbcCOTwv (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 15 Mar 2016 15:52:51 -0400
Received: by mail-wm0-f51.google.com with SMTP id l68so42329307wml.1
        for <linux-sparse@vger.kernel.org>; Tue, 15 Mar 2016 12:52:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87oac1gngs.fsf@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Nicolai Stange <nicstange@gmail.com>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>

On Mon, Feb 01, 2016 at 03:42:59AM +0100, Nicolai Stange wrote:
> Currently, the determination of a __builtin_offsetof() expressions'
> constness flags is done in two steps:
> - Several flags are speculatively set at expression parsing time
> - and possibly cleared again at evaluation if the member expression
>   includes a non-const array index like in
>     __builtin_offsetof(struct A, a.b[non_const_foo])
> 
> For consistency with other expression types' evaluation, defer the
> determination of a __builtin_offsetof() expression's constness to
> evaluation time, too.

I don't think that consistency is the good/real reason,
you're doing it for the same reason as the others: so that
the expression is recognized as an integer constant expression.
 
> Furthermore, carry an array index expression's constness flags
> through the implicit cast to size_t type.
> 
> Signed-off-by: Nicolai Stange <nicstange@gmail.com>
> ---
> diff --git a/evaluate.c b/evaluate.c
> index 7a4af39..0101e61 100644
> --- a/evaluate.c
> +++ b/evaluate.c
> @@ -3031,25 +3031,29 @@ static struct symbol *evaluate_offsetof(struct expression *expr)
>  		} else {
>  			struct expression *idx = expr->index, *m;
>  			struct symbol *i_type = evaluate_expression(idx);
> +			unsigned old_idx_flags;
>  			int i_class = classify_type(i_type, &i_type);
> +
>  			if (!is_int(i_class)) {
>  				expression_error(expr, "non-integer index");
>  				return NULL;
>  			}
>  			unrestrict(idx, i_class, &i_type);
> +			old_idx_flags = idx->constexpr_flags;
>  			idx = cast_to(idx, size_t_ctype);
> +			idx->constexpr_flags = old_idx_flags;

This saving/restoring of teh flags is annoying.
Why is it needed? Can it be solved in another way?

