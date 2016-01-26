From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v2 06/13] expression, evaluate: add support for
 recognizing address constants
Date: Tue, 26 Jan 2016 02:27:12 +0100
Message-ID: <20160126012711.GD46188@macpro.local>
References: <87twm1g1go.fsf@gmail.com>
 <874me1g12g.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33126 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932727AbcAZB1Q (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 25 Jan 2016 20:27:16 -0500
Received: by mail-wm0-f68.google.com with SMTP id u188so14572611wmu.0
        for <linux-sparse@vger.kernel.org>; Mon, 25 Jan 2016 17:27:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <874me1g12g.fsf@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Nicolai Stange <nicstange@gmail.com>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>

On Mon, Jan 25, 2016 at 03:56:23PM +0100, Nicolai Stange wrote:
> Address constants [6.6(9)] constitute one of the types of constant
> expressions allowed in initializers [6.6(7)] for static storage
> duration objects [6.7.8(4)].
> 
> Introduce support for recognizing address constants created either
> - explicitly by referencing a static storage duration object by means
>   of the unary & operator
> - or implicitly by the use of an expression of array or function type.
> 
> Treat string literals as address constants.
> 
> Initially tag an expression as being an address constant at the
> primary expression level, i.e. upon encountering a symbol designating
> an object of static storage duration in primary_expression().
> 
> Carry these flags over to the *-preop wrapped expression created by
> evaluate_symbol_expression().
> 
> For the special case of string literals, tag them as address constants
> in evaluate_string().
> 
> Take care in evaluate_ptr_add() and evaluate_offset()
> to properly propagate the address constness flags from
> subexpressions to their parent expressions, namely the array ([])
> or structure member dereference (->, .) expressions.
> 
> Finally, do not strip away an *-preop wrapped expression's constness
> flags in evaluate_addressof().

There is two much thing in the description, this is a sure sign that the patch
should be splitted, like putting the part concerning strings in a separate one.

> @@ -1678,7 +1689,6 @@ static struct symbol *evaluate_addressof(struct expression *expr)
>  	}
>  	ctype = op->ctype;
>  	*expr = *op->unop;
> -	expr->flags = EXPR_FLAG_NONE;

Is this because it's already initialized so by the allocator?
if so, it can be moved to the patch that add this initialization
(because it's unrelated to the current change).


Good otherwise.


Luc
