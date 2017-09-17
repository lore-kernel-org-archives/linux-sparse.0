From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/2] fix missing evaluation when using '-include <file>'
Date: Sun, 17 Sep 2017 12:05:50 +0200
Message-ID: <20170917100552.72288-1-luc.vanoostenryck@gmail.com>
References: <CAHmME9o02YNvfqV3RFofJE8FXwRaUACzq03TBADSYc74E02iBg@mail.gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34653 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750802AbdIQKGA (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 17 Sep 2017 06:06:00 -0400
Received: by mail-wm0-f66.google.com with SMTP id i131so6288888wma.1
        for <linux-sparse@vger.kernel.org>; Sun, 17 Sep 2017 03:05:59 -0700 (PDT)
In-Reply-To: <CAHmME9o02YNvfqV3RFofJE8FXwRaUACzq03TBADSYc74E02iBg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This mini series is to fix a bug where functions included via
'-include <file>' are not evaluated and thus not expanded or
linearized as they should be.

Thanks to Jason A. Donenfeld for catching that and having enough
perseverance to create a small reproducer.

----------------------------------------------------------------

The patches are also available in the git repository at:

  git://github.com/lucvoo/sparse.git fix-include-eval

for you to fetch changes up to 36d1d8b9a453c1f7c215136624198aee9a6f174c:

  fix: missing evaluate with '-include' (2017-09-17 11:54:23 +0200)

----------------------------------------------------------------
Luc Van Oostenryck (2):
      fix: missing evaluate with '-include' : add testcase
      fix: missing evaluate with '-include'

 lib.c                       | 14 ++++++++++++++
 validation/include-eval.c   |  6 ++++++
 validation/include-eval.inc | 12 ++++++++++++
 3 files changed, 32 insertions(+)
 create mode 100644 validation/include-eval.c
 create mode 100644 validation/include-eval.inc
