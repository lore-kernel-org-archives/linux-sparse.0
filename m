From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/3] -Wmemcpy-max-count & friends
Date: Thu,  1 Jun 2017 22:27:21 +0200
Message-ID: <20170601202724.77597-1-luc.vanoostenryck@gmail.com>
References: <84e547c2-8a5b-225c-1363-361e091821f4@ramsayjones.plus.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33745 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751029AbdFAU1f (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 1 Jun 2017 16:27:35 -0400
Received: by mail-wm0-f68.google.com with SMTP id b84so14127458wmh.0
        for <linux-sparse@vger.kernel.org>; Thu, 01 Jun 2017 13:27:35 -0700 (PDT)
In-Reply-To: <84e547c2-8a5b-225c-1363-361e091821f4@ramsayjones.plus.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Chris Li <sparse@chrisli.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>, Junio C Hamano <gitster@pobox.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

sparse will warn if memcpy() (and some others memcpy-like
functions) is called with a very large static byte count.
But this warning cannot be disabled and the limit is arbitrary
fixed at 100000.

The goal of this series is to allow to disable this warning if
found too unconvenient or to allow to configure its limit.


The series can also be found on the tree:
	git://github.com/lucvoo/sparse.git memcpy-max-count


Luc Van Oostenryck (3):
  memcpy()'s byte count is unsigned
  add support for -Wmemcpy-max-count
  add support for -fmemcpy-max-count

 lib.c    | 18 ++++++++++++++++++
 lib.h    |  2 ++
 sparse.1 | 18 ++++++++++++++++++
 sparse.c |  6 +++---
 4 files changed, 41 insertions(+), 3 deletions(-)

-- 
2.13.0

