From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/5] add support for __builtin_unreachable()
Date: Wed, 18 Mar 2020 18:31:15 +0100
Message-ID: <20200318173120.63939-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33367 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbgCRRbZ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 18 Mar 2020 13:31:25 -0400
Received: by mail-wm1-f66.google.com with SMTP id r7so2841591wmg.0
        for <linux-sparse@vger.kernel.org>; Wed, 18 Mar 2020 10:31:24 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

__builtin_unreachable() has direct consequences on the CFG
and should thus not be ignored. This series add minimal
support for it, motivated by some improvements in the
processing of contexts.


Luc Van Oostenryck (5):
  add testcases for OP_UNREACH
  add instruction OP_UNREACH
  add an implicit __builtin_unreachable() for __noreturn
  add support for linearization of builtins
  teach sparse to linearize __builtin_unreachable()

 Documentation/IR.rst                          |  3 ++
 builtin.c                                     |  2 +
 linearize.c                                   | 52 +++++++++++++++++++
 opcode.def                                    |  1 +
 symbol.h                                      |  7 ++-
 validation/context-unreachable.c              | 15 ++++++
 validation/linear/builtin_unreachable0.c      | 29 +++++++++++
 ...n_unreachable.c => builtin_unreachable1.c} | 15 +++---
 validation/linear/noreturn-unreachable0.c     | 22 ++++++++
 9 files changed, 137 insertions(+), 9 deletions(-)
 create mode 100644 validation/context-unreachable.c
 create mode 100644 validation/linear/builtin_unreachable0.c
 rename validation/linear/{builtin_unreachable.c => builtin_unreachable1.c} (59%)
 create mode 100644 validation/linear/noreturn-unreachable0.c


base-commit: 0558317d0c7a2e20a6d82b7ef35357ec02e2ad38
-- 
2.25.1
