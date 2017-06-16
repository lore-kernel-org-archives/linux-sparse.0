From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/2] fix bogus "crazy progammer"
Date: Fri, 16 Jun 2017 21:18:42 +0200
Message-ID: <20170616191844.86256-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36760 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751012AbdFPTS4 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 16 Jun 2017 15:18:56 -0400
Received: by mail-wm0-f67.google.com with SMTP id d17so6638807wme.3
        for <linux-sparse@vger.kernel.org>; Fri, 16 Jun 2017 12:18:55 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Chris Li <sparse@chrisli.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The goal of this series is to fix the bogus "crazy progammer"
warnings issued by sparse when running on the git tree.

This "crazy programmer" warning is issued when there is
a circulary dependency between pseudos but in the present
case this circulary dependence was only an consequence of
optimizations applied on a wrong state.

With this bug fixed, there is only a single sparse warnings 
left in the git tree (and it's most probably a bogus one).
Big congrats to them!
For comparison the Linux kernel has more than 1000 errors and
close to 24000 warnings (on an allyesconfig for x86-64),
plenty of bogus ones but also a lot of real ones.

For the adventurous ones, this series is also available at:
  git://github.com/lucvoo/sparse.git fix-eager-ttsbb


Luc Van Oostenryck (2):
  fix OP_PHI usage in try_to_simplify_bb() only when non-bogus
  fix: try_to_simplify_bb eargerness

 flow.c               | 47 ++++++++++++++++++++++++++---------------------
 validation/crazy03.c | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+), 21 deletions(-)
 create mode 100644 validation/crazy03.c

-- 
2.13.0

