From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 1/2] evaluate: split out implementation of
 compatible_assignment_types
Date: Sat, 1 Mar 2014 12:16:12 -0800
Message-ID: <20140301201600.GB24871@thin>
References: <afd69e2697f3d3da96b74c06501fd2fb1fc5cba2.1393674078.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:33975 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753201AbaCAUQW (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 1 Mar 2014 15:16:22 -0500
Content-Disposition: inline
In-Reply-To: <afd69e2697f3d3da96b74c06501fd2fb1fc5cba2.1393674078.git.john@keeping.me.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
Cc: linux-sparse@vger.kernel.org

On Sat, Mar 01, 2014 at 11:41:38AM +0000, John Keeping wrote:
> This will allow us to reuse the logic when processing a transparent
> union by checking each member in turn without printing a warning unless
> none of the members match.
> 
> Signed-off-by: John Keeping <john@keeping.me.uk>

Reviewed-by: Josh Triplett <josh@joshtriplett.org>

>  evaluate.c | 57 ++++++++++++++++++++++++++++++++++-----------------------
>  1 file changed, 34 insertions(+), 23 deletions(-)
> 
> diff --git a/evaluate.c b/evaluate.c
> index 6655615..2e6511b 100644
> --- a/evaluate.c
> +++ b/evaluate.c
> @@ -1307,10 +1307,9 @@ static int whitelist_pointers(struct symbol *t1, struct symbol *t2)
>  	return !Wtypesign;
>  }
>  
> -static int compatible_assignment_types(struct expression *expr, struct symbol *target,
> -	struct expression **rp, const char *where)
> +static int check_assignment_types(struct symbol *target, struct expression **rp,
> +	const char **typediff)
>  {
> -	const char *typediff;
>  	struct symbol *source = degenerate(*rp);
>  	struct symbol *t, *s;
>  	int tclass = classify_type(target, &t);
> @@ -1327,8 +1326,8 @@ static int compatible_assignment_types(struct expression *expr, struct symbol *t
>  				return 1;
>  		} else if (!(sclass & TYPE_RESTRICT))
>  			goto Cast;
> -		typediff = "different base types";
> -		goto Err;
> +		*typediff = "different base types";
> +		return 0;
>  	}
>  
>  	if (tclass == TYPE_PTR) {
> @@ -1342,8 +1341,8 @@ static int compatible_assignment_types(struct expression *expr, struct symbol *t
>  			goto Cast;
>  		}
>  		if (!(sclass & TYPE_PTR)) {
> -			typediff = "different base types";
> -			goto Err;
> +			*typediff = "different base types";
> +			return 0;
>  		}
>  		b1 = examine_pointer_target(t);
>  		b2 = examine_pointer_target(s);
> @@ -1356,19 +1355,19 @@ static int compatible_assignment_types(struct expression *expr, struct symbol *t
>  			 * or mix address spaces [sparse].
>  			 */
>  			if (t->ctype.as != s->ctype.as) {
> -				typediff = "different address spaces";
> -				goto Err;
> +				*typediff = "different address spaces";
> +				return 0;
>  			}
>  			if (mod2 & ~mod1) {
> -				typediff = "different modifiers";
> -				goto Err;
> +				*typediff = "different modifiers";
> +				return 0;
>  			}
>  			goto Cast;
>  		}
>  		/* It's OK if the target is more volatile or const than the source */
> -		typediff = type_difference(&t->ctype, &s->ctype, 0, mod1);
> -		if (typediff)
> -			goto Err;
> +		*typediff = type_difference(&t->ctype, &s->ctype, 0, mod1);
> +		if (*typediff)
> +			return 0;
>  		return 1;
>  	}
>  
> @@ -1379,22 +1378,34 @@ static int compatible_assignment_types(struct expression *expr, struct symbol *t
>  		/* XXX: need to turn into comparison with NULL */
>  		if (t == &bool_ctype && (sclass & TYPE_PTR))
>  			goto Cast;
> -		typediff = "different base types";
> -		goto Err;
> +		*typediff = "different base types";
> +		return 0;
>  	}
> -	typediff = "invalid types";
> -
> -Err:
> -	warning(expr->pos, "incorrect type in %s (%s)", where, typediff);
> -	info(expr->pos, "   expected %s", show_typename(target));
> -	info(expr->pos, "   got %s", show_typename(source));
> -	*rp = cast_to(*rp, target);
> +	*typediff = "invalid types";
>  	return 0;
> +
>  Cast:
>  	*rp = cast_to(*rp, target);
>  	return 1;
>  }
>  
> +static int compatible_assignment_types(struct expression *expr, struct symbol *target,
> +	struct expression **rp, const char *where)
> +{
> +	const char *typediff;
> +	struct symbol *source = degenerate(*rp);
> +
> +	if (!check_assignment_types(target, rp, &typediff)) {
> +		warning(expr->pos, "incorrect type in %s (%s)", where, typediff);
> +		info(expr->pos, "   expected %s", show_typename(target));
> +		info(expr->pos, "   got %s", show_typename(source));
> +		*rp = cast_to(*rp, target);
> +		return 0;
> +	}
> +
> +	return 1;
> +}
> +
>  static void mark_assigned(struct expression *expr)
>  {
>  	struct symbol *sym;
> -- 
> 1.9.0.6.g037df60.dirty
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sparse" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
