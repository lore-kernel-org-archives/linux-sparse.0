From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/6] testsuite speedup
Date: Sun, 28 May 2017 21:29:00 +0200
Message-ID: <20170528192906.1023-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35773 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750802AbdE1T3M (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 28 May 2017 15:29:12 -0400
Received: by mail-wm0-f65.google.com with SMTP id g15so12960162wmc.2
        for <linux-sparse@vger.kernel.org>; Sun, 28 May 2017 12:29:11 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The goal of this series is to speedup the testsuite,
mainly by avoiding to unneedlessly spawn child processes.

The resulting speedup here is over 2.5, which is quite appreciable.

Luc Van Oostenryck (6):
  testsuite: get all tags in once
  testsuite: grep the expected output only when needed
  testsuite: grep the output patterns only when needed
  testsuite: use shell arithmetic instead of fork-execing expr
  testsuite: remove unneeded './' before commands
  testsuite: avoid fork+execing basename

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
 validation/prototype.c                |   2 +-
 validation/test-suite                 | 137 +++++++++++++++++++---------------
 23 files changed, 97 insertions(+), 84 deletions(-)

-- 
2.13.0

