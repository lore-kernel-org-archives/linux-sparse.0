Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728472080C8
	for <linux-sparse@vger.kernel.org>; Mon,  1 Dec 2025 19:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764616998; cv=none; b=cP4gt5qnam1YwaiLt1nc2YsDCjj4TfK/j2qN8whBGCjCncEYNCqjnRLOIOlgY5BWHk4Nx5L2DNKVqG0D4wadZqUHFA1+X6are9Cmi9NFGh/r5EUwyNiZG5qDrtLOdG4m3fsYTGp50qfdtqjuPQgQQCjl8RqwgOMQ7XUF1LBTypM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764616998; c=relaxed/simple;
	bh=1MOuXPtrfNdgRAqC0y6h6GBEPyIwlN6RqUvVUPX+vW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f99CwQ5iRGHsIkOKBZqsfbPcWZcdeTV4FRXYT5LEWzA9ICO60bULnv7KvYFydI/p93T/Fdn1D0EGWobWhB7cl20c4oATJRzsFGJP8ExXOp2UeI4HZFTXTBQa7wTe3vfs52JNuc3lmDD0x2RQT8PnJJUFivoNgNcLyNUd7/tGrXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org; spf=pass smtp.mailfrom=chrisli.org; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisli.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-78a6a7654a4so40857417b3.0
        for <linux-sparse@vger.kernel.org>; Mon, 01 Dec 2025 11:23:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764616995; x=1765221795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OhO60kpAJgBx9y24pyS19YirHgKmAYSHET/tiVd8XT0=;
        b=K98hVZ5DbTYcDn88jFP/AKNoaw4xI6KI4AV9qNV+QgW3jjr8AJsF1p/j6GOgW7Cw1P
         iRIBpvWbFMJ/UuvF9X0y5ai8GWRPX7emGXk3/VJyNqQWu3ppriERycZx1O/+Y+w50pbn
         vIsGxhRUje3OB7R9HDWY0u3qN68SZu0PN+R+Mczdu34ybochIGWwDrCDXoyXjdnBeje5
         G3hxkUh9dkJ+9L7H+swBkYi+WTQNE8BLDtp0iUJVrqje7XSA5X+5PKo8i6HFkgSkxg0T
         pTJ7bnX88O312NmUwdgHovfYCbSrh/yjXvpyebplXH4svYCLNeUuRBEjDnYuBdBzIjvH
         KNYA==
X-Gm-Message-State: AOJu0YweCgisF0aOhcOq96vvmjgTZkOmrpFdRe8Up3NvnkzxjHGlLNDi
	6QAkZPNa5GuaPG3nW1Hf47yMAJq+8q5v+wrVehnF0/CUyVmdk9+LVRzLDiFKsUDJiqIFqV8tJDo
	Kn0Ii4m0RkCfDWeaqwEmXAz5tQiqS96crnC3xnuEZGObSQwDJnvgDTto=
X-Gm-Gg: ASbGncuU/ZcLOCm+4xba9ULmLb7lINzswIL6eEM5F32AgvcCOlk+U2oGmMnoXuBlKZs
	3WmZcVfVSVo6pCNXTkHQF7SPBJH4BFxEHVgtPBkXnFTOX1QIcB0V8flUT0lB5KLiK6aboFwCBGg
	6BPNBACCw2QiSWKhJseU+7firLB5CT+MUUr4Zs+TL6416V0M8COUxUXmJDXACTt778GpDPzSTun
	0JVNtMD1wWUEsbuYGEOxlcH77M1AuSTBYwpoJJRuzD+g61s0nIrkuvwYq9z3h/2R+mrvSMssoF8
	4dLgFGbksziw6v+zB1oS0vC3AiwW
X-Google-Smtp-Source: AGHT+IFjEAJSlOttQfUDO1IkXCd+UTGXiyYLcbdHrpYwy+CuRwKWhQ6EOXFy71xf3l8WhgREUQVvKYkw2IKkdF1zG1c=
X-Received: by 2002:a05:690c:9c01:b0:787:dbe1:8cbc with SMTP id
 00721157ae682-78a8b479f53mr311097977b3.8.1764616995099; Mon, 01 Dec 2025
 11:23:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020153918.812235-1-ben.dooks@codethink.co.uk> <20251020153918.812235-2-ben.dooks@codethink.co.uk>
In-Reply-To: <20251020153918.812235-2-ben.dooks@codethink.co.uk>
From: Chris Li <sparse@chrisli.org>
Date: Mon, 1 Dec 2025 23:23:04 +0400
X-Gm-Features: AWmQ_bkQYgqFenSsEGKudQDob1zYEQ7hH34bMNKwRk2nsR6UL4N0pRXupTXlERM
Message-ID: <CACePvbVvsAPURh+jfb2Vh8cPsOzuR2HmzuD9j5Gf6GJyD2orng@mail.gmail.com>
Subject: Re: [PATCH RESEND2 1/4] parse: initial parsing of __attribute__((format))
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-sparse@vger.kernel.org, 
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ben,

