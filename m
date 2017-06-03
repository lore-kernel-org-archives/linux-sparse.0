From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 0/8] division-by-zero warnings
Date: Sat,  3 Jun 2017 10:01:27 +0200
Message-ID: <20170603080135.46477-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33588 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750759AbdFCIBn (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 3 Jun 2017 04:01:43 -0400
Received: by mail-wm0-f68.google.com with SMTP id b84so22124637wmh.0
        for <linux-sparse@vger.kernel.org>; Sat, 03 Jun 2017 01:01:42 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Chris Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The goal of this series is to add the 'division by zero'
warnings that are missing. Indeed, sparse only warned about
division by zero when the LHS was a constant. When the LHS
was not a constant (and thus also when the division was part
of a compound assignement) no warning was ever issued.

Note: the floating point division need similar changes
      which will be part of another series.

Changes since v1:
- add the warnins for compound assignments at expansion time too
- code restructuration and simplification
- test cases consolidation


This series is also available in the git repository at:
  git://github.com/lucvoo/sparse.git div-by-zero-v2


Luc Van Oostenryck (8):
  add is_pseudo_value()
  add a .warned field to struct instruction
  div0: warn on integer divide by 0 also when the lhs is not constant
  div0: also check for compound assignments
  div0: add warning option -Wdiv-by-zero
  div0: use -Wdiv-by-zero
  div0: warn also during simplification
  div0: warn on float divide by 0 also when the lhs is not constant

 expand.c                    | 42 +++++++++++++++----------
 lib.c                       |  2 ++
 lib.h                       |  1 +
 linearize.c                 | 17 +++++++++++
 linearize.h                 | 12 ++++++--
 simplify.c                  | 12 ++++++++
 validation/div-by-zero-fp.c | 24 +++++++++++++++
 validation/div-by-zero.c    | 74 +++++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 166 insertions(+), 18 deletions(-)
 create mode 100644 validation/div-by-zero-fp.c
 create mode 100644 validation/div-by-zero.c

-- 
2.13.0

