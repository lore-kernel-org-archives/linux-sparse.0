From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 0/2] fix: give a type to bad conditionnal expressions
Date: Fri,  4 Aug 2017 18:06:20 +0200
Message-ID: <20170804160622.18260-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37751 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752160AbdHDQGa (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 4 Aug 2017 12:06:30 -0400
Received: by mail-wm0-f66.google.com with SMTP id t138so6173987wmt.4
        for <linux-sparse@vger.kernel.org>; Fri, 04 Aug 2017 09:06:30 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The goal of this series is to fix the slow compilation of
the Wine test file.

It should be safe enough but IMO it's not -rc5 material.


This series is available in the git repository at:

  git://github.com/lucvoo/sparse.git fix-type-bad-cond-expr-v2

for you to fetch changes up to be35da05f38df984d518bc4670b36aa0b7ad4185:

  fix: give a type to bad cond expr with known condition (2017-08-04 15:49:49 +0200)

----------------------------------------------------------------
Luc Van Oostenryck (2):
      take comma expr in account for constant value
      fix: give a type to bad cond expr with known condition

 evaluate.c                   | 12 ++++++++++++
 expand.c                     | 30 ++++++++++++++++++++++++++++++
 expression.h                 |  1 +
 validation/cond-err-expand.c | 27 +++++++++++++++++++++++++++
 4 files changed, 70 insertions(+)
 create mode 100644 validation/cond-err-expand.c