Thanks for the patch and sorry for the late reply.

Your format attribute series work applies to the sparse-dev tree fine
and "make check" runs fine as well. Thank you so much.

I have some trivial coding style of feedback for you, see the comments
below. Mostly just nitpicks, does not impact the coding behavior. Let
me know if you want to update a new series or I can be lazy and just
apply your current series.

Chris

On Mon, Oct 20, 2025 at 7:39=E2=80=AFPM Ben Dooks <ben.dooks@codethink.co.u=
k> wrote:
>
> Add code to parse the __attribute__((format)) used to indicate that
> a variadic function takes a printf-style format string and where
> those are. Save the data in ctype ready for checking when such an
> function is encoutered.
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  parse.c  | 81 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  symbol.h |  9 ++++++-
>  2 files changed, 88 insertions(+), 2 deletions(-)
>
> diff --git a/parse.c b/parse.c
> index 3f67451e..af4e5b50 100644
> --- a/parse.c
> +++ b/parse.c
> @@ -86,7 +86,7 @@ static attr_t
>         attribute_cleanup,
>         attribute_designated_init,
>         attribute_transparent_union, ignore_attribute,
> -       attribute_mode, attribute_force;
> +       attribute_mode, attribute_force, attribute_format;
>
>  typedef struct symbol *to_mode_t(struct symbol *);
>
> @@ -121,6 +121,12 @@ static void asm_modifier(struct token *token, unsign=
ed long *mods, unsigned long
>         *mods |=3D mod;
>  }
>
> +/* the types of formatting from __attribute__((format)) */
> +enum {
> +       FMT_PRINTF =3D 0,
> +       FMT_SCANF,
> +};
> +
>  static struct symbol_op typedef_op =3D {
>         .type =3D KW_MODIFIER,
>         .declarator =3D storage_specifier,
> @@ -382,6 +388,10 @@ static struct symbol_op attr_force_op =3D {
>         .attribute =3D attribute_force,
>  };
>
> +static struct symbol_op attr_format_op =3D {
> +       .attribute =3D attribute_format,
> +};
> +
>  static struct symbol_op address_space_op =3D {
>         .attribute =3D attribute_address_space,
>  };
> @@ -441,6 +451,16 @@ static struct symbol_op mode_word_op =3D {
>         .to_mode =3D to_word_mode
>  };
>
> +static struct symbol_op attr_printf_op =3D {
> +       .type   =3D KW_FORMAT,
> +       .class  =3D FMT_PRINTF,
> +};
> +
> +static struct symbol_op attr_scanf_op =3D {
> +       .type   =3D KW_FORMAT,
> +       .class  =3D FMT_SCANF,
> +};
> +
>  /*
>   * Define the keyword and their effects.
>   * The entries in the 'typedef' and put in NS_TYPEDEF and
> @@ -557,6 +577,9 @@ static struct init_keyword {
>         D("pure",               &attr_fun_op,           .mods =3D MOD_PUR=
E),
>         A("const",              &attr_fun_op,           .mods =3D MOD_PUR=
E),
>         D("gnu_inline",         &attr_fun_op,           .mods =3D MOD_GNU=
_INLINE),
> +       D("format",             &attr_format_op),
> +       D("printf",             &attr_printf_op),
> +       D("scanf",              &attr_scanf_op),
>
>         /* Modes */
>         D("mode",               &mode_op),
> @@ -1217,6 +1240,60 @@ static struct token *attribute_address_space(struc=
t token *token, struct symbol
>         return token;
>  }
>
> +static int invalid_format_args(long long start, long long at)
> +{
> +       return start < 0 || at < 0 || start > USHRT_MAX || at > USHRT_MAX=
 ||
> +               (start =3D=3D at && start > 0) ||
> +               (start =3D=3D 0 && at =3D=3D 0);
> +}
> +
> +static struct token *attribute_format(struct token *token, struct symbol=
 *attr, struct decl_state *ctx)
> +{
> +       struct expression *args[3];

I notice that you never use the args as an array, e.g. pass "args" to
any function. You always use args[n] as scalar.
In that case, it is better to make each args as individual variables
with proper names. When I read your patch, I need to lookup gcc
document for the format attribute to understand each args. I found
this:

format (archetype, string-index, first-to-check)

I assume that matches your three args. Then just name the expression
"archetype", "stridx", "first2check" something like that. You get the
idea. I just make up the variable name on the spot, you can probably
find a better variable name than I do.

> +       struct symbol *fmt_sym =3D NULL;
> +
> +       /* expecting format ( type, start, va_args at) */
> +
> +       token =3D expect(token, '(', "after format attribute");
> +       if (token_type(token) =3D=3D TOKEN_IDENT)
> +               fmt_sym =3D lookup_keyword(token->ident, NS_KEYWORD);
> +       if (fmt_sym)
> +               if (!fmt_sym->op || fmt_sym->op->type !=3D KW_FORMAT)

This two if statement can be combined into one if statement with
compound test expression:
if (fmt_sym && (!fmt_sym->op || fmt_sym->op->type !=3D KW_FORMAT))

> +                       fmt_sym =3D NULL;
> +
> +       token =3D conditional_expression(token, &args[0]);

See above, give args[0] a proper name that would be more readable.

> +       token =3D expect(token, ',', "format attribute type");
> +       token =3D conditional_expression(token, &args[1]);

Same.

> +       token =3D expect(token, ',', "format attribute type position");
> +       token =3D conditional_expression(token, &args[2]);

Same.

> +       token =3D expect(token, ')', "format attribute arg position");
> +
> +       if (!fmt_sym || !args[0] || !args[1] || !args[2]) {
> +               warning(token->pos, "incorrect format attribute");

In such cases, the kernel source code often bails out early to make
the rest of code flater.
e.g.:
                "goto done" here or "return toke";

> +       } else if (fmt_sym->op->class !=3D FMT_PRINTF) {

If you follow the above suggestion. "} else if () {" becomes "if ()".
That looks cleaner

> +               /* skip anything that isn't printf for the moment */
> +               warning(token->pos, "only printf format attribute support=
ed");

You can also bail out or return early here to save the following "else"

> +       } else {

Use the above suggestion to remove one level of indentation.

> +               long long start, at;
> +
> +               start =3D get_expression_value(args[2]);

args[2] can use the nice variable name if you follow the above suggestion.

> +               at =3D get_expression_value(args[1]);
> +
> +               if (invalid_format_args(start, at)) {
> +                       warning(token->pos, "bad format positions");

Same here, bail out early can make the function flatter.

> +               } else if (start =3D=3D 0) {
> +                       /* nothing to do here, is va_list function */
Same here.

> +               } else if (start < at) {
> +                       warning(token->pos, "format cannot be after va_ar=
gs");
Same.

> +               } else {

This else can be removed if bail out early above.

> +                       ctx->ctype.format.index =3D at;
> +                       ctx->ctype.format.first =3D start;
> +               }
> +       }
> +
> +       return token;
> +}
> +
>  static struct symbol *to_QI_mode(struct symbol *ctype)
>  {
>         if (ctype->ctype.base_type !=3D &int_type)
> @@ -3007,6 +3084,8 @@ struct token *external_declaration(struct token *to=
ken, struct symbol_list **lis
>
>                 if (!(decl->ctype.modifiers & MOD_STATIC))
>                         decl->ctype.modifiers |=3D MOD_EXTERN;
> +
> +               base_type->ctype.format =3D decl->ctype.format;
>         } else if (base_type =3D=3D &void_ctype && !(decl->ctype.modifier=
s & MOD_EXTERN)) {
>                 sparse_error(token->pos, "void declaration");
>         }
> diff --git a/symbol.h b/symbol.h
> index 88130c15..0ea46da8 100644
> --- a/symbol.h
> +++ b/symbol.h
> @@ -82,8 +82,9 @@ enum keyword {
>         KW_ASM          =3D 1 << 5,
>         KW_MODE         =3D 1 << 6,
>         KW_STATIC       =3D 1 << 7,
> -     // KW UNUSED      =3D 1 << 8,
> +       // KW_UNUSED    =3D 1 << 8.
>         KW_EXACT        =3D 1 << 9,

Nobody is using KW_UNUSED. Just delete it and let KW_EXACT use 1 << 8.

> +       KW_FORMAT       =3D 1 << 10,
Move up this to 1 << 9.


>  };
>
>  struct context {
> @@ -95,12 +96,18 @@ extern struct context *alloc_context(void);
>
>  DECLARE_PTR_LIST(context_list, struct context);
>
> +struct attr_format {
> +       unsigned short index;   /* index in argument list for format stri=
ng */
> +       unsigned short first;   /* where first variadic argument is */
> +};
> +
>  struct ctype {
>         struct symbol *base_type;
>         unsigned long modifiers;
>         unsigned long alignment;
>         struct context_list *contexts;
>         struct ident *as;
> +       struct attr_format format;

The struct attr_format is very small, adding it here should be fine.
Keep in mind that the struct ctype is a very common data structure in
sparse. Most of the ctype symbols will not have the attr_format
declared. We might want to move the non common ctype into ctype
extensions struct and only store a pointer to the extension struct if
not NULL.

Using the extension attribute I need to check NULL first. It will save
memory space for almost all of the common  ctype.
Because the format member is very small, two shorts, a pointer would
be the same size. We can just add it as it is.


Chris
