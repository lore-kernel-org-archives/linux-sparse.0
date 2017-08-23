From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC PATCH 00/48] fix promotion of symbol to register
Date: Wed, 23 Aug 2017 22:15:06 +0200
Message-ID: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36956 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932443AbdHWUQC (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 23 Aug 2017 16:16:02 -0400
Received: by mail-wm0-f65.google.com with SMTP id v186so629587wmf.4
        for <linux-sparse@vger.kernel.org>; Wed, 23 Aug 2017 13:16:02 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This series fixes the promotion of symbols accesses from
memory to pseudos.
The fix in itself is in the few of the last patches (40-43)
but is preceded by an extensive rework of the whole thing.

As is, it seems to work quite well and of course more
accesses are promoted than the Simple SSA was able to do
(SSSA only cared about purely local vars of which the address
was never ever taken).

For performance, the situation is highly dependent on the
type of code: the amount of work that is done in
simplify_loads() can easily take 80% of the time for complex
files.

Warning 1: this is for review & testing only
Warning 2: it's not (yet) bissectable between patches 40 & 43
Warning 3: simplify_loads is still broken and will need the same
           fix (but the code is currently disabled)


This series is  available in the git repository at:

  git://github.com/lucvoo/sparse.git mem2reg


Luc Van Oostenryck (48):
      remove wrong part of simplify_loads()
      remove trivial phi-nodes during clean_up_phi()
      give a type to OP_PHISOURCEs
      fix test case kill-phi-ttsb
      add test case for incomplete type
      add test case for bad return type
      topasm: top-level asm is special
      ret-void: return nothing only for void functions
      small code reorg of add_store()
      add PSEUDO_UNDEF
      add undef_pseudo()
      add insert_phi_node()
      extract alloc_phisrc() from alloc_phi()
      add remove_use()
      rename 'struct warning' to 'struct flag'
      let handle_simple_switch() handle an array of flags
      dump-ir: rename -fdump-linearize to -fdump-ir
      dump-ir: use defines
      dump-ir: add an helper to parse sub-options
      dump-ir: make it more flexible
      sssa: move simplify_one_symbol() to a separate file
      mem2reg: rename to use 'promote' instead of 'simplify'
      mem2reg: simplify check of modifiers for external visibility
      mem2reg: extract externaly_visible()
      mem2reg: reorg externaly_visible() returns
      mem2reg: ignore all killed instructions
      mem2reg: extract kill_pseudo_stores()
      mem2reg: extract kill_pseudo_dominated_stores()
      mem2reg: extract kill_pseudo_dead_stores()
      mem2reg: remove one indent level
      mem2reg: add comment to find_dominating_stores()
      mem2reg: add flags to enable/disable some parts
      mem2reg: rename the other kill_dominated_stores()
      mem2reg: move rewrite_load_instruction() here
      mem2reg: be clear that we're using a symbol/var
      mem2reg: be clear that we're using a symbol/var here too
      mem2reg: add description for find_dominating_parents()
      mem2reg: let rewrite_load_instruction() take the symbol as arg
      mem2reg: remove check phisrc_in_bb()
      mem2reg: delay the creation of phi-sources
      mem2reg: make rewrite_load_instruction() functional
      mem2reg: rename one->target to dom
      mem2reg: get recursion right
      mem2reg: don't check dominance by removed instructions
      mem2reg: update copyright
      mem2reg: allow dumping IR
      mem2reg: add some small test cases
      mem2reg: don't promote unused or already promoted vars

 Makefile                                |   1 +
 cgcc                                    |   2 +-
 flow.c                                  | 362 -------------------------
 flow.h                                  |   4 +-
 lib.c                                   | 102 +++++--
 lib.h                                   |  11 +-
 linearize.c                             | 101 +++++--
 linearize.h                             |   8 +-
 mem2reg.c                               | 453 ++++++++++++++++++++++++++++++++
 memops.c                                |  85 ++----
 simplify.c                              |  69 +++--
 sparse-llvm.c                           |   4 +
 sparse.1                                |  30 ++-
 validation/bad-return-type.c            |  19 ++
 validation/incomplete-struct.c          |  23 ++
 validation/kill-casts.c                 |   1 -
 validation/kill-phi-ttsbb.c             |   2 +-
 validation/linear/bitfield-init-mask.c  |   2 +-
 validation/loop-linearization.c         |  60 ++---
 validation/mem2reg/global-direct00.c    |  24 ++
 validation/mem2reg/local-addr-taken00.c |  21 ++
 validation/mem2reg/local-direct00.c     |  20 ++
 validation/optim/trivial-phis.c         |  15 ++
 23 files changed, 883 insertions(+), 536 deletions(-)
 create mode 100644 mem2reg.c
 create mode 100644 validation/bad-return-type.c
 create mode 100644 validation/incomplete-struct.c
 create mode 100644 validation/mem2reg/global-direct00.c
 create mode 100644 validation/mem2reg/local-addr-taken00.c
 create mode 100644 validation/mem2reg/local-direct00.c
 create mode 100644 validation/optim/trivial-phis.c
