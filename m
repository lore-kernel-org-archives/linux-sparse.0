From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v2 07/13] evaluate: check static storage duration
 objects' intializers' constness
Date: Tue, 26 Jan 2016 02:42:28 +0100
Message-ID: <20160126014227.GE46188@macpro.local>
References: <87twm1g1go.fsf@gmail.com>
 <87zivtemfq.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35221 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756102AbcAZBmc (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 25 Jan 2016 20:42:32 -0500
Received: by mail-wm0-f65.google.com with SMTP id 123so14633640wmz.2
        for <linux-sparse@vger.kernel.org>; Mon, 25 Jan 2016 17:42:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <87zivtemfq.fsf@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Nicolai Stange <nicstange@gmail.com>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>

On Mon, Jan 25, 2016 at 03:57:45PM +0100, Nicolai Stange wrote:
> Initializers of static storage duration objects shall be constant
> expressions [6.7.8(4)].
> 
> Warn if that requirement is not met and the -Wstatic-initializer-not-const
> flag has been given on sparse's command line.
> 
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

Better here also to split the patch in two:
one add the -W flag flag and another one which will use it.

ch > Signed-off-by: Nicolai Stange <nicstange@gmail.com>
> ---
>  evaluate.c                  |  26 ++++++++++-
>  lib.c                       |   2 +
>  lib.h                       |   2 +-
>  sparse.1                    |   7 +++
>  validation/constexpr-init.c | 110 ++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 145 insertions(+), 2 deletions(-)
>  create mode 100644 validation/constexpr-init.c
> 
> diff --git a/evaluate.c b/evaluate.c
> index 70f419f..e3b08e4 100644
> --- a/evaluate.c
> +++ b/evaluate.c
> @@ -2468,6 +2468,7 @@ static void handle_list_initializer(struct expression *expr,
>  {
>  	struct expression *e, *last = NULL, *top = NULL, *next;
>  	int jumped = 0;
> +	unsigned long old_modifiers;
>  
>  	FOR_EACH_PTR(expr->expr_list, e) {
>  		struct expression **v;
> @@ -2522,8 +2523,21 @@ found:
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

I don't understand why saving the mods is needed.
It feels hackish to me. Isn't it because something is done wrongly at another
level or maybe handle_simple_initializer() need an additional arg or so?

> @@ -2633,6 +2647,16 @@ static int handle_simple_initializer(struct expression **ep, int nested,
...
> +			warning(e->pos, "initializer for static storage duration object is not a constant expression");

This is quite longish message.
What about something like "non-constant initializer"?

> diff --git a/lib.c b/lib.c
> --- a/lib.c
> +++ b/lib.c
> @@ -241,6 +241,7 @@ int Wtypesign = 0;
>  int Wundef = 0;
>  int Wuninitialized = 1;
>  int Wvla = 1;
> +int Wstatic_initializer_not_const = 0;

Here also it's quite longish. Yes I'm a lazy typer :)
What about simply -Wconst-initializer ?
  
One thing that could be added (later and in another patch) is to 
set it by default when the C99 variant is selected.

>  enum {
> diff --git a/lib.h b/lib.h
> index 15b69fa..1b38db2 100644
> --- a/lib.h
> +++ b/lib.h
> @@ -127,7 +127,7 @@ extern int Wtypesign;
>  extern int Wundef;
>  extern int Wuninitialized;
>  extern int Wvla;
> -
> +extern int Wstatic_initializer_not_const;

Better to leave the blank line where it was.



Luc
