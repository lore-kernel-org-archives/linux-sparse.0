From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 00/29] Simple & Efficient SSA construction.
Date: Wed, 16 Aug 2017 17:34:26 +0200
Message-ID: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33627 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751471AbdHPPfF (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 16 Aug 2017 11:35:05 -0400
Received: by mail-wr0-f193.google.com with SMTP id n88so3695452wrb.0
        for <linux-sparse@vger.kernel.org>; Wed, 16 Aug 2017 08:35:04 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The goal of this series is to implement and integrate to sparse
the method described in the paper:
    "Simple and Efficient Construction of Static Single Assignment Form"
	by Matthias Braun, Sebastian Buchwald, Sebastian Hack,
	   Roland Leissa, Christoph Mallon and Andreas Zwinkau.
    cfr. http://www.cdl.uni-saarland.de/papers/bbhlmz13cc.pdf

In the present case, the principal motivation to use this method
is that the current one in sparse is severely broken.


The series is also available in the git repository at:

  git://github.com/lucvoo/sparse.git sssa-mini-v1

for you to fetch changes up to 98a21bc0c82af5115687c7e03a277519836bcac6:

  sssa: remove now unneeded simplify_one_symbol() (2017-08-16 17:25:25 +0200)

----------------------------------------------------------------
Luc Van Oostenryck (29):
      remove wrong part of simplify_loads()
      give a type to OP_PHISOURCEs
      fix test case kill-phi-ttsb
      add test case for incomplete type
      add test case for bad return type
      topasm: top-level asm is special
      ret-void: return nothing only for void functions
      small code reorg of add_store()
      add helper to test if a variable is "simple"
      add helper imple_access() to test if an access is "simple"
      add PSEUDO_UNDEF
      add undef_pseudo()
      add insert_phi_node()
      extract alloc_phisrc() from alloc_phi()
      add remove_use()
      ptrmap: add missing #include "compat.h"
      ptrmap: core implementation
      ptrmap: add type-safe interface
      sssa: add Simple SSA interfaces
      sssa: add needed new members
      sssa: add basic implementation
      sssa: add seal_gotos() needed to seal BBs targeted by gotos
      sssa: set var's ident
      sssa: add PSEUDO_INDIR
      sssa: reorg load_var()
      sssa: protect against unreachable loops
      sssa: remove trivial phi-nodes
      sssa: switch to the new SSA construction
      sssa: remove now unneeded simplify_one_symbol()

 Makefile                                |   2 +
 allocate.h                              |   2 +
 flow.c                                  | 324 --------------------------------
 flow.h                                  |   2 +-
 linearize.c                             | 174 ++++++++++++-----
 linearize.h                             |  23 ++-
 memops.c                                |  63 -------
 ptrmap.c                                |  84 +++++++++
 ptrmap.h                                |  28 +++
 simplify.c                              |  13 ++
 sparse-llvm.c                           |   4 +
 ssa.c                                   | 219 +++++++++++++++++++++
 ssa.h                                   |  12 ++
 symbol.h                                |  34 ++++
 validation/bad-return-type.c            |  19 ++
 validation/cast-constant-to-float.c     |   8 +-
 validation/cast-constants.c             |  40 ++--
 validation/cast-kinds.c                 | 160 ++++++++--------
 validation/context.c                    |   2 +-
 validation/incomplete-struct.c          |  23 +++
 validation/kill-casts.c                 |   1 -
 validation/kill-phi-ttsbb.c             |   2 +-
 validation/linear/bitfield-init-zero.c  |  24 +--
 validation/linear/struct-init-partial.c |   8 +-
 validation/loop-linearization.c         |  60 +++---
 validation/memops-volatile.c            |   4 +-
 validation/optim/bool-simplify.c        |  12 +-
 27 files changed, 745 insertions(+), 602 deletions(-)
 create mode 100644 ptrmap.c
 create mode 100644 ptrmap.h
 create mode 100644 ssa.c
 create mode 100644 ssa.h
 create mode 100644 validation/bad-return-type.c
 create mode 100644 validation/incomplete-struct.c
