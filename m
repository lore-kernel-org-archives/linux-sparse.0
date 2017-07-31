From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v3 1/7] fix ptrlist corruption while killing unreachable BBs
Date: Mon, 31 Jul 2017 17:41:07 -0400
Message-ID: <CANeU7QmGhg0T0ZkGthDoER3QxbV696OZLJ602dc9Tnv0bojFgA@mail.gmail.com>
References: <20170731203624.58971-1-luc.vanoostenryck@gmail.com> <20170731203624.58971-2-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:38509 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751672AbdGaVlI (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 31 Jul 2017 17:41:08 -0400
Received: by mail-pg0-f67.google.com with SMTP id 125so18914552pgi.5
        for <linux-sparse@vger.kernel.org>; Mon, 31 Jul 2017 14:41:08 -0700 (PDT)
In-Reply-To: <20170731203624.58971-2-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Michael Stefaniuc <mstefani@mykolab.com>

On Mon, Jul 31, 2017 at 4:36 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> Fix this by:
> 1) refuse to emit the "crazy programmer" warning if there
>    is a potential dead BB
> 2) move kill_unreachable_bbs() in the main cleanup loop
>    which will avoid nested ep->bbs loop.

Great!

>
> Note: this solution is preferable to some others because
>       the "crazy programmer" condition happens very rarely.
>       It this thus better to delay this check than to call
>       kill_unreachable_bbs() preventively.
>
> Note: the reproducer is one with very broken syntax but nothing
>       forbid the same situation to happen with a valid program.
>
> Fixes: 51cfbc90a5e1462fcd624a1598ecd985a508a5d6
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  cse.c                       |  2 ++
>  flow.c                      |  2 --
>  linearize.c                 |  3 ---
>  simplify.c                  |  9 +++++++++
>  validation/crash-ptrlist.c  | 23 +++++++++++++++++++++++
>  validation/crazy02-not-so.c | 18 ++++++++++++++++++
>  6 files changed, 52 insertions(+), 5 deletions(-)
>  create mode 100644 validation/crash-ptrlist.c
>
> diff --git a/cse.c b/cse.c
> index 0d3815c5a..17b3da01a 100644
> --- a/cse.c
> +++ b/cse.c
> @@ -364,6 +364,8 @@ void cleanup_and_cse(struct entrypoint *ep)
>  repeat:
>         repeat_phase = 0;
>         clean_up_insns(ep);
> +       if (repeat_phase & REPEAT_CFG_CLEANUP)
> +               kill_unreachable_bbs(ep);
>         for (i = 0; i < INSN_HASH_SIZE; i++) {

Interesting.  So my reading is that, this is similar to the other
alternative patch
we discuss with different that:
1. move up kill_unreachable_bbs(ep) right after clean_up_insns(ep)

> +               /*
> +                * If some BB have been removed it is possible that this
> +                * memop is in fact part of a dead BB. In this case
> +                * we must not warn since nothing is wrong.
> +                * If not part of a dead BB this will be redone after
> +                * the BBs have been cleaned up.
> +                */
> +               if (repeat_phase & REPEAT_CFG_CLEANUP)
> +                       return 0;

2. Avoid issue "crazy programmer" if we still have dead code to clean up.

That sound very reasonable and I feel that is better than the previous version
which eager to kill bbs. That is great.

I really appreciate the change.

Chris
