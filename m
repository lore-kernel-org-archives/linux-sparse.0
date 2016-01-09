From: Nicolai Stange <nicstange@gmail.com>
Subject: Re: [PATCH RFC 01/13] expression: introduce additional expression constness tracking flags
Date: Sat, 09 Jan 2016 23:20:27 +0100
Message-ID: <87a8oewg2c.fsf@gmail.com>
References: <87r3nzkct3.fsf@gmail.com> <20160109170328.GA8655@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34218 "EHLO
	mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756068AbcAIWUa (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 9 Jan 2016 17:20:30 -0500
Received: by mail-lf0-f67.google.com with SMTP id n70so17946555lfn.1
        for <linux-sparse@vger.kernel.org>; Sat, 09 Jan 2016 14:20:29 -0800 (PST)
In-Reply-To: <20160109170328.GA8655@macpro.local> (Luc Van Oostenryck's
	message of "Sat, 9 Jan 2016 18:03:29 +0100")
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Nicolai Stange <nicstange@gmail.com>, linux-sparse@vger.kernel.org

Luc Van Oostenryck <luc.vanoostenryck@gmail.com> writes:

> On Thu, Jul 23, 2015 at 01:11:36AM +0200, Nicolai Stange wrote:
>> Prepare for a more fine-grained tracking of expression constness in the
>> sense of C99 [6.4.4, 6.6].
>> 
>
> I have a few remarks/questions/suggestions here under.
>
>> +/*
>> + * Flags for tracking the promotion of various attributes from
>> + * subexpressions to their parents.
>> + *
>> + * Currently, they only cope with an expression's constness as defined
>> + * by C99.
>> + *
>> + * The flags are not independent as one might imply another. Use
>> + * expr_set_flag_mask() and expr_clear_flag_mask() for setting and
>> + * clearing a particular flag.
>> + */
>> +enum expression_flags {
>> +	EXPR_FLAG_NONE = 0,
>> +	/*
>> +	 * A constant in the sense of [6.4.4]:
>> +	 * - Integer constant [6.4.4.1]
>> +	 * - Floating point constant [6.4.4.2]
>> +	 * - Enumeration constant [6.4.4.3]
>> +	 * - Character constant [6.4.4.4]
>> +	 */
>> +	EXPR_FLAG_INT_CONST = (1 << 0),
>> +	EXPR_FLAG_FP_CONST = (1 << 1),
>> +	EXPR_FLAG_ENUM_CONST = (1 << 2),
>> +	EXPR_FLAG_CHAR_CONST = (1 << 3),
>> +
>> +	/*
>> +	 * A constant expression in the sense of [6.6]:
>> +	 * - integer constant expression [6.6(6)]
>> +	 * - arithmetic constant expression [6.6(8)]
>> +	 * - address constanr [6.6(9)]
>> +	 */
>> +	EXPR_FLAG_INT_CONST_EXPR = (1 << 4),
>> +	EXPR_FLAG_ARITH_CONST_EXPR = (1 << 5),
>> +	EXPR_FLAG_ADDR_CONST_EXPR = (1 << 6),
>> +};
>> +
>> +/*
>> + * Calculate a mask to be or'ed in in order to set a particular
>> + * expression flag.
>> + *
>> + * Only one single flag from enum expression_flags is allowed at a
>> + * time.
>> + */
>> +static inline enum expression_flags expr_set_flag_mask
>> +	(const enum expression_flags flag)
>> +{
>> +	/* obey the implications */
>> +	enum expression_flags implied_flags = EXPR_FLAG_NONE;
>> +
>> +	switch (flag) {
>> +	case EXPR_FLAG_INT_CONST:
>> +	case EXPR_FLAG_ENUM_CONST:
>> +	case EXPR_FLAG_CHAR_CONST:
>> +		implied_flags |= EXPR_FLAG_INT_CONST_EXPR;
>> +	/* fallthrough */
>> +	case EXPR_FLAG_FP_CONST:
>> +	case EXPR_FLAG_INT_CONST_EXPR:
>> +		implied_flags |= EXPR_FLAG_ARITH_CONST_EXPR;
>> +	/* fallthrough */
>> +	case EXPR_FLAG_ARITH_CONST_EXPR:
>> +	case EXPR_FLAG_ADDR_CONST_EXPR:
>> +	case EXPR_FLAG_NONE:
>> +		break;
>> +	}
>> +
>> +	return (implied_flags | flag);
>> +}
>> +
>> +/*
>> + * Calculate a mask to be negated and and'ed in in order to clear a
>> + * particular expression flag.
>> + *
>> + * Only one single flag from enum expression_flags is allowed at a
>> + * time.
>> + */
>> +static inline enum expression_flags expr_clear_flag_mask
>> +	(const enum expression_flags flag)
>> +{
>> +	/* obey the implications */
>> +	enum expression_flags implied_flags = EXPR_FLAG_NONE;
>> +
>> +	switch (flag) {
>> +	case EXPR_FLAG_ARITH_CONST_EXPR:
>> +		implied_flags |= EXPR_FLAG_INT_CONST_EXPR;
>> +		implied_flags |= EXPR_FLAG_FP_CONST;
>> +	/* fallthrough */
>> +	case EXPR_FLAG_INT_CONST_EXPR:
>> +		implied_flags |= EXPR_FLAG_INT_CONST;
>> +		implied_flags |= EXPR_FLAG_ENUM_CONST;
>> +		implied_flags |= EXPR_FLAG_CHAR_CONST;
>> +	/* fallthrough */
>> +	case EXPR_FLAG_ADDR_CONST_EXPR:
>> +	case EXPR_FLAG_INT_CONST:
>> +	case EXPR_FLAG_FP_CONST:
>> +	case EXPR_FLAG_ENUM_CONST:
>> +	case EXPR_FLAG_CHAR_CONST:
>> +	case EXPR_FLAG_NONE:
>> +		break;
>> +	}
>> +
>> +	return (implied_flags | flag);
>> +}
>
> Shouldn't the following be more explicit?
> 	flag = expr_set_flag_mask(0, ...);
> 	flag = expr_set_flag_mask(in_flag, ...);
> 	flag = expr_clear_flag_mask(in_flag, ...);
> Yes, I know, it would need to duplicate the expr->flags at almost all calls.

Admittedly, this looks way better.

I'll change that to
  void expr_set_flag(unsigned *flag, ...);
and likewise for the clearing guy.

>
> Couldn't we get rid of those two function by separating the exclusive "bits"
> from the "sets"?
> Something like:
> 	#define	__EXPR_FLAG_INT_CONST	(1 << 0)
> 	#define	__EXPR_FLAG_FP_CONST	(1 << 1)
> 	...
> 	#define	EXPR_FLAG_INT_CONST	(__EXPR_FLAG_INT_CONST |
> 					 __EXPR_FLAG_INT_CONST_EXPR |
> 					 __EXPR_FLAG_ARITH_CONST)

