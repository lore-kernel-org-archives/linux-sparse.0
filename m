From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v3 6/7] make process_decl() aware of the presence of an initializer
Date: Sun, 5 Mar 2017 22:49:37 +0800
Message-ID: <CANeU7Qm1oPqK=56=c8q=dtVBr27vF0NufGgCr4Y0RYnyJVfBQg@mail.gmail.com>
References: <20170228094635.qbod5dwqwrw6etvt@macbook.local>
 <20170228100403.33184-1-luc.vanoostenryck@gmail.com> <20170228100403.33184-7-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f171.google.com ([209.85.223.171]:33494 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752470AbdCEO5f (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Mar 2017 09:57:35 -0500
Received: by mail-io0-f171.google.com with SMTP id f84so98430546ioj.0
        for <linux-sparse@vger.kernel.org>; Sun, 05 Mar 2017 06:57:34 -0800 (PST)
In-Reply-To: <20170228100403.33184-7-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Feb 28, 2017 at 6:04 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:


> @@ -2896,7 +2896,9 @@ static struct token *external_decl(struct token *token, process_decl_t process_d
>         }
>
>         for (;;) {
> +               int has_init = 0;
>                 if (!is_typedef && match_op(token, '=')) {
> +                       has_init = 1;

This can be written as:

int has_init = !is_typedef && match_op(token, '=');
if (has_init) {
     ....

>                         if (decl->ctype.modifiers & MOD_EXTERN) {
>                                 warning(decl->pos, "symbol with external linkage has initializer");
>                                 decl->ctype.modifiers &= ~MOD_EXTERN;
> @@ -2904,7 +2906,7 @@ static struct token *external_decl(struct token *token, process_decl_t process_d
>                         token = initializer(&decl->initializer, token->next);
>                 }
>                 if (!is_typedef)
> -                       process_decl(list, decl);
> +                       process_decl(list, decl, has_init);

My comment regarding patch 5/7 still stands valid here. If you keep the common
logic here, move the code from "default_process_decl" body back to here.
You can avoid passing has_init into process_decl at all.

Passing the "has_init" into a call back function make the code hard to
read because the logic has separated into two function. At the same time
process_for_loop_decl does not issue this warning at all, I think it should.

I will apply this patch for sparse-next, I agree the warning is useful
behavior. I am also expecting a follow up patch.

Chris
