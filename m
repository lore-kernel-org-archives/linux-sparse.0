From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 01/10] Add the __restrict__ keyword
Date: Wed, 6 Aug 2014 02:19:54 -0700
Message-ID: <CANeU7Qkr5oX-_iLRXTt6DKD4pCwV3LoWPy9CuhQ0kk9NLz7s_Q@mail.gmail.com>
References: <53DFD1D2.5050600@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qg0-f42.google.com ([209.85.192.42]:60573 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751792AbaHFJTz (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 6 Aug 2014 05:19:55 -0400
Received: by mail-qg0-f42.google.com with SMTP id j5so2357249qga.29
        for <linux-sparse@vger.kernel.org>; Wed, 06 Aug 2014 02:19:54 -0700 (PDT)
In-Reply-To: <53DFD1D2.5050600@ramsay1.demon.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Mon, Aug 4, 2014 at 11:32 AM, Ramsay Jones
<ramsay@ramsay1.demon.co.uk> wrote:
>
> -       if (match_idents(token, &restrict_ident, &__restrict_ident, NULL))
> +       if (match_idents(token, &restrict_ident, &__restrict_ident, &__restrict___ident, NULL))
>                 token = abstract_array_static_declarator(token->next, &has_static);
>         token = parse_expression(token, &expr);
>         sym->array_size = expr;
> diff --git a/validation/reserved.c b/validation/reserved.c
> index caacd21..e5d7af8 100644
> --- a/validation/reserved.c
> +++ b/validation/reserved.c
> @@ -30,6 +30,7 @@ reserved.c:8:12: error: Trying to use reserved word '__const' as identifier
>  reserved.c:9:12: error: Trying to use reserved word '__const__' as identifier
>  reserved.c:10:12: error: Trying to use reserved word 'restrict' as identifier
>  reserved.c:11:12: error: Trying to use reserved word '__restrict' as identifier
> +reserved.c:12:12: error: Trying to use reserved word '__restrict__' as identifier
>  reserved.c:13:12: error: Trying to use reserved word 'typedef' as identifier
>  reserved.c:14:12: error: Trying to use reserved word '__typeof' as identifier
>  reserved.c:15:12: error: Trying to use reserved word '__typeof__' as identifier

Can you give more test case for __restrict__? Your patch seems suggest that you
hit some  code use "__restruct__" for abstract array declaration. Did
that actually
happen? I want to get some example.

Chris
