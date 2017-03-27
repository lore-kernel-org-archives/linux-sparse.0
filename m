From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v6 00/15] prepare for LLVM fixes
Date: Mon, 27 Mar 2017 19:33:50 +0200
Message-ID: <20170327173405.11405-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34527 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751287AbdC0RhM (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Mar 2017 13:37:12 -0400
Received: by mail-wr0-f196.google.com with SMTP id w43so12461729wrb.1
        for <linux-sparse@vger.kernel.org>; Mon, 27 Mar 2017 10:36:13 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This serie contains preparatory patches for
sparse-llvm's fixes but not sparse-llvm specific
and having some values of their own.

These patches were extracted from a previous
serie containing also the sparse-llvm patches.

Changes since v5:
- use a table for compare_opcode() & swap_compare_opcode()
- fix test cases on 32bit machines

Changes since extraction:
- no functional changes
- add missing parts in the IR doc
- fix some typos in the IR doc
- move OP_PUSHs near their OP_CALL
- give a real commit msg for some of the patches
- improve the commit msg of some of the patches
- use a table for compare_swap() & compare_opcode()
- use a better name for compare_swap() & compare_opcode()


Luc Van Oostenryck (15):
  don't output value of anonymous symbol's pointer
  add table to "negate" some opcode
  use opcode table for compare_opcode()
  canonicalize binops before simplification
  canonicalize compare instructions
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
 Makefile                         |   1 +
 compile-i386.c                   |  14 +-
 example.c                        |   4 +-
 flow.c                           |   3 +-
 linearize.c                      |  78 +++++++----
 linearize.h                      |  17 ++-
 liveness.c                       |  14 +-
 memops.c                         |   2 +-
 opcode.c                         |  36 +++++
 opcode.h                         |  10 ++
 show-parse.c                     |  11 +-
 simplify.c                       |  77 +++++-----
 sparse-llvm.c                    |   4 +-
 symbol.h                         |   9 ++
 validation/call-inlined.c        |  54 +++++++
 validation/call-variadic.c       |  31 ++++
 validation/loop-linearization.c  |   9 +-
 validation/optim/call-inlined.c  |  30 ++++
 validation/optim/canonical-cmp.c | 124 ++++++++++++++++
 validation/push-call.c           |  26 ++++
 validation/switch-long.c         |  47 +++++++
 22 files changed, 790 insertions(+), 107 deletions(-)
 create mode 100644 Documentation/instructions.txt
 create mode 100644 opcode.c
 create mode 100644 opcode.h
 create mode 100644 validation/call-inlined.c
 create mode 100644 validation/call-variadic.c
 create mode 100644 validation/optim/call-inlined.c
 create mode 100644 validation/optim/canonical-cmp.c
 create mode 100644 validation/push-call.c
 create mode 100644 validation/switch-long.c

-- 
2.12.0

