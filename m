From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 2/2] builtin: make builtins more builtin
Date: Tue, 7 Nov 2017 09:38:00 +0800
Message-ID: <CANeU7Qn+gSxPy+RMGGTJ4rmhwZyMLkzpGQt2-G+jYNtgRCd4qw@mail.gmail.com>
References: <20171106201628.98470-1-luc.vanoostenryck@gmail.com> <20171106201628.98470-3-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f196.google.com ([209.85.161.196]:44350 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752603AbdKGBiB (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 6 Nov 2017 20:38:01 -0500
Received: by mail-yw0-f196.google.com with SMTP id k11so9605511ywh.1
        for <linux-sparse@vger.kernel.org>; Mon, 06 Nov 2017 17:38:01 -0800 (PST)
In-Reply-To: <20171106201628.98470-3-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Nov 7, 2017 at 4:16 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> Currently, (most) builtin functions are declared like
> a normal function prototype. Furthermore, these declarations
> is done via the pre-buffer mechanism and thus need to be
> tokenized & parsed like normal code.
> This is far from being 'builtin'.
>
> Change this by skipping this pre-buffer phase and directly creating
> the appropriate symbol for them.
>
> Note: the correct mechanism to be used to make them really builtin
>       is via init_builtins(), used when we have a real semantic
>       action for the builtin.
>
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  builtin.c | 165 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  lib.c     | 157 ++---------------------------------------------------------
>  symbol.h  |   1 +
>  3 files changed, 171 insertions(+), 152 deletions(-)
>
> diff --git a/builtin.c b/builtin.c
> index 9f90926cb..987ca9b3a 100644
> --- a/builtin.c
> +++ b/builtin.c
> @@ -27,6 +27,7 @@
>  #include "expand.h"
>  #include "symbol.h"
>  #include "compat/bswap.h"
> +#include <stdarg.h>
>
>  static int evaluate_to_int_const_expr(struct expression *expr)
>  {
> @@ -259,3 +260,167 @@ void init_builtins(int stream)
>                 sym->op = ptr->op;
>         }
>  }
> +
> +static void declare_builtin(const char *name, struct symbol *rtype, int variadic, ...)
> +{
> +       int stream = 0;                 // FIXME
> +       struct symbol *sym = create_symbol(stream, name, SYM_NODE, NS_SYMBOL);
> +       struct symbol *fun = alloc_symbol(sym->pos, SYM_FN);
> +       struct symbol *arg;
> +       va_list args;
> +
> +       sym->ident->reserved = 1;
> +       sym->ctype.base_type = fun;
> +       sym->ctype.modifiers = MOD_TOPLEVEL;
> +
> +       fun->ctype.base_type = rtype;
> +       fun->variadic = variadic;
> +
> +       va_start(args, variadic);
> +       while ((arg = va_arg(args, struct symbol *))) {
> +               struct symbol *anode = alloc_symbol(sym->pos, SYM_NODE);
> +               anode->ctype.base_type = arg;
> +               add_symbol(&fun->arguments, anode);
> +       }
> +       va_end(args);
> +}
> +
> +void declare_builtins(void)
> +{
> +       struct symbol *va_list_ctype = &ptr_ctype;
> +
> +       declare_builtin("__builtin_abort", &void_ctype, 0, NULL);
> +       declare_builtin("__builtin_abs", &int_ctype , 0, &int_ctype, NULL);
> +       declare_builtin("__builtin_alloca", &ptr_ctype, 0, size_t_ctype, NULL);
> +       declare_builtin("__builtin_alpha_cmpbge", &long_ctype, 0, &long_ctype, &long_ctype, NULL);
> +       declare_builtin("__builtin_alpha_extbl", &long_ctype, 0, &long_ctype, &long_ctype, NULL);
> +       declare_builtin("__builtin_alpha_extwl", &long_ctype, 0, &long_ctype, &long_ctype, NULL);

Hi Luc,

I like the direction this patch is heading.

I think you can change the  declare_builtin to be driven by table (C
structure array).
Rather than explicit function call. That will both save code do you
don't need to deal with
the variance part.

Thanks

Chris
