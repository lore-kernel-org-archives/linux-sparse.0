From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/5] fixes for rare crashes
Date: Thu,  6 Jul 2017 21:19:45 +0200
Message-ID: <20170706191950.81268-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35039 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752826AbdGFTUI (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 6 Jul 2017 15:20:08 -0400
Received: by mail-wr0-f196.google.com with SMTP id z45so2607046wrb.2
        for <linux-sparse@vger.kernel.org>; Thu, 06 Jul 2017 12:20:08 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This series contains some fixes for crashes I found during
some fuzzy-testing.

Most of the reproducers are not at all valid C code and
the crashes occurs very very rarely (a few tens of
crashes after more or less 150 CPU hours of fuzzing)
but I don't see much reasons why more 'normal' uses
could not trigger the crashes.

Sorry for coming with this so late in the release.

Note: I'm not really sure if these patches should be
      included in the release but patch 1/5 is a bit
      different and should be included while patch 5/5
      is only for those who use test-linearize.


The following changes since commit ec3f72e981792a86a9e002471a06d61ecd5c6675:

  bump sparse's version to 0.5.1-rc4 (2017-07-04 08:24:40 -0700)

are available in the git repository at:

  git://github.com/lucvoo/sparse.git fix-fuzzy-crashes

for you to fetch changes up to 2f59acac476c07c4d32b82fb8e214d0d6b8b05fc:

  avoid crash with sym->bb_target == NULL (2017-07-06 20:59:10 +0200)

----------------------------------------------------------------

Luc Van Oostenryck (5):
  do not corrupt ptrlist while killing unreachable BBs
  avoid crash when ep->active is NULL
  avoid crash in rewrite_branch()
  avoid some crashes in add_dominators()
  avoid crash with sym->bb_target == NULL

 flow.c                            |  7 ++++---
 flow.h                            |  2 +-
 linearize.c                       | 14 ++++++++++----
 memops.c                          |  2 ++
 validation/crash-add-doms.c       | 22 ++++++++++++++++++++++
 validation/crash-bb_target.c      | 10 ++++++++++
 validation/crash-ep-active.c      | 17 +++++++++++++++++
 validation/crash-ptrlist.c        | 23 +++++++++++++++++++++++
 validation/crash-rewrite-branch.c | 24 ++++++++++++++++++++++++
 9 files changed, 113 insertions(+), 8 deletions(-)
 create mode 100644 validation/crash-add-doms.c
 create mode 100644 validation/crash-bb_target.c
 create mode 100644 validation/crash-ep-active.c
 create mode 100644 validation/crash-ptrlist.c
 create mode 100644 validation/crash-rewrite-branch.c

-- 
2.13.0

