From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 00/27] LLVM fixes
Date: Sat, 11 Mar 2017 10:06:39 +0100
Message-ID: <20170311090706.17171-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33008 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751024AbdCKJHQ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Mar 2017 04:07:16 -0500
Received: by mail-wm0-f65.google.com with SMTP id n11so2314165wma.0
        for <linux-sparse@vger.kernel.org>; Sat, 11 Mar 2017 01:07:15 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Pekka Enberg <penberg@kernel.org>, Jeff Garzik <jeff@garzik.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This series solves a number of issues in sparse-llvm,
mainly about wrong or missing type information as needed
to build LLVM IR.
These issues have been reported and investigated by
Dibyendu Majumdar.

* patches 1-4 adds missing type info in sparse's IR
* patch   4 is not needed by this serie but logically belong
	  to the same group as patches 1-3. It can be dropped.
* patches 5-7 are fixes
* patch	  8 makes debugging easier
* patches 8-10 are preparatory steps for patch 11
* patches 11 & 12 are fixes
* patch   13 is a preparatory step for patch 14
* patch   14 solves a lot of issues
* patches 15-18 are test cases solved by patch 14
* patch   19 & 20 are fixes
* patches 21, 23-27 are cleanups
* patch   22 makes debugging easier
	  

These patches already allow to compile a lot more code to LLVM
but there is still known issues with sparse-llvm:
- it won't work on bitfields
- it won't work on computed gotos
- it won't work on label-as-value
- it won't work on exotic instructions (OP_SPLICE)
- few things are working correctly with floats
  (but this is not specific to sparse-llvm).
There is most probably a bunch of others issues too.

For convenience, this serie is also available at:
  https://github.com/lucvoo/sparse/tree/llvm-fixes-v2


Luc Van Oostenryck (27):
  give a type to OP_PHISOURCE
  give a type to OP_SEL, always
  give a type to OP_SYMADDR
  give a type to PSEUDO_ARGs
  llvm: fix translation of PSEUDO_VALs into a ValueRefs
  llvm: fix output_op_store() which modify its operand
  llvm: fix output_op_[ptr]cast()
  llvm: give a name to call return values
  llvm: add test cases for the type of constants
  add ptr_list_nth_entry()
  llvm: fix type of literal integer passed as arguments
  llvm: fix output OP_ADD mixed with pointers
  llvm: add support for OP_SYMADDR
  keep OP_SYMADDR instructions
  llvm: add test cases for symbol's address
  llvm: add test cases for pointers passed as argument
  llvm: add test cases for arrays passed as argument
  llvm: add test cases for degenerated pointers
  llvm: add support for OP_NEG
  llvm: fix pointer/float mixup in comparisons
  llvm: use pseudo_list_size() instead of open coding it
  llvm: give arguments a name
  llvm: remove unneeded arg 'module'
  llvm: remove unneeded arg 'fn'
  llvm: remove unneeded 'generation'
  llvm: remove unneeded function::type
  llvm: reduce scope of 'bb_nr'

 flow.c                              |   2 +-
 linearize.c                         |  31 +++--
 linearize.h                         |   8 +-
 memops.c                            |   2 +-
 ptrlist.c                           |  18 +++
 ptrlist.h                           |   1 +
 simplify.c                          |   2 +-
 sparse-llvm.c                       | 254 ++++++++++++++++++++++++++----------
 symbol.h                            |   5 +
 validation/backend/degenerate-ptr.c |  72 ++++++++++
 validation/backend/function-ptr.c   | 149 +++++++++++++++++++++
 validation/backend/null.c           |  24 ++++
 validation/backend/pointer-add.c    |  54 ++++++++
 validation/backend/pointer-cmp.c    |   9 ++
 validation/backend/pointer-param.c  |  42 ++++++
 validation/backend/store-x2.c       |  16 +++
 validation/backend/symaddr.c        |  70 ++++++++++
 validation/backend/type-constant.c  |  23 ++++
 validation/symaddr.c                |  35 +++++
 19 files changed, 724 insertions(+), 93 deletions(-)
 create mode 100644 validation/backend/degenerate-ptr.c
 create mode 100644 validation/backend/null.c
 create mode 100644 validation/backend/pointer-add.c
 create mode 100644 validation/backend/pointer-cmp.c
 create mode 100644 validation/backend/pointer-param.c
 create mode 100644 validation/backend/store-x2.c
 create mode 100644 validation/backend/symaddr.c
 create mode 100644 validation/backend/type-constant.c
 create mode 100644 validation/symaddr.c

-- 
2.11.1

