From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v2 03/13] expression: examine constness of binops and
 alike at evaluation only
Date: Tue, 26 Jan 2016 01:59:32 +0100
Message-ID: <20160126005931.GA46188@macpro.local>
References: <87twm1g1go.fsf@gmail.com>
 <87h9i1g19d.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35547 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755337AbcAZA7g (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 25 Jan 2016 19:59:36 -0500
Received: by mail-wm0-f67.google.com with SMTP id 123so14502200wmz.2
        for <linux-sparse@vger.kernel.org>; Mon, 25 Jan 2016 16:59:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <87h9i1g19d.fsf@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Nicolai Stange <nicstange@gmail.com>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>

On Mon, Jan 25, 2016 at 03:52:14PM +0100, Nicolai Stange wrote:
> @@ -1001,11 +996,9 @@ static struct symbol *evaluate_compare(struct expression *expr)
>  	struct symbol *ctype;
>  	const char *typediff;
>  
> -	if (expr->flags) {
> -		if (!(expr->left->flags & expr->right->flags &
> -				EXPR_FLAG_INT_CONST_EXPR))
> -			expr->flags = EXPR_FLAG_NONE;
> -	}
> +	expr->flags = left->flags & right->flags;
> +	expr_flags_decay_consts(&expr->flags);
> +	expr_clear_flag(&expr->flags, EXPR_FLAG_ADDR_CONST_EXPR);

Related to the [0 < 0.0] test case, shouldn't this be (re) done after
the call to usual_conversions() ?


Luc
