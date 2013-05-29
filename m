From: Chris Li <sparse@chrisli.org>
Subject: Re: [PATCH 3/3] symbol.c: Set correct size of array from
 parenthesized string initializer
Date: Wed, 29 May 2013 03:02:09 -0700
Message-ID: <20130529100207.GA3005@gmail.com>
References: <5195370B.9080702@ramsay1.demon.co.uk>
 <51972FDB.6060201@chrisli.org>
 <5197387E.5030000@gmail.com>
 <519A6EAD.8070700@ramsay1.demon.co.uk>
 <519E3582.7060704@gmail.com>
 <51A1189A.1010404@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:64201 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965107Ab3E2KC3 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 29 May 2013 06:02:29 -0400
Received: by mail-pd0-f171.google.com with SMTP id z11so8775484pdj.16
        for <linux-sparse@vger.kernel.org>; Wed, 29 May 2013 03:02:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <51A1189A.1010404@ramsay1.demon.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Sat, May 25, 2013 at 09:01:30PM +0100, Ramsay Jones wrote:
> Yes, this patch works.
> 
> However, it made me go cross-eyed trying to follow the flow of
> control. So, I created a new patch, added after the scissor mark
> below, which hopefully makes the flow of control easier to follow.

As my patch, you should just read the "case EXPR_STRING" as a label,
that is easier to understand.

Unfortunately I think your patch is not doing the same thing as mine,
control flow wise. Please see the later comment on your code.

> Also, note that I changed the test to add a check for the length
> of the v1 array. Having said that, I had intended to rename the
> variables in the test to u->y and a->e (this is a new test, after
> all), but I forgot! sorry about that.

Can you submit a separate delta  for the test part of the change?
I can smash the patch on top your original one.

> +static struct expression *paren_string(struct expression *expr)

Paren sounds very much like "parent". I would make the function name
"parenthesized_string" or "extract_parenthesized_string".


>  
> +	/* check for a parenthesized string: char x[] = ("string"); */
> +	if (is_char && (p = paren_string(expr)))
> +		expr = p;
> +

I want to move this test to inside the switch statement.
The parenthesized string is a very rare case. Adding the test
here make the common case pay a price.


>  	switch (expr->type) {
>  	case EXPR_INITIALIZER: {
>  		struct expression *entry;
> @@ -296,6 +313,10 @@ static int count_array_initializer(struct symbol *t, struct expression *expr)
>  				if (entry->idx_to >= nr)
>  					nr = entry->idx_to+1;
>  				break;
> +			case EXPR_PREOP:
> +				/* check for char x[] = {("string")}; */
> +				if (is_char && (p = paren_string(entry)))
> +					entry = p;
>  			case EXPR_STRING:
>  				if (is_char)
>  					str_len = entry->string->length;

OK, here is the subtle bug. Consider the case expr->type ==  EXPR_PREOP
and is_char == 1 and paren_string(entry) return false.

Before apply your patch, it will go to default case.
Now after your patch, it will go to execute "str_len =
entry->string->length", even entry expression is not a string.

So your patch is doing some thing not intended. In order to correct
that, you can't always allow EXPR_PREOP case fall through to
EXPR_STRING. It need to depend on the test condition paren_string()
return true or not.

You can add goto statement to the switch statement to fix that.
It will make the control flow hard to read as well.

If you have better way to write it I am open to it.

Chris



