From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v3 20/21] symbol: do not inherit storage modifiers from
 base types at examination
Date: Tue, 15 Mar 2016 21:31:42 +0100
Message-ID: <20160315203141.GB2417@macpro.local>
References: <87lh75jh9l.fsf@gmail.com>
 <877fipgnaw.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:34108 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932347AbcCOUbr (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 15 Mar 2016 16:31:47 -0400
Received: by mail-wm0-f43.google.com with SMTP id p65so161463354wmp.1
        for <linux-sparse@vger.kernel.org>; Tue, 15 Mar 2016 13:31:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <877fipgnaw.fsf@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Nicolai Stange <nicstange@gmail.com>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>

On Mon, Feb 01, 2016 at 03:46:31AM +0100, Nicolai Stange wrote:
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
> 
> Signed-off-by: Nicolai Stange <nicstange@gmail.com>
> ---
>  symbol.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/symbol.c b/symbol.c
> index 42e6a8f..4766adb 100644
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
> -- 


Mmmm ...

As I already said in the v2 of this serie, it's a complicated case,
and yes this change certainly quite the warning.
However I don't think it's the right fix.

For info, my previous analysis & comment was:
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

However, some time ago I sent another patch for 2)
Chris has already taken it:
	7647c775497f ("Do not drop 'nocast' modifier when taking the address")
even thought it doesn't yet appears on sparse/sparse.git

So, once this last one will be on the master tree, this patch will be moot.


Luc
