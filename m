From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v2] ignore VOID when trying to if-convert phi-nodes
Date: Thu, 11 May 2017 13:57:36 -0700
Message-ID: <CANeU7QmNC3LQxE5_5n1Ab1DKVpBC+0zWD6NLn6j6CQB7qR7E=A@mail.gmail.com>
References: <CANeU7QmM5Rd6o8keZMHL-N2=_dKZg4iPg=M-FAYjqRpEavrj3Q@mail.gmail.com>
 <20170511204617.58622-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f42.google.com ([209.85.214.42]:38555 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932464AbdEKU5i (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 11 May 2017 16:57:38 -0400
Received: by mail-it0-f42.google.com with SMTP id e65so27193514ita.1
        for <linux-sparse@vger.kernel.org>; Thu, 11 May 2017 13:57:37 -0700 (PDT)
In-Reply-To: <20170511204617.58622-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

Looks good.

Signed-of-by: <sparse@chrisli.org>

On Thu, May 11, 2017 at 1:46 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> +static int get_phisources(struct instruction *sources[], int nbr, struct instruction *insn)
> +{
> +       pseudo_t phi;
> +       int i = 0;
> +
> +       assert(insn->opcode == OP_PHI);
> +       FOR_EACH_PTR(insn->phi_list, phi) {
> +               struct instruction *def;
> +               if (phi == VOID)
> +                       continue;
> +               if (i >= nbr)
> +                       return 1;
> +               def = phi->def;
> +               assert(def->opcode == OP_PHISOURCE);
> +               sources[i++] = def;
> +       } END_FOR_EACH_PTR(phi);
> +       return nbr - i;

Here if you want to return negative value it should be i - nbr.
Of course if you only care about return zero or not then it does
not matter. The call in this patch does only compare to zero
any way.

Chris
