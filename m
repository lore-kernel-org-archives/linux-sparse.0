From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 4/5] add a method to external_declaration()
Date: Mon, 27 Feb 2017 23:37:09 +0800
Message-ID: <CANeU7Q=X66U4F1nGTdNH1q+mNF=JU9s8z=we0Gbpep4F6X-vgA@mail.gmail.com>
References: <20170218203048.22276-1-luc.vanoostenryck@gmail.com> <20170218203048.22276-5-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f170.google.com ([209.85.223.170]:35546 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751291AbdB0Qrz (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Feb 2017 11:47:55 -0500
Received: by mail-io0-f170.google.com with SMTP id j18so35244388ioe.2
        for <linux-sparse@vger.kernel.org>; Mon, 27 Feb 2017 08:47:29 -0800 (PST)
In-Reply-To: <20170218203048.22276-5-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Feb 19, 2017 at 4:30 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> After parsing and validation, the symbols in the declaration
> are added to the list given in argument, *if* they are not extern
> symbols. The symbols that are extern are them not added to the list.
>
> This is what is needed for usual declarations but ignoring extern
> symbols make it impossible to emit a diagnostic in less usual
> situation.

I have other situation want to use this as well.

> --- a/parse.h
> +++ b/parse.h
> @@ -129,7 +129,8 @@ extern int show_statement(struct statement *);
>  extern void show_statement_list(struct statement_list *, const char *);
>  extern int show_expression(struct expression *);
>
> -extern struct token *external_declaration(struct token *token, struct symbol_list **list);
> +typedef void (*add_decl_t)(struct symbol_list **list, struct symbol *decl);
> +extern struct token *external_declaration(struct token *token, add_decl_t add_decl, struct symbol_list **list);
>

I think the logic should be, "external_declaration" accept token as input.
For each newly declared symbol, it call to the callbacks function
to receive the symbol. The receive behavior is depend on the callback
function. The default function can be adding the symbol to a list.

So the struct symbol_list **list should turn into transparent argument as
context for the call back.

> --- a/lib.c
> +++ b/lib.c
> @@ -1080,7 +1080,7 @@ static struct symbol_list *sparse_tokenstream(struct token *token)
>
>         // Parse the resulting C code
>         while (!eof_token(token))
> -               token = external_declaration(token, &translation_unit_used_list);
> +               token = external_declaration(token, NULL, &translation_unit_used_list);

I prefer here just provide the default call back which is
add_stmt_decl in your case.

>         return translation_unit_used_list;
>  }
>
> diff --git a/parse.c b/parse.c
> index a4a126720..866186fd2 100644
> --- a/parse.c
> +++ b/parse.c
> @@ -2230,7 +2230,7 @@ static struct token *parse_for_statement(struct token *token, struct statement *
>         e1 = NULL;
>         /* C99 variable declaration? */
>         if (lookup_type(token)) {
> -               token = external_declaration(token, &syms);
> +               token = external_declaration(token, NULL, &syms);

Same here.


>         } else {
>                 token = parse_expression(token, &e1);
>                 token = expect(token, ';', "in 'for'");
> @@ -2457,7 +2457,7 @@ static struct token * statement_list(struct token *token, struct statement_list
>                                 seen_statement = 0;
>                         }
>                         stmt = alloc_statement(token->pos, STMT_DECLARATION);
> -                       token = external_declaration(token, &stmt->declaration);
> +                       token = external_declaration(token, NULL, &stmt->declaration);

And here.

> +       if (!add_decl)
> +               add_decl = add_stmt_decl;
> +

We don't need this if we ask the caller to provide the call back.


>         for (;;) {
>                 if (!is_typedef && match_op(token, '=')) {
>                         if (decl->ctype.modifiers & MOD_EXTERN) {
> @@ -2873,10 +2884,7 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
>                         token = initializer(&decl->initializer, token->next);
>                 }
>                 if (!is_typedef) {
> -                       if (!(decl->ctype.modifiers & (MOD_EXTERN | MOD_INLINE))) {
> -                               add_symbol(list, decl);
> -                               fn_local_symbol(decl);
> -                       }
> +                       add_decl(list, decl);
change this to some thing like:

if (add_decl)
                   add_decl(decl, decl_args);


>                 }
>                 check_declaration(decl);
>                 if (decl->same_symbol) {


Chris
