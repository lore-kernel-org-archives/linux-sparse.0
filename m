From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH] univ-init: scalar initializer needs some additional
 checks
Date: Wed, 3 Jun 2020 02:01:07 +0100
Message-ID: <34e42c7f-6c9d-b8e5-6ee1-2988b1099176@ramsayjones.plus.com>
References: <20200602163336.32667-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from avasout06.plus.net ([212.159.14.18]:60702 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgFCBBL (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 2 Jun 2020 21:01:11 -0400
In-Reply-To: <20200602163336.32667-1-luc.vanoostenryck@gmail.com>
Content-Language: en-GB
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, linux-sparse@vger.kernel.org



On 02/06/2020 17:33, Luc Van Oostenryck wrote:
> Currently, -Wno-universal-initializer is simply implemented
> by simply replacing '{ 0 }' by '{ }'.
> 
> However, this is a bit too simple when it concerns scalars
> initialized with '{ 0 }' because:
> * sparse & GCC issued warnings for empty scalar initializers
> * initializing a pointer with '{ }' is extra bad.
> 
> So, restore the old behaviour for scalar initializers.
> This is done by leaving '{ 0 }' as-is at parse time and changing
> it as '{ }' only at evaluation time for compound initializers.
> 

I applied this patch just now and everything worked fine. In addition,
the tests from my patch also passed, once I had remembered to add the
-Wno-universal-initializer to the 'check-command' - because I do not
have the patch which changes the default for that warning.

The only thing which gave me pause ...

> Fixes: 537e3e2daebd37d69447e65535fc94e82b38fc18
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  evaluate.c                 |  3 +++
>  expression.h               |  1 +
>  parse.c                    | 15 ++++++++-------
>  validation/Wuniv-init-ko.c | 16 ++++++++++++++++
>  validation/Wuniv-init-ok.c | 18 ++++++++++++++++++
>  5 files changed, 46 insertions(+), 7 deletions(-)
> 
> diff --git a/evaluate.c b/evaluate.c
> index 8d2e68692a48..16553eb3481b 100644
> --- a/evaluate.c
> +++ b/evaluate.c
> @@ -2608,6 +2608,9 @@ static void handle_list_initializer(struct expression *expr,
>  	struct expression *e, *last = NULL, *top = NULL, *next;
>  	int jumped = 0;
>  
> +	if (expr->zero_init)
> +		expr->expr_list = NULL;

... was the potential memory leak here. (OK it wouldn't be a
huge leak, but still!).

ATB,
Ramsay Jones

> +
>  	FOR_EACH_PTR(expr->expr_list, e) {
>  		struct expression **v;
>  		struct symbol *type;
> diff --git a/expression.h b/expression.h
> index 64aa1fc23309..07fe8502e15e 100644
> --- a/expression.h
> +++ b/expression.h
> @@ -159,6 +159,7 @@ DECLARE_ALLOCATOR(type_expression);
>  struct expression {
>  	enum expression_type type:8;
>  	unsigned flags:8;
> +	unsigned zero_init:1;
>  	int op;
>  	struct position pos;
>  	struct symbol *ctype;
> diff --git a/parse.c b/parse.c
> index 687c8c0c235c..9569efdc68b3 100644
> --- a/parse.c
> +++ b/parse.c
> @@ -2783,13 +2783,6 @@ static struct token *initializer_list(struct expression_list **list, struct toke
>  {
>  	struct expression *expr;
>  
> -	// '{ 0 }' is equivalent to '{ }' unless wanting all possible
> -	// warnings about using '0' to initialize a null-pointer.
> -	if (!Wuniversal_initializer) {
> -		if (match_token_zero(token) && match_op(token->next, '}'))
> -			token = token->next;
> -	}
> -
>  	for (;;) {
>  		token = single_initializer(&expr, token);
>  		if (!expr)
> @@ -2807,6 +2800,14 @@ struct token *initializer(struct expression **tree, struct token *token)
>  	if (match_op(token, '{')) {
>  		struct expression *expr = alloc_expression(token->pos, EXPR_INITIALIZER);
>  		*tree = expr;
> +		if (!Wuniversal_initializer) {
> +			struct token *next = token->next;
> +			// '{ 0 }' is equivalent to '{ }' except for some
> +			// warnings, like using 0 to initialize a null-pointer.
> +			if (match_token_zero(next) && match_op(next->next, '}'))
> +				expr->zero_init = 1;
> +		}
> +
>  		token = initializer_list(&expr->expr_list, token->next);
>  		return expect(token, '}', "at end of initializer");
>  	}
> diff --git a/validation/Wuniv-init-ko.c b/validation/Wuniv-init-ko.c
> index 315c211a5db6..bd77a0af55bd 100644
> --- a/validation/Wuniv-init-ko.c
> +++ b/validation/Wuniv-init-ko.c
> @@ -4,11 +4,27 @@ struct s {
>  
>  
>  static struct s s = { 0 };
> +static int a = { 0 };
> +static int b = { };
> +static int c = { 1, 2 };
> +static struct s *ptr = { 0 };
> +
> +struct o {
> +	struct i {
> +		int a;
> +	};
> +};
> +
> +static struct o o = { 0 };
>  
>  /*
>   * check-name: univ-init-ko
>   *
>   * check-error-start
>  Wuniv-init-ko.c:6:23: warning: Using plain integer as NULL pointer
> +Wuniv-init-ko.c:8:16: error: invalid initializer
> +Wuniv-init-ko.c:9:16: error: invalid initializer
> +Wuniv-init-ko.c:10:26: warning: Using plain integer as NULL pointer
> +Wuniv-init-ko.c:18:23: warning: missing braces around initializer
>   * check-error-end
>   */
> diff --git a/validation/Wuniv-init-ok.c b/validation/Wuniv-init-ok.c
> index c39647517323..1f0c3dcb0c02 100644
> --- a/validation/Wuniv-init-ok.c
> +++ b/validation/Wuniv-init-ok.c
> @@ -4,8 +4,26 @@ struct s {
>  
>  
>  static struct s s = { 0 };
> +static int a = { 0 };
> +static int b = { };
> +static int c = { 1, 2 };
> +static struct s *ptr = { 0 };
> +
> +struct o {
> +	struct i {
> +		int a;
> +	};
> +};
> +
> +static struct o o = { 0 };
>  
>  /*
>   * check-name: univ-init-ok
>   * check-command: sparse -Wno-universal-initializer $file
> + *
> + * check-error-start
> +Wuniv-init-ok.c:8:16: error: invalid initializer
> +Wuniv-init-ok.c:9:16: error: invalid initializer
> +Wuniv-init-ok.c:10:26: warning: Using plain integer as NULL pointer
> + * check-error-end
>   */
> 
