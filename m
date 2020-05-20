From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v1 15/28] scope: __func__ is special
Date: Wed, 20 May 2020 01:45:50 +0100
Message-ID: <cbeaeb8a-698b-56e2-6e31-90547de54e89@ramsayjones.plus.com>
References: <20200519005728.84594-1-luc.vanoostenryck@gmail.com>
 <20200519005728.84594-16-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from avasout02.plus.net ([212.159.14.17]:32933 "EHLO
        avasout02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgETApx (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 19 May 2020 20:45:53 -0400
In-Reply-To: <20200519005728.84594-16-luc.vanoostenryck@gmail.com>
Content-Language: en-GB
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>



On 19/05/2020 01:57, Luc Van Oostenryck wrote:
> __func__ needs to be in the namepsace for symbols: NS_SYMBOL
> but doesn't follow the usual scope rules of them: it always
> needs to be declared in the function scope.
> 
> So, use bind_symbol_scoped() instead of first using bind_symbol()

s/bind_symbol_scoped/bind_symbol_with_scope/

ATB,
Ramsay Jones

> and then changing the namespace.
> Also change the comment to better express that it's the scope
> that is the unusual thing.
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  expression.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/expression.c b/expression.c
> index 78e577cf10a1..ffb3c2dce4d5 100644
> --- a/expression.c
> +++ b/expression.c
> @@ -122,9 +122,8 @@ static struct symbol *handle_func(struct token *token)
>  	decl->ctype.modifiers = MOD_STATIC;
>  	decl->endpos = token->pos;
>  
> -	/* function-scope, but in NS_SYMBOL */
> -	bind_symbol(decl, ident, NS_LABEL);
> -	decl->namespace = NS_SYMBOL;
> +	/* NS_SYMBOL but in function-scope */
> +	bind_symbol_with_scope(decl, ident, NS_SYMBOL, function_scope);
>  
>  	len = current_fn->ident->len;
>  	string = __alloc_string(len + 1);
> 
