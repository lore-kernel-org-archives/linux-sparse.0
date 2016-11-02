From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH 1/3] Warn on unknown attributes instead of throwing errors
Date: Wed, 2 Nov 2016 22:29:41 +0000
Message-ID: <f9d05ae2-8e1d-c743-f73a-9a02499fea77@ramsayjones.plus.com>
References: <20161102215939.36765-1-luc.vanoostenryck@gmail.com>
 <20161102215939.36765-2-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from avasout03.plus.net ([84.93.230.244]:32920 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755897AbcKBWhY (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 2 Nov 2016 18:37:24 -0400
In-Reply-To: <20161102215939.36765-2-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>



On 02/11/16 21:59, Luc Van Oostenryck wrote:
> GCC creates new attributes quite often, generaly for specific
> usages irrelevant to what sparse is used for.
> Throwing errors on these create needless noise and annoyance
> which is better to avoid.
> 
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  parse.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/parse.c b/parse.c
> index 205e1264..212fae3a 100644
> --- a/parse.c
> +++ b/parse.c
> @@ -1230,7 +1230,8 @@ static struct token *recover_unknown_attribute(struct token *token)
>  {
>  	struct expression *expr = NULL;
>  
> -	sparse_error(token->pos, "attribute '%s': unknown attribute", show_ident(token->ident));
> +	if (Wunknown_attribute)

Since Wunknown_attribute is not declared yet, this won't even compile.
Simply squash this into patch #2.

Apart from that, looks good.

Thanks!

ATB,
Ramsay Jones
