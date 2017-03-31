From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] fix OP_PHI usage in try_to_simplify_bb(), correctly
Date: Sat, 1 Apr 2017 07:27:47 +0800
Message-ID: <CANeU7QmX3ZgkC4RjecbNp8TvCnYUr4LzY4364AV-6EeJTbjC5A@mail.gmail.com>
References: <CACXZuxeomDxKsmdu7e5YEg_-3exNpV-psjQ_o3P0BLV1A2=z0Q@mail.gmail.com>
 <20170322105331.91596-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:33862 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932868AbdCaX1t (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 31 Mar 2017 19:27:49 -0400
Received: by mail-io0-f193.google.com with SMTP id n76so7265568ioe.1
        for <linux-sparse@vger.kernel.org>; Fri, 31 Mar 2017 16:27:48 -0700 (PDT)
In-Reply-To: <20170322105331.91596-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>

On Wed, Mar 22, 2017 at 6:53 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> Patch 11b1a83b1 solved an issue with dangling PSEUDO_PHI
> by killing it's use after a branch rewrite.
>
> However, the change didn't took in account the fact that,
> even after the branch rewrite, some other paths may exist
> where this pseudo was needed.
>
> Fix this by cheking that no such path exist before killing
> the (usage of the) pseudo.
>
> Fixes: 11b1a83b1 "fix OP_PHI usage in try_to_simplify_bb()"
> Reported-by: Dibyendu Majumdar <mobile@majumdar.org.uk>
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  flow.c                       | 35 ++++++++++++++++++++++++++++++++++-
>  validation/kill-phi-ttsbb2.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 74 insertions(+), 1 deletion(-)
>  create mode 100644 validation/kill-phi-ttsbb2.c
>
> diff --git a/flow.c b/flow.c
> index a5332203f..c12bc0716 100644
> --- a/flow.c
> +++ b/flow.c
> @@ -79,6 +79,39 @@ static int bb_depends_on(struct basic_block *target, struct basic_block *src)
>         return 0;
>  }
>
> +/*
> + * Return 1 if 'pseudo' is needed in some parent of 'bb'.
> + * Need liveness info.
> + */
> +static int needed_phisrc(struct instruction *phi, struct basic_block *curr, unsigned long generation)
> +{
> +       pseudo_t target = phi->target;
> +       struct basic_block *bb;
> +       int rc = 0;
> +
> +       curr->generation = generation;
> +       FOR_EACH_PTR(curr->children, bb) {
> +               if (bb->generation == generation)
> +                       continue;
> +               if (bb == phi->bb)
> +                       continue;
> +               if (pseudo_in_list(bb->defines, target)) {
> +                       continue;
> +               }

For just one line continue, there is no need for {}

> +               if (pseudo_in_list(bb->needs, target)) {
> +                       rc = 1;
> +                       goto ret;

Can this simplify as "return 1;"

> +               }
> +               rc = needed_phisrc(phi, bb, generation);
> +               if (rc)
> +                       goto ret;
needed_phisrc(phi, bb, generation)

And "return 1;" here
> +
> +       } END_FOR_EACH_PTR(bb);


> +
> +ret:
> +       return rc;

"return 0" here.
There is no need for rc variable.

Chris
