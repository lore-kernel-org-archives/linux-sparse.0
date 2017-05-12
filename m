From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [GIT PULL] last pending patches for sparse's next release
Date: Fri, 12 May 2017 13:19:36 +0200
Message-ID: <20170512111935.se6k5v2tlcwvtffc@desk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:35172 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755136AbdELLTk (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 12 May 2017 07:19:40 -0400
Received: by mail-wm0-f44.google.com with SMTP id b84so18093640wmh.0
        for <linux-sparse@vger.kernel.org>; Fri, 12 May 2017 04:19:40 -0700 (PDT)
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

Chris,

Please pull these patches for sparse's next release.
There is 3 fixes, plus Lance's support for _Static_assert
and the keyword cleanup that goes over it.

Regards,
Luc

--->8

The following changes since commit e35efe330c6ae7d154197c29b127560d569016d0:

  Merge branches 'sent/float-expand-v2', 'sent/fix-kill-ttsb-v2', 'sent/fix-cond-address' and 'careful-concat-user-list' into tip (2017-04-30 02:08:54 +0200)

are available in the git repository at:

  git://github.com/lucvoo/sparse.git tags/fixes-for-stable-20170512

for you to fetch changes up to 51de1cca1bde56d9a1c73142fa2c93eeba65d0bf:

  Merge branches 'quiets-bool-cast-restricted-v2', 'keyword-cleanup-v2', 'not-so-crazy-v2' and 'ignore-void-if-convert-v3' into tip (2017-05-12 12:59:06 +0200)

----------------------------------------------------------------
Pending fixes for sparse's next release

----------------------------------------------------------------
Lance Richardson (1):
      sparse: add support for _Static_assert

Luc Van Oostenryck (12):
      avoid useless warning for 'bool <- restricted type' conversion
      introduce REPEAT_CFG_CLEANUP
      let kill_unreachable_bbs() clear REPEAT_CFG_CLEANUP
      fix: kill unreachable BBs after killing a child
      ignore VOID when trying to if-convert phi-nodes
      keyword: add test case for reserved '_Static_assert'
      keyword: regroup the [reserved] keywords
      keyword: explicitly add C99 & C11 keywords
      keyword: add more reserved keywords to the test case
      keyword: add a comment about NS_TYPEDEF & reserved keywords
      keyword: no pre-declaration needed for attribute names
      Merge branches 'quiets-bool-cast-restricted-v2', 'keyword-cleanup-v2', 'not-so-crazy-v2' and 'ignore-void-if-convert-v3' into tip

 evaluate.c                         |   6 ++
 flow.c                             |   2 +
 flow.h                             |   1 +
 ident-list.h                       |  77 ++++-------------
 linearize.c                        |   5 +-
 parse.c                            |  46 +++++++++-
 simplify.c                         |  41 +++++++--
 validation/bool-cast-bad.c         |   3 -
 validation/bool-cast-implicit.c    |   3 -
 validation/bool-cast-restricted.c  |  25 ++++++
 validation/crazy02-not-so.c        |  22 +++++
 validation/optim/void-if-convert.c |  19 +++++
 validation/reserved.c              | 171 +++++++++++++++++++++++++++++++------
 validation/static_assert.c         |  71 +++++++++++++++
 14 files changed, 392 insertions(+), 100 deletions(-)
 create mode 100644 validation/bool-cast-restricted.c
 create mode 100644 validation/crazy02-not-so.c
 create mode 100644 validation/optim/void-if-convert.c
 create mode 100644 validation/static_assert.c
