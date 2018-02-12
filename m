From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/9] fix usage when killing loads & stores
Date: Mon, 12 Feb 2018 23:02:37 +0100
Message-ID: <20180212220246.17750-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:42918 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932383AbeBLWCy (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 12 Feb 2018 17:02:54 -0500
Received: by mail-wr0-f195.google.com with SMTP id k9so2941223wre.9
        for <linux-sparse@vger.kernel.org>; Mon, 12 Feb 2018 14:02:54 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This series contains 4 fixes for missing removal of
value or address usage when unneeded loads or stores
are killed during symbol simplification.

This series is available in the Git repository at:
  https://github.com/lucvoo/sparse-dev/tree/fix-missing-kills
  git://github.com/lucvoo/sparse-dev.git fix-missing-kills

----------------------------------------------------------------
Luc Van Oostenryck (9):
      add helpers for pseudo's user-list's size
      add testcase for bad killing of dominated stores
      add testcases for converted loads
      fix killing of converted loads
      kill dead stores when simplifying symbols
      use has_users() in dead_insn() too
      let kill_instruction() report if changes were made
      kill dead loads
      fix usage of deadborn loads

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
