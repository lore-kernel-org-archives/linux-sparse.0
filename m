From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/2] simplify binops with identical operands
Date: Wed,  7 Dec 2016 17:32:55 +0100
Message-ID: <20161207163257.22287-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:32902 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932426AbcLGQdg (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 7 Dec 2016 11:33:36 -0500
Received: by mail-wm0-f66.google.com with SMTP id u144so28804904wmu.0
        for <linux-sparse@vger.kernel.org>; Wed, 07 Dec 2016 08:33:06 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This serie add simplification of binops and comparison where
both operands are identical, and add an optional warning for those
comparison.


Luc Van Oostenryck (2):
  simplify '(x op x)' to '0', '1' or 'x'
  add warning option '-Wtautological-compare'

 lib.c                               |  2 ++
 lib.h                               |  1 +
 simplify.c                          | 39 +++++++++++++++++++++++++++++
 validation/optim/binops-same-args.c | 49 +++++++++++++++++++++++++++++++++++++
 validation/tautological-compare.c   | 35 ++++++++++++++++++++++++++
 5 files changed, 126 insertions(+)
 create mode 100644 validation/optim/binops-same-args.c
 create mode 100644 validation/tautological-compare.c

-- 
2.10.2

