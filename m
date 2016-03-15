From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v3 18/21] evaluate: relax some constant expression rules
 for pointer expressions
Date: Tue, 15 Mar 2016 19:10:41 +0100
Message-ID: <20160315181040.GP1283@macpro.local>
References: <87lh75jh9l.fsf@gmail.com>
 <87fuxdgne1.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:37020 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932212AbcCOSKq (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 15 Mar 2016 14:10:46 -0400
Received: by mail-wm0-f51.google.com with SMTP id p65so38713182wmp.0
        for <linux-sparse@vger.kernel.org>; Tue, 15 Mar 2016 11:10:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87fuxdgne1.fsf@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Nicolai Stange <nicstange@gmail.com>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>

On Mon, Feb 01, 2016 at 03:44:38AM +0100, Nicolai Stange wrote:
> The official constraints on constant expressions [6.6] are insanely
> strict in that they do not allow some constructs commonly used in the
> wild.
> 
> Relax them by treating
> - address constants cast to different pointer type as address constants
>   again,
> - address constants cast to arithmetic type as arithmetic constant
>   expressions
> - conditional expressions whose true and false branches both yield
>   address constants as address constants,
> - and conditional expressions whose condition is an address constant
>   as an constant expression to the extent their true and false branches
>   allow.
> 
> Signed-off-by: Nicolai Stange <nicstange@gmail.com>
> ---
> diff --git a/evaluate.c b/evaluate.c
> index 0101e61..ff51d84 100644
> --- a/evaluate.c
> +++ b/evaluate.c
> @@ -1129,14 +1129,23 @@ static struct symbol *evaluate_conditional_expression(struct expression *expr)
 ...
>  	 * A conditional operator never yields an address constant
>  	 * [6.6(9)].
> +	 * However, as an extension, if the condition is any constant
> +	 * expression, and the true and false expressions are both
> +	 * address constants, mark the result as an address constant.
>  	 */

The comment make perfect sense in the patch serie because it explain exactly
what the incremental patch is doing.
But once the patch is applied it's not what the code is really doing:
	the result is not marked as an address constant,
	it's only not unmarked anymore.
So, I think it's better to restrict it to something like:
	However as an extension also accept address constant.

> -	expr->constexpr_flags = (expr->conditional->constexpr_flags &
> -				(*true)->constexpr_flags &
> -				expr->cond_false->constexpr_flags &
> -				~CONSTEXPR_FLAG_DECAY_CONSTS_MASK &
> -				~CONSTEXPR_FLAG_ADDR_CONST);
> +	if (expr->conditional->constexpr_flags &
> +		(CONSTEXPR_FLAG_ARITH_CONST_EXPR | CONSTEXPR_FLAG_ADDR_CONST))

The 'if' expression could be simplified (!CONSTEXPR_FLAG_NON)

> +		expr->constexpr_flags = (*true)->constexpr_flags &
> +			expr->cond_false->constexpr_flags &
> +			~CONSTEXPR_FLAG_DECAY_CONSTS_MASK;
>  
>  	lclass = classify_type(ltype, &ltype);
>  	rclass = classify_type(rtype, &rtype);
