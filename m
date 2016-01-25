From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v2 01/13] expression: introduce additional expression
 constness tracking flags
Date: Mon, 25 Jan 2016 22:51:36 +0100
Message-ID: <20160125215135.GC43341@macpro.local>
References: <87twm1g1go.fsf@gmail.com>
 <87powpg1dz.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36614 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751259AbcAYVvk (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 25 Jan 2016 16:51:40 -0500
Received: by mail-wm0-f67.google.com with SMTP id l65so13822687wmf.3
        for <linux-sparse@vger.kernel.org>; Mon, 25 Jan 2016 13:51:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <87powpg1dz.fsf@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Nicolai Stange <nicstange@gmail.com>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>

On Mon, Jan 25, 2016 at 03:49:28PM +0100, Nicolai Stange wrote:
> Prepare for a more fine-grained tracking of expression constness in the
> sense of C99 [6.4.4, 6.6].

This part could be moved at the end of the patch description
> User-visible behaviour remains unchanged.
> 
> The current implementation tags an expression with either combination
> of the flags Int_const_expr and Float_literal, the latter being only
> used to tell that
>   (int).0
> is indeed an integer constant expression.

This part should be dropped, I think, and maybe moved to the cover letter.

> Even if sparse attempted to verify that initializers for static storage
> duration objects are constant expressions [6.7.8(4)] (which it
> currently does not), it could not tell reliably.
> Examples:
> 1.)
>   static float a = { (float)0 }; /* allowed by C99 */
>   '(float)0' is not an integer constant expression, but an arithmetic
>   one.
> 2.)
>   enum { b = 0 };
>   static void *c = { (void*)b }; /* disallowed by C99 */
>   References to enum members are not allowed in address constants
>   [6.6(9)] and thus, the initializer is not a constant expression at
>   all.

This could be moved to the top of the patch description 
> Introduce a broader set of constness tracking flags, resembling the
> four types of constants [6.4.4] (integer, floating, enumeration,
> character) and the three types of constant expressions [6.6] (integer,
> arithmetic, address). Use helper functions to consistently set and
> clear these flags as they are not completely independent.
> Finally, make alloc_expression() and alloc_const_expression()
> initialize the new expression's flags to zero.

I think this patch should be split into 2-4 smaller patches:
0) introduce the new flags, maybe first only NONE, INT_EXPR & FP_CONST
1) replace the old use of 0, Int_const_expr, ... (can be folded with 0)
2) initialize the flag in alloc_expression() (can be folded with 1)..
3) introduce the the new flags if needed, the expr_..._flag() helpers
   and begin them


