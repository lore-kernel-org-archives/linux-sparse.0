From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH RFC 01/13] expression: introduce additional expression
 constness tracking flags
Date: Sat, 9 Jan 2016 18:03:29 +0100
Message-ID: <20160109170328.GA8655@macpro.local>
References: <87r3nzkct3.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36221 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755230AbcAIRDe (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 9 Jan 2016 12:03:34 -0500
Received: by mail-wm0-f65.google.com with SMTP id l65so20181163wmf.3
        for <linux-sparse@vger.kernel.org>; Sat, 09 Jan 2016 09:03:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <87r3nzkct3.fsf@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Nicolai Stange <nicstange@gmail.com>
Cc: linux-sparse@vger.kernel.org

On Thu, Jul 23, 2015 at 01:11:36AM +0200, Nicolai Stange wrote:
> Prepare for a more fine-grained tracking of expression constness in the
> sense of C99 [6.4.4, 6.6].
> 

I have a few remarks/questions/suggestions here under.

> +/*
> + * Flags for tracking the promotion of various attributes from
> + * subexpressions to their parents.
> + *
> + * Currently, they only cope with an expression's constness as defined
> + * by C99.
> + *
> + * The flags are not independent as one might imply another. Use
> + * expr_set_flag_mask() and expr_clear_flag_mask() for setting and
> + * clearing a particular flag.
> + */
> +enum expression_flags {
> +	EXPR_FLAG_NONE = 0,
> +	/*
> +	 * A constant in the sense of [6.4.4]:
> +	 * - Integer constant [6.4.4.1]
> +	 * - Floating point constant [6.4.4.2]
> +	 * - Enumeration constant [6.4.4.3]
> +	 * - Character constant [6.4.4.4]
> +	 */
> +	EXPR_FLAG_INT_CONST = (1 << 0),
> +	EXPR_FLAG_FP_CONST = (1 << 1),
> +	EXPR_FLAG_ENUM_CONST = (1 << 2),
> +	EXPR_FLAG_CHAR_CONST = (1 << 3),
> +
> +	/*
> +	 * A constant expression in the sense of [6.6]:
> +	 * - integer constant expression [6.6(6)]
> +	 * - arithmetic constant expression [6.6(8)]
> +	 * - address constanr [6.6(9)]
> +	 */
> +	EXPR_FLAG_INT_CONST_EXPR = (1 << 4),
> +	EXPR_FLAG_ARITH_CONST_EXPR = (1 << 5),
> +	EXPR_FLAG_ADDR_CONST_EXPR = (1 << 6),
> +};
> +
> +/*
> + * Calculate a mask to be or'ed in in order to set a particular
> + * expression flag.
> + *
> + * Only one single flag from enum expression_flags is allowed at a
> + * time.
> + */
> +static inline enum expression_flags expr_set_flag_mask
> +	(const enum expression_flags flag)
> +{
> +	/* obey the implications */
> +	enum expression_flags implied_flags = EXPR_FLAG_NONE;
> +
> +	switch (flag) {
> +	case EXPR_FLAG_INT_CONST:
> +	case EXPR_FLAG_ENUM_CONST:
> +	case EXPR_FLAG_CHAR_CONST:
> +		implied_flags |= EXPR_FLAG_INT_CONST_EXPR;
> +	/* fallthrough */
> +	case EXPR_FLAG_FP_CONST:
> +	case EXPR_FLAG_INT_CONST_EXPR:
> +		implied_flags |= EXPR_FLAG_ARITH_CONST_EXPR;
> +	/* fallthrough */
> +	case EXPR_FLAG_ARITH_CONST_EXPR:
> +	case EXPR_FLAG_ADDR_CONST_EXPR:
> +	case EXPR_FLAG_NONE:
> +		break;
> +	}
> +
> +	return (implied_flags | flag);
> +}
> +
> +/*
> + * Calculate a mask to be negated and and'ed in in order to clear a
> + * particular expression flag.
> + *
> + * Only one single flag from enum expression_flags is allowed at a
> + * time.
> + */
> +static inline enum expression_flags expr_clear_flag_mask
> +	(const enum expression_flags flag)
> +{
> +	/* obey the implications */
> +	enum expression_flags implied_flags = EXPR_FLAG_NONE;
> +
> +	switch (flag) {
> +	case EXPR_FLAG_ARITH_CONST_EXPR:
> +		implied_flags |= EXPR_FLAG_INT_CONST_EXPR;
> +		implied_flags |= EXPR_FLAG_FP_CONST;
> +	/* fallthrough */
> +	case EXPR_FLAG_INT_CONST_EXPR:
> +		implied_flags |= EXPR_FLAG_INT_CONST;
> +		implied_flags |= EXPR_FLAG_ENUM_CONST;
> +		implied_flags |= EXPR_FLAG_CHAR_CONST;
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
> +	return (implied_flags | flag);
> +}

Shouldn't the following be more explicit?
	flag = expr_set_flag_mask(0, ...);
	flag = expr_set_flag_mask(in_flag, ...);
	flag = expr_clear_flag_mask(in_flag, ...);
Yes, I know, it would need to duplicate the expr->flags at almost all calls.

Couldn't we get rid of those two function by separating the exclusive "bits"
from the "sets"?
Something like:
	#define	__EXPR_FLAG_INT_CONST	(1 << 0)
	#define	__EXPR_FLAG_FP_CONST	(1 << 1)
	...
	#define	EXPR_FLAG_INT_CONST	(__EXPR_FLAG_INT_CONST |
					 __EXPR_FLAG_INT_CONST_EXPR |
					 __EXPR_FLAG_ARITH_CONST)

> +/*
> + *  Remove any "Constant" [6.4.4] flag, but retain the "constant
> + * expression" [6.6] flags.
> + * Used to merge the constantness flags of primary subexpressions
> + * into their parent expressions' ones.
> + */
> +static inline enum expression_flags expr_flags_decay_consts
> +	(enum expression_flags flags)
> +{
> +	return (flags & ~(expr_clear_flag_mask(EXPR_FLAG_INT_CONST)
> +			  | expr_clear_flag_mask(EXPR_FLAG_FP_CONST)
> +			  | expr_clear_flag_mask(EXPR_FLAG_ENUM_CONST)
> +			  | expr_clear_flag_mask(EXPR_FLAG_CHAR_CONST)));
> +}

How is that different from:
	return flags & ~(EXPR_FLAG_INT_CONST
			|EXPR_FLAG_FP_CONST
			|EXPR_FLAG_ENUM_CONST
			|EXPR_FLAG_CHAR_CONST)?
Shouldn't this more directly implement the desciption of the function:
	"Remove any 'Constant' flag but retain ... ?

> +/* Purge any constantness related flag. */
> +static inline enum expression_flags expr_flags_remove_consts
> +	(enum expression_flags flags)
> +{
> +	return (flags &
> +		~(expr_clear_flag_mask(EXPR_FLAG_ARITH_CONST_EXPR)
> +		  | expr_clear_flag_mask(EXPR_FLAG_ADDR_CONST_EXPR)));
> +}

Same as above with the appropriate changes.


Yours,
Luc
