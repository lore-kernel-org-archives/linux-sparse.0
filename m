From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 1/5] do not corrupt ptrlist while killing unreachable BBs
Date: Sun, 9 Jul 2017 02:07:53 -0700
Message-ID: <CANeU7Qktna3bNQ+kgVsULqwmze49wijZihA-Ea-weKcURmgL_Q@mail.gmail.com>
References: <20170706191950.81268-1-luc.vanoostenryck@gmail.com> <20170706191950.81268-2-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33280 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752081AbdGIJHz (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 9 Jul 2017 05:07:55 -0400
Received: by mail-pf0-f196.google.com with SMTP id e199so10450896pfh.0
        for <linux-sparse@vger.kernel.org>; Sun, 09 Jul 2017 02:07:55 -0700 (PDT)
In-Reply-To: <20170706191950.81268-2-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Jul 6, 2017 at 12:19 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> Fix this, by adding a flag to kill_unreachable_bbs(), telling
> if it is safe to delete the BBs or if we can just mark them
> as unreachable (set bb->ep to NULL and unlink any parent and/or
> chilren), in which case the deletion will be done later.
>
> Note: the reproducer is one with very broken syntax but nothing
>       seems to forbid the same situation to happen with a valid
>       program.

I think it is simpler to move the kill not reachable bb to outer
CSE stage. The following patch has been test pass kernel compile
test. Feel free to combine that with your test as one patch.

git branch:

https://git.kernel.org/pub/scm/devel/sparse/sparse.git/log/?h=sparse-next-20170708

Chris

From 5234b1fcb69ade5e69ab3a528b57c8f5cea9b11e Mon Sep 17 00:00:00 2001
From: Christopher Li <sparse@chrisli.org>
Date: Sat, 8 Jul 2017 19:34:49 -0700
Subject: [PATCH 1/2] move kill_unreachable_bbs to outer cse stage

The current way of kill_unreach_bbs in insert_branch()
cause delete entry in ptrlist that the upper level
caller is looping on.

Move it outside to the cse stage avoid that problem.

Reported-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Signed-of-By: Christopher Li <sparse@chrisli.org>
---
 cse.c       | 3 +++
 flow.c      | 2 +-
 linearize.c | 3 ---
 3 files changed, 4 insertions(+), 4 deletions(-)

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

diff --git a/flow.c b/flow.c
index c7161d4..5d2f15a 100644
--- a/flow.c
+++ b/flow.c
@@ -841,7 +841,7 @@ void kill_unreachable_bbs(struct entrypoint *ep)
  } END_FOR_EACH_PTR(bb);
  PACK_PTR_LIST(&ep->bbs);

- repeat_phase &= ~REPEAT_CFG_CLEANUP;
+ repeat_phase |=  REPEAT_CSE ;
 }

 static int rewrite_parent_branch(struct basic_block *bb, struct
basic_block *old, struct basic_block *new)
diff --git a/linearize.c b/linearize.c
index 7313e72..a367207 100644
--- a/linearize.c
+++ b/linearize.c
@@ -671,9 +671,6 @@ void insert_branch(struct basic_block *bb, struct
instruction *jmp, struct basic
  remove_parent(child, bb);
  } END_FOR_EACH_PTR(child);
  PACK_PTR_LIST(&bb->children);
