From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/8] fix uses of killed instructions
Date: Thu, 17 Nov 2016 15:34:59 +0100
Message-ID: <20161117143507.3598-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:37528 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932596AbcKQR1l (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 17 Nov 2016 12:27:41 -0500
Received: by mail-wm0-f50.google.com with SMTP id t79so159370921wmt.0
        for <linux-sparse@vger.kernel.org>; Thu, 17 Nov 2016 09:27:40 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The series fixes some issues regarding the operands of killed
instructions not having their usage adjusted.
The main apparent consequence of this situation is that
some instructions which should be considered as unneeded are
not removed from the code as expected. This can sometimes have
a cascading effect that can be "quite interesting".

There is some closely related issues that remains,
for example the situation of the exotic instructions.
It's also possible that something is missing with OP_SYMADDR.

OP_LOAD, OP_STORE & OP_CALL are completly ignored and their
correct handling need another approach, so they're also
ignored by this series.


*ATTENTION*
The test cases in this series depends on some
features I added to the test-suite that I posted the
10th November with the "fix discarded label statement" serie.


Luc Van Oostenryck (8):
  kill uses of replaced instructions
  fix killing OP_SETVAL instructions
  fix killing OP_PHI instructions
  fix killing OP_CAST & friends
  fix killing OP_SELECT
  fix killing OP_COMPUTEDGOTO
  explicitely ignore killing OP_ENTRY
  cleanup kill_instruction()

 simplify.c                      | 74 ++++++++++++++++++++++++++++-------------
 validation/kill-casts.c         | 22 ++++++++++++
 validation/kill-computedgoto.c  | 17 ++++++++++
 validation/kill-phi-node.c      | 18 ++++++++++
 validation/kill-replaced-insn.c | 61 +++++++++++++++++++++++++++++++++
 validation/kill-select.c        | 16 +++++++++
 6 files changed, 184 insertions(+), 24 deletions(-)
 create mode 100644 validation/kill-casts.c
 create mode 100644 validation/kill-computedgoto.c
 create mode 100644 validation/kill-phi-node.c
 create mode 100644 validation/kill-replaced-insn.c
 create mode 100644 validation/kill-select.c

-- 