No, this won't work since the "implied" bit masks are in general different for
setting and clearing a flag.

For example, "integer constant" (i.e. integer literal) implies "integer
constant expression", but "not a integer constant" does not imply "not a
integer constant expression".


>
>> +/*
>> + *  Remove any "Constant" [6.4.4] flag, but retain the "constant
>> + * expression" [6.6] flags.
>> + * Used to merge the constantness flags of primary subexpressions
>> + * into their parent expressions' ones.
>> + */
>> +static inline enum expression_flags expr_flags_decay_consts
>> +	(enum expression_flags flags)
>> +{
>> +	return (flags & ~(expr_clear_flag_mask(EXPR_FLAG_INT_CONST)
>> +			  | expr_clear_flag_mask(EXPR_FLAG_FP_CONST)
>> +			  | expr_clear_flag_mask(EXPR_FLAG_ENUM_CONST)
>> +			  | expr_clear_flag_mask(EXPR_FLAG_CHAR_CONST)));
>> +}
>
> How is that different from:
> 	return flags & ~(EXPR_FLAG_INT_CONST
> 			|EXPR_FLAG_FP_CONST
> 			|EXPR_FLAG_ENUM_CONST
> 			|EXPR_FLAG_CHAR_CONST)?

Not at all.

> Shouldn't this more directly implement the desciption of the function:
> 	"Remove any 'Constant' flag but retain ... ?

Yes. I will change this.


>> +/* Purge any constantness related flag. */
>> +static inline enum expression_flags expr_flags_remove_consts
>> +	(enum expression_flags flags)
>> +{
>> +	return (flags &
>> +		~(expr_clear_flag_mask(EXPR_FLAG_ARITH_CONST_EXPR)
>> +		  | expr_clear_flag_mask(EXPR_FLAG_ADDR_CONST_EXPR)));
>> +}
>
> Same as above with the appropriate changes.
>

Ditto.

> Yours,
> Luc

Again, thank you very much for your valuable review!
