From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 1/3] sparse: Just use simple ints for decision variables
Date: Mon, 9 Jun 2014 06:27:59 -0700
Message-ID: <20140609132759.GA11986@thin>
References: <1402315082-14102-1-git-send-email-phil@dovecot.fi>
 <1402315082-14102-2-git-send-email-phil@dovecot.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:39051 "EHLO
	relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755585AbaFIN2I (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 9 Jun 2014 09:28:08 -0400
Content-Disposition: inline
In-Reply-To: <1402315082-14102-2-git-send-email-phil@dovecot.fi>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Phil Carmody <phil@dovecot.fi>
Cc: sparse@chrisli.org, linux-sparse@vger.kernel.org

On Mon, Jun 09, 2014 at 02:58:00PM +0300, Phil Carmody wrote:
> The expressions are just ints, and const is pointess.

"bool" actually seems more appropriate here.  As for the const, it
does in fact hold true, as neither changes afte rdeclaration; why not
keep it?

> Signed-off-by: Phil Carmody <phil@dovecot.fi>
> ---
>  evaluate.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/evaluate.c b/evaluate.c
> index 6655615..9052962 100644
> --- a/evaluate.c
> +++ b/evaluate.c
> @@ -917,10 +917,10 @@ static struct symbol *evaluate_binop(struct expression *expr)
>  			rtype = integer_promotion(rtype);
>  		} else {
>  			// The rest do usual conversions
> -			const unsigned left_not  = expr->left->type == EXPR_PREOP
> -			                           && expr->left->op == '!';
> -			const unsigned right_not = expr->right->type == EXPR_PREOP
> -			                           && expr->right->op == '!';
> +			int left_not  = expr->left->type == EXPR_PREOP
> +					&& expr->left->op == '!';
> +			int right_not = expr->right->type == EXPR_PREOP
> +			                && expr->right->op == '!';
>  			if ((op == '&' || op == '|') && (left_not || right_not))
>  				warning(expr->pos, "dubious: %sx %c %sy",
>  				        left_not ? "!" : "",
> -- 
> 2.0.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sparse" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
