From: Pekka Enberg <penberg@kernel.org>
Subject: Re: [PATCH] fix casting to bool
Date: Sun, 19 May 2013 10:47:27 +0300
Message-ID: <CAOJsxLGWnegLeB-O6PQy_JkCV_06bqf9N8pTnsxsKAphgcZSnw@mail.gmail.com>
References: <1368737766-6517-1-git-send-email-xi.wang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:59418 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751882Ab3ESHr3 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 19 May 2013 03:47:29 -0400
Received: by mail-wi0-f182.google.com with SMTP id c10so1290720wiw.15
        for <linux-sparse@vger.kernel.org>; Sun, 19 May 2013 00:47:28 -0700 (PDT)
In-Reply-To: <1368737766-6517-1-git-send-email-xi.wang@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Xi Wang <xi.wang@gmail.com>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Thu, May 16, 2013 at 11:56 PM, Xi Wang <xi.wang@gmail.com> wrote:
> Consider the following function.
>
>         static _Bool foo(int x) { return x; }
>
> Currently sparse emits:
>
>         scast.1     %r2 <- (32) %arg1
>         ret.1       %r2
>
> This is incorrect since bool requires a zero test.
>
>         setne.32    %r2 <- %arg1, $0
>         ret.1       %r2
>
> This patch adds zero testing for bool in cast_to().
>
> Signed-off-by: Xi Wang <xi.wang@gmail.com>

Acked-by: Pekka Enberg <penberg@kernel.org>

> ---
>  evaluate.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/evaluate.c b/evaluate.c
> index d9c767f..a090028 100644
> --- a/evaluate.c
> +++ b/evaluate.c
> @@ -272,6 +272,18 @@ static struct expression * cast_to(struct expression *old, struct symbol *type)
>         if (old->ctype != &null_ctype && is_same_type(old, type))
>                 return old;
>
> +       /* bool requires a zero test */
> +       if (is_bool_type(type)) {
> +               expr = alloc_expression(old->pos, EXPR_COMPARE);
> +               expr->op = SPECIAL_NOTEQUAL;
> +               expr->ctype = type;
> +               expr->left = old;
> +               expr->right = alloc_expression(old->pos, EXPR_VALUE);
> +               expr->right->ctype = old->ctype;
> +               expr->right->value = 0;
> +               return expr;
> +       }
> +
>         /*
>          * See if we can simplify the op. Move the cast down.
>          */
> --
> 1.8.1.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sparse" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
