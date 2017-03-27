From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v6 00/52] LLVM fixes
Date: Mon, 27 Mar 2017 23:23:24 +0200
Message-ID: <20170327212416.18536-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f172.google.com ([209.85.128.172]:35586 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751629AbdC0V01 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Mar 2017 17:26:27 -0400
Received: by mail-wr0-f172.google.com with SMTP id u1so76379413wra.2
        for <linux-sparse@vger.kernel.org>; Mon, 27 Mar 2017 14:26:26 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This series solves a number of issues in sparse-llvm,
mainly about wrong or missing type information as needed
to build LLVM IR.
Most of these issues have been reported and investigated by
Dibyendu Majumdar.

Changes since v5:
- avoid declare a var inside a for-loop for non C99 compilers
- fix naming of symbol without an indent
- avoid sparsec to leave its tmp file

Changes since v4:
- extract the non sparse-llvm specific patches into
  a separate, preparatory serie.

Changes since v3:
- systematically insure that operands and output values
  have the expected type (which may different than the
  stored with). Some work may still be needed here.
- add support for OP_SWITCH with a range
- add support for floating-point casts (to and from)
- add support for OP_SETVAL (floats & labels)
- fix type of globals having an initializer

Changes since v2:
- remove the changes tha gave a type to PSEUDO_VALs
- introduction of OP_PUSH instructions
- move toward generic solution using the instruction's type
- some more fixes
- temporary remove changes related to OP_SYMADDR


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
  https://github.com/lucvoo/sparse/tree/llvm-fixes-v5

Luc Van Oostenryck (52):
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

 sparse-llvm.c                           | 584 +++++++++++++++++++++-----------
 sparsec                                 |   4 +-
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
 21 files changed, 1233 insertions(+), 212 deletions(-)
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

-- 
2.12.0

