From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v4 32/63] llvm: add support for OP_SETVAL with floats
Date: Thu, 23 Mar 2017 22:53:15 -0700
Message-ID: <CANeU7QmUAe+K20pV_oiv0UB3RjGEatAo0TBtTSzW9jwcuuqQ8A@mail.gmail.com>
References: <20170321001607.75169-1-luc.vanoostenryck@gmail.com> <20170321001607.75169-33-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f51.google.com ([209.85.214.51]:38520 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751313AbdCXFxR (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 24 Mar 2017 01:53:17 -0400
Received: by mail-it0-f51.google.com with SMTP id y18so4144754itc.1
        for <linux-sparse@vger.kernel.org>; Thu, 23 Mar 2017 22:53:16 -0700 (PDT)
In-Reply-To: <20170321001607.75169-33-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>

On Mon, Mar 20, 2017 at 5:15 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> --- a/sparse-llvm.c
> +++ b/sparse-llvm.c
> @@ -866,6 +866,23 @@ static void output_op_cast(struct function *fn, struct instruction *insn, LLVMOp
>         insn->target->priv = target;
>  }
>
> +static void output_op_setval(struct function *fn, struct instruction *insn)
> +{
> +       struct expression *val = insn->val;
> +       LLVMTypeRef dtype = symbol_type(insn->type);
> +       LLVMValueRef target;
> +
> +       switch (val->type) {
> +       case EXPR_FVALUE:
> +               target = LLVMConstReal(dtype, val->fvalue);
> +               break;
> +       default:
> +               assert(0);

If there is just one case and default, maybe "if" statement is good enough?
Switch statement is kind of over kill here.

Chris
