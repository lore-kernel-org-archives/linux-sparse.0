From: Pekka Enberg <penberg@kernel.org>
Subject: Re: [PATCH] fix pointer casts in evaluate_compare()
Date: Sun, 19 May 2013 10:48:51 +0300
Message-ID: <CAOJsxLEy3A72isV1OFL4rUm=B6Z659h1ZXsExSn9pzG2GSmukQ@mail.gmail.com>
References: <1368737733-6475-1-git-send-email-xi.wang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:43177 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752501Ab3ESHsx (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 19 May 2013 03:48:53 -0400
Received: by mail-wg0-f53.google.com with SMTP id m15so92158wgh.32
        for <linux-sparse@vger.kernel.org>; Sun, 19 May 2013 00:48:52 -0700 (PDT)
In-Reply-To: <1368737733-6475-1-git-send-email-xi.wang@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Xi Wang <xi.wang@gmail.com>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>

On Thu, May 16, 2013 at 11:55 PM, Xi Wang <xi.wang@gmail.com> wrote:
> The results of cast_to() seem unused.  Assign them to expr->left and
> expr->right.
>
> Signed-off-by: Xi Wang <xi.wang@gmail.com>

How did you find about this? Is this needed to fix a reproducible issue?

> ---
>  evaluate.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/evaluate.c b/evaluate.c
> index 0dfa519..d9c767f 100644
> --- a/evaluate.c
> +++ b/evaluate.c
> @@ -1024,11 +1024,11 @@ static struct symbol *evaluate_compare(struct expression *expr)
>                         goto OK;
>                 }
>                 if (is_null1 && (rclass & TYPE_PTR)) {
> -                       left = cast_to(left, rtype);
> +                       expr->left = cast_to(left, rtype);
>                         goto OK;
>                 }
>                 if (is_null2 && (lclass & TYPE_PTR)) {
> -                       right = cast_to(right, ltype);
> +                       expr->right = cast_to(right, ltype);
>                         goto OK;
>                 }
>         }
> @@ -1044,11 +1044,11 @@ static struct symbol *evaluate_compare(struct expression *expr)
>         if (expr->op == SPECIAL_EQUAL || expr->op == SPECIAL_NOTEQUAL) {
>                 if (ltype->ctype.as == rtype->ctype.as) {
>                         if (lbase == &void_ctype) {
> -                               right = cast_to(right, ltype);
> +                               expr->right = cast_to(right, ltype);
>                                 goto OK;
>                         }
>                         if (rbase == &void_ctype) {
> -                               left = cast_to(left, rtype);
> +                               expr->left = cast_to(left, rtype);
>                                 goto OK;
>                         }
>                 }
> --
> 1.8.1.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sparse" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
