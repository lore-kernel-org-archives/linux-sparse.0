From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/5] report allocation stats
Date: Wed, 12 Apr 2017 10:36:58 +0200
Message-ID: <20170412083703.11552-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36052 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752546AbdDLIht (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 12 Apr 2017 04:37:49 -0400
Received: by mail-wm0-f65.google.com with SMTP id q125so4874239wmd.3
        for <linux-sparse@vger.kernel.org>; Wed, 12 Apr 2017 01:37:49 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The goal of this series is to add some support to easily
report allocations statistics and thus be able to do
some experiments about allocation.

For example, playing a bit with this showed that most lists
are quite short (can be as short as and avarage of 2.5 elements
on some code) and that decreasing LIST_NODE_NR from 29 to 13
allow to win 5% when using make C=2 on the kernel (when all
source files have already been compile by GCC), which is already
quite interesting..


This series is available at:
	git://github.com/lucvoo/sparse.git alloc-stats
based on commits (a merge):
	263f8ce449097da4caacfac4e00144f626c6e6a7 (pre-llvm-fixes-v6)
	fc981fe285c37ee297e93ef1cc8725caac75f9b3 (fix-bitfield-init-v2
up to commit:
	bdd16ed276569a16b2362adb266048b91e617f32

Luc Van Oostenryck (5):
  add get_<allocator>_stats()
  add show_allocation_stats()
  add helper handle_simple_switch()
  teach sparse how to handle '-fmem-report'
  use -fmem-report to report allocation stats


 Makefile         |  1 +
 allocate.c       |  8 ++++++++
 allocate.h       | 13 ++++++++++++
 lib.c            | 26 ++++++++++++++++++++----
 lib.h            |  2 ++
 sparse-llvm.c    |  1 +
 sparse.1         |  4 ++++
 sparse.c         |  2 ++
 stats.c          | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 test-linearize.c |  2 ++
 test-unssa.c     |  1 +
 11 files changed, 118 insertions(+), 4 deletions(-)
 create mode 100644 stats.c

-- 
2.12.0

