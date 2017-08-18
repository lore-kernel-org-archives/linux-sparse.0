From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 13/29] add insert_phi_node()
Date: Fri, 18 Aug 2017 16:39:31 -0400
Message-ID: <CANeU7QkAM=5Z+Ksn+Wjx66kF=Hz3pumfADiHQAs74AoKdYC4=A@mail.gmail.com>
References: <20170816153455.97693-1-luc.vanoostenryck@gmail.com> <20170816153455.97693-14-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f178.google.com ([209.85.161.178]:36461 "EHLO
        mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751695AbdHRUjc (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 18 Aug 2017 16:39:32 -0400
Received: by mail-yw0-f178.google.com with SMTP id u207so65529883ywc.3
        for <linux-sparse@vger.kernel.org>; Fri, 18 Aug 2017 13:39:32 -0700 (PDT)
In-Reply-To: <20170816153455.97693-14-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Wed, Aug 16, 2017 at 11:34 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> +pseudo_t insert_phi_node(struct basic_block *bb, struct symbol *type)
> +{
> +       struct instruction *phi_node = alloc_typed_instruction(OP_PHI, type);
> +       struct instruction *insn;
> +       pseudo_t phi;
> +
> +       phi = alloc_pseudo(phi_node);
> +       phi_node->target = phi;
> +       phi_node->bb = bb;
> +
> +       FOR_EACH_PTR(bb->insns, insn) {
> +               enum opcode op = insn->opcode;
> +               if (op == OP_ENTRY || op == OP_PHI)
> +                       continue;
> +               INSERT_CURRENT(phi_node, insn);

You do need to preserve the order of the phi node, right?
At first I was thinking always insert the phi at the first instruction.
Then I realized that, it is possible some phi node use some other
phi node as source in case of a loop. So the order does need
to be preserved some how.

> +               return phi;
> +       } END_FOR_EACH_PTR(insn);
> +
> +       add_instruction(&bb->insns, phi_node);
> +       return phi;
> +}
> +


Chris
