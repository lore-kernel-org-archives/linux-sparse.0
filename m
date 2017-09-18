From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [GIT PULL] llvm fixes
Date: Mon, 18 Sep 2017 11:51:35 +0200
Message-ID: <20170918095135.12066-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33744 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754474AbdIRJvu (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 18 Sep 2017 05:51:50 -0400
Received: by mail-wr0-f195.google.com with SMTP id b9so4771327wra.0
        for <linux-sparse@vger.kernel.org>; Mon, 18 Sep 2017 02:51:49 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Chris,

Please, pull these patches for master. 

No surprises here, it's just all March's good old fixes
for sparse-llvm which have been rebased on top of rc5.

Thanks,
Luc

----------------------------------------------------------------
The following changes since commit 90859bb4e3f9ad11f76ad42e3dce84043bdc3176:

  Bump sparse's version to -rc5 (2017-08-11 18:17:41 +0200)

are available in the git repository at:

  git://github.com/lucvoo/sparse.git llvm-fixes

for you to fetch changes up to fa5266b1770cf8d97158beb290af084082cd335a:

  llvm: fix creation of sparsec's tmp files (2017-08-12 16:05:11 +0200)

----------------------------------------------------------------
Luc Van Oostenryck (68):
      show OP_PHI without VOID
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
      llvm: remove unneeded arg 'module'
      llvm: remove unneeded 'generation'
      llvm: remove unneeded function::type
      llvm: reduce scope of 'bb_nr'
      llvm: use pseudo_list_size() instead of open coding it
      llvm: give arguments a name
      llvm: give a name to call's return values
      llvm: avoid useless temp variable
      llvm: extract get_sym_value() from pseudo_to_value()
      llvm: fix test of floating-point type
      llvm: fix translation of PSEUDO_VALs into a ValueRefs
      llvm: fix output_op_store() which modify its operand
      llvm: fix output_op_[ptr]cast()
      llvm: take care of degenerated rvalues
      llvm: add test cases for symbol's address
      llvm: add test cases for pointers passed as argument
      llvm: add test cases for arrays passed as argument
      llvm: add test cases for degenerated pointers
      llvm: add support for OP_NEG
      llvm: add support for OP_SETVAL with floats
      llvm: add support for OP_SETVAL with labels
      llvm: ignore OP_INLINED_CALL
      llvm: fix pointer/float mixup in comparisons
      llvm: fix type in comparison with an address constant
      llvm: give correct type to binops
      llvm: adjust OP_RET's type
      llvm: variadic functions are not being marked as such
      llvm: fix type of switch constants
      llvm: make pseudo_name() more flexible
      llvm: give a name to all values
      llvm: add support for OP_SWITCH with a range
      llvm: fix OP_SWITCH has no target
      llvm: make value_to_pvalue() more flexible
      llvm: make value_to_ivalue() more flexible
      llvm: add test case pointer compare with cast
      llvm: let pseudo_to_value() directly use the type
      llvm: remove unneeded pseudo_to_value() unneeded argument
      llvm: introduce get_ioperand()
      llvm: fix mutating function pointer
      llvm: fix mutated OP_RET
      llvm: fix mutated OP_SEL
      llvm: fix mutated OP_SWITCH
      llvm: fix mutated OP_PHISOURCE
      llvm: fix mutated OP_[PTR]CAST
      llvm: add support for restricted types
      llvm: fix get value from initialized symbol
      llvm: fix get value from non-anonymous symbol
      llvm: fix type of bitfields
      llvm: add support for OP_FPCAST
      llvm: add support for cast from floats
      llvm: cleanup of output_[ptr]cast()
      llvm: fix creation of sparsec's tmp files

 Documentation/instructions.txt          | 296 ++++++++++++++++
 Makefile                                |   1 +
 compile-i386.c                          |  14 +-
 example.c                               |   4 +-
 flow.c                                  |   3 +-
 linearize.c                             |  80 +++--
 linearize.h                             |  17 +-
 liveness.c                              |  14 +-
 memops.c                                |   2 +-
 opcode.c                                |  36 ++
 opcode.h                                |  10 +
 show-parse.c                            |  11 +-
 simplify.c                              |  77 ++---
 sparse-llvm.c                           | 586 +++++++++++++++++++++-----------
 sparsec                                 |   4 +-
 symbol.h                                |   9 +
 validation/backend/cast.c               |   7 +-
 validation/backend/compare-with-null.c  |  12 +
 validation/backend/constant-pointer.c   |  24 ++
 validation/backend/degenerate-ptr.c     |  72 ++++
 validation/backend/function-ptr-xtype.c |  37 ++
 validation/backend/function-ptr.c       | 148 +++++++-
 validation/backend/label-as-value.c     |  13 +
 validation/backend/load-global.c        |  21 ++
 validation/backend/pointer-add.c        |  54 +++
 validation/backend/pointer-cmp.c        |  12 +
 validation/backend/pointer-param.c      |  42 +++
 validation/backend/pointer-sub.c        |  17 +
 validation/backend/setval.c             |   7 +
 validation/backend/shift-special.c      |  13 +
 validation/backend/store-x2.c           |  16 +
 validation/backend/string-value.c       |  21 ++
 validation/backend/switch.c             | 248 ++++++++++++++
 validation/backend/symaddr.c            |  70 ++++
 validation/backend/type-constant.c      |  23 ++
 validation/call-inlined.c               |  54 +++
 validation/call-variadic.c              |  31 ++
 validation/loop-linearization.c         |   9 +-
 validation/optim/call-inlined.c         |  30 ++
 validation/optim/canonical-cmp.c        | 124 +++++++
 validation/push-call.c                  |  26 ++
 validation/switch-long.c                |  47 +++
 42 files changed, 2024 insertions(+), 318 deletions(-)
 create mode 100644 Documentation/instructions.txt
 create mode 100644 opcode.c
 create mode 100644 opcode.h
 create mode 100644 validation/backend/compare-with-null.c
 create mode 100644 validation/backend/constant-pointer.c
 create mode 100644 validation/backend/degenerate-ptr.c
 create mode 100644 validation/backend/function-ptr-xtype.c
 create mode 100644 validation/backend/label-as-value.c
 create mode 100644 validation/backend/load-global.c
 create mode 100644 validation/backend/pointer-add.c
 create mode 100644 validation/backend/pointer-cmp.c
 create mode 100644 validation/backend/pointer-param.c
 create mode 100644 validation/backend/pointer-sub.c
 create mode 100644 validation/backend/setval.c
 create mode 100644 validation/backend/shift-special.c
 create mode 100644 validation/backend/store-x2.c
 create mode 100644 validation/backend/string-value.c
 create mode 100644 validation/backend/switch.c
 create mode 100644 validation/backend/symaddr.c
 create mode 100644 validation/backend/type-constant.c
 create mode 100644 validation/call-inlined.c
 create mode 100644 validation/call-variadic.c
 create mode 100644 validation/optim/call-inlined.c
 create mode 100644 validation/optim/canonical-cmp.c
 create mode 100644 validation/push-call.c
 create mode 100644 validation/switch-long.c
