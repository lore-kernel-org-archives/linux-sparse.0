From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [GIT PULL] fix for rare crashes
Date: Sat, 29 Jul 2017 14:53:03 +0200
Message-ID: <20170729125303.65852-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33388 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753607AbdG2MxN (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 29 Jul 2017 08:53:13 -0400
Received: by mail-wm0-f65.google.com with SMTP id q189so19219022wmd.0
        for <linux-sparse@vger.kernel.org>; Sat, 29 Jul 2017 05:53:12 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Chris, this pull request is for the rare crashes fixes
discovered after -rc4.
The changes since the initial post are:
- add a note to patch 1
- avoid an unneeded allocation in patch 4
- add a missing signoff


The following changes since commit ec3f72e981792a86a9e002471a06d61ecd5c6675:

  bump sparse's version to 0.5.1-rc4 (2017-07-04 08:24:40 -0700)

are available in the git repository at:

  git://github.com/lucvoo/sparse.git tags/for-chris

for you to fetch changes up to a0d89707326626a16be31fcddc9933c07378a747:

  avoid crash with sym->bb_target == NULL (2017-07-29 14:39:03 +0200)
 

Thanks.

----------------------------------------------------------------
Luc Van Oostenryck (5):
      do not corrupt ptrlist while killing unreachable BBs
      avoid crash when ep->active is NULL
      avoid crash in rewrite_branch()
      avoid some crashes in add_dominators()
      avoid crash with sym->bb_target == NULL

 flow.c                            |  7 ++++---
 flow.h                            |  2 +-
 linearize.c                       | 20 ++++++++++++++------
 memops.c                          |  2 ++
 validation/crash-add-doms.c       | 22 ++++++++++++++++++++++
 validation/crash-bb_target.c      | 10 ++++++++++
 validation/crash-ep-active.c      | 12 ++++++++++++
 validation/crash-ptrlist.c        | 23 +++++++++++++++++++++++
 validation/crash-rewrite-branch.c | 24 ++++++++++++++++++++++++
 9 files changed, 112 insertions(+), 10 deletions(-)
 create mode 100644 validation/crash-add-doms.c
 create mode 100644 validation/crash-bb_target.c
 create mode 100644 validation/crash-ep-active.c
 create mode 100644 validation/crash-ptrlist.c
 create mode 100644 validation/crash-rewrite-branch.c
