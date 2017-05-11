From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] ignore VOID when trying to if-convert phi-nodes
Date: Thu, 11 May 2017 10:13:11 -0700
Message-ID: <CANeU7QmM5Rd6o8keZMHL-N2=_dKZg4iPg=M-FAYjqRpEavrj3Q@mail.gmail.com>
References: <20170509220619.72375-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f179.google.com ([209.85.223.179]:36700 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757729AbdEKRNM (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 11 May 2017 13:13:12 -0400
Received: by mail-io0-f179.google.com with SMTP id o12so25684900iod.3
        for <linux-sparse@vger.kernel.org>; Thu, 11 May 2017 10:13:12 -0700 (PDT)
In-Reply-To: <20170509220619.72375-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

Over all looks good. Some minor comment follows.

On Tue, May 9, 2017 at 3:06 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> +/*
> + * Essentially the same as linearize_ptr_list()
> + * but ignoring VOID.
> + * Returns 0 if the the list contained the expected
> + * number of element, 1 or -1 if there was more or less.
> + */
> +static int get_phi_list(pseudo_t array[], int n, struct pseudo_list *list)

The function name does not reflect that it is going to skip the VOID entry
and the API to return value is a little bit non straight forward. e.g.
If the result entries is less than the quest one, there is no way to get
know the exact number of entry returned.

Just RFC here, how about having one helper function to do
the normal linearize ptr and skip the VOID entry. Which return how
many entry it scanned. (it return n+1 if there is more than n request one).

Then the second function you can do the compare to "n" thing.
After inline it would behave exactly like your current function.

> +{
> +       pseudo_t phi;
> +       int i = 0;
> +
> +       FOR_EACH_PTR(list, phi) {
> +               if (phi == VOID)
> +                       continue;
> +               if (i >= n)
> +                       return 1;
> +               array[i++] = phi;
> +       } END_FOR_EACH_PTR(phi);
> +       return (i == n) ? 0 : -1;

Maybe here can be use (i - n)?, it will return -2 if 2 entry less than
requested.

> -       pseudo_t array[3];
> +       pseudo_t array[2];
>         struct basic_block *parents[3];
>         struct basic_block *bb, *bb1, *bb2, *source;
>         struct instruction *br;
>         pseudo_t p1, p2;
>
>         bb = insn->bb;
> -       if (linearize_ptr_list((struct ptr_list *)insn->phi_list, (void **)array, 3) != 2)
> +       if (get_phi_list(array, 2, insn->phi_list) != 0)

It is not necessary to compare to zero.

Chris
