From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [GIT PULL] patches for -rc2
Date: Thu, 15 Jun 2017 10:20:52 +0200
Message-ID: <20170615082050.4ztydiu3d6m4fx2e@ltop.local>
References: <20170615043455.3ke55dyo6v4vpebo@ltop.local>
 <CANeU7QmtKh5LxJVvaFVGy7KApXTtzW+-G19LogbEZH=kTNLHAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lf0-f42.google.com ([209.85.215.42]:35918 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752075AbdFOIU5 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 15 Jun 2017 04:20:57 -0400
Received: by mail-lf0-f42.google.com with SMTP id o83so4053986lff.3
        for <linux-sparse@vger.kernel.org>; Thu, 15 Jun 2017 01:20:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7QmtKh5LxJVvaFVGy7KApXTtzW+-G19LogbEZH=kTNLHAQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Jun 15, 2017 at 12:11:55AM -0700, Christopher Li wrote:
> On Wed, Jun 14, 2017 at 9:34 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > Chris,
> >
> > Please pull these patches for v0.5.1-rc2.
> 
> Thanks, I fetch your change already.

And of course, I had to mess it up by forgetting to add
my SoB to the new patches for cgcc. Sorry for that.
I have added them now, as well as adding missing credits,
and republished the updated version. The patches themselves
haven't changed, only the commit messages.

Please, drop what you have already pulled and take the
following instead.

Sorry again,
-- Luc

The following changes since commit 88578349140acf4405b768a60be05e10b7b8b158:

  Merge branches 'dump-macros-v2', 'fix-predefined-size', 'fix-bool-context', 'fix-missing-reload', 'fix-insert-branch', 'fix-NULL-type', 'testsuite-clean', 'fix-bitfield-init-v3' and 'fdump-linearize' into tip (2017-05-19 16:11:51 +0200)

are available in the git repository at:

  git://github.com/lucvoo/sparse.git tags/for-chris

for you to fetch changes up to bcfe020ed939fa1e8474efaf31a86d80d0e5c5fe:

  add support for -fmemcpy-max-count (2017-06-15 10:03:49 +0200)

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
