From: Phil Carmody <phil@dovecot.fi>
Subject: Re: [PATCH 2/3] sparse: detect non-sign-extended masks created by '~'
Date: Mon, 9 Jun 2014 19:05:41 +0300
Message-ID: <20140609160529.GA14166@phil.dovecot.net>
References: <1402315082-14102-1-git-send-email-phil@dovecot.fi>
 <1402315082-14102-2-git-send-email-phil@dovecot.fi>
 <1402315082-14102-3-git-send-email-phil@dovecot.fi>
 <20140609133424.GB11986@thin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from wursti.dovecot.fi ([87.106.245.223]:42630 "EHLO
	wursti.dovecot.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933184AbaFIQKl (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 9 Jun 2014 12:10:41 -0400
Content-Disposition: inline
In-Reply-To: <20140609133424.GB11986@thin>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Phil Carmody <phil@dovecot.fi>, sparse@chrisli.org, linux-sparse@vger.kernel.org

On Mon, Jun 09, 2014 at 06:34:24AM -0700, Josh Triplett wrote:

Thanks for the  quick response.

> On Mon, Jun 09, 2014 at 02:58:01PM +0300, Phil Carmody wrote:
> > Consider the operation of rounding up to the nearest multiple of a power of 2.
> > e.g.  #define ALLOC_SIZE(t) ((sizeof(t) + ASIZE - 1) & ~(ASIZE - 1))
> > 
> > If ASIZE is unfortunately defined as an unsigned type smaller than size_t,
> > then the ~ will not undergo sign-bit extension, and the incorrect mask will
> > be used. If used in a memory allocation context this could be fatal.
> > 
> > Warn about such dubious 'large op ~short' usage.
> > 
> > Signed-off-by: Phil Carmody <phil@dovecot.fi>
> > ---
> >  evaluate.c | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> > 
> > diff --git a/evaluate.c b/evaluate.c
> > index 9052962..c0f3c91 100644
> > --- a/evaluate.c
> > +++ b/evaluate.c
> > @@ -189,6 +189,14 @@ left:
> >  	return left;
> >  }
> >  
> > +static int is_bigger_int_type(struct symbol *left, struct symbol *right)
> > +{
> > +	left = integer_promotion(left);
> > +	right = integer_promotion(right);
> > +
> > +	return (left->bit_size > right->bit_size);
> > +}
> > +
> >  static int same_cast_type(struct symbol *orig, struct symbol *new)
> >  {
> >  	return orig->bit_size == new->bit_size &&
> > @@ -927,6 +935,19 @@ static struct symbol *evaluate_binop(struct expression *expr)
> >  					op,
> >  					right_not ? "!" : "");
> >  
> > +			left_not  = expr->left->type == EXPR_PREOP
> > +					&& expr->left->op == '~';
> > +			right_not = expr->right->type == EXPR_PREOP
> > +			                && expr->right->op == '~';
> 
> Ah, now I see why you wanted these to not use "const".  Fair enough.
> "bool" still seems like the right type, though.

There did seem to be general bool-avoidance in the code, it would have been
my preference too.
 
> > +			if ((left_not && is_bigger_int_type(rtype, ltype)
> > +			     && (ltype->ctype.modifiers & MOD_UNSIGNED)) ||
> > +			    (right_not && is_bigger_int_type(ltype, rtype)
> > +			     && (rtype->ctype.modifiers & MOD_UNSIGNED)))
> 
> You might consider wrapping the common expression here, along with the
> corresponding previous _not expression, into a function, and then
> calling it twice, flipping the arguments around for the second call.

Yes, that makes sense.
 
> > +				warning(expr->pos, "dubious: %sx %c %sy",
> > +				        left_not ? "~" : "",
> > +					op,
> > +					right_not ? "~" : "");
> 
> What happens here if left_not && right_not?  Should this warning still
> occur?  I *think* it still makes sense for it to, but the warning
> message might prove less informative.

You're right, the message wouldn't identify which was the operand that
was not being sign extended. I can pull the warning itself into the helper
function I create for the test.

> > +
> >  			ltype = usual_conversions(op, expr->left, expr->right,
> >  						  lclass, rclass, ltype, rtype);
> >  			ctype = rtype = ltype;

Thanks for your comments. A v2 will be forthcoming...

Cheers,
Phil
