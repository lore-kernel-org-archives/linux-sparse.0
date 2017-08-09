From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 0/9] fix loading of partially defined bitfield
Date: Wed,  9 Aug 2017 21:37:57 +0200
Message-ID: <20170809193806.30975-1-luc.vanoostenryck@gmail.com>
References: <CANeU7Qk99kn3etn8yoEKKFzcW15wHjt7OYPSpZhqCDc4DE3EDQ@mail.gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36578 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751884AbdHITi6 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 9 Aug 2017 15:38:58 -0400
Received: by mail-wm0-f65.google.com with SMTP id d40so611456wma.3
        for <linux-sparse@vger.kernel.org>; Wed, 09 Aug 2017 12:38:57 -0700 (PDT)
In-Reply-To: <CANeU7Qk99kn3etn8yoEKKFzcW15wHjt7OYPSpZhqCDc4DE3EDQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The goal of this series is to fix the problems present in sparse
when a bitfield in an uninitialized automatic variable is first
set then read-back.

In this case the bitfield itself is initialized but not the
remaining of the structure/word and sparse was not smart
enough to handle it.

It will also avoid internal infinite loops occuring when
processing undefined vars present during the SSA construction.


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

Change since v3:
- add timeout support in the testsuite
- add a testcase for infinite loop
- improve some commit messages

----------------------------------------------------------------

The series is also available in the git repository at:

  git://github.com/lucvoo/sparse.git fix-loading-partialy-defined-bitfields-v4


Luc Van Oostenryck (9):
      testsuite: add support for commands with timeout
      Remove single-store shortcut
      new helper: def_opcode()
      reuse nbr_pseudo_users()
      change the masking when loading bitfields
      simplify ((A & M') | B ) & M when M' & M == 0
      transform (A & M) >> S to (A >> S) & (M >> S)
      transform (A << S) >> S into A & (-1 >> S)
      fix: cast of OP_AND only valid if it's an OP_CAST

 Documentation/test-suite               |   4 ++
 flow.c                                 |  39 +-----------
 linearize.c                            |  15 +++--
 linearize.h                            |   5 ++
 simplify.c                             | 109 ++++++++++++++++++++++++++++++---
 unssa.c                                |   5 --
 validation/bitfield-size.c             |   4 +-
 validation/infinite-loop0.c            |  11 ++++
 validation/optim/store-load-bitfield.c |  66 ++++++++++++++++++++
 validation/test-suite                  |   7 +++
 10 files changed, 205 insertions(+), 60 deletions(-)
 create mode 100644 validation/infinite-loop0.c
 create mode 100644 validation/optim/store-load-bitfield.c
