From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] Print an error if typeof() lacks an argument
Date: Sun, 26 Apr 2009 23:38:51 -0700
Message-ID: <70318cbf0904262338g698eb2g7265b472fb0efd46@mail.gmail.com>
References: <20090425130343.3df87cbb@notas>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-gx0-f166.google.com ([209.85.217.166]:58425 "EHLO
	mail-gx0-f166.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756735AbZD0Giw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 27 Apr 2009 02:38:52 -0400
Received: by gxk10 with SMTP id 10so4456402gxk.13
        for <linux-sparse@vger.kernel.org>; Sun, 26 Apr 2009 23:38:51 -0700 (PDT)
In-Reply-To: <20090425130343.3df87cbb@notas>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Martin Nagy <mnagy@redhat.com>
Cc: linux-sparse@vger.kernel.org

On Sat, Apr 25, 2009 at 4:03 AM, Martin Nagy <mnagy@redhat.com> wrote:
>
> We weren't checking if the initializer isn't NULL, which caused spars=
e
> to segfault later on when performing lazy evaluation in classify_type=
().
>
> Signed-off-by: Martin Nagy <nagy.martin@gmail.com>
> ---
> =A0parse.c | =A0 17 +++++++++++------
> =A01 files changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/parse.c b/parse.c
> index 9662122..18cfaef 100644
> --- a/parse.c
> +++ b/parse.c
> @@ -924,12 +924,17 @@ static struct token *typeof_specifier(struct to=
ken *token, struct decl_state *ct
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ctx->ctype.base_type =3D sym->ctype.ba=
se_type;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0apply_ctype(token->pos, &sym->ctype, &=
ctx->ctype);
> =A0 =A0 =A0 =A0} else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct symbol *typeof_sym =3D alloc_sym=
bol(token->pos, SYM_TYPEOF);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 token =3D parse_expression(token->next,=
 &typeof_sym->initializer);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 typeof_sym->endpos =3D token->pos;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctx->ctype.base_type =3D typeof_sym;
> - =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct expression *expr;

I think you want expr =3D NULL here. Otherwise if(expr) will pick up cr=
ap.

I would just add two lines after "token =3D
parse_expression(token->next, &typeof_sym->initializer);"

if (!type->initializer)
        sparse_error(token->pos, "expected expression after the '(' tok=
en");

If there is compile error, the sparse should not continue the later
stage any way.

BTW, can you add a validation test case which will trigger the bug?

Thanks

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
