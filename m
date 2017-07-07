From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 1/5] do not corrupt ptrlist while killing unreachable BBs
Date: Thu, 6 Jul 2017 17:40:59 -0700
Message-ID: <CANeU7QnbwqVcZdbarrj4OdpR9-TaG9=t5Q_CDFZXSuB+SN8zLw@mail.gmail.com>
References: <20170706191950.81268-1-luc.vanoostenryck@gmail.com> <20170706191950.81268-2-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:32824 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752351AbdGGAlB (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 6 Jul 2017 20:41:01 -0400
Received: by mail-pf0-f195.google.com with SMTP id e199so2313957pfh.0
        for <linux-sparse@vger.kernel.org>; Thu, 06 Jul 2017 17:41:01 -0700 (PDT)
In-Reply-To: <20170706191950.81268-2-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Jul 6, 2017 at 12:19 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> In commit (51cfbc90a5 "fix: kill unreachable BBs after killing a child")
> kill_unreachable_bbs() was called during simplification in order
> to avoid creating fake cycles between phis and issuing bogus
> "crazy programmer" warnings.
>
> However, simplification is done via cse.c:clean_up_insns()
> which is looping over all BBs while kill_unreachable_bbs()
> loops over all BBs *and* can delete some of them which may
> corrupt the looping in clean_up_insns().
>
> Fix this, by adding a flag to kill_unreachable_bbs(), telling
> if it is safe to delete the BBs or if we can just mark them
> as unreachable (set bb->ep to NULL and unlink any parent and/or
> chilren), in which case the deletion will be done later.
>
> Note: the reproducer is one with very broken syntax but nothing
>       seems to forbid the same situation to happen with a valid
>       program.
>
> Fixes: 51cfbc90a5e1462fcd624a1598ecd985a508a5d6
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Thanks for catching it. That is a very serious bug.
The release will be on hold until this bug has been fix.
It is actually more than one of them. I will send out a separate patch
catching this kind of behavior.


When the parent is doing the loop on this, the
lower level  caller remove the list element is very hasty.

> -void kill_unreachable_bbs(struct entrypoint *ep)
> +void kill_unreachable_bbs(struct entrypoint *ep, int del)
>  {
>         struct basic_block *bb;
>         unsigned long generation = ++bb_generation;
> @@ -837,7 +837,8 @@ void kill_unreachable_bbs(struct entrypoint *ep)
>                 /* Mark it as being dead */
>                 kill_bb(bb);
>                 bb->ep = NULL;
> -               DELETE_CURRENT_PTR(bb);
> +               if (del)
> +                       DELETE_CURRENT_PTR(bb);
>         } END_FOR_EACH_PTR(bb);
>         PACK_PTR_LIST(&ep->bbs);
>

Well, it can happen to other ptr list as well. And it did.

For this one, I thing it is simpler just move the kill_unreachable_bbs()
to the outer stage.

Some thing like this, what do you say?
It did pass the validation test you send out on this patch.

From c4ef6086b07cdf1d0d1790a274ba056910b00b44 Mon Sep 17 00:00:00 2001
From: Christopher Li <sparse@chrisli.org>
Date: Thu, 6 Jul 2017 16:25:38 -0700
Subject: [PATCH 1/2] move kill_unreachable_bbs to outer cse stage

---
 cse.c       | 3 +++
 linearize.c | 3 ---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/cse.c b/cse.c
index 0d3815c..af9863f 100644
--- a/cse.c
+++ b/cse.c
@@ -387,6 +387,9 @@ repeat:
  }
  }

+ if (repeat_phase & REPEAT_CFG_CLEANUP)
+ kill_unreachable_bbs(ep);
+
  if (repeat_phase & REPEAT_SYMBOL_CLEANUP)
  simplify_memops(ep);

diff --git a/linearize.c b/linearize.c
index 7313e72..a367207 100644
--- a/linearize.c
+++ b/linearize.c
@@ -671,9 +671,6 @@ void insert_branch(struct basic_block *bb, struct
instruction *jmp, struct basic
  remove_parent(child, bb);
  } END_FOR_EACH_PTR(child);
  PACK_PTR_LIST(&bb->children);