> --- a/expression.c
> +++ b/expression.c
> @@ -131,7 +131,7 @@ static struct token *parse_type(struct token *token, struct expression **tree)
>  {
>  	struct symbol *sym;
>  	*tree = alloc_expression(token->pos, EXPR_TYPE);
> -	(*tree)->flags = Int_const_expr; /* sic */
> +	expr_set_flag(&(*tree)->flags, EXPR_FLAG_INT_CONST_EXPR); /* sic */

Better to remove those 'sic'. To which text do they refer?

> @@ -457,7 +459,8 @@ struct token *primary_expression(struct token *token, struct expression **tree)
>  		}
>  		if (token->special == '[' && lookup_type(token->next)) {
>  			expr = alloc_expression(token->pos, EXPR_TYPE);
> -			expr->flags = Int_const_expr; /* sic */
> +			/* sic */
> +			expr_set_flag(&expr->flags, EXPR_FLAG_INT_CONST_EXPR);

Ditto for the 'sic'

> +
> +/*
> + * Set a particular flag among an expression's ones.
> + *
> + * The set of flags defined is not completely independent. Take care
> + * that implications keep obeyed.
> + *
> + * Only one single flag from enum expression_flags is allowed for
> + * the flag argument at a time.
> + */
> +static inline void expr_set_flag(unsigned char * const flags,
> +				enum expression_flags flag)
> +{
> +	/* obey the implications */
> +	switch (flag) {
> +	case EXPR_FLAG_INT_CONST:
> +	case EXPR_FLAG_ENUM_CONST:
> +	case EXPR_FLAG_CHAR_CONST:
> +		flag |= EXPR_FLAG_INT_CONST_EXPR;
> +	/* fallthrough */
> +	case EXPR_FLAG_FP_CONST:
> +	case EXPR_FLAG_INT_CONST_EXPR:
> +		flag |= EXPR_FLAG_ARITH_CONST_EXPR;
> +	/* fallthrough */
> +	case EXPR_FLAG_ARITH_CONST_EXPR:
> +	case EXPR_FLAG_ADDR_CONST_EXPR:
> +	case EXPR_FLAG_NONE:
> +		break;
> +	}
> +
> +	*flags |= flag;
> +}
> +
> +/*
> + * Clear a particular flag among an expression's ones.
> + *
> + * The set of flags defined is not completely independent. Take care
> + * that implications keep obeyed.
> + *
> + * Only one single flag from enum expression_flags is allowed for
> + * the flag argument at a time.
> + */
> +static inline void expr_clear_flag(unsigned char * const flags,
> +				enum expression_flags flag)
> +{
> +	/* obey the implications */
> +	switch (flag) {
> +	case EXPR_FLAG_ARITH_CONST_EXPR:
> +		flag |= EXPR_FLAG_INT_CONST_EXPR;
> +		flag |= EXPR_FLAG_FP_CONST;
> +	/* fallthrough */
> +	case EXPR_FLAG_INT_CONST_EXPR:
> +		flag |= EXPR_FLAG_INT_CONST;
> +		flag |= EXPR_FLAG_ENUM_CONST;
> +		flag |= EXPR_FLAG_CHAR_CONST;
> +	/* fallthrough */
> +	case EXPR_FLAG_ADDR_CONST_EXPR:
> +	case EXPR_FLAG_INT_CONST:
> +	case EXPR_FLAG_FP_CONST:
> +	case EXPR_FLAG_ENUM_CONST:
> +	case EXPR_FLAG_CHAR_CONST:
> +	case EXPR_FLAG_NONE:
> +		break;
> +	}
> +
> +	*flags &= ~flag;
> +}
> +
> +/*
> + * Remove any "Constant" [6.4.4] flag, but retain the "constant
> + * expression" [6.6] flags.
> + * Used to merge the constantness flags of primary subexpressions
> + * into their parent expressions' ones.
> + */
> +static inline void expr_flags_decay_consts(unsigned char * const flags)
> +{
> +	*flags &= ~(EXPR_FLAG_INT_CONST | EXPR_FLAG_FP_CONST |
> +		EXPR_FLAG_ENUM_CONST | EXPR_FLAG_CHAR_CONST);
> +}
  

I think it's already much better so!
But honestly, I still think that it could be improved:
- the fact that it need a pointer for the update, means that it can only be used
  with a specific type, here unsigned char, and not arbitrary expressions
- expr_flags_decay_consts(flags) could be simply be replaced by something like:
	#define EXPR_FLAG_CONSTANTS (EXPR_FLAG_INT_CONST|EXPR_FLAG_FP_CONST|...)
	flags &= ~EXPR_FLAG_CONSTANTS;
- expr_clear_flag() is only used 5 times:
  -) 4 times with ADDR_CONST_EXPR where it can be replaced by a simple &= ~
  -) once with INT_CONST_EXPR 
 
So, with only a few defines for the set/union, one for the 'clear' and one
one for the decay you can get rid of these helpers wich IMO improve readability
and is consistent that elsewhere in the code there is anyway manipulations of
expr->flags done simply with '|' and '&'.

>  enum {
>  	Taint_comma = 1,
> @@ -77,7 +188,7 @@ enum {
>  
>  struct expression {
>  	enum expression_type type:8;
> -	unsigned flags:8;
> +	unsigned char flags;

I suppose that initialy this 'flags' was foreseen for other things than
'Int_const_expr' & 'Float_literal' but now I think it should be better
to rename it with something more explicit, like 'constness' or something
(same then for the EXPR_FLAG_... of course).


Luc
