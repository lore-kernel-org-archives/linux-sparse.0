From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/3] -Wmemcpy-max-count & friends
Date: Sat,  3 Jun 2017 09:47:24 +0200
Message-ID: <20170603074727.66945-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35468 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751077AbdFCHre (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 3 Jun 2017 03:47:34 -0400
Received: by mail-wm0-f67.google.com with SMTP id g15so22043843wmc.2
        for <linux-sparse@vger.kernel.org>; Sat, 03 Jun 2017 00:47:34 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Chris Li <sparse@chrisli.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

sparse will warn if memcpy() (and some others memcpy-like
functions) is called with a very large static byte count.
But this warning cannot be disabled and the limit is arbitrary
fixed at 100000.

The goal of this series is to allow to disable this warning if
found too bothersome or to allow to configure its limit.


Changes since v1:
- take in account Ramsay's remarks and suggestion:
  - fix some name mixups in the man page & commit message
  - use a limit of 0 as being equivalent to an infinite
    limit, effectively disabling the warning.
- somewhat rewrote the man page for -fmemcpy-max-count
- extend the limit's range

The series can also be found on the tree:
	git://github.com/lucvoo/sparse.git memcpy-max-count-v2

Luc Van Oostenryck (3):
  memcpy()'s byte count is unsigned
  add support for -Wmemcpy-max-count
  add support for -fmemcpy-max-count

 lib.c    | 20 ++++++++++++++++++++
 lib.h    |  2 ++
 sparse.1 | 17 +++++++++++++++++
 sparse.c |  6 +++---
 4 files changed, 42 insertions(+), 3 deletions(-)

-- 
2.13.0

