From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 1/2] split OP_BR between unconditional & conditional: OP_CBR
Date: Mon, 27 Feb 2017 23:02:23 +0800
Message-ID: <CANeU7Q=60E+2tvn=bdjaYnZFS3U3PMiTTq0=eYS-NkPDK3aJNA@mail.gmail.com>
References: <20170218012848.27417-1-luc.vanoostenryck@gmail.com> <20170218012848.27417-2-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f53.google.com ([209.85.214.53]:36078 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750934AbdB0PCZ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Feb 2017 10:02:25 -0500
Received: by mail-it0-f53.google.com with SMTP id h10so59704776ith.1
        for <linux-sparse@vger.kernel.org>; Mon, 27 Feb 2017 07:02:24 -0800 (PST)
In-Reply-To: <20170218012848.27417-2-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sat, Feb 18, 2017 at 9:28 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> This could be corrected in several ways (like changing all
> the places wheer the first test is used, use the helper
> everywhere or never set ->cond to VOID) but the simplest
> is to simply split them in two separated instructions:
> OP_BR & OP_CBR, especailly given the fact that in most cases
> the OP_BR was first selected by a switch (opcode).

I think that change itself is fine. The implications is that all sparse
back end user will need to be updated to use CBR instead of BR.

Sparse can be compiled as a lib to link against. We might want to
have some API version for sprase to check which version of sparse
it is.  Currently there is SPARSE_VERSION but that is a macro
which does not reflect in the lib version of sparse. That is a separate
patch though.

> @@ -811,9 +811,10 @@ static int rewrite_parent_branch(struct basic_block *bb, struct basic_block *old
>                 return 0;
>
>         switch (insn->opcode) {
> +       case OP_CBR:
> +               changed |= rewrite_branch(bb, &insn->bb_false, old, new);

We can use some comment of fall though the case here.

>         case OP_BR:
>                 changed |= rewrite_branch(bb, &insn->bb_true, old, new);
> -               changed |= rewrite_branch(bb, &insn->bb_false, old, new);
>                 assert(changed);
>                 return changed;
>         case OP_SWITCH: {
> @@ -886,9 +887,10 @@ static void vrfy_children(struct basic_block *bb)
>         }
>         switch (br->opcode) {
>                 struct multijmp *jmp;
> +       case OP_CBR:
> +               vrfy_bb_in_list(br->bb_false, bb->children);

Same here.

Chris
