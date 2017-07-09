From: Christopher Li <sparse@chrisli.org>
Subject: [PATCH] V2 move kill_unreachable_bbs to outer cse stage Was Re:
 [PATCH 1/5] do not corrupt ptrlist while killing unreachable BBs
Date: Sun, 9 Jul 2017 09:07:06 -0700
Message-ID: <CANeU7QkCcx1d29megDn9bQ0g7rw04=ujsWCe_bN1Kc1NW_-NZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f44.google.com ([74.125.83.44]:35431 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751946AbdGIQHH (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 9 Jul 2017 12:07:07 -0400
Received: by mail-pg0-f44.google.com with SMTP id j186so37794524pge.2
        for <linux-sparse@vger.kernel.org>; Sun, 09 Jul 2017 09:07:07 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Jul 9, 2017 at 3:26 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>>
>> - repeat_phase &= ~REPEAT_CFG_CLEANUP;
>> + repeat_phase |=  REPEAT_CSE ;
>
> It would be good to add a comment for why the '|= REPEAT_CSE' is needed here.
>

You are right.

Actually I just find out that is not needed. I was having impression that I
need that to pass one of the test-suit. It seems fine without. It pass the
full kernel check as well. It is likely due to I have an unclean tree of the
ptr ref count stuff.

Patch refreshed.
https://git.kernel.org/pub/scm/devel/sparse/sparse.git/log/?h=sparse-next-20170709

Thanks

Chris

From 484a3a27d95b4bf3be9ac4b9bcf1aca1abe3ac19 Mon Sep 17 00:00:00 2001
From: Christopher Li <sparse@chrisli.org>
Date: Sat, 8 Jul 2017 19:34:49 -0700
Subject: [PATCH] move kill_unreachable_bbs to outer cse stage

The current way of kill_unreach_bbs in insert_branch()
cause delete entry in ptrlist that the upper level
caller is looping on.

Move it outside to the cse stage avoid that problem.

Reported-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Signed-of-By: Christopher Li <sparse@chrisli.org>
---
 cse.c       | 3 +++
 flow.c      | 2 --
 linearize.c | 3 ---
 3 files changed, 3 insertions(+), 5 deletions(-)

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
index c7161d4..fce8bde 100644
--- a/flow.c
+++ b/flow.c
@@ -840,8 +840,6 @@ void kill_unreachable_bbs(struct entrypoint *ep)
  DELETE_CURRENT_PTR(bb);
  } END_FOR_EACH_PTR(bb);
  PACK_PTR_LIST(&ep->bbs);
-
- repeat_phase &= ~REPEAT_CFG_CLEANUP;
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
