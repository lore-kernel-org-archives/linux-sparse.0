From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 0/8] fix loading of partially defined bitfield
Date: Wed,  9 Aug 2017 01:06:26 +0200
Message-ID: <20170808230634.16227-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34788 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752465AbdHHXGx (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 8 Aug 2017 19:06:53 -0400
Received: by mail-wm0-f67.google.com with SMTP id x64so4929412wmg.1
        for <linux-sparse@vger.kernel.org>; Tue, 08 Aug 2017 16:06:52 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Linus Torvalds <torvalds@linux-foundation.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The goal of this series is to fix the problems present in sparse
when a bitfield in an uninitialized automatic variable is first
set then read-back.

In this case the bitfield itself is initialized but not the
remaining of the structure/word and sparse was not smart
enough to handle it.

It will also solve most infinite loops that can happen
when processing undefined vars.


Changes since v1:
- use the hack from March to work-around the problem 
  with undefined vars.
- add the missing simplifications to make the
  store-and-load-back of a bitfield almost a no-op
  as it should be.

Change since v2:
- in patch 7, '-1' really meant 'all ones' but only for the
  size of the word, not bigger. Thanks to Linus for noticing it.
- add a note in patch 1 about the infinite loops.


The series is also available in the git repository at:
  git://github.com/lucvoo/sparse.git fix-loading-partialy-defined-bitfields-v3

----------------------------------------------------------------
Luc Van Oostenryck (8):
      Remove single-store shortcut
      new helper: def_opcode()
      reuse nbr_pseudo_users()
      change the masking when loading bitfields
      simplify ((A & M') | B ) & M when M' & M == 0
      transform (A & M) >> S to (A >> S) & (M >> S)
      transform (A << S) >> S into A & (-1 >> S)
      fix: cast of OP_AND only valid if it's an OP_CAST

 flow.c                                 |  39 +-----------
 linearize.c                            |  15 +++--
 linearize.h                            |   5 ++
 simplify.c                             | 109 ++++++++++++++++++++++++++++++---
 unssa.c                                |   5 --
 validation/bitfield-size.c             |   4 +-
 validation/optim/store-load-bitfield.c |  66 ++++++++++++++++++++
 7 files changed, 183 insertions(+), 60 deletions(-)
 create mode 100644 validation/optim/store-load-bitfield.c
