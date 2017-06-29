From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/7] put struct symbol & friends on diet
Date: Thu, 29 Jun 2017 07:16:39 +0200
Message-ID: <20170629051646.35988-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33101 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751567AbdF2FS6 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 29 Jun 2017 01:18:58 -0400
Received: by mail-wm0-f66.google.com with SMTP id j85so351532wmj.0
        for <linux-sparse@vger.kernel.org>; Wed, 28 Jun 2017 22:18:57 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The goal of this series is to decrease sparse's memory consumption
by decreasing the size of some of the structure.

What can be win with these small changes is quite appreciable:
about 30% with some gain in speed too (but this are harder to
put numbers on it, 5% or a bit more seems quite common for
big files).

It should be noted that those gains come almost entirely from
the LIST_NODE_NR change which halves the size of struct ptrlist,
a very heavily used structure.


Luc Van Oostenryck (7):
  use long for all mem stats
  diet: use smaller LIST_NODE_NR (29 -> 13)
  diet: remove unused struct scope::token
  diet: remove unused struct symbol::arg_count
  diet: remove unused struct symbol::value
  diet: squeeze struct symbol's members
  diet: squeeze struct ctype's members

 allocate.c     |  2 +-
 allocate.h     |  3 ++-
 compile-i386.c | 12 ++++++------
 ptrlist.h      |  2 +-
 scope.h        |  1 -
 show-parse.c   |  8 ++++----
 symbol.h       | 12 ++++++------
 7 files changed, 20 insertions(+), 20 deletions(-)

-- 
2.13.0

