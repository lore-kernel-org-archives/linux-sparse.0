From: "Christopher Li" <sparse@chrisli.org>
Subject: Re: [PATCH] Warn about explicit usage of sizeof(void) and sizeof(function)
Date: Thu, 25 Dec 2008 11:45:49 -0800
Message-ID: <70318cbf0812251145k1fa1e3bbh58b33a1aadf277cc@mail.gmail.com>
References: <4953C17B.8060803@numba-tu.com>
	 <20081225182817.26024.19045.stgit@zaytsev.su>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.232]:9972 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751524AbYLYTpu (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 25 Dec 2008 14:45:50 -0500
Received: by rv-out-0506.google.com with SMTP id k40so3288746rvb.1
        for <linux-sparse@vger.kernel.org>; Thu, 25 Dec 2008 11:45:49 -0800 (PST)
In-Reply-To: <20081225182817.26024.19045.stgit@zaytsev.su>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Cc: Tommy Thorn <tommy@numba-tu.com>, linux-sparse@vger.kernel.org

Hi Alexey,

On Thu, Dec 25, 2008 at 10:36 AM, Alexey Zaytsev
<alexey.zaytsev@gmail.com> wrote:
> I added (hopefully the right way) handling of (sizeof(function)) to the
> patch. function++ was already prohibited.

Can you send me an incremental patch for the sizeof(function) change?
BTW, is it one of the gcc special treatment as well?

Thanks

Chris

On Thu, Dec 25, 2008 at 10:36 AM, Alexey Zaytsev
<alexey.zaytsev@gmail.com> wrote:
> Tommy Thorn wrote:
>> Christopher Li wrote:
>>> So here is what I got. A patch address both of our need. It gives warning
>>> of using sizeof(void) explicitly. void* + offset will continue to work without
>>> warnings. It will also make is_byte_type() continue to work as it was
>>> before.
>>>
>>> Here is my test script:
>>>
> I added (hopefully the right way) handling of (sizeof(function)) to the
> patch. function++ was already prohibited.


>>> void *p;
>>>
>>> int i = sizeof(void);
>>> int j = sizeof(*p);
>>>
>
>> I can't test it right now, but does it give a warning for both sizeof's
>> above? If just first results in a warning, then I think that quite
>> reasonable.
>
> Both trigger the warning. I'm not sure this is a problem, as there are
> no such usage cases in the kernel.
>

>
> Running the test on the kernel right now.
>
> --
>
>
> From: Christopher Li <sparse@chrisli.org>
>
> sizeof(void) and sizeof(function) still evaluate as 1
> after the warning. void_ctype.bit_size remain zero so
> is_byte_type() will continue to work.
>
> Signed-Off-By: Christopher Li <sparse@chrisli.org>
> [sizeof(function) added by Alexey Zaytsev]
> Signed-off-by: Alexey Zaytsev <alexey.zaytsev@gmail.com>
> ---
>  evaluate.c |   13 ++++++++++++-
>  symbol.c   |    2 +-
>  2 files changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/evaluate.c b/evaluate.c
> index f976645..e82be53 100644
> --- a/evaluate.c
> +++ b/evaluate.c
> @@ -579,7 +579,7 @@ static struct symbol *evaluate_ptr_add(struct expression *expr, struct symbol *i
>        }
>
>        /* Get the size of whatever the pointer points to */
> -       multiply = bits_to_bytes(base->bit_size);
> +       multiply = (base == &void_ctype) ? 1 : bits_to_bytes(base->bit_size);
>
>        if (ctype == &null_ctype)
>                ctype = &ptr_ctype;
> @@ -2044,8 +2044,19 @@ static struct symbol *evaluate_sizeof(struct expression *expr)
>                return NULL;
>
>        size = type->bit_size;
> +
> +       if (type->ctype.base_type == &void_ctype) {
> +               warning(expr->pos, "expression using sizeof(void)");
> +               size = bits_in_char;
> +       }
> +
> +       if (is_function(type->ctype.base_type)) {
> +               warning(expr->pos, "expression using sizeof on a function");
> +               size = bits_in_char;
> +       }
>        if ((size < 0) || (size & (bits_in_char - 1)))
>                expression_error(expr, "cannot size expression");
> +
>        expr->type = EXPR_VALUE;
>        expr->value = bits_to_bytes(size);
>        expr->taint = 0;
> diff --git a/symbol.c b/symbol.c
> index 02844cf..4da253b 100644
> --- a/symbol.c
> +++ b/symbol.c
> @@ -834,7 +834,7 @@ static const struct ctype_declare {
>        struct symbol *base_type;
>  } ctype_declaration[] = {
>        { &bool_ctype,      SYM_BASETYPE, MOD_UNSIGNED,             &bits_in_bool,           &max_int_alignment, &int_type },
> -       { &void_ctype,      SYM_BASETYPE, 0,                        &bits_in_char,           NULL,               NULL },
> +       { &void_ctype,      SYM_BASETYPE, 0,                        NULL,                    NULL,               NULL },
>        { &type_ctype,      SYM_BASETYPE, MOD_TYPE,                 NULL,                    NULL,               NULL },
>        { &incomplete_ctype,SYM_BASETYPE, 0,                        NULL,                    NULL,               NULL },
>        { &bad_ctype,       SYM_BASETYPE, 0,                        NULL,                    NULL,               NULL },
>
>
