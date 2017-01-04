From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/4] phisrc fixes
Date: Wed,  4 Jan 2017 04:03:17 +0100
Message-ID: <20170104030321.28019-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wj0-f196.google.com ([209.85.210.196]:33689 "EHLO
        mail-wj0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751018AbdADDEM (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 3 Jan 2017 22:04:12 -0500
Received: by mail-wj0-f196.google.com with SMTP id kp2so73908314wjc.0
        for <linux-sparse@vger.kernel.org>; Tue, 03 Jan 2017 19:03:32 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This series fixes problems with the creation and placement of phisrcs.

Patch 1 is a preparatory step for patch 4 but fixes a very problem
of its own.
Patch 2 & 3 are the main fixes.
Patch 4 is a small improvement but also avoid divergence in the code
regarding the changes made in patch 3.

Note: I'm very sure there is still others bugs in the same corner but
      at least these patch improve the situation a bit.
Note: Only one patch has a regression test. For the other 3, it's
      to have some examples but this doesn't fit very well into the current
      testsuite.
      
This serie can also be found on the 'sent/broken-phisrc' of
	git://github.com/lucvoo/sparse.git

Luc Van Oostenryck (4):
  volatile loads must not be simplified
  fix superfluous phisrc
  fix phisrc mixup
  missing load simplification

 flow.c                       | 23 ++++++++++++++++-------
 memops.c                     | 13 ++++++-------
 validation/memops-volatile.c | 21 +++++++++++++++++++++
 3 files changed, 43 insertions(+), 14 deletions(-)
 create mode 100644 validation/memops-volatile.c
