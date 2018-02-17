From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/4] expansion of builtin FP predicates (isinf(), ...)
Date: Sat, 17 Feb 2018 15:56:30 +0100
Message-ID: <20180217145634.53616-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37624 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750977AbeBQO4k (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 17 Feb 2018 09:56:40 -0500
Received: by mail-wm0-f66.google.com with SMTP id v71so7853899wmv.2
        for <linux-sparse@vger.kernel.org>; Sat, 17 Feb 2018 06:56:40 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

These patches add proper typechecking to built-in floating-point
predicates like __builtin_isinf(). They also are an excuse to put
in place a bit more infrastructure for complete handling of builtins.

This series is available in the Git repository at:
  https://github.com/lucvoo/sparse-dev/tree/builtin-fp
  git://github.com/lucvoo/sparse-dev.git builtin-fp

----------------------------------------------------------------
Luc Van Oostenryck (4):
      builtin: extract eval_args() from arguments_choose()
      builtin: add typechecking of isnan(), isinf(), ...
      builtin: add testcases for expansion of special FP constants
      builtin: add testcases for expansion of FP classification

 builtin.c                              | 79 +++++++++++++++++++++-------
 validation/builtin-fp-unop.c           | 95 ++++++++++++++++++++++++++++++++++
 validation/expand/builtin_fpclassify.c | 26 ++++++++++
 validation/expand/builtin_huge_val.c   | 39 ++++++++++++++
 validation/expand/builtin_isinf.c      | 20 +++++++
 validation/expand/builtin_isnan.c      | 20 +++++++
 validation/expand/builtin_isnormal.c   | 20 +++++++
 validation/expand/builtin_nan.c        | 23 ++++++++
 8 files changed, 303 insertions(+), 19 deletions(-)
 create mode 100644 validation/builtin-fp-unop.c
 create mode 100644 validation/expand/builtin_fpclassify.c
 create mode 100644 validation/expand/builtin_huge_val.c
 create mode 100644 validation/expand/builtin_isinf.c
 create mode 100644 validation/expand/builtin_isnan.c
 create mode 100644 validation/expand/builtin_isnormal.c
 create mode 100644 validation/expand/builtin_nan.c
