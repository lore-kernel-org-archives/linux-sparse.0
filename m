From: "Chris Li" <christ.li@gmail.com>
Subject: Re: attributes are not stored at right location for array variables
Date: Wed, 31 Jan 2007 11:53:51 -0800
Message-ID: <70318cbf0701311153k126d4aeam5f68f1c519d3a7af@mail.gmail.com>
References: <AKEOJDDJLNPHDAKOMMBHGEPKCPAA.mshah@teja.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:44308 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932175AbXAaTxx (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 31 Jan 2007 14:53:53 -0500
Received: by ug-out-1314.google.com with SMTP id 44so269780uga
        for <linux-sparse@vger.kernel.org>; Wed, 31 Jan 2007 11:53:52 -0800 (PST)
In-Reply-To: <AKEOJDDJLNPHDAKOMMBHGEPKCPAA.mshah@teja.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Mitesh Shah <mshah@teja.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

Your patch assumes every attribute apply to node instead of type.
Is there any attribute need to apply to type instead?

For your change, apply_modifiers() need to change where it take the
__mode__ attribute as well.

Chris


On 1/31/07, Mitesh Shah <mshah@teja.com> wrote:
>
> It seems that the attributes are not stored with the variable ctype when the variable is an array. For declaration such as,
>
> char c[100] __attribute__((aligned(64)));
>
> The attribute is stored with the array ctype instead of the variable C ctype.
>
> In function direct_declarator in parse.c at line 920 the ctype gets replaced with the array ctype and in the next iteration it is
> passed to handle_attributes. handle_attributes should be passed the original ctype so here is the patch.
>
> Thanks,
>
> -Mitesh
>
> -------------------------------------------------------
>
> index 5077ee6..306b144 100644
> --- a/parse.c
> +++ b/parse.c
> @@ -881,7 +881,7 @@ static struct token *direct_declarator(struct token *token, struct symbol *decl,
>         }
>
>         for (;;) {
> -               token = handle_attributes(token, ctype);
> +               token = handle_attributes(token, &decl->ctype);
>
>                 if (token_type(token) != TOKEN_SPECIAL)
>                         return token;
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-sparse" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
