From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 3/8] early return if null ctype in evaluate_conditional()
Date: Sat, 10 Feb 2018 11:28:44 -0800
Message-ID: <CANeU7QmA+2WQcZRbgG9bb_N8su1SH90U3JFyyntiyijAXJbCxQ@mail.gmail.com>
References: <20180202121735.39621-1-luc.vanoostenryck@gmail.com> <20180202121735.39621-4-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:37618 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751381AbeBJT2q (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 10 Feb 2018 14:28:46 -0500
Received: by mail-qk0-f194.google.com with SMTP id c128so14078683qkb.4
        for <linux-sparse@vger.kernel.org>; Sat, 10 Feb 2018 11:28:45 -0800 (PST)
In-Reply-To: <20180202121735.39621-4-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Feb 2, 2018 at 4:17 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> NB: no functional changes here.
>
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  evaluate.c | 32 +++++++++++++++-----------------
>  1 file changed, 15 insertions(+), 17 deletions(-)
>
> diff --git a/evaluate.c b/evaluate.c
> index 027993983..1fc6111e4 100644
> --- a/evaluate.c
> +++ b/evaluate.c
> @@ -879,25 +879,23 @@ static struct symbol *evaluate_conditional(struct expression *expr, int iterator
>                 warning(expr->pos, "assignment expression in conditional");
>
>         ctype = evaluate_expression(expr);
> -       if (ctype) {
> -               if (is_safe_type(ctype))
> -                       warning(expr->pos, "testing a 'safe expression'");
> -               if (is_func_type(ctype)) {
> -                       if (Waddress)
> -                               warning(expr->pos, "the address of %s will always evaluate as true", "a function");
> -               } else if (is_array_type(ctype)) {
> -                       if (Waddress)
> -                               warning(expr->pos, "the address of %s will always evaluate as true", "an array");
> -               } else if (!is_scalar_type(ctype)) {
> -                       sparse_error(expr->pos, "incorrect type in conditional");
> -                       info(expr->pos, "   got %s", show_typename(ctype));
> -                       ctype = NULL;
> -               }
> +       if (!ctype)
> +               return NULL;
> +       if (is_safe_type(ctype))
> +               warning(expr->pos, "testing a 'safe expression'");
> +       if (is_func_type(ctype)) {
> +               if (Waddress)
> +                       warning(expr->pos, "the address of %s will always evaluate as true", "a function");
> +       } else if (is_array_type(ctype)) {
> +               if (Waddress)
> +                       warning(expr->pos, "the address of %s will always evaluate as true", "an array");
> +       } else if (!is_scalar_type(ctype)) {
> +               sparse_error(expr->pos, "incorrect type in conditional");
> +               info(expr->pos, "   got %s", show_typename(ctype));
> +               return NULL;

This is not straightly necessary to re-indent a section of the code.
It mess up the git annotation. For example, you can keep the "return NULL"
there and just move the

            ctype = degenerate(expr);

Inside if (ctype) statement block.

Any way, as you said, the function is the same.

Chris
