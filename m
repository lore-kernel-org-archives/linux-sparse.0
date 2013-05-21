From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 3/5] Fix some "unknown format" warnings
Date: Tue, 21 May 2013 15:05:46 -0700
Message-ID: <20130521220546.GD11463@jtriplet-mobl1>
References: <519BC851.5090202@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:46387 "EHLO
	slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751748Ab3EUWPI (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 21 May 2013 18:15:08 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	by slow1-d.mail.gandi.net (Postfix) with ESMTP id AB03047A8C9
	for <linux-sparse@vger.kernel.org>; Wed, 22 May 2013 00:06:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <519BC851.5090202@ramsay1.demon.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Cc: Christopher Li <sparse@chrisli.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Tue, May 21, 2013 at 08:17:37PM +0100, Ramsay Jones wrote:
> 
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> ---

%Ld for a long long int is actually broken on all architectures; L only
works for long double.  Thanks for fixing that.

Formatting nit: I think this reads better when written as:

"... blah blah " PRIx64 " blah blah ..."

, leaving spaces between the macro and the close/open doublequotes.

Further comments below.

> @@ -336,10 +337,14 @@ const char *show_instruction(struct instruction *insn)
>  			
>  		switch (expr->type) {
>  		case EXPR_VALUE:
> -			buf += sprintf(buf, "%lld", expr->value);
> +			buf += sprintf(buf, "%"PRId64, expr->value);
>  			break;
>  		case EXPR_FVALUE:
> +#if !defined(__MINGW32__)
>  			buf += sprintf(buf, "%Lf", expr->fvalue);
> +#else
> +			buf += sprintf(buf, "%f", (double)expr->fvalue);
> +#endif

This seems really sad; does MinGW really have long double but no way to
print it?  Can we at least emit something here to indicate possible
truncation or loss of precision, if no means exists to print a long
double?

> @@ -463,7 +468,7 @@ const char *show_instruction(struct instruction *insn)
>  	}
>  
>  	if (buf >= buffer + sizeof(buffer))
> -		die("instruction buffer overflowed %td\n", buf - buffer);
> +		die("instruction buffer overflowed %d\n", (int)(buf - buffer));

No, ptrdiff_t does not portably fit in int; it generally has the same
size as size_t (64-bit on 64-bit platforms).  Cast to "long long" and
use PRId64 if you must.

> --- a/pre-process.c
> +++ b/pre-process.c
> @@ -158,12 +158,17 @@ static int expand_one_symbol(struct token **list)
>  	} else if (token->ident == &__DATE___ident) {
>  		if (!t)
>  			time(&t);
> +#if !defined(__MINGW32__)
>  		strftime(buffer, 12, "%b %e %Y", localtime(&t));
> +#else
> +		strftime(buffer, 12, "%b %d %Y", localtime(&t));
> +		if (buffer[4] == '0') buffer[4] = ' ';
> +#endif

To the best of my knowledge, nothing guarantees the length of %b, so the
[4] here seems wrong.

> @@ -980,7 +981,11 @@ static int show_fvalue(struct expression *expr)
>  	int new = new_pseudo();
>  	long double value = expr->fvalue;
>  
> +#if !defined(__MINGW32__)
>  	printf("\tmovf.%d\t\tv%d,$%Lf\n", expr->ctype->bit_size, new, value);
> +#else
> +	printf("\tmovf.%d\t\tv%d,$%f\n", expr->ctype->bit_size, new, (double)value);
> +#endif

Same comment as above regarding long double.

> --- a/tokenize.c
> +++ b/tokenize.c
> @@ -547,8 +547,8 @@ static int get_one_number(int c, int next, stream_t *stream)
>  	}
>  
>  	if (p == buffer_end) {
> -		sparse_error(stream_pos(stream), "number token exceeds %td characters",
> -		      buffer_end - buffer);
> +		sparse_error(stream_pos(stream), "number token exceeds %d characters",
> +		      (int)(buffer_end - buffer));

Same comment as above regarding ptrdiff_t.

- Josh Triplett
