From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 09/29] add helper to test if a variable is "simple"
Date: Thu, 17 Aug 2017 03:19:16 -0400
Message-ID: <CANeU7QmU30Oafe5Peq6D5tnfBE+k=T+tttt3_vV0MeDGbbTZxQ@mail.gmail.com>
References: <20170816153455.97693-1-luc.vanoostenryck@gmail.com> <20170816153455.97693-10-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:35692 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750741AbdHQHTR (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 17 Aug 2017 03:19:17 -0400
Received: by mail-yw0-f195.google.com with SMTP id c13so854807ywa.2
        for <linux-sparse@vger.kernel.org>; Thu, 17 Aug 2017 00:19:17 -0700 (PDT)
In-Reply-To: <20170816153455.97693-10-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Wed, Aug 16, 2017 at 11:34 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> Here by 'simple' we really mean 'worth of putting in a register'.
>
> We select all scalar types as well as struct and unions with a
> size not bigger than a long (register).
>
> Global and static variables, variables which address have been
> taken and volatiles variables are never selected.
>
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  symbol.h | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>
> diff --git a/symbol.h b/symbol.h
> index 327449611..3f075c5bc 100644
> --- a/symbol.h
> +++ b/symbol.h
> @@ -407,6 +407,39 @@ static inline int is_scalar_type(struct symbol *type)
>         return 0;
>  }
>
> +static inline int is_simple_type(struct symbol *type)
...
> +       case SYM_STRUCT:
> +       case SYM_UNION:
> +               return type->bit_size <= long_ctype.bit_size;

I think the function name should be some thing along the
line of "type fits register" or is_registerable_type.

union and struct are composite types. It is a bit
confusing calling them simple, if some one just looking
at the code without look at the commit message.


Chris
