From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [GIT PULL] patches for -rc2
Date: Thu, 15 Jun 2017 06:34:57 +0200
Message-ID: <20170615043455.3ke55dyo6v4vpebo@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f182.google.com ([209.85.128.182]:35852 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750768AbdFOEfB (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 15 Jun 2017 00:35:01 -0400
Received: by mail-wr0-f182.google.com with SMTP id 36so4074622wry.3
        for <linux-sparse@vger.kernel.org>; Wed, 14 Jun 2017 21:35:00 -0700 (PDT)
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: sparse@chrisli.org
Cc: linux-sparse@vger.kernel.org

Chris,

Please pull these patches for v0.5.1-rc2.
The patches are all about warnings or usability:
* warn for implicit type
* avoid warning on explicit 'bool <- restricted' casts
* finer control over error vs. warnings
* teach cgcc about OSX aka darwin
* add support for -Wmemcpy-max-count
* add more declarations of builtin functions
* add missing names for cgcc to filter out
* speedup the testsuite by avoiding unneeded fork+exec

The only recent changes are parts concerning
the missing names to filter out in cgcc,
thanks to Ramsay Jones to noticing it.

Thank you,
Luc

----------------------------------------------------------------
The following changes since commit 88578349140acf4405b768a60be05e10b7b8b158:

  Merge branches 'dump-macros-v2', 'fix-predefined-size', 'fix-bool-context', 'fix-missing-reload', 'fix-insert-branch', 'fix-NULL-type', 'testsuite-clean', 'fix-bitfield-init-v3' and 'fdump-linearize' into tip (2017-05-19 16:11:51 +0200)

are available in the git repository at:

  git://github.com/lucvoo/sparse.git tags/for-chris

for you to fetch changes up to 8f5e283dc0798ebfea8c019b3f4ea96a8ad00ca1:

  add support for -fmemcpy-max-count (2017-06-14 05:53:10 +0200)

----------------------------------------------------------------
Luc Van Oostenryck (22):
      more tests for implicit 'bool <- restricted' casts
      avoid warning on explicit 'bool <- restricted' casts
      testsuite: get all tags in once
      testsuite: grep the expected output only when needed
      testsuite: grep the output patterns only when needed
      testsuite: use shell arithmetic instead of fork-execing expr
      testsuite: remove unneeded './' before commands
      testsuite: avoid fork+execing basename
      teach cgcc about OSX aka darwin
      ret-void: add test case for toplevel asm
      ret-void: warn for implicit type
      use NULL instead of 0 in testcases.
      finer control over error vs. warnings
      Add more declarations for more builtin functions
      keep the warnings table alphabetically sorted
      cgcc: alphasort warning names in check_only_option()
      cgcc: add missing warning names to check_only_option()
      cgcc: filter-out '-fdump-linearize[=...]'
      memcpy()'s byte count is unsigned
      add support for -Wmemcpy-max-count
      add support for -fmemcpy-max-count

 cgcc                                  |   6 +-
 evaluate.c                            |  14 +++-
 lib.c                                 |  73 +++++++++++++++++-
 lib.h                                 |   6 ++
 parse.c                               |   9 +++
 sparse.1                              |  17 +++++
 sparse.c                              |   6 +-
 validation/alias-mixed.c              |   2 +-
 validation/asm-toplevel.c             |   7 ++
 validation/backend/arithmetic-ops.c   |   2 +-
 validation/backend/array.c            |   2 +-
 validation/backend/bitwise-ops.c      |   2 +-
 validation/backend/bool-test.c        |   2 +-
 validation/backend/cast.c             |   2 +-
 validation/backend/cmp-ops.c          |   2 +-
 validation/backend/extern.c           |   2 +-
 validation/backend/function-ptr.c     |   2 +-
 validation/backend/hello.c            |   2 +-
 validation/backend/int-cond.c         |   2 +-
 validation/backend/load-type.c        |   2 +-
 validation/backend/logical-ops.c      |   2 +-
 validation/backend/loop.c             |   2 +-
 validation/backend/loop2.c            |   2 +-
 validation/backend/ptrcast.c          |   2 +-
 validation/backend/store-type.c       |   2 +-
 validation/backend/struct-access.c    |   2 +-
 validation/backend/struct.c           |   2 +-
 validation/backend/sum.c              |   2 +-
 validation/backend/union.c            |   2 +-
 validation/backend/void-return-type.c |   2 +-
 validation/badtype2.c                 |   1 +
 validation/bool-cast-bad.c            |   1 -
 validation/bool-cast-explicit.c       |   4 -
 validation/bool-cast-restricted.c     |  20 ++++-
 validation/function-redecl.c          |   6 +-
 validation/implicit-ret-type.c        |  15 ++++
 validation/implicit-type.c            |  14 ++++
 validation/prototype.c                |   2 +-
 validation/test-suite                 | 137 +++++++++++++++++++---------------
 validation/typedef_shadow.c           |   1 +
 40 files changed, 279 insertions(+), 104 deletions(-)
 create mode 100644 validation/asm-toplevel.c
 create mode 100644 validation/implicit-ret-type.c
 create mode 100644 validation/implicit-type.c
