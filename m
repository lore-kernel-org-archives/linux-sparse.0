From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [GIT PULL] patches for -rc5
Date: Wed,  9 Aug 2017 02:43:07 +0200
Message-ID: <20170809004307.16663-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37740 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752047AbdHIAnO (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 8 Aug 2017 20:43:14 -0400
Received: by mail-wm0-f66.google.com with SMTP id t138so5047975wmt.4
        for <linux-sparse@vger.kernel.org>; Tue, 08 Aug 2017 17:43:13 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Chris,
Please pull these patches for the upcoming release.
No surprise here, it's the patches that have been on
sparse-next, with no rebasing on external branches and
some extra testing.

The following changes since commit fa71b7ac0594c9ddf81ec27753280cffef702489:

  Adding gcc attribute no_gccisr (2017-07-13 23:57:09 -0700)

are available in the git repository at:

  git://github.com/lucvoo/sparse.git tip

for you to fetch changes up to cccba8defbf0386305f522e63e1a1dd939f8c734:

  Bump sparse's version to -rc5 (2017-08-09 00:24:23 +0200)


Regards,
-- Luc Van Oostenryck

----------------------------------------------------------------
Christopher Li (6):
      Add test case for the wine dead loop bug
      Makefile: clean up and simplify
      Makefile: add selfcheck target
      Adding _Pragma()
      fix warnings report by selfcheck
      Adding gcc attribute noipa etc

Luc Van Oostenryck (16):
      fix ptrlist corruption while killing unreachable BBs
      fix infinite simplification loops
      fix BB dependencies on phi-nodes
      fix crash when ep->active is NULL
      fix crash in rewrite_branch()
      fix some crashes in add_dominators()
      fix crash with sym->bb_target == NULL
      take comma expr in account for constant value
      fix: give a type to bad cond expr with known condition
      ptrlist: add a counter for the number of removed elemnets
      ptrlist: adjust ptr_list_size for the new ->rm field
      ptrlist: add MARK_CURRENT_DELETED
      ptrlist: avoid iteration on NULL entries
      mark pseudo users as deleted instead of removing them
      Bump sparse's version to -rc5

Ramsay Jones (2):
      lib: workaround the 'redeclared with different type' errors
      Makefile: pass -Wno-vla to sparse while checking pre-process.c

 Makefile                          | 35 +++++++++++++++++++++++------------
 ast-model.c                       |  2 +-
 ast-view.c                        |  3 ++-
 cse.c                             |  2 ++
 evaluate.c                        | 12 ++++++++++++
 expand.c                          | 30 ++++++++++++++++++++++++++++++
 expression.h                      |  1 +
 flow.c                            | 38 ++++++++++++++++++--------------------
 gcc-attr-list.h                   |  2 ++
 lib.c                             |  3 +++
 lib.h                             | 10 ++++++++--
 linearize.c                       | 17 +++++++++++------
 memops.c                          |  2 ++
 ptrlist.c                         |  2 +-
 ptrlist.h                         | 15 ++++++++++++++-
 simplify.c                        | 14 ++++++++++++--
 validation/cond-err-expand.c      | 27 +++++++++++++++++++++++++++
 validation/crash-add-doms.c       | 22 ++++++++++++++++++++++
 validation/crash-bb_target.c      | 10 ++++++++++
 validation/crash-ep-active.c      | 12 ++++++++++++
 validation/crash-ptrlist.c        | 23 +++++++++++++++++++++++
 validation/crash-rewrite-branch.c | 24 ++++++++++++++++++++++++
 validation/crazy02-not-so.c       | 18 ++++++++++++++++++
 validation/infinite-loop02.c      | 11 +++++++++++
 validation/infinite-loop03.c      | 16 ++++++++++++++++
 validation/kill-unreachable-phi.c | 27 +++++++++++++++++++++++++++
 26 files changed, 332 insertions(+), 46 deletions(-)
 create mode 100644 validation/cond-err-expand.c
 create mode 100644 validation/crash-add-doms.c
 create mode 100644 validation/crash-bb_target.c
 create mode 100644 validation/crash-ep-active.c
 create mode 100644 validation/crash-ptrlist.c
 create mode 100644 validation/crash-rewrite-branch.c
 create mode 100644 validation/infinite-loop02.c
 create mode 100644 validation/infinite-loop03.c
 create mode 100644 validation/kill-unreachable-phi.c
