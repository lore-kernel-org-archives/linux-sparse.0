From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: Designated initializers for fields in anonymous structs and
 unions
Date: Thu, 31 Jul 2014 19:41:54 -0700
Message-ID: <20140801024154.GA21780@thin>
References: <20140731181006.GA13180@cloud>
 <CA+55aFwinxO5H=5Rtgz37AuOCTHBDWJ6mVRU0HX+fiGP9JRa1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:52311 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751553AbaHACmE (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 31 Jul 2014 22:42:04 -0400
Content-Disposition: inline
In-Reply-To: <CA+55aFwinxO5H=5Rtgz37AuOCTHBDWJ6mVRU0HX+fiGP9JRa1Q@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Chris Li <sparse@chrisli.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Thu, Jul 31, 2014 at 07:19:20PM -0700, Linus Torvalds wrote:
> On Thu, Jul 31, 2014 at 11:10 AM,  <josh@joshtriplett.org> wrote:
> > Test case:
> >
> > struct S {
> >     int a;
> >     union {
> >         int b;
> >         int c;
> >     };
> > };
> >
> > static struct S s = {
> >     .a = 0,
> >     .b = 0,
> > };
> 
> So sparse fails on this test-case (differently from what Josh
> reported, because apparently Josh is running 0.5.0) with:
> 
>   t.c:10:6: warning: Initializer entry defined twice
>   t.c:11:6:   also defined here

I had the latest bits from the main sparse repo; switching to the
chrisli repo gives me these same results.

> because the offsets are miscomputed. The conversion from
> EXPR_IDENTIFIER (an initializer entry with a named identifier) to
> EXPR_POS (an initializer entry with a byte offset) got this wrong.
> 
> We need to use "find_identifier()" that does the proper recursive
> lookup and updates the offset, but the required structure type wasn't
> passed down to convert_designators() and convert_ident(), so the patch
> is a bit bigger than just changing a couple of lines.
> 
> I'm quite sure we still screw complex intiializers up . But this makes
> at least Josh's test-case pass, and looks superficially sane.
> 
> Hmm?

Comments below.

> From 7670d933e82917ea28a7e5a5df09bcc9744dba34 Mon Sep 17 00:00:00 2001
> From: Linus Torvalds <torvalds@linux-foundation.org>
> Date: Thu, 31 Jul 2014 19:01:36 -0700
> Subject: [PATCH] Make 'convert_ident()' use 'find_identifier()' to get the
>  proper member offset
> 
> The convert_ident() function used to do
> 
> 	struct symbol *sym = e->field;
> 	e->init_offset = sym->offset;
> 
> which is wrong for embedded unnamed unions.  It really wants to do
> "find_identifier()", which looks up the field name in the structure or
> union type, and properly adds the offsets when it looks things up in an
> anonymous structure or union.
> 
> However, we didn't pass in the right symbol type, so convert_ident()
> couldn't be just trivially converted with a couple of lines.
> 
> This changes the code to pass in the struct/union type, and also
> re-organizes find_identifier() to have a nicer calling convention.  We
> now pass in the type, not the name-list, which makes it possible for
> find_identifier() to do the peeling of the SYM_NODE if required,
> simplifying the callers (including the recursive call for the anonymous
> case).
> 
> Reported-by: Just Triplett <josh@joshtriplett.org>

s/Just/Josh/

> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

With the above typo fixed:
Reviewed-by: Josh Triplett <josh@joshtriplett.org>
Tested-by: Josh Triplett <josh@joshtriplett.org>

It might make sense to combine this with the handling of array
designated initializers, to allow things like .x[0].y.z[3] = ..., but
this definitely fixes the issue I ran into.

(And now I'm wondering why nobody seems to have ever created an
"unnamed array" extension.)

> ---
>  evaluate.c | 47 ++++++++++++++++++++++++++---------------------
>  1 file changed, 26 insertions(+), 21 deletions(-)
> 
> diff --git a/evaluate.c b/evaluate.c
> index 03992d03ae1d..5195decd1b2e 100644
> --- a/evaluate.c
> +++ b/evaluate.c
> @@ -1872,13 +1872,19 @@ static struct symbol *evaluate_preop(struct expression *expr)
>  	return ctype;
>  }
>  
> -static struct symbol *find_identifier(struct ident *ident, struct symbol_list *_list, int *offset)
> +static struct symbol *find_identifier(struct ident *ident, struct symbol *ctype, int *offset)
>  {
> -	struct ptr_list *head = (struct ptr_list *)_list;
> -	struct ptr_list *list = head;
> +	struct ptr_list *head, *list;
>  
> +	if (ctype->type == SYM_NODE)
> +		ctype = ctype->ctype.base_type;
> +	if (ctype->type != SYM_UNION && ctype->type != SYM_STRUCT)
> +		return NULL;
> +
> +	head = (struct ptr_list *)ctype->symbol_list;
>  	if (!head)
>  		return NULL;
> +	list = head;
>  	do {
>  		int i;
>  		for (i = 0; i < list->nr; i++) {
> @@ -1889,13 +1895,8 @@ static struct symbol *find_identifier(struct ident *ident, struct symbol_list *_
>  				*offset = sym->offset;
>  				return sym;
>  			} else {
> -				struct symbol *ctype = sym->ctype.base_type;
>  				struct symbol *sub;
> -				if (!ctype)
> -					continue;
> -				if (ctype->type != SYM_UNION && ctype->type != SYM_STRUCT)
> -					continue;
> -				sub = find_identifier(ident, ctype->symbol_list, offset);
> +				sub = find_identifier(ident, sym, offset);
>  				if (!sub)
>  					continue;
>  				*offset += sym->offset;
> @@ -1965,7 +1966,7 @@ static struct symbol *evaluate_member_dereference(struct expression *expr)
>  		return NULL;
>  	}
>  	offset = 0;
> -	member = find_identifier(ident, ctype->symbol_list, &offset);
> +	member = find_identifier(ident, ctype, &offset);
>  	if (!member) {
>  		const char *type = ctype->type == SYM_STRUCT ? "struct" : "union";
>  		const char *name = "<unnamed>";
> @@ -2220,23 +2221,27 @@ static void convert_index(struct expression *e)
>  	e->init_expr = child;
>  }
>  
> -static void convert_ident(struct expression *e)
> +static void convert_ident(struct expression *e, struct symbol *ctype)
>  {
> +	int offset;
>  	struct expression *child = e->ident_expression;
> -	struct symbol *sym = e->field;
> +
> +	ctype = find_identifier(e->expr_ident, ctype, &offset);
> +	if (!ctype)
> +		return;
>  	e->type = EXPR_POS;
> -	e->init_offset = sym->offset;
> +	e->init_offset = offset;
>  	e->init_nr = 1;
>  	e->init_expr = child;
>  }
>  
> -static void convert_designators(struct expression *e)
> +static void convert_designators(struct expression *e, struct symbol *ctype)
>  {
>  	while (e) {
>  		if (e->type == EXPR_INDEX)
>  			convert_index(e);
>  		else if (e->type == EXPR_IDENTIFIER)
> -			convert_ident(e);
> +			convert_ident(e, ctype);
>  		else
>  			break;
>  		e = e->init_expr;
> @@ -2322,7 +2327,7 @@ static struct expression *check_designators(struct expression *e,
>  				err = "field name not in struct or union";
>  				break;
>  			}
> -			ctype = find_identifier(e->expr_ident, ctype->symbol_list, &offset);
> +			ctype = find_identifier(e->expr_ident, ctype, &offset);
>  			if (!ctype) {
>  				err = "unknown field name in";
>  				break;
> @@ -2392,7 +2397,7 @@ static struct expression *next_designators(struct expression *old,
>  		if (!copy) {
>  			field = old->field->next_subobject;
>  			if (!field) {
> -				convert_ident(old);
> +				convert_ident(old, ctype);
>  				return NULL;
>  			}
>  			copy = e;
> @@ -2406,7 +2411,7 @@ static struct expression *next_designators(struct expression *old,
>  		new->expr_ident = field->ident;
>  		new->ident_expression = copy;
>  		new->ctype = field;
> -		convert_ident(old);
> +		convert_ident(old, ctype);
>  	}
>  	return new;
>  }
> @@ -2465,7 +2470,7 @@ static void handle_list_initializer(struct expression *expr,
>  			top = next;
>  			/* deeper than one designator? */
>  			jumped = top != e;
> -			convert_designators(last);
> +			convert_designators(last, ctype);
>  			last = e;
>  		}
>  
> @@ -2497,7 +2502,7 @@ found:
>  
>  	} END_FOR_EACH_PTR(e);
>  
> -	convert_designators(last);
> +	convert_designators(last, ctype);
>  	expr->ctype = ctype;
>  }
>  
> @@ -2901,7 +2906,7 @@ static struct symbol *evaluate_offsetof(struct expression *expr)
>  			return NULL;
>  		}
>  
> -		field = find_identifier(expr->ident, ctype->symbol_list, &offset);
> +		field = find_identifier(expr->ident, ctype, &offset);
>  		if (!field) {
>  			expression_error(expr, "unknown member");
>  			return NULL;
> -- 
> 2.1.0.rc0.52.gaa544bf
> 

