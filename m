From: "Christopher Li" <sparse@chrisli.org>
Subject: Re: [RFC PATCH] Make "bad constant expression" a warning, not an error
Date: Fri, 20 Jun 2008 15:52:58 -0700
Message-ID: <70318cbf0806201552wb27c4f8v7dad63b1d9438f18@mail.gmail.com>
References: <1213974508.18379.2.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.227]:8906 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752915AbYFTWw7 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 20 Jun 2008 18:52:59 -0400
Received: by rv-out-0506.google.com with SMTP id k40so5857484rvb.1
        for <linux-sparse@vger.kernel.org>; Fri, 20 Jun 2008 15:52:59 -0700 (PDT)
In-Reply-To: <1213974508.18379.2.camel@dv>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
Cc: linux-sparse@vger.kernel.org

I object.

You should fix it in the parser side. When the parser call get expression
value, it really expect to get back a constant value. Make it return the
largest value on error is just wrong.

Chris

On Fri, Jun 20, 2008 at 8:08 AM, Pavel Roskin <proski@gnu.org> wrote:
> Do the same to "bad integer constant expression".  It's still possible
> to continue parsing the code if those are not constant.  To be on the
> safe side, assume the actual value to be the largest value for the
> type.
> ---
>
>  expand.c |   12 +++++++-----
>  1 files changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/expand.c b/expand.c
> index 032f0c5..12a8989 100644
> --- a/expand.c
> +++ b/expand.c
> @@ -1201,18 +1201,20 @@ static long long __get_expression_value(struct expression *expr, int strict)
>                expression_error(expr, "bad constant expression type");
>                return 0;
>        }
> +
> +       mask = 1ULL << (ctype->bit_size-1);
> +
>        expand_expression(expr);
>        if (expr->type != EXPR_VALUE) {
> -               expression_error(expr, "bad constant expression");
> -               return 0;
> +               warning(expr->pos, "bad constant expression");
> +               return mask;
>        }
>        if (strict && bad_integer_constant_expression(expr)) {
> -               expression_error(expr, "bad integer constant expression");
> -               return 0;
> +               warning(expr->pos, "bad integer constant expression");
> +               return mask;
>        }
>
>        value = expr->value;
> -       mask = 1ULL << (ctype->bit_size-1);
>
>        if (value & mask) {
>                while (ctype->type != SYM_BASETYPE)
>
> --
> Regards,
> Pavel Roskin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sparse" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
