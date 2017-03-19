From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 00/30] LLVM fixes
Date: Sun, 19 Mar 2017 02:41:57 +0100
Message-ID: <20170319014227.8833-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34463 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751189AbdCSBmj (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 18 Mar 2017 21:42:39 -0400
Received: by mail-wm0-f66.google.com with SMTP id u132so8889908wmg.1
        for <linux-sparse@vger.kernel.org>; Sat, 18 Mar 2017 18:42:38 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This series solves a number of issues in sparse-llvm,
mainly about wrong or missing type information as needed
to build LLVM IR.
Most of these issues have been reported and investigated by
Dibyendu Majumdar.

Changes since v2:
- remove the changes tha gave a type to PSEUDO_VALs
- introduction of OP_PUSH instructions
- move toward generic solution using the instruction's type
- some more fixes
- temporary remove changes related to OP_SYMADDR

* patches 1 & 2 are fixes/improvement of inlined call
	  unrelated to LLVM
* patch   3 add support of OP_PUSH and solve variadic + constant
* patches 4 & 5 add missing type to some instructions
* patches 6-14 are preparatory cleanups
* patch   15 fix a problme with floats & SYM_NODE
* patch   16 improve the typing of contants
* patches 17 & 18 are fixes
* patch	  19 fix issues with degenerated pointers
* patches 20-23 add test cases solved by patch 19
* patches 24-30 are fixes

These patches already allow to compile a lot more code to LLVM
but there is still known issues with sparse-llvm:
- it won't work on bitfields
- it won't work on computed gotos
- it won't work on label-as-value
- it won't work on exotic instructions (OP_SPLICE)
- there is a bunch of problems with floats
  (but this is not specific to sparse-llvm).
There is most probably a bunch of others issues too.

For convenience, this serie is also available at:
  https://github.com/lucvoo/sparse/tree/llvm-fixes-v3


Luc Van Oostenryck (30):
  fix usage of inlined calls
  inlined calls should not block BB packing
  give function's arguments a type via OP_PUSH
  give a type to OP_PHISOURCE
  give a type to OP_SEL, always
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
  llvm: fix pointer/float mixup in comparisons
  llvm: fix type in comparison with an address constant
  llvm: give correct type to binops
  llvm: adjust OP_RET's type
  llvm: variadic functions are not being marked as such
  llvm: fix type of switch constants

 example.c                              |   4 +-
 flow.c                                 |   3 +-
 linearize.c                            |  53 +++--
 linearize.h                            |  12 +-
 liveness.c                             |  14 +-
 memops.c                               |   2 +-
 simplify.c                             |  11 +-
 sparse-llvm.c                          | 412 +++++++++++++++++++++------------
 validation/backend/compare-with-null.c |  12 +
 validation/backend/constant-pointer.c  |  24 ++
 validation/backend/degenerate-ptr.c    |  72 ++++++
 validation/backend/function-ptr.c      | 148 +++++++++++-
 validation/backend/pointer-add.c       |  54 +++++
 validation/backend/pointer-cmp.c       |   9 +
 validation/backend/pointer-param.c     |  42 ++++
 validation/backend/pointer-sub.c       |  17 ++
 validation/backend/store-x2.c          |  16 ++
 validation/backend/symaddr.c           |  70 ++++++
 validation/backend/type-constant.c     |  23 ++
 validation/call-inlined.c              |  58 +++++
 validation/call-variadic.c             |  31 +++
 validation/loop-linearization.c        |   9 +-
 validation/optim/call-inlined.c        |  30 +++
 23 files changed, 943 insertions(+), 183 deletions(-)
 create mode 100644 validation/backend/compare-with-null.c
 create mode 100644 validation/backend/constant-pointer.c
 create mode 100644 validation/backend/degenerate-ptr.c
 create mode 100644 validation/backend/pointer-add.c
 create mode 100644 validation/backend/pointer-cmp.c
 create mode 100644 validation/backend/pointer-param.c
 create mode 100644 validation/backend/pointer-sub.c
 create mode 100644 validation/backend/store-x2.c
 create mode 100644 validation/backend/symaddr.c
 create mode 100644 validation/backend/type-constant.c
 create mode 100644 validation/call-inlined.c
 create mode 100644 validation/call-variadic.c
 create mode 100644 validation/optim/call-inlined.c

-- 
2.12.0

