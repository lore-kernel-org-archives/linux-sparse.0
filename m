From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 2/3] sparse: detect non-sign-extended masks created by '~'
Date: Mon, 9 Jun 2014 06:34:24 -0700
Message-ID: <20140609133424.GB11986@thin>
References: <1402315082-14102-1-git-send-email-phil@dovecot.fi>
 <1402315082-14102-2-git-send-email-phil@dovecot.fi>
 <1402315082-14102-3-git-send-email-phil@dovecot.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:33677 "EHLO
	relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932657AbaFINed (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 9 Jun 2014 09:34:33 -0400
Content-Disposition: inline
In-Reply-To: <1402315082-14102-3-git-send-email-phil@dovecot.fi>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Phil Carmody <phil@dovecot.fi>
Cc: sparse@chrisli.org, linux-sparse@vger.kernel.org

On Mon, Jun 09, 2014 at 02:58:01PM +0300, Phil Carmody wrote:
> Consider the operation of rounding up to the nearest multiple of a power of 2.
> e.g.  #define ALLOC_SIZE(t) ((sizeof(t) + ASIZE - 1) & ~(ASIZE - 1))
> 
> If ASIZE is unfortunately defined as an unsigned type smaller than size_t,
> then the ~ will not undergo sign-bit extension, and the incorrect mask will
> be used. If used in a memory allocation context this could be fatal.
> 
> Warn about such dubious 'large op ~short' usage.
> 
> Signed-off-by: Phil Carmody <phil@dovecot.fi>
> ---
>  evaluate.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/evaluate.c b/evaluate.c
> index 9052962..c0f3c91 100644
> --- a/evaluate.c
> +++ b/evaluate.c
> @@ -189,6 +189,14 @@ left:
>  	return left;
>  }
>  
> +static int is_bigger_int_type(struct symbol *left, struct symbol *right)
> +{
> +	left = integer_promotion(left);
> +	right = integer_promotion(right);
> +
> +	return (left->bit_size > right->bit_size);
> +}
> +
>  static int same_cast_type(struct symbol *orig, struct symbol *new)
>  {
>  	return orig->bit_size == new->bit_size &&
> @@ -927,6 +935,19 @@ static struct symbol *evaluate_binop(struct expression *expr)
>  					op,
>  					right_not ? "!" : "");
>  
> +			left_not  = expr->left->type == EXPR_PREOP
> +					&& expr->left->op == '~';
> +			right_not = expr->right->type == EXPR_PREOP
> +			                && expr->right->op == '~';

Ah, now I see why you wanted these to not use "const".  Fair enough.
"bool" still seems like the right type, though.

> +			if ((left_not && is_bigger_int_type(rtype, ltype)
> +			     && (ltype->ctype.modifiers & MOD_UNSIGNED)) ||
> +			    (right_not && is_bigger_int_type(ltype, rtype)
> +			     && (rtype->ctype.modifiers & MOD_UNSIGNED)))

You might consider wrapping the common expression here, along with the
corresponding previous _not expression, into a function, and then
calling it twice, flipping the arguments around for the second call.

> +				warning(expr->pos, "dubious: %sx %c %sy",
> +				        left_not ? "~" : "",
> +					op,
> +					right_not ? "~" : "");

What happens here if left_not && right_not?  Should this warning still
occur?  I *think* it still makes sense for it to, but the warning
message might prove less informative.

> +
>  			ltype = usual_conversions(op, expr->left, expr->right,
>  						  lclass, rclass, ltype, rtype);
>  			ctype = rtype = ltype;
