From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v3 11/21] evaluate: recognize address constants created
 through casts
Date: Tue, 15 Mar 2016 18:44:56 +0100
Message-ID: <20160315174455.GJ1283@macpro.local>
References: <87lh75jh9l.fsf@gmail.com>
 <87a8nli27m.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:38814 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839AbcCORpB (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 15 Mar 2016 13:45:01 -0400
Received: by mail-wm0-f47.google.com with SMTP id l68so37655149wml.1
        for <linux-sparse@vger.kernel.org>; Tue, 15 Mar 2016 10:45:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87a8nli27m.fsf@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Nicolai Stange <nicstange@gmail.com>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>

On Mon, Feb 01, 2016 at 03:39:09AM +0100, Nicolai Stange wrote:
> According to 6.6(9), an address constant may get created by casting
> an integer constant to pointer type.
> 
> Make evaluate_cast() handle this case, that is tag a cast expression
> as being an address constant if the target is a integer constant and
> the destination is of pointer type.
> 
> Signed-off-by: Nicolai Stange <nicstange@gmail.com>
> ---
>  evaluate.c                          | 10 +++++++++-
>  validation/constexpr-pointer-cast.c | 13 +++++++++++++
>  2 files changed, 22 insertions(+), 1 deletion(-)
>  create mode 100644 validation/constexpr-pointer-cast.c
> 
> diff --git a/evaluate.c b/evaluate.c
> index 91f89f4..a740474 100644
> --- a/evaluate.c
> +++ b/evaluate.c
> @@ -2767,7 +2767,15 @@ static struct symbol *evaluate_cast(struct expression *expr)
>  
>  	class1 = classify_type(ctype, &t1);
>  
> -	if (class1 & TYPE_NUM) {
> +	if (!(class1 & TYPE_NUM)) {
> +		/*
> +		 * Casts of integer literals to pointer type yield
> +		 * address constants [6.6(9)].
> +		 */
> +		if (class1 & TYPE_PTR &&

Better put "class1 & TYPE_PTR" between parenthesis.

> +			(target->constexpr_flags & CONSTEXPR_FLAG_INT_CONST))
> +			expr->constexpr_flags = CONSTEXPR_FLAG_ADDR_CONST;
> +	} else {

I would have put as the else clause instead of changing the condition.
Not that it really matters though.

