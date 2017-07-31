From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 0/7] fixes for rare issues
Date: Mon, 31 Jul 2017 22:36:17 +0200
Message-ID: <20170731203624.58971-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35234 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751046AbdGaUgc (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 31 Jul 2017 16:36:32 -0400
Received: by mail-wr0-f195.google.com with SMTP id c24so28955583wra.2
        for <linux-sparse@vger.kernel.org>; Mon, 31 Jul 2017 13:36:32 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org, Michael Stefaniuc <mstefani@mykolab.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This series contains some fixes for crashes I found during
some fuzzy-testing, as well as for some infinite loops
that may happen during simplification.

Patch 3 is quite fundamental for all BB simplifications.
I won't bet this is all perfect now but at least the change
make a lot of sense and I'm confident that the situation is
now a lot saner.

It passes all functional tests (regressions test & kernel check),
it should be fine when used on the Wine code too.

Changes since v3:
- change the way kill_unreachable_bbs() is called (patch 1)
- add fix for the infinite simplification loops   (patch 2 & 3)

This series is also available at:
  git://github.com/lucvoo/sparse.git fix-fuzzy-crashes-v3

----------------------------------------------------------------
Luc Van Oostenryck (7):
      fix ptrlist corruption while killing unreachable BBs
      fix infinite simplification loops
      fix BB dependencies on phi-nodes
      fix crash when ep->active is NULL
      fix crash in rewrite_branch()
      fix some crashes in add_dominators()
      fix crash with sym->bb_target == NULL

 cse.c                             |  2 ++
 flow.c                            | 38 ++++++++++++++++++--------------------
 linearize.c                       | 17 +++++++++++------
 memops.c                          |  2 ++
 simplify.c                        |  9 +++++++++
 validation/crash-add-doms.c       | 22 ++++++++++++++++++++++
 validation/crash-bb_target.c      | 10 ++++++++++
 validation/crash-ep-active.c      | 12 ++++++++++++
 validation/crash-ptrlist.c        | 23 +++++++++++++++++++++++
 validation/crash-rewrite-branch.c | 24 ++++++++++++++++++++++++
 validation/crazy02-not-so.c       | 18 ++++++++++++++++++
 validation/infinite-loop02.c      | 11 +++++++++++
 validation/infinite-loop03.c      | 16 ++++++++++++++++
 13 files changed, 178 insertions(+), 26 deletions(-)
 create mode 100644 validation/crash-add-doms.c
 create mode 100644 validation/crash-bb_target.c
 create mode 100644 validation/crash-ep-active.c
 create mode 100644 validation/crash-ptrlist.c
 create mode 100644 validation/crash-rewrite-branch.c
 create mode 100644 validation/infinite-loop02.c
 create mode 100644 validation/infinite-loop03.c
