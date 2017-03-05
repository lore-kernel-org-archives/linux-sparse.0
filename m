From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v3 4/7] add a method to external_declaration()
Date: Sun, 5 Mar 2017 22:04:01 +0800
Message-ID: <CANeU7Qk34VzZ6Q2oxEcFrreK=NOwmpSGbiVgvyckpp154xWJaQ@mail.gmail.com>
References: <20170228094635.qbod5dwqwrw6etvt@macbook.local>
 <20170228100403.33184-1-luc.vanoostenryck@gmail.com> <20170228100403.33184-5-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f54.google.com ([209.85.214.54]:38365 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752238AbdCEOED (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Mar 2017 09:04:03 -0500
Received: by mail-it0-f54.google.com with SMTP id m27so36722207iti.1
        for <linux-sparse@vger.kernel.org>; Sun, 05 Mar 2017 06:04:02 -0800 (PST)
In-Reply-To: <20170228100403.33184-5-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Feb 28, 2017 at 6:04 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> The changes are made up of:
> - extract the part 'add local symbols to the list' to a separate
>   function: default_process_decl() as preparatory step to make
> - replace the part 'add local symbols to the list' by a call
>   to a new function pointer given in argument,
>
> Also, to make the change non-invasive for others files:
> - rename 'external_declaration()' into 'external_decl()'
> - make 'external_declaration()' a small helper calling
>   'external_decl()' with 'default_process_decl()' as the method.

I will apply this patch in the sparse-next with some minor comment.
Mostly naming the function.

> ---
>  parse.c | 27 ++++++++++++++++++++-------
>  1 file changed, 20 insertions(+), 7 deletions(-)
>
> diff --git a/parse.c b/parse.c
> index d07b27a21..b9b8d1ae0 100644
> --- a/parse.c
> +++ b/parse.c
> @@ -48,6 +48,9 @@ static struct symbol_list **function_symbol_list;
>  struct symbol_list *function_computed_target_list;
>  struct statement_list *function_computed_goto_list;
>
> +typedef void (*process_decl_t)(struct symbol_list **list, struct symbol *decl);
> +static struct token *external_decl(struct token *, process_decl_t, struct symbol_list **);
> +
>  static struct token *statement(struct token *token, struct statement **tree);
>  static struct token *handle_attributes(struct token *token, struct decl_state *ctx, unsigned int keywords);
>
> @@ -2797,7 +2800,8 @@ static struct token *toplevel_asm_declaration(struct token *token, struct symbol
>         return token;
>  }
>
> -struct token *external_declaration(struct token *token, struct symbol_list **list)
> +static struct token *external_decl(struct token *token, process_decl_t process_decl,
> +               struct symbol_list **list)

I am fine with the code logic change. However, I wish function has better names.
It just looking at the function name, "external_decl" vs "external_declaration",
it is hard to guess which function is lower level than the other.

> -               }
> +               if (!is_typedef)
> +                       process_decl(list, decl);

I think here better check the process_decl is not NULL.
The caller might issue NULL call back which means it is not
interested in adding the symbol to a list.
> +
> +static void default_process_decl(struct symbol_list **list, struct symbol *decl)
> +{
> +       if (!(decl->ctype.modifiers & (MOD_EXTERN | MOD_INLINE))) {
> +               add_symbol(list, decl);
> +               fn_local_symbol(decl);
> +       }

Again, if I look at just pure function name "default_process_decl", it is
very hard to me to guess what should happen in this function.
After all, "process a declare" is very generic, it can mean any thing.

I suggest a more meaningful name related what the code does.
e.g. "track_local_declaration". I don't know, I want to find a better name.
You are welcome to suggest a better one.

> +}
> +
> +struct token *external_declaration(struct token *token, struct symbol_list **list)
> +{
> +       return external_decl(token, default_process_decl, list);
> +}

If I don't have a better function name for external_decl, I might just not use
the wrapper function at all.

Chris
