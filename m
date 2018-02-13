From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 00/10] fix usage when killing loads & stores
Date: Tue, 13 Feb 2018 22:58:02 +0100
Message-ID: <20180213215812.18735-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:52272 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965865AbeBMWAU (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 13 Feb 2018 17:00:20 -0500
Received: by mail-wm0-f53.google.com with SMTP id j199so6620974wmj.2
        for <linux-sparse@vger.kernel.org>; Tue, 13 Feb 2018 14:00:20 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This series contains 4 fixes for missing removal of
value or address usage when unneeded loads or stores
are killed during symbol simplification.

Change since v1:
- split patch "add helpers for pseudo's user-list's size" in two
  so to not add has_users() in a patch that where only the other
  helper is used (noticed by Linus).

This series is available in the Git repository at:
  https://github.com/lucvoo/sparse-dev/tree/fix-missing-kills-v2
  git://github.com/lucvoo/sparse-dev.git fix-missing-kills-v2

----------------------------------------------------------------
Luc Van Oostenryck (10):
      add testcase for bad killing of dominated stores
      add testcases for converted loads
      fix killing of converted loads
      kill dead stores when simplifying symbols
      fix usage of deadborn loads
      add helper for pseudo's user-list's size
      add helper: has_users()
      use has_users() in dead_insn() too
      let kill_instruction() report if changes were made
      kill dead loads

 flow.c                                | 23 ++++++-----------------
 flow.h                                | 10 +++++-----
 linearize.h                           | 10 ++++++++++
 memops.c                              | 11 +----------
 simplify.c                            | 34 +++++++++++++++++-----------------
 validation/mem2reg/load-deadborn.c    |  9 +++++++++
 validation/optim/load-converted.c     | 14 ++++++++++++++
 validation/optim/load-dead.c          | 11 +++++++++++
 validation/optim/load-semi-volatile.c | 25 +++++++++++++++++++++++++
 validation/optim/store-dominated.c    | 15 +++++++++++++++
 10 files changed, 113 insertions(+), 49 deletions(-)
 create mode 100644 validation/mem2reg/load-deadborn.c
 create mode 100644 validation/optim/load-converted.c
 create mode 100644 validation/optim/load-dead.c
 create mode 100644 validation/optim/load-semi-volatile.c
 create mode 100644 validation/optim/store-dominated.c
