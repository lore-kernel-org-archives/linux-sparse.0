From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v2 06/13] expression, evaluate: add support for
 recognizing address constants
Date: Tue, 26 Jan 2016 04:10:49 +0100
Message-ID: <20160126031048.GL46188@macpro.local>
References: <87twm1g1go.fsf@gmail.com>
 <874me1g12g.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35665 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932582AbcAZDKx (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 25 Jan 2016 22:10:53 -0500
Received: by mail-wm0-f68.google.com with SMTP id 123so14900124wmz.2
        for <linux-sparse@vger.kernel.org>; Mon, 25 Jan 2016 19:10:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <874me1g12g.fsf@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Nicolai Stange <nicstange@gmail.com>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>

On Mon, Jan 25, 2016 at 03:56:23PM +0100, Nicolai Stange wrote:
> @@ -563,6 +566,14 @@ static struct symbol *evaluate_ptr_add(struct expression *expr, struct symbol *i
>  	classify_type(degenerate(expr->left), &ctype);
>  	base = examine_pointer_target(ctype);
>  
> +	/*
> +	 * An address constant +/- an integer constant expression
> +	 * yields an address constant again [6.6(7)].
> +	 */
> +	if((expr->left->flags & EXPR_FLAG_ADDR_CONST_EXPR) &&

Missing ' ' in 'if('

