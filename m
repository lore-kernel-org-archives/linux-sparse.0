From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] avoid infinite loop during simplification
Date: Sat, 12 Aug 2017 09:55:31 -0400
Message-ID: <CANeU7QmjFd17UTFGSe_FOR+0jTn+azzaHvwq_FtG6sSGL1sx+Q@mail.gmail.com>
References: <20170812125525.34044-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:38157 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750983AbdHLNzd (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 12 Aug 2017 09:55:33 -0400
Received: by mail-yw0-f194.google.com with SMTP id p68so3733891ywg.5
        for <linux-sparse@vger.kernel.org>; Sat, 12 Aug 2017 06:55:32 -0700 (PDT)
In-Reply-To: <20170812125525.34044-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sat, Aug 12, 2017 at 8:55 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> Currently, sparse can enter in infinite loops.
> The effect can be seen is the normal simplification/CSE
> loops but the origin of the problem is not there
> (it's some interaction between simplify_loads() and
> unreachable code, at least for a good part of them).
>
> On the other hand, on normal code, the number of
> simplification/CSE cycle is fairly small: even in big,
> complex functions, in 80% of cases only 1 or 2 cycles are
> needed. The most extreme I found was 12 cycles and that's
> an unique case (on a total of 172000+).

That make sense.

>
> So, avoid to let sparse in infinite loop by stopping
> the loop if the number of cycles becomes too high: 16.
>
> Note: this solves all the 77 cases of inifinite loop I found.
> Note: of course, this patch doesn't change the fact that
>       the generated IR is broken and that the root cause(s)
>       must be addressed.

Of course. I am more interested in the 77 cases.

Are you considering this in this release?

>
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>
> The patch is also available in the git repository at:
>   git://github.com/lucvoo/sparse.git avoid-infinite-loop--max-cse
>
>  cse.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/cse.c b/cse.c
> index 17b3da01a..fa136c370 100644
> --- a/cse.c
> +++ b/cse.c
> @@ -356,13 +356,17 @@ static struct instruction * try_to_cse(struct entrypoint *ep, struct instruction
>         return i1;
>  }
>
> +#define        MAX_CSE_CYCLES  16
>  void cleanup_and_cse(struct entrypoint *ep)
>  {
> +       int max = MAX_CSE_CYCLES;
>         int i;
>
>         simplify_memops(ep);
>  repeat:
>         repeat_phase = 0;
> +       if (--max == 0)
> +               return;


I think we might also want to have the option that if max loop
was reached,  dump the instruction and see what the hell is going
on here. The dumping can be turn off.

Chris
