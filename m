From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 00/14] prepare LLVM fixes
Date: Sat, 25 Mar 2017 00:14:07 +0100
Message-ID: <20170324231421.14869-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35044 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755244AbdCXXOa (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 24 Mar 2017 19:14:30 -0400
Received: by mail-wm0-f66.google.com with SMTP id z133so785146wmb.2
        for <linux-sparse@vger.kernel.org>; Fri, 24 Mar 2017 16:14:28 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This serie contains preparatory patches for 
sparse-llvm's fixes but not sparse-llvm specific
and having some values of their own.

These patches were extracted from a previous
serie containing also the sparse-llvm patches.

Changes since extraction:
- no functional changes
- add missing parts in the IR doc
- fix some typos in the IR doc
- move OP_PUSHs near their OP_CALL
- give a real commit msg for some of the patches
- improve the commit msg of some of the patches
- use a table for compare_swap() & compare_opcode()
- use a better name for compare_swap() & compare_opcode()


Luc Van Oostenryck (14):
  don't output value of anonymous symbol's pointer
  canonicalize binops before simplification
  canonicalize compare instructions
  rewrite compare_opcode() like swap_compare_opcode()
  add is_signed_type()
  fix usage of inlined calls
  inlined calls should not block BB packing
  give function's arguments a type via OP_PUSH
  insure that all OP_PUSHs are just before their OP_CALL
  give a type to OP_PHISOURCEs
  give a type to OP_SELs, always
  give a type to OP_SWITCHs
  add doc about sparse's instructions/IR
  add support for wider type in switch-case

 Documentation/instructions.txt   | 296 +++++++++++++++++++++++++++++++++++++++
 compile-i386.c                   |  14 +-
 example.c                        |   4 +-
 flow.c                           |   3 +-
 linearize.c                      |  78 +++++++----
 linearize.h                      |  14 +-
 liveness.c                       |  14 +-
 memops.c                         |   2 +-
 show-parse.c                     |  11 +-
 simplify.c                       | 104 +++++++++-----
 sparse-llvm.c                    |   4 +-
 symbol.h                         |   9 ++
 validation/call-inlined.c        |  54 +++++++
 validation/call-variadic.c       |  31 ++++
 validation/loop-linearization.c  |   9 +-
 validation/optim/call-inlined.c  |  30 ++++
 validation/optim/canonical-cmp.c | 124 ++++++++++++++++
 validation/push-call.c           |  26 ++++
 validation/switch-long.c         |  47 +++++++
 19 files changed, 774 insertions(+), 100 deletions(-)
 create mode 100644 Documentation/instructions.txt
 create mode 100644 validation/call-inlined.c
 create mode 100644 validation/call-variadic.c
 create mode 100644 validation/optim/call-inlined.c
 create mode 100644 validation/optim/canonical-cmp.c
 create mode 100644 validation/push-call.c
 create mode 100644 validation/switch-long.c

-- 
2.12.0

