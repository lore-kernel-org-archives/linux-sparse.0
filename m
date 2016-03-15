From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v3 02/21] expression: init constexpr_flags at expression
 allocation
Date: Tue, 15 Mar 2016 17:59:16 +0100
Message-ID: <20160315165915.GB1283@macpro.local>
References: <87lh75jh9l.fsf@gmail.com>
 <87d1shjh5y.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:37361 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964950AbcCOQ7i (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 15 Mar 2016 12:59:38 -0400
Received: by mail-wm0-f48.google.com with SMTP id p65so35926634wmp.0
        for <linux-sparse@vger.kernel.org>; Tue, 15 Mar 2016 09:59:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87d1shjh5y.fsf@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Nicolai Stange <nicstange@gmail.com>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>

On Mon, Feb 01, 2016 at 03:30:49AM +0100, Nicolai Stange wrote:
> Currently, the expression evaluation code explicitly opts out from
> constness at evaluation if certain criteria regarding the subexpressions
> are not matched.
> 
> Instead of this active opt-out, we want to have subexpression constness
> attributes to get propagated from child expressions to their parents in
> the future.
> 
> A prerequisite is that each expression's ->constexpr_flags is in a defined
> state at all times.
> 
> Set ->constexpr_flags to CONSTEXPR_FLAG_NONE at expression allocation time,
> i.e. in alloc_expression() as well as in alloc_const_expression().
> 
> Signed-off-by: Nicolai Stange <nicstange@gmail.com>
> ---
>  expression.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/expression.h b/expression.h
> index 3725a73..8a943a4 100644
> --- a/expression.h
> +++ b/expression.h
> @@ -255,6 +255,7 @@ static inline struct expression *alloc_expression(struct position pos, int type)
>  	struct expression *expr = __alloc_expression(0);
>  	expr->type = type;
>  	expr->pos = pos;
> +	expr->constexpr_flags = CONSTEXPR_FLAG_NONE;
>  	return expr;
>  }
>  
> @@ -265,6 +266,7 @@ static inline struct expression *alloc_const_expression(struct position pos, int
>  	expr->pos = pos;
>  	expr->value = value;
>  	expr->ctype = &int_ctype;
> +	expr->constexpr_flags = CONSTEXPR_FLAG_NONE;
>  	return expr;
>  }

Fine for me.

Feel free to add
  Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
