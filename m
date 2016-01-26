From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v2 13/13] symbol: do not inherit storage modifiers from
 base types at examination
Date: Tue, 26 Jan 2016 03:54:20 +0100
Message-ID: <20160126025418.GK46188@macpro.local>
References: <87twm1g1go.fsf@gmail.com>
 <87a8ntem2i.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34986 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933656AbcAZCyY (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 25 Jan 2016 21:54:24 -0500
Received: by mail-wm0-f66.google.com with SMTP id 123so14849869wmz.2
        for <linux-sparse@vger.kernel.org>; Mon, 25 Jan 2016 18:54:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <87a8ntem2i.fsf@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Nicolai Stange <nicstange@gmail.com>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Mon, Jan 25, 2016 at 04:05:41PM +0100, Nicolai Stange wrote:
> Consider the following code snippet:
>   static inline foo(int dummy, ...) {}
>   static int a = 0;
>   static void bar(void)
>   {
>   	foo(0, a);
>   }
> 
> Sparse moans:
>   test.c:5:9: warning: initializer for static storage duration object
>               is not a constant expression
> 
> The cause can be tracked down as follows:
> The anonymous node created by inline_function() for the variadic
> argument will get assigned to its base_type whatever the passed
> expression's ctype is. For the special case of a primary expression
> referencing a symbol, this ctype is the referenced symbol itself.
> Furthermore, inline_function() sets that symbol node's initializer
> to this expression.
> 
> Now, when the anonymous symbol node is evaluated, its base_type is
> handled in examine_base_type(). This applies the base_type's modifiers,
> i.e. the referenced symbol's MOD_STATIC in this case, to the inheriting
> ctype, that of the anonymous node, itself.
> This in turn instructs the evaluation of the symbol's initializer to
> allow constant expressions only.
> 
> Do not inherit a base_type's storage related modifiers in
> examine_base_type().


For this one ...
there is a lot to say about, not about your patch but about what should be done.

It should be noted that the warning only occurs because:
1) the function is inlined.
2) the function is variadic and the symbol is given in the variable part.
3) the symbol doesn't need integer promotion.
4) MOD_STORAGE is part of MOD_PTRINHERIT.

It would be good to show these conditions in the test case.

What I see in the code about calls is that when conditions 1, 2 & 3 are met
the argument to this variadic inline function is sorta used as-it-is while,
I think, a sort of l-value to r-value conversion should be done.
This conversion would essentially just adapting some of the modifiers:
clearing MOD_STORAGE (and maybe MOD_ADDRESSABLE).

For the condition 4), while digging in the code history (commit 822d3b1a222b),
it can be seen that MOD_STORAGE was added to MOD_PTRINHERIT without a real need;
quoting Linus:
	This still keeps other attributes, like "pointer to 'static'". Useful?
	Probably not. I'll have to think about it.

Normally it's not a problem to have it because unneeded modifiers are generally
filtered out or simply ignored.

So there is several ways to "fix" (or at least hide) this problem but it's not
clear to me what really should be done.

I added Linus in CC, his opinion on the subject would be precious.

NB. While looking at this one I've noted several other problems with modifier
    inheritance. I'll send an RFC in the coming hours or days.


Cheers,
Luc

> Signed-off-by: Nicolai Stange <nicstange@gmail.com>
> ---
>  symbol.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/symbol.c b/symbol.c
> index 0438dc4..5c94dc2 100644
> --- a/symbol.c
> +++ b/symbol.c
> @@ -214,7 +214,8 @@ static struct symbol *examine_base_type(struct symbol *sym)
>  	if (!base_type || base_type->type == SYM_PTR)
>  		return base_type;
>  	sym->ctype.as |= base_type->ctype.as;
> -	sym->ctype.modifiers |= base_type->ctype.modifiers & MOD_PTRINHERIT;
> +	sym->ctype.modifiers |= base_type->ctype.modifiers & MOD_PTRINHERIT &
> +		~MOD_STORAGE;
>  	concat_ptr_list((struct ptr_list *)base_type->ctype.contexts,
>  			(struct ptr_list **)&sym->ctype.contexts);
>  	if (base_type->type == SYM_NODE) {
