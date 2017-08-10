From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v4 7/9] transform (A & M) >> S to (A >> S) & (M >> S)
Date: Wed, 9 Aug 2017 21:16:07 -0400
Message-ID: <CANeU7QmSNz8vTjiukmakHsWHveKkA-8bLY_E4AtfKRbKUtJSCA@mail.gmail.com>
References: <CANeU7Qk99kn3etn8yoEKKFzcW15wHjt7OYPSpZhqCDc4DE3EDQ@mail.gmail.com>
 <20170809193806.30975-1-luc.vanoostenryck@gmail.com> <20170809193806.30975-8-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:37671 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752497AbdHJBQI (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 9 Aug 2017 21:16:08 -0400
Received: by mail-yw0-f195.google.com with SMTP id s143so5282437ywg.4
        for <linux-sparse@vger.kernel.org>; Wed, 09 Aug 2017 18:16:08 -0700 (PDT)
In-Reply-To: <20170809193806.30975-8-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Aug 9, 2017 at 3:38 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> This is especially usefull when simplifying code
> accessing bitfields.
>
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  simplify.c                 | 29 ++++++++++++++++++++++++++++-
>  validation/bitfield-size.c |  4 +---
>  2 files changed, 29 insertions(+), 4 deletions(-)
>
> diff --git a/simplify.c b/simplify.c
> index 40d4f0068..e8bf1c171 100644
> --- a/simplify.c
> +++ b/simplify.c
> @@ -411,6 +411,32 @@ static int simplify_asr(struct instruction *insn, pseudo_t pseudo, long long val
>         return 0;
>  }
>
> +static int simplify_lsr(struct instruction *insn, pseudo_t pseudo, long long value)
> +{
> +       struct instruction *def;
> +       unsigned long long mask;
> +
> +       if (!value)
> +               return replace_with_pseudo(insn, pseudo);
> +       switch (def_opcode(insn->src1)) {
> +       case OP_AND:
> +               // replace (A & M) >> S
> +               // by      (A >> S) & (M >> S)

A little bit suggestion base on my previous reading and question ask on
this. When I first read the comment without reading the code, then I would
wondering why (A>>S) & (M>>S) is simpler. The following code actually
explain the constant mask very well. So the comment best understand if
the code was read. Adding some comment on M is constant will help a
lot in the comment.

Not a reason to object the patch of course. Just suggestions.

Chris
