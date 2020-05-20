From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v1 16/28] scope: __label__ is special
Date: Wed, 20 May 2020 01:47:27 +0100
Message-ID: <92c02efb-7733-cca8-981d-b3d0c5b7909e@ramsayjones.plus.com>
References: <20200519005728.84594-1-luc.vanoostenryck@gmail.com>
 <20200519005728.84594-17-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from avasout02.plus.net ([212.159.14.17]:33069 "EHLO
        avasout02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbgETAra (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 19 May 2020 20:47:30 -0400
In-Reply-To: <20200519005728.84594-17-luc.vanoostenryck@gmail.com>
Content-Language: en-GB
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>



On 19/05/2020 01:57, Luc Van Oostenryck wrote:
> Labels declared wth __label__ are special because they must follow
> the block scope normally used for variables instad of using the

s/instad/instead/

> scope used for labels.
> 
> So, use bind_symbol_scoped() instead of first using bind_symbol()

s/bind_symbol_scoped/bind/symbol_with_scope/

ATB,
Ramsay Jones

> and then changing the namespace.
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  parse.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/parse.c b/parse.c
> index e23c5b64e8be..29e3f939166d 100644
> --- a/parse.c
> +++ b/parse.c
> @@ -2569,8 +2569,7 @@ static struct token *label_statement(struct token *token)
>  	while (token_type(token) == TOKEN_IDENT) {
>  		struct symbol *sym = alloc_symbol(token->pos, SYM_LABEL);
>  		/* it's block-scope, but we want label namespace */
> -		bind_symbol(sym, token->ident, NS_SYMBOL);
> -		sym->namespace = NS_LABEL;
> +		bind_symbol_with_scope(sym, token->ident, NS_LABEL, block_scope);
>  		fn_local_symbol(sym);
>  		token = token->next;
>  		if (!match_op(token, ','))
> 
