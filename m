From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 1/2] Add warning about duplicate initializers
Date: Sun, 30 Mar 2014 13:37:40 -0700
Message-ID: <20140330203740.GA27368@leaf>
References: <alpine.LFD.2.11.1403301018060.16237@i7.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:40918 "EHLO
	relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752054AbaC3Uhs (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 30 Mar 2014 16:37:48 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.11.1403301018060.16237@i7.linux-foundation.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christopher Li <sparse@chrisli.org>, Hans Verkuil <hverkuil@xs4all.nl>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Mar 30, 2014 at 10:20:41AM -0700, Linus Torvalds wrote:
> 
> From: Linus Torvalds <torvalds@linux-foundation.org>
> Date: Sun, 30 Mar 2014 09:49:13 -0700
> Subject: [PATCH 1/2] Add warning about duplicate initializers
> 
> Noticed this while looking at an independent bug reported by Hans
> Verkuil.
> 
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

Reviewed-by: Josh Triplett <josh@joshtriplett.org>

> 
> This is not a big deal, but the next patch will make us take the array 
> size from any initializer, so let's warn on multiple initializers.
> 
>  evaluate.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/evaluate.c b/evaluate.c
> index 66556150ddac..8a53b3e884e0 100644
> --- a/evaluate.c
> +++ b/evaluate.c
> @@ -3043,10 +3043,18 @@ static void check_duplicates(struct symbol *sym)
>  {
>  	int declared = 0;
>  	struct symbol *next = sym;
> +	int initialized = sym->initializer != NULL;
>  
>  	while ((next = next->same_symbol) != NULL) {
>  		const char *typediff;
>  		evaluate_symbol(next);
> +		if (initialized && next->initializer) {
> +			sparse_error(sym->pos, "symbol '%s' has multiple initializers (originally initialized at %s:%d)",
> +				show_ident(sym->ident),
> +				stream_name(next->pos.stream), next->pos.line);
> +			/* Only warn once */
> +			initialized = 0;
> +		}
>  		declared++;
>  		typediff = type_difference(&sym->ctype, &next->ctype, 0, 0);
>  		if (typediff) {
> -- 
> 1.9.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sparse" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
