From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 0/3] -Wmemcpy-max-count & friends
Date: Tue, 6 Jun 2017 00:20:50 +0200
Message-ID: <20170605222049.wzwewfcupxdbeoxg@ltop.local>
References: <20170603074727.66945-1-luc.vanoostenryck@gmail.com>
 <20170603074727.66945-2-luc.vanoostenryck@gmail.com>
 <CANeU7QmDHd4mZNZyaYVvJ0LPykUNbH3H1TEELZhYYDp=Ob_sMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33161 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751195AbdFEWUy (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 5 Jun 2017 18:20:54 -0400
Received: by mail-wm0-f68.google.com with SMTP id x3so4845792wme.0
        for <linux-sparse@vger.kernel.org>; Mon, 05 Jun 2017 15:20:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7QmDHd4mZNZyaYVvJ0LPykUNbH3H1TEELZhYYDp=Ob_sMg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

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
