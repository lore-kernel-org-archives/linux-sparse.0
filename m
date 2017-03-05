From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v3 5/7] check the storage of C99 for-loop initializers
Date: Sun, 5 Mar 2017 22:26:53 +0800
Message-ID: <CANeU7Qn0Tk=cJdiXY4fjNkdOXnECmvZHCeoD-2dW6B0TceQQmQ@mail.gmail.com>
References: <20170228094635.qbod5dwqwrw6etvt@macbook.local>
 <20170228100403.33184-1-luc.vanoostenryck@gmail.com> <20170228100403.33184-6-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f43.google.com ([209.85.214.43]:34901 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752470AbdCEO5n (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Mar 2017 09:57:43 -0500
Received: by mail-it0-f43.google.com with SMTP id 203so36419708ith.0
        for <linux-sparse@vger.kernel.org>; Sun, 05 Mar 2017 06:57:43 -0800 (PST)
In-Reply-To: <20170228100403.33184-6-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Feb 28, 2017 at 6:04 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> In C99, it is valid to declare a variable inside a
> for-loop initializer but only when the storage is local
> (automatic or register).
> Until now this was not enforced.
>

Will apply in sparse-next with some comment.

>
> +static void process_for_loop_decl(struct symbol_list **list, struct symbol *sym)
> +{
> +       unsigned long storage;
> +
> +       storage = sym->ctype.modifiers & MOD_STORAGE;
> +       if (storage & ~(MOD_AUTO | MOD_REGISTER)) {
> +               const char *name = show_ident(sym->ident);
> +               sparse_error(sym->pos, "non-local var '%s' in for-loop initializer", name);
> +               sym->ctype.modifiers &= ~MOD_STORAGE;
> +       }
> +
> +       add_symbol(list, sym);
> +       fn_local_symbol(sym);

The more I look at it, the more I feel that the above two lines
should kind of appear in every process_*_declar function.

So may be we should just change your patch 4/7 into:

               if (!is_typedef) {

+                     if (process_decl)
+                                process_decl(sym);

                       if (!(decl->ctype.modifiers & (MOD_EXTERN |
MOD_INLINE))) {
                               add_symbol(list, decl);
                               fn_local_symbol(decl);
                       }
               }

Then for the default case, just pass NULL as process_decl. Might want
to find a better name for this function callback arguments as well.

Because you are actually not interested in change the behavor of adding
to the list at all. You just want to get an notification when the symbol does
get added into the list. Now thing of it, I can't come up with one example
process_xxx_decl not add the symbol nor doing the fn_local_symbol.

Chris
