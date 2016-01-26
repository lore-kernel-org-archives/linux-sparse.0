From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v2 09/13] expression: examine constness of
 __builtin_offsetof at evaluation only
Date: Tue, 26 Jan 2016 02:57:09 +0100
Message-ID: <20160126015708.GG46188@macpro.local>
References: <87twm1g1go.fsf@gmail.com>
 <87r3h5eman.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36287 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756407AbcAZB5M (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 25 Jan 2016 20:57:12 -0500
Received: by mail-wm0-f68.google.com with SMTP id l65so14644457wmf.3
        for <linux-sparse@vger.kernel.org>; Mon, 25 Jan 2016 17:57:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <87r3h5eman.fsf@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Nicolai Stange <nicstange@gmail.com>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>

On Mon, Jan 25, 2016 at 04:00:48PM +0100, Nicolai Stange wrote:
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
> 
> Furthermore, carry an array index expression's constness flags
> through the implicit cast to size_t type.

Better to split this into two patches.
 
> @@ -3028,13 +3026,18 @@ static struct symbol *evaluate_offsetof(struct expression *expr)
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
> +			old_idx_flags = idx->flags;
>  			idx = cast_to(idx, size_t_ctype);
> +			idx->flags |= old_idx_flags;
> +			expr_flags_decay_consts(&idx->flags);
>  			m = alloc_const_expression(expr->pos,
>  						   bits_to_bytes(ctype->bit_size));
>  			m->ctype = size_t_ctype;

It's not clear at all to me why this is needed.
Why cast_to() can't set itself the right value for idx->flags?


Luc
