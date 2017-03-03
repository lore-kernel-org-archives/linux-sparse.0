From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: [PATCH] llvm: fix output_op_[ptr]cast()
Date: Fri, 3 Mar 2017 07:37:22 +0000
Message-ID: <CACXZuxcN_5H+Ur53axpwbxy-LwQX2fANp5x6GUU-jU+7b4_2tw@mail.gmail.com>
References: <CACXZuxcd6q6c5VzsYME01nzUhKzLjzvxTDt3juSbNB226APTTg@mail.gmail.com>
 <20170303052459.2351-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f41.google.com ([209.85.214.41]:36486 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752069AbdCCOaO (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 3 Mar 2017 09:30:14 -0500
Received: by mail-it0-f41.google.com with SMTP id h10so13599926ith.1
        for <linux-sparse@vger.kernel.org>; Fri, 03 Mar 2017 06:30:13 -0800 (PST)
In-Reply-To: <20170303052459.2351-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Luc,

On 3 March 2017 at 05:24, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> This should fox the problems of mixed types in casts.
> Without much testing but should be essentialy OK.
>
> CC: Dibyendu Majumdar <mobile@majumdar.org.uk>
> ---
>  sparse-llvm.c | 40 +++++++++++++++++++++++++++++++++++-----
>  1 file changed, 35 insertions(+), 5 deletions(-)
>
> diff --git a/sparse-llvm.c b/sparse-llvm.c
> index edd0615ec..92ad26845 100644
> --- a/sparse-llvm.c
> +++ b/sparse-llvm.c
> @@ -763,6 +763,8 @@ static void output_op_phi(struct function *fn, struct instruction *insn)
>  static void output_op_ptrcast(struct function *fn, struct instruction *insn)
>  {
>         LLVMValueRef src, target;
> +       LLVMTypeRef dtype;
> +       LLVMOpcode op;
>         char target_name[64];
>
>         src = insn->src->priv;
> @@ -773,15 +775,31 @@ static void output_op_ptrcast(struct function *fn, struct instruction *insn)
>
>         assert(!symbol_is_fp_type(insn->type));
>
> -       target = LLVMBuildBitCast(fn->builder, src, insn_symbol_type(fn->module, insn), target_name);
> +       dtype = insn_symbol_type(fn->module, insn);
> +       switch (LLVMGetTypeKind(LLVMTypeOf(src))) {
> +       case LLVMPointerTypeKind:
> +               op = LLVMBitCast;
> +               break;
> +       case LLVMIntegerTypeKind:
> +               op = LLVMIntToPtr;
> +               break;
> +       default:
> +               assert(0);
> +       }
>
> +       target = LLVMBuildCast(fn->builder, op, src, dtype, target_name);
>         insn->target->priv = target;
>  }
>
>  static void output_op_cast(struct function *fn, struct instruction *insn, LLVMOpcode op)
>  {
>         LLVMValueRef src, target;
> +       LLVMTypeRef dtype;
>         char target_name[64];
> +       unsigned int width;
> +
> +       if (is_ptr_type(insn->type))
> +               return output_op_ptrcast(fn, insn);
>
>         src = insn->src->priv;
>         if (!src)
> @@ -791,11 +809,23 @@ static void output_op_cast(struct function *fn, struct instruction *insn, LLVMOp
>
>         assert(!symbol_is_fp_type(insn->type));
>
> -       if (insn->size < LLVMGetIntTypeWidth(LLVMTypeOf(src)))
> -               target = LLVMBuildTrunc(fn->builder, src, insn_symbol_type(fn->module, insn), target_name);
> -       else
> -               target = LLVMBuildCast(fn->builder, op, src, insn_symbol_type(fn->module, insn), target_name);
> +       dtype = insn_symbol_type(fn->module, insn);
> +       switch (LLVMGetTypeKind(LLVMTypeOf(src))) {
> +       case LLVMPointerTypeKind:
> +               op = LLVMPtrToInt;
> +               break;
> +       case LLVMIntegerTypeKind:
> +               width = LLVMGetIntTypeWidth(LLVMTypeOf(src));
> +               if (insn->size < width)
> +                       op = LLVMTrunc;
> +               else if (insn->size == width)
> +                       op = LLVMBitCast;
> +               break;
> +       default:
> +               assert(0);
> +       }
>
> +       target = LLVMBuildCast(fn->builder, op, src, dtype, target_name);
>         insn->target->priv = target;
>  }
>


This doesn't quite work. The problem is that in op_cast, the pointer
is being cast to int, but subsequent operations expect a pointer.

Regards
