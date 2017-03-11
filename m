From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v2 00/27] LLVM fixes
Date: Sat, 11 Mar 2017 15:12:02 +0100
Message-ID: <20170311141201.kptzqgn4qpu3gaic@macbook.local>
References: <20170311090706.17171-1-luc.vanoostenryck@gmail.com>
 <CACXZuxc8rbcGSO9dTkFSKST8UJkDgc2ifFae5=Y+cojtm5qb3Q@mail.gmail.com>
 <20170311114903.zrhufw6ydneky3ya@macbook.local>
 <CACXZuxcL4NHa2Ahdtu91rANDFTUw8hY9BizN-9pLgpyQ2wPf-w@mail.gmail.com>
 <20170311123039.tcpo2dcajfmxwmsm@macbook.local>
 <CACXZuxc4F-PgDQO0p-nYB0D6NkrJf7cS0qWB=SkO5tQJzGFpxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:37035 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755601AbdCKOMH (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Mar 2017 09:12:07 -0500
Received: by mail-wm0-f42.google.com with SMTP id n11so12918939wma.0
        for <linux-sparse@vger.kernel.org>; Sat, 11 Mar 2017 06:12:06 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CACXZuxc4F-PgDQO0p-nYB0D6NkrJf7cS0qWB=SkO5tQJzGFpxQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>, Pekka Enberg <penberg@kernel.org>, Jeff Garzik <jeff@garzik.org>

On Sat, Mar 11, 2017 at 01:36:30PM +0000, Dibyendu Majumdar wrote:
> > Here you're hitting the OP_SET{EQ,...} case.
> >
> 
> Here is my attempt to fix:
> 
> static struct symbol *pseudo_get_type(pseudo_t pseudo) {
>  switch (pseudo->type) {
>  case PSEUDO_SYM:
>  case PSEUDO_ARG:
>   return pseudo->sym;
>  case PSEUDO_PHI:
>  case PSEUDO_REG:
>   return pseudo->def->type;
>  default:
>   assert(0);
>   return NULL;
>  }
> }
> static void output_op_compare(struct function *fn, struct instruction *insn)
> {
>  LLVMValueRef lhs, rhs, target;
>  char target_name[64];
>  if (insn->src1->type == PSEUDO_VAL)
>   lhs = val_to_value(fn, insn->src1->value, pseudo_get_type(insn->src2));
>  else
>   lhs = pseudo_to_value(fn, insn, insn->src1);
>  if (insn->src2->type == PSEUDO_VAL)
>   //rhs = LLVMConstInt(LLVMTypeOf(lhs), insn->src2->value, 1);
>   rhs = val_to_value(fn, insn->src2->value, pseudo_get_type(insn->src1));
>  else
>   rhs = pseudo_to_value(fn, insn, insn->src2);
> 
> 
> Does this look like the right thing to do?

I didn't tested it but it looks correct and it is certainly OK for now.
I made the patch "give a type to PSEUDO_ARGs" with this in mind.

I'll take it the others ones.

However I'm slowly looking at a more generic solution.
For example, it would certainly be easier if there would be a
OP_PTRCAST between a constant-value-used-as-a-pointer and its use.
The cost would be some missing optimizations, or more complex ones
or a sort of normalization pass.

-- Luc Van Oostenryck
