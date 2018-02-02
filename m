From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/8] avoid duplicated warnings
Date: Fri,  2 Feb 2018 13:17:27 +0100
Message-ID: <20180202121735.39621-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:56152 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751463AbeBBMTs (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 2 Feb 2018 07:19:48 -0500
Received: by mail-wm0-f48.google.com with SMTP id 143so12139112wma.5
        for <linux-sparse@vger.kernel.org>; Fri, 02 Feb 2018 04:19:47 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The goal of this series is to eliminate some duplicated
warnings in order to reduce noise and allow to better
focus on the origin of the problem.

The series is also available in the Git repository at:
  git://github.com/lucvoo/sparse-dev.git expr-bad-twice

----------------------------------------------------------------
Luc Van Oostenryck (8):
  add testcases for duplicated warning about invalid types
  fix error in bad conditional
  early return if null ctype in evaluate_conditional()
  add helper: valid_type()
  use valid_type to avoid to warn twice on conditionals
  add helpers: valid_expr_type() & valid_subexpr_type()
  do not report bad types twice
  always evaluate both operands

 evaluate.c                   | 66 +++++++++++++++++++++++++++-----------------
 symbol.h                     |  5 ++++
 validation/bad-type-twice0.c | 13 +++++++++
 validation/bad-type-twice1.c | 16 +++++++++++
 validation/bad-type-twice2.c | 18 ++++++++++++
 5 files changed, 93 insertions(+), 25 deletions(-)
 create mode 100644 validation/bad-type-twice0.c
 create mode 100644 validation/bad-type-twice1.c
 create mode 100644 validation/bad-type-twice2.c

-- 
2.16.0

