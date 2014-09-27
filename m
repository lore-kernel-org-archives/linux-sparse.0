From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v2 01/10] Add the __restrict__ keyword
Date: Sat, 27 Sep 2014 08:47:43 +0800
Message-ID: <CANeU7QkWoXrrjdZvDFCM4yzFH7h70=1WraB7m3ggVrCan11dwQ@mail.gmail.com>
References: <53E3DD56.1030706@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:41821 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750793AbaI0Arq (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 26 Sep 2014 20:47:46 -0400
Received: by mail-wg0-f42.google.com with SMTP id z12so274437wgg.1
        for <linux-sparse@vger.kernel.org>; Fri, 26 Sep 2014 17:47:44 -0700 (PDT)
In-Reply-To: <53E3DD56.1030706@ramsay1.demon.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

Catching up my backlog.

On Fri, Aug 8, 2014 at 4:11 AM, Ramsay Jones <ramsay@ramsay1.demon.co.uk> wrote:
>
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> ---
>
> Hi Chris,
>
> I added a separate test file (alternate-keywords.c) which includes
> test cases for restrict, __restrict and __restrict__. I also included
> some additional tests for other alternative keywords (hence the name
> of the file), namely inline, typeof and their variants.

Looks good.

> Just for the
> record, I don't know of any use of __restrict__ in an abstract array
> declaration on _any_ platform.

If there is no code using the __restrict__ for abstract array, we shouldn't need
this line:

> @@ -1553,7 +1554,7 @@ static struct token *abstract_array_declarator(struct token *token, struct symbo
>
>         token = abstract_array_static_declarator(token, &has_static);
>
> -       if (match_idents(token, &restrict_ident, &__restrict_ident, NULL))
> +       if (match_idents(token, &restrict_ident, &__restrict_ident, &__restrict___ident, NULL))
>                 token = abstract_array_static_declarator(token->next, &has_static);
>         token = parse_expression(token, &expr);
>         sym->array_size = expr;

Or, if you have valid reason to add it. Please provide a test case for
this code path.

Thanks

Chris
