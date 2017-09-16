From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/3] testcases for memory-to-register conversion
Date: Sat, 16 Sep 2017 11:01:44 +0200
Message-ID: <20170916090147.38083-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34862 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751050AbdIPJBz (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 16 Sep 2017 05:01:55 -0400
Received: by mail-wm0-f66.google.com with SMTP id e64so4592560wmi.2
        for <linux-sparse@vger.kernel.org>; Sat, 16 Sep 2017 02:01:54 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The series contains tescases related to memory-to-register and
SSA conversion.

This series is also available for review in the git repository at:

  git://github.com/lucvoo/sparse.git testcases-mem2reg

----------------------------------------------------------------
Luc Van Oostenryck (3):
      add testcase for __builtin_unreachable()
      add testcase for return & inline
      add testcase for mem2reg/SSA conversion

 validation/linear/builtin_unreachable.c  | 31 +++++++++++++++++++++++++++++++
 validation/linear/inline-return.c        | 24 ++++++++++++++++++++++++
 validation/mem2reg/address-used00.c      | 19 +++++++++++++++++++
 validation/mem2reg/broken-phi02.c        | 28 ++++++++++++++++++++++++++++
 validation/mem2reg/broken-phi03.c        | 29 +++++++++++++++++++++++++++++
 validation/mem2reg/cond-expr.c           | 13 +++++++++++++
 validation/mem2reg/cond-expr5.c          | 18 ++++++++++++++++++
 validation/mem2reg/global-direct-undef.c | 23 +++++++++++++++++++++++
 validation/mem2reg/global-direct.c       | 23 +++++++++++++++++++++++
 validation/mem2reg/global-loop.c         | 20 ++++++++++++++++++++
 validation/mem2reg/global-noalias.c      | 21 +++++++++++++++++++++
 validation/mem2reg/global-pointer.c      | 26 ++++++++++++++++++++++++++
 validation/mem2reg/if-direct.c           | 19 +++++++++++++++++++
 validation/mem2reg/if-pointer.c          | 21 +++++++++++++++++++++
 validation/mem2reg/init-global-array.c   | 17 +++++++++++++++++
 validation/mem2reg/init-local-array.c    | 25 +++++++++++++++++++++++++
 validation/mem2reg/init-local-union0.c   | 18 ++++++++++++++++++
 validation/mem2reg/init-local-union1.c   | 32 ++++++++++++++++++++++++++++++++
 validation/mem2reg/init-local.c          | 27 +++++++++++++++++++++++++++
 validation/mem2reg/loop00.c              | 16 ++++++++++++++++
 validation/mem2reg/loop01-global.c       | 18 ++++++++++++++++++
 validation/mem2reg/loop02-array.c        | 23 +++++++++++++++++++++++
 validation/mem2reg/loop02-global.c       | 22 ++++++++++++++++++++++
 validation/mem2reg/loop02-local.c        | 23 +++++++++++++++++++++++
 validation/mem2reg/loop02-pointer.c      | 23 +++++++++++++++++++++++
 validation/mem2reg/quadra00.c            | 28 ++++++++++++++++++++++++++++
 validation/mem2reg/short-load.c          | 29 +++++++++++++++++++++++++++++
 validation/mem2reg/undef00.c             | 14 ++++++++++++++
 validation/mem2reg/volatile-store00.c    | 27 +++++++++++++++++++++++++++
 validation/optim/volatile-store00.c      | 28 ++++++++++++++++++++++++++++
 30 files changed, 685 insertions(+)
 create mode 100644 validation/linear/builtin_unreachable.c
 create mode 100644 validation/linear/inline-return.c
 create mode 100644 validation/mem2reg/address-used00.c
 create mode 100644 validation/mem2reg/broken-phi02.c
 create mode 100644 validation/mem2reg/broken-phi03.c
 create mode 100644 validation/mem2reg/cond-expr.c
 create mode 100644 validation/mem2reg/cond-expr5.c
 create mode 100644 validation/mem2reg/global-direct-undef.c
 create mode 100644 validation/mem2reg/global-direct.c
 create mode 100644 validation/mem2reg/global-loop.c
 create mode 100644 validation/mem2reg/global-noalias.c
 create mode 100644 validation/mem2reg/global-pointer.c
 create mode 100644 validation/mem2reg/if-direct.c
 create mode 100644 validation/mem2reg/if-pointer.c
 create mode 100644 validation/mem2reg/init-global-array.c
 create mode 100644 validation/mem2reg/init-local-array.c
 create mode 100644 validation/mem2reg/init-local-union0.c
 create mode 100644 validation/mem2reg/init-local-union1.c
 create mode 100644 validation/mem2reg/init-local.c
 create mode 100644 validation/mem2reg/loop00.c
 create mode 100644 validation/mem2reg/loop01-global.c
 create mode 100644 validation/mem2reg/loop02-array.c
 create mode 100644 validation/mem2reg/loop02-global.c
 create mode 100644 validation/mem2reg/loop02-local.c
 create mode 100644 validation/mem2reg/loop02-pointer.c
 create mode 100644 validation/mem2reg/quadra00.c
 create mode 100644 validation/mem2reg/short-load.c
 create mode 100644 validation/mem2reg/undef00.c
 create mode 100644 validation/mem2reg/volatile-store00.c
 create mode 100644 validation/optim/volatile-store00.c
