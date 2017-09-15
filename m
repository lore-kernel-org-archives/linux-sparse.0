From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/4] testcases for optimization problems
Date: Fri, 15 Sep 2017 10:55:07 +0200
Message-ID: <20170915085511.43429-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38683 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751146AbdIOIzS (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 15 Sep 2017 04:55:18 -0400
Received: by mail-wm0-f65.google.com with SMTP id x17so2157715wmd.5
        for <linux-sparse@vger.kernel.org>; Fri, 15 Sep 2017 01:55:17 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The series contains a few tescases for some past or present
optimization problems.


Thsi series is also available for review in the git repository at:

  git://github.com/lucvoo/sparse.git testcases-bugs-optim

----------------------------------------------------------------
Luc Van Oostenryck (4):
      add test cases for canonicalization of add/sub chains
      add test cases for canonicalization of mul chains
      add test cases for simplification of equivalent to 'x == 0' or 'x != 0'
      add test cases for canonicalization of boolean expressions

 validation/optim/bool-eq0.c      | 12 +++++++++
 validation/optim/bool-ne0.c      | 12 +++++++++
 validation/optim/bool-neq0.c     | 12 +++++++++
 validation/optim/canonical-add.c | 55 ++++++++++++++++++++++++++++++++++++++++
 validation/optim/canonical-mul.c | 24 ++++++++++++++++++
 5 files changed, 115 insertions(+)
 create mode 100644 validation/optim/bool-eq0.c
 create mode 100644 validation/optim/bool-ne0.c
 create mode 100644 validation/optim/bool-neq0.c
 create mode 100644 validation/optim/canonical-add.c
 create mode 100644 validation/optim/canonical-mul.c
