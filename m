From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] Fix wrong array size expression
Date: Wed, 1 Aug 2012 09:35:15 -0700
Message-ID: <CANeU7QmaMSAfNfX14=LjM9jpdWXmFjEyi-vRAQeeOpTdu3xatw@mail.gmail.com>
References: <50195447.2060407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:43054 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105Ab2HAQfT (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 1 Aug 2012 12:35:19 -0400
Received: by lbbgm6 with SMTP id gm6so452566lbb.19
        for <linux-sparse@vger.kernel.org>; Wed, 01 Aug 2012 09:35:17 -0700 (PDT)
In-Reply-To: <50195447.2060407@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Mauro Dreissig <mukadr@gmail.com>
Cc: linux-sparse@vger.kernel.org

Thanks for the good catch. That is simple and obvious correct.

Will apply.

Chris

On Wed, Aug 1, 2012 at 9:07 AM, Mauro Dreissig <mukadr@gmail.com> wrote:
> Signed-off-by: Mauro Dreissig <mukadr@gmail.com>
> ---
>  expression.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/expression.c b/expression.c
> index 0ae3a60..9f45c79 100644
> --- a/expression.c
> +++ b/expression.c
> @@ -655,7 +655,7 @@ static struct token *unary_expression(struct token *token, struct expression **t
>                                 { &__sizeof_ptr___ident, EXPR_PTRSIZEOF },
>                         };
>                         int i;
> -                       for (i = 0; i < 3; i++) {
> +                       for (i = 0; i < ARRAY_SIZE(type_information); i++) {
>                                 if (ident == type_information[i].id)
>                                         return type_info_expression(token, tree, type_information[i].type);
>                         }
> --
> 1.7.11.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sparse" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
