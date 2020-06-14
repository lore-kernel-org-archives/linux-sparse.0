From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH] attribute: parse but ignore enum attributes
Date: Sun, 14 Jun 2020 20:35:10 +0100
Message-ID: <402dc19b-9d5f-d42b-169f-a96a2cc16a58@ramsayjones.plus.com>
References: <20200614160235.22320-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from avasout06.plus.net ([212.159.14.18]:44385 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbgFNTfP (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 14 Jun 2020 15:35:15 -0400
In-Reply-To: <20200614160235.22320-1-luc.vanoostenryck@gmail.com>
Content-Language: en-GB
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, linux-sparse@vger.kernel.org



On 14/06/2020 17:02, Luc Van Oostenryck wrote:
> Currently, sparse is confused whne encountering an enum attribute.

s/whne/when/

ATB,
Ramsay Jones

> 
> Teach sparse about these attributes and, for now, ignore them.
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  parse.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/parse.c b/parse.c
> index 570b2516714f..70d8b237ce5e 100644
> --- a/parse.c
> +++ b/parse.c
> @@ -937,8 +937,12 @@ static struct token *parse_enum_declaration(struct token *token, struct symbol *
>  	while (token_type(token) == TOKEN_IDENT) {
>  		struct expression *expr = NULL;
>  		struct token *next = token->next;
> +		struct decl_state ctx = { };
>  		struct symbol *sym;
>  
> +		// FIXME: only 'deprecated' should be accepted
> +		next = handle_attributes(next, &ctx, KW_ATTRIBUTE);
> +
>  		if (match_op(next, '=')) {
>  			next = constant_expression(next->next, &expr);
>  			lastval = get_expression_value(expr);
> 
