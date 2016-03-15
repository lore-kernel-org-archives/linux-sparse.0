From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v3 09/21] evaluate: check static storage duration
 objects' intializers' constness
Date: Tue, 15 Mar 2016 18:28:35 +0100
Message-ID: <20160315172834.GH1283@macpro.local>
References: <87lh75jh9l.fsf@gmail.com>
 <87io29i2ap.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35267 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934777AbcCOR2k (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 15 Mar 2016 13:28:40 -0400
Received: by mail-wm0-f52.google.com with SMTP id l68so159756994wml.0
        for <linux-sparse@vger.kernel.org>; Tue, 15 Mar 2016 10:28:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87io29i2ap.fsf@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Nicolai Stange <nicstange@gmail.com>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>

On Mon, Feb 01, 2016 at 03:37:18AM +0100, Nicolai Stange wrote:
> Initializers of static storage duration objects shall be constant
> expressions [6.7.8(4)].
> 
> Warn if that requirement is not met and the -Wstatic-initializer-not-const
> flag has been given on sparse's command line.


"-Wstatic-initializer-not-const" s not what is used further in the code.

Also, I think it should be better to introduce this new -W flag in a separate
patch.
 
> Identify static storage duration objects by having either of
> MOD_TOPLEVEL or MOD_STATIC set.
> 
> Check an initializer's constness at the lowest possible subobject
> level, i.e. at the level of the "assignment-expression" production
> in [6.7.8].
> 
> For compound objects, make handle_list_initializer() pass the
> surrounding object's storage duration modifiers down to
> handle_simple_initializer() at subobject initializer evaluation.
> 
> Signed-off-by: Nicolai Stange <nicstange@gmail.com>
> ---
> diff --git a/evaluate.c b/evaluate.c
> index dd44cd5..300bfbe 100644
> --- a/evaluate.c
> +++ b/evaluate.c
> @@ -2509,8 +2510,21 @@ found:
>  		else
>  			v = &top->ident_expression;
>  
> -		if (handle_simple_initializer(v, 1, lclass, top->ctype))
> +		/*
> +		 * Temporarily copy storage modifiers down from
> +		 * surrounding type such that
> +		 * handle_simple_initializer() can check
> +		 * initializations of subobjects with static storage
> +		 * duration.
> +		 */
> +		old_modifiers = top->ctype->ctype.modifiers;
> +		top->ctype->ctype.modifiers =
> +			old_modifiers | (ctype->ctype.modifiers & MOD_STORAGE);
> +		if (handle_simple_initializer(v, 1, lclass, top->ctype)) {
> +			top->ctype->ctype.modifiers = old_modifiers;
>  			continue;
> +		}
> +		top->ctype->ctype.modifiers = old_modifiers;

This saving/restoring of the modifiers is not very nice.
Hadn't we talked about adding an arg to handle_simple_initializer() or so?
  
>  		if (!(lclass & TYPE_COMPOUND)) {
>  			warning(e->pos, "bogus scalar initializer");
> @@ -2620,6 +2634,16 @@ static int handle_simple_initializer(struct expression **ep, int nested,
>  		if (!evaluate_expression(e))
>  			return 1;
>  		compatible_assignment_types(e, ctype, ep, "initializer");
> +		/*
> +		 * Initializers for static storage duration objects
> +		 * shall be constant expressions or a string literal [6.7.8(4)].
> +		 */
> +		if ((ctype->ctype.modifiers & (MOD_TOPLEVEL | MOD_STATIC)) &&
> +			!(e->constexpr_flags & (CONSTEXPR_FLAG_ARITH_CONST_EXPR
> +					| CONSTEXPR_FLAG_ADDR_CONST)) &&
> +			Wconstexpr_not_const)

This last line whould be more indented, maybe like the previous line.

> +			warning(e->pos, "non-constant initializer for static object");
> +
>  		return 1;
>  	}
>  
> diff --git a/lib.c b/lib.c
> index 8dc5bcf..75cea42 100644
> --- a/lib.c
> +++ b/lib.c
> @@ -219,6 +219,7 @@ int Waddress_space = 1;
>  int Wbitwise = 0;
>  int Wcast_to_as = 0;
>  int Wcast_truncate = 1;
> +int Wconstexpr_not_const = 0;


This name is quite good.


