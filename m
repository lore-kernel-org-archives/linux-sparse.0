From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [GIT PULL] next batch of patches
Date: Sat, 20 May 2017 18:14:31 +0200
Message-ID: <20170520161430.rojzqbt7rl6rud5b@desk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f173.google.com ([209.85.128.173]:36526 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750760AbdETQOf (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 20 May 2017 12:14:35 -0400
Received: by mail-wr0-f173.google.com with SMTP id l50so30390354wrc.3
        for <linux-sparse@vger.kernel.org>; Sat, 20 May 2017 09:14:34 -0700 (PDT)
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

Chris,

Please pull these patches for sparse's next release.
More or less half of them are fixes, the remaining ones
are utilities like -fmem-report, -fdump-linearize and
support for -dD.

Thank you,
Luc

--->8

The following changes since commit 51de1cca1bde56d9a1c73142fa2c93eeba65d0bf:

  Merge branches 'quiets-bool-cast-restricted-v2', 'keyword-cleanup-v2', 'not-so-crazy-v2' and 'ignore-void-if-convert-v3' into tip (2017-05-12 12:59:06 +0200)

are available in the git repository at:

  git://github.com/lucvoo/sparse.git tags/fixes-for-stable-20170520

for you to fetch changes up to 88578349140acf4405b768a60be05e10b7b8b158:

  Merge branches 'dump-macros-v2', 'fix-predefined-size', 'fix-bool-context', 'fix-missing-reload', 'fix-insert-branch', 'fix-NULL-type', 'testsuite-clean', 'fix-bitfield-init-v3' and 'fdump-linearize' into tip (2017-05-19 16:11:51 +0200)

----------------------------------------------------------------
Pending fixes for sparse's next release

----------------------------------------------------------------
Luc Van Oostenryck (24):
      fix boolean context for OP_AND_BOOL & OP_OR_BOOL
      fix missing reload
      add get_<allocator>_stats()
      add show_allocation_stats()
      add helper handle_simple_switch()
      teach sparse how to handle '-fmem-report'
      use -fmem-report to report allocation stats
      testsuite: cleanup result files
      fix: kill old branch in insert_branch()
      returns the correct type when evaluating NULL
      remove bit_size & bit_offset from struct access_data
      add test case for linearize_initializer() of bitfields
      fix implicit zero initializer.
      remove alignment from struct access_data
      remove origval from struct access_data
      add support for a new flag: -fdump-linearize[=only]
      define ident_list
      teach sparse how to dump macro definitions
      fix hardcoded size of wide chars
      avoid to redefine __INT_MAX__ and friends
      fix definition of __SCHAR_MAX__ & friends
      teach sparse how to handle -dD flag
      let -dD report macro definitions
      Merge branches 'dump-macros-v2', 'fix-predefined-size', 'fix-bool-context', 'fix-missing-reload', 'fix-insert-branch', 'fix-NULL-type', 'testsuite-clean', 'fix-bitfield-init-v3' and 'fdump-linearize' into tip

 Makefile                                    |   1 +
 allocate.c                                  |   8 +++
 allocate.h                                  |  13 ++++
 char.c                                      |   4 +-
 evaluate.c                                  |   2 +-
 flow.c                                      |  12 +++-
 lib.c                                       |  91 +++++++++++++++++++++----
 lib.h                                       |  13 ++++
 linearize.c                                 |  86 +++++++++++++++++------
 pre-process.c                               |  55 +++++++++++++++
 sparse-llvm.c                               |   1 +
 sparse.1                                    |  10 +++
 sparse.c                                    |   2 +
 stats.c                                     |  62 +++++++++++++++++
 target.c                                    |   2 +
 target.h                                    |   2 +
 test-linearize.c                            |   2 +
 test-unssa.c                                |   1 +
 validation/alias-distinct.c                 |  17 +++++
 validation/alias-mixed.c                    |  30 ++++++++
 validation/alias-same.c                     |  17 +++++
 validation/empty-file                       |   0
 validation/kill-insert-branch.c             |  22 ++++++
 validation/linear/bitfield-init-mask.c      |  27 ++++++++
 validation/linear/bitfield-init-zero.c      | 102 ++++++++++++++++++++++++++++
 validation/linear/struct-init-full.c        |  28 ++++++++
 validation/linear/struct-init-partial.c     |  41 +++++++++++
 validation/optim/bool-context.c             |  12 ++++
 validation/optim/bool-simplify.c            |   8 ++-
 validation/preprocessor/dump-macros-empty.c |   7 ++
 validation/preprocessor/dump-macros-multi.c |   7 ++
 validation/preprocessor/dump-macros.c       |  18 +++++
 validation/test-suite                       |   1 +
 33 files changed, 663 insertions(+), 41 deletions(-)
 create mode 100644 stats.c
 create mode 100644 validation/alias-distinct.c
 create mode 100644 validation/alias-mixed.c
 create mode 100644 validation/alias-same.c
 create mode 100644 validation/empty-file
 create mode 100644 validation/kill-insert-branch.c
 create mode 100644 validation/linear/bitfield-init-mask.c
 create mode 100644 validation/linear/bitfield-init-zero.c
 create mode 100644 validation/linear/struct-init-full.c
 create mode 100644 validation/linear/struct-init-partial.c
 create mode 100644 validation/optim/bool-context.c
 create mode 100644 validation/preprocessor/dump-macros-empty.c
 create mode 100644 validation/preprocessor/dump-macros-multi.c
 create mode 100644 validation/preprocessor/dump-macros.c
