From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/9] division by zero warnings
Date: Wed, 31 May 2017 05:21:58 +0200
Message-ID: <20170531032207.95830-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35211 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751088AbdEaDWR (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 30 May 2017 23:22:17 -0400
Received: by mail-wr0-f195.google.com with SMTP id g76so303757wrd.2
        for <linux-sparse@vger.kernel.org>; Tue, 30 May 2017 20:22:16 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The goal of this series is to add the 'division by zero'
warnings that are missing. Indeed, sparse only warned about
division by zero when the LHS was a constant. When the LHS
was not a constant (and thus also when the division was part
of a compound assignement) no warning was ever issued.

Note: the floating point division need a similar changes
      which will be part of another series.


This series is also available in the git repository at:
  git://github.com/lucvoo/sparse.git div-by-zero


Luc Van Oostenryck (9):
  add is_pseudo_value()
  add a .warned field to struct instruction
  div0: warn on integer divide by 0 also when the lhs is not constant
  div0: warn on division by zero - general case
  div0: add warning option -Wdiv-by-zero
  div0: use -Wdiv-by-zero
  div0: warn also during simplification
  div0: warn on float divide by 0 also when the lhs is not constant
  div0: add missing tests for floating point div by zero

 expand.c                    | 30 +++++++++++-------------
 lib.c                       |  2 ++
 lib.h                       |  1 +
 linearize.c                 | 20 ++++++++++++++++
 linearize.h                 | 12 ++++++++--
 simplify.c                  | 12 ++++++++++
 validation/div-by-zero-fp.c | 24 +++++++++++++++++++
 validation/div-by-zero.c    | 57 +++++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 140 insertions(+), 18 deletions(-)
 create mode 100644 validation/div-by-zero-fp.c
 create mode 100644 validation/div-by-zero.c

-- 
2.13.0

